//
//  DoctorCollectionViewController.m
//  Pan大夫
//
//  Created by tiny on 15/3/5.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "DoctorTableView.h"
#import "DoctorItemViewCell.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"

#define kCellHeight 140/667.0
#define kImageHeight 164.0/736.0
#define kHeaderHeight 30.0/736.0
#define kUserLocationViewHeight 30/568.0
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
@interface DoctorTableView ()
{
    int pages;
    int speTag;
}
@property (strong, nonatomic) NSMutableArray *doctorsArray;
@property (strong, nonatomic) MKNetworkOperation *netOp;
@property (strong, nonatomic) NSString *special;
@property (strong, nonatomic) NSMutableArray *docSpecialList;
@property (strong, nonatomic) NSString *userChooseCity;

@end
@implementation DoctorTableView
@synthesize docListNavPushDelegate;
@synthesize doctorsArray,docSpecialList;
@synthesize userLocation;
@synthesize netOp;

//初始化函数，参数是医生数组和DoctorsListViewController对象
- (id)initWithDoctors:(NSMutableArray *)doctors Delegate:(DoctorsListViewController *)delegate Special:(NSString *)special Page:(int) page SpecialTag:(int)specialTag ChooseCity:(NSString *)chooseCity{
    self.special = special;
    if (!self.special) {
        self = [super initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height-49-64-kUserLocationViewHeight*KDeviceHeight)];
    }
    else{
        self = [super initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height-49-64-kUserLocationViewHeight*KDeviceHeight)];
        UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, (kImageHeight+kHeaderHeight)*KDeviceHeight)];
        switch (specialTag) {
            case 0:{
                if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
                    headerView.image = [UIImage imageNamed:@"marriageImage-4"];
                }
                else{
                    headerView.image = [UIImage imageNamed:@"marriageImage"];
                }
                break;
            }
            case 1:{
                if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
                    headerView.image = [UIImage imageNamed:@"educationImage-4"];
                }
                else{
                    headerView.image = [UIImage imageNamed:@"educationImage"];
                }
                break;
            }
            case 2:{
                if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
                    headerView.image = [UIImage imageNamed:@"parentImage-4"];
                }
                else{
                    headerView.image = [UIImage imageNamed:@"parentImage"];
                }
                break;
            }
            case 3:{
                if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
                    headerView.image = [UIImage imageNamed:@"interactionImage-4"];
                }
                else{
                    headerView.image = [UIImage imageNamed:@"interactionImage"];
                }
                break;
            }
            case 4:{
                if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
                    headerView.image = [UIImage imageNamed:@"pressureImage-4"];
                }
                else{
                    headerView.image = [UIImage imageNamed:@"pressureImage"];
                }
                break;
            }
            case 5:{
                if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
                    headerView.image = [UIImage imageNamed:@"AIDS-4"];
                }
                else{
                    headerView.image = [UIImage imageNamed:@"AIDS"];
                }
                break;
            }
            case 6:{
                if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
                    headerView.image = [UIImage imageNamed:@"othersImage-4"];
                }
                else{
                    headerView.image = [UIImage imageNamed:@"othersImage"];
                }
                break;
            }
            default:
                break;
        }
        self.tableHeaderView = headerView;
        speTag = specialTag;
    }
    if (self) {
        doctorsArray = [[NSMutableArray alloc]init];
        doctorsArray = doctors;
        docListNavPushDelegate = delegate;
        self.userChooseCity = chooseCity;
        
        self.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
        self.dataSource = self;
        self.delegate = self;
        
        //设置Cell的分割线
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [self setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [self setLayoutMargins:UIEdgeInsetsZero];
            
        }

        
        self.pullDelegate = self;
        self.canPullUp = YES;
        self.canPullDown = YES;
        
        pages = page;
        
        self.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return self;
}
//根据手势的上拉和下拉判断加载或者刷新
- (void)scrollView:(UIScrollView *)scrollView loadWithState:(LoadState)state{
    if (state == PullDownLoadState) {
        [self refreshDocTable];
    }
    if (state == PullUpLoadState) {
            pages = pages+1;
            [self requestNetWork];
            [self performSelector:@selector(PullUpLoadEnd) withObject:nil afterDelay:0];
    }
}
//上拉加载结束调用的函数
- (void)PullUpLoadEnd {
    [self reloadData];
    [self stopLoadWithState:PullUpLoadState];
}
//下拉刷新结束调用的函数
- (void)PullDownLoadEnd {
    self.canPullUp = YES;
    [self reloadData];
    [self stopLoadWithState:PullDownLoadState];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!doctorsArray) {
        return 0;
    }else{
        return [doctorsArray count];
    }
}
//设置Cell的分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"cell";
    DoctorItemViewCell *cell = (DoctorItemViewCell *)[tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[DoctorItemViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    NSInteger row = [indexPath row];
    [self setCellContent:cell Rows:row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight*[[UIScreen mainScreen]bounds].size.height;
}
//触摸tableViewcell传递doctor的id返回给DoctorsListViewController对象
- (void)cellClickedWithDoc:(Doctor *)doc{
    [docListNavPushDelegate cellTapedBackToHomeWith:doc];
}
//下拉刷新时调用函数
- (void)refreshDocTable{
    pages = 1;
    [self requestNetWork];
    [self performSelector:@selector(PullDownLoadEnd) withObject:nil afterDelay:0];
}
//设置tableViewCell里的内容
- (void)setCellContent:(DoctorItemViewCell *)cell Rows:(NSInteger)row{
    Doctor *doctor = (Doctor *)[doctorsArray objectAtIndex:row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:doctor.imageURL] placeholderImage:[UIImage imageNamed:@"ImageLoadError"]];
    cell.doctor = doctor;
    if (doctor.docName == nil) {
        cell.nameLabel.text = @"";
    }else{
        cell.nameLabel.text = doctor.docName;
    }
    if (doctor.docDepartment == nil) {
        cell.departmentLabel.text = @"";
    }else{
       cell.departmentLabel.text = doctor.docDepartment;
    }
    if (!doctor.docTitle) {
       cell.docTitleLabel.text = @"";
    }else{
       cell.docTitleLabel.text = doctor.docTitle;
    }
    if (doctor.docSpecial == nil&&doctor.docMoreSpecial==nil) {
        cell.specialView.text = @"";
    }
    if(doctor.docSpecial == nil&&doctor.docMoreSpecial!=nil){
        cell.specialView.text = doctor.docMoreSpecial;
    }
    if(doctor.docSpecial != nil&&doctor.docMoreSpecial!=nil){
        cell.specialView.text = [NSString stringWithFormat:@"%@,%@",[self getRealSpecialField:doctor.docSpecial],doctor.docMoreSpecial];
    }
    if (doctor.docSpecial != nil&&doctor.docMoreSpecial == nil) {
        cell.specialView.text = [self getRealSpecialField:doctor.docSpecial];
    }
    if (doctor.docCertificate == nil) {
        cell.secRankLabel.text = @"";
    }else{
        cell.secRankLabel.text = doctor.docCertificate;
    }
//    if (doctor.docPrice == nil) {
//        cell.secPriceLabel.text = @"";
//    }else{
//       cell.secPriceLabel.text =[NSString stringWithFormat:@"￥%@/h",doctor.docPrice];
//    }
//    if (doctor.docConTimes == nil) {
//        cell.secConTimesLabel.text = @"";
//    }else{
//        cell.secConTimesLabel.text =[NSString stringWithFormat:@"%@次", doctor.docConTimes];
//    }

    if (doctor.docLocation == nil) {
       cell.secLocationLabel.text = doctor.docLocation;
    }else{
        cell.secLocationLabel.text = doctor.docLocation;
    }
//    if (doctor.docMark == nil) {
//        cell.starRate.scorePercent = 0/5.0;
//    }else{
//        cell.starRate.scorePercent = [doctor.docMark floatValue]/5.0;
//    }
//    
//    userLocation = [self getCurrentPosition];
//    if (userLocation) {
//        NSArray *gpsArray = [doctor.docGPS componentsSeparatedByString:@","];
//        double doctorLng = [[gpsArray objectAtIndex:1]doubleValue];
//        double doctorLat = [[gpsArray objectAtIndex:0]doubleValue];
//        double userLng = [[userLocation objectForKey:@"lng"]doubleValue];
//        double userLat = [[userLocation objectForKey:@"lat"]doubleValue];
//        
//        BMKMapPoint doctorPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(doctorLat,doctorLng));
//        BMKMapPoint userPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(userLat,userLng));
//        
//        CLLocationDistance distance = BMKMetersBetweenMapPoints(doctorPosition,userPosition);
//        cell.secGPSLabel.text = [NSString stringWithFormat:@"%.1fkm",distance/1000];
//    }
//    else{
//        cell.secGPSLabel.text = [NSString stringWithFormat:@""];
//    }

    
}

- (NSString *)getRealSpecialField:(NSString *)special{
    BOOL isBegun = false;
    NSMutableString *result = [[NSMutableString alloc]init];
    NSArray *array = [[NSArray alloc]initWithObjects:@"婚恋情感",@"学业问题",@"亲子教育",@"人际交往",@"职场压力",@"恐艾症", nil];
    for (int i=0; i < special.length; i++) {
        if ([special characterAtIndex:i] == '1') {
            if (isBegun) {
                [result appendString:@","];
            }
            [result appendString:[array objectAtIndex:i]];
            isBegun = true;
        }
    }
    return result;
}

- (void)requestNetWork{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    NSString *path = [NSString stringWithFormat:@"/doctordb.php?id=all&nextPage=%d&city=%@",pages,self.userChooseCity];
    netOp = [appDelegate.netEngine operationWithPath:path];
    
    __block NSMutableArray *localDoctorsArray = doctorsArray;
    __block int localPage = pages;
    __block int localTag = speTag;
    __block NSString *newSpecial = self.special;
    __block DoctorTableView *localSelf = self;
    
    [netOp addCompletionHandler:^(MKNetworkOperation *operation){
        id json = [operation responseJSON];
        NSDictionary *dic = (NSDictionary *)json;
        int doctorNumber = [[dic objectForKey:@"doctorNumber"]intValue];
        NSMutableArray *allDoctorsArray = [dic objectForKey:@"doctors"];
        
        if (doctorNumber == 0) {
            
        }
        else{
            if (localPage <= 1) {
                [localDoctorsArray removeAllObjects];
            }
            for (int i=0; i<[allDoctorsArray count]; i++) {
                NSDictionary *doctor = [allDoctorsArray objectAtIndex:i];
                NSString *ID = [doctor objectForKey:@"id"];
                NSString *name = [doctor objectForKey:@"name"];
                NSString *sex = [doctor objectForKey:@"sex"];
                NSString *age = [doctor objectForKey:@"age"];
                NSString *mark = [doctor objectForKey:@"mark"];
                NSString *price = [doctor objectForKey:@"price"];
                NSString *special = [doctor objectForKey:@"special"];
                NSString *conTimes = [doctor objectForKey:@"conTimes"];
                NSString *introduction = [doctor objectForKey:@"introduction"];
                NSString *more = [doctor objectForKey:@"more"];
                NSString *moreSpecial = [doctor objectForKey:@"moreSpecial"];
                NSString *careerYears = [doctor objectForKey:@"careerYears"];
                NSString *location = [doctor objectForKey:@"location"];
                NSString *imageUrl = @"http://c.hiphotos.baidu.com/image/pic/item/aa18972bd40735fa8c6d0ec89d510fb30f240825.jpg";
                NSString *certificate = [doctor objectForKey:@"certificate"];
                NSString *GPS = [doctor objectForKey:@"GPS"];
                NSString *department = [doctor objectForKey:@"department"];
                NSString *title = [doctor objectForKey:@"title"];
                Doctor *singleDoctor = [[Doctor alloc]initWithDocID:ID DocName:name DocSex:sex DocAge:age DocMark:mark DocPrice:price DocSpecial:special DocConTimes:conTimes DocIntroduction:introduction DocMore:more DocMoreSpe:moreSpecial DoccareerTimes:careerYears DocGPS:GPS PicUrl:imageUrl DocCertificate:certificate DocLocation:location DocDepartment:department DocTitle:title];
                
                if (localTag == 6) {
                    [localDoctorsArray addObject:singleDoctor];
                }
                else{
                    if ((newSpecial != nil)&&([special characterAtIndex:localTag]=='1')) {
                        [localDoctorsArray addObject:singleDoctor];
                    }
                }
                if (!newSpecial) {
                    [localDoctorsArray addObject:singleDoctor];
                }
            }
            if ((newSpecial != nil)&&([localDoctorsArray count]<6)) {
                pages = pages+1;
                [localSelf requestNetWork];
            }
            
        }
     
        
    } errorHandler:^(MKNetworkOperation *operation,NSError *error){
        NSLog(@"网络加载失败！");
        
    }
     ];
    [appDelegate.netEngine enqueueOperation:netOp];
}

////获取当前positon
//- (NSMutableDictionary *)getCurrentPosition{
//    //获取plist字典
//    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *documentsDirectory =[paths objectAtIndex:0];
//    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
//    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
//    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
//    return currentPosition;
//}
@end
