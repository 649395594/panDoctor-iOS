//
//  DoctorsListViewController.m
//  Pan大夫
//
//  Created by zxy on 2/27/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//
#import "DoctorsListViewController.h"
#import "DoctorTableView.h"
#import "UIImageView+WebCache.h"
#import "InformationViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define kUserLocationViewHeight 30/568.0
#define kUserLocationLabelLeft 5/320.0
#define kUserLocationLabelWidth 245/320.0
#define kSettingButtonTopInterval 3/568.0
#define kSettingButtonWidth 60/320.0
#define kSettingButtonHeight 24/568.0
@interface DoctorsListViewController ()
{
    int specialTag;
    int page;
    BOOL didFinsh;
    NSString *chooseCity;
}
@property (strong, nonatomic) DoctorTableView *docTable;
@property (strong, nonatomic) NSMutableArray *doctorsArray;
@property (strong, nonatomic) MKNetworkOperation *netOp;
@property (strong, nonatomic) UIActivityIndicatorView *NetIndicator;
@property (strong, nonatomic) UILabel *loadingLabel;
@property (strong, nonatomic) UILabel *netFailLabel;
@property (strong, nonatomic) NSMutableArray *specialArray;
@property (strong, nonatomic) UIView *userLocationView;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) HomeViewController *homeNavPushDelegate;

@property (strong, nonatomic) InformationViewController *userInfoView;

@property (strong, nonatomic) AppDelegate *appDelegate;

//@property (strong, nonatomic) NSString *otherCity;
@end

@implementation DoctorsListViewController
@synthesize docTable,homeNavPushDelegate;
@synthesize doctorsArray,specialArray;
@synthesize netOp,NetIndicator,loadingLabel,netFailLabel,userLocationLabel;
@synthesize userLocationView;
@synthesize userInfoView;
@synthesize userLocation;
@synthesize appDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    didFinsh = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    doctorsArray = [[NSMutableArray alloc]init];
    chooseCity = [self getChooseCityFromFile];
    if (!chooseCity) {
       chooseCity = @"沈阳";
    }
    [self getDoctorsFromNetWork];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCurrentCity) name:@"getCurrentCity" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getChooseCityFromFile{
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
    NSString  *city = [currentPosition objectForKey:@"defaultCity"];
    NSLog(@"city is %@",[currentPosition objectForKey:@"defaultCity"]);
    return city;
}

- (void)getCurrentCity{
    if (didFinsh) {
        didFinsh = NO;
        NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
        NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
        chooseCity = [currentPosition objectForKey:@"defaultCity"];
        [self getDoctorsFromNetWork];
    }
}

//初始化函数，参数为homeviewController的对象
- (id)initWithDelegate:(HomeViewController *)homeDelegate Special:(NSString *)special{
    self = [super init];
    if (self) {
        
        homeNavPushDelegate = homeDelegate;
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        if (!special){
            userLocationView = [[UIView alloc]initWithFrame:CGRectMake(0, KDeviceHeight-49-64-kUserLocationViewHeight*KDeviceHeight, KDeviceWidth, kUserLocationViewHeight*KDeviceHeight)];
            [self.view addSubview:userLocationView];
            userLocationView.backgroundColor = [UIColor whiteColor];
        }
        else{
            self.special = special;
            if ([self.special isEqualToString:@"others"]) {
                specialTag = 6;
            }
            else{
                specialArray = [[NSMutableArray alloc]initWithObjects:@"marriage",@"education",@"parents",@"interaction",@"pressure",@"AIDS", nil];
                for (int i=0; i<[specialArray count]; i++) {
                    if ([self.special isEqualToString:[specialArray objectAtIndex:i]]){
                        specialTag = i;
                    }
                }
            }
            userLocationView = [[UIView alloc]initWithFrame:CGRectMake(0, KDeviceHeight-49-kUserLocationViewHeight*KDeviceHeight, KDeviceWidth, kUserLocationViewHeight*KDeviceHeight)];
            [self.view addSubview:userLocationView];
            userLocationView.backgroundColor = [UIColor whiteColor];

        }
        //用户当前地理位置
        userLocationLabel = [[UILabel alloc]initWithFrame:CGRectMake(kUserLocationLabelLeft*KDeviceWidth, 0, kUserLocationLabelWidth*KDeviceWidth, kUserLocationViewHeight*KDeviceHeight)];
        userLocationLabel.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserLocationBydataBase) name:@"chooseDefaultAddress" object:nil];
        userLocation = [self getCurrentPosition];
        if (userLocation) {
            userLocationLabel.text =[NSString stringWithFormat:@"预约地址:%@",[userLocation objectForKey:@"currentAddress"]];
        }
        else{
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserLocationLabel:) name:@"chooseDefaultAddressByAppdelegate" object:nil];
            [self readLocationDataFromDataBase];
        }
        [userLocationView addSubview:userLocationLabel];

        
        //设置用户地理位置的button
        UIButton *settingButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userLocationLabel.frame), kSettingButtonTopInterval*KDeviceHeight, kSettingButtonWidth*KDeviceWidth, kSettingButtonHeight*KDeviceHeight)];
        [settingButton setTitle:@"去设置" forState:UIControlStateNormal];
        [settingButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0]];
        [settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        settingButton.layer.cornerRadius = 5;
        [settingButton addTarget:self action:@selector(setUserLocation) forControlEvents:UIControlEventTouchUpInside];
        [userLocationView addSubview:settingButton];
        
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
           userLocationLabel.font = [UIFont systemFontOfSize:13];
           settingButton.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
           userLocationLabel.font = [UIFont systemFontOfSize:12];
           settingButton.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        if (KDeviceWidth>=374&&KDeviceWidth<=376) {
            userLocationLabel.font = [UIFont systemFontOfSize:15];
            settingButton.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        if (KDeviceWidth>=413&&KDeviceWidth<=415) {
            userLocationLabel.font = [UIFont systemFontOfSize:15];
            settingButton.titleLabel.font = [UIFont systemFontOfSize:17];
        }
        
        //注册通知，监听选择默认地址事件
    }
    return self;
}
//触摸tableViewcell传递doctor的id返回homeviewController
- (void)cellTapedBackToHomeWith:(Doctor *)doc{
    [homeNavPushDelegate cellTapedPushWith:doc Special:self.special DoctorList:self];
}
//开启网络链接，获得doctor的信息
- (void)getDoctorsFromNetWork{
    if (docTable != nil && self.special == nil) {
        docTable.hidden = YES;
    }
     NetIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
     NetIndicator.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width - 10)/2, (self.view.frame.size.height - 100)/2-20, 10, 10);
    
    loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width - 120)/2, (self.view.frame.size.height - 40)/2-20, 150, 40)];
    loadingLabel.text = @"拼命加载中。。。";
    [self doctorInfoWillLoad];
    
    chooseCity = [chooseCity stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [NSString stringWithFormat:@"/mental/doctordb.php?id=all&nextPage=%d&city=%@",page,chooseCity];
    netOp = [appDelegate.netEngine operationWithPath:path];
    
    __block NSMutableArray *localDoctorsArray = doctorsArray;
    __block DoctorsListViewController *localSelf = self;
    __block NSString *localSpecial = self.special;
    __block int localSpeTag = specialTag;
    __block BOOL didReceiveData = NO;
    
    [netOp addCompletionHandler:^(MKNetworkOperation *operation){
        id json = [operation responseJSON];
        NSDictionary *dic = (NSDictionary *)json;
        int doctorNumber = [[dic objectForKey:@"doctorNumber"]intValue];
        NSMutableArray *allDoctorsArray = [dic objectForKey:@"doctors"];
        didReceiveData = YES;
        if (doctorNumber == 0) {

        }
        else{
            if (!localSpecial) {
                [localDoctorsArray removeAllObjects];
            }
            for (int i=0; i<[allDoctorsArray count]; i++) {
                NSDictionary *doctor = [allDoctorsArray objectAtIndex:i];
                NSString *ID = [doctor objectForKey:@"id"];
                NSString *name = [doctor objectForKey:@"name"];
                NSString *sex = [doctor objectForKey:@"sex"];
                NSString *age = [doctor objectForKey:@"age"];
                NSString *title = [doctor objectForKey:@"title"];
                NSString *mark = [doctor objectForKey:@"mark"];
                NSString *special = [doctor objectForKey:@"special"];
                NSString *moreSpecial = [doctor objectForKey:@"moreSpecial"];
                NSString *price = [doctor objectForKey:@"price"];
                NSString *conTimes = [doctor objectForKey:@"conTimes"];
                NSString *introduction = [doctor objectForKey:@"introduction"];
                NSString *more = [doctor objectForKey:@"more"];
                NSString *careerYears = [doctor objectForKey:@"careerYears"];
                NSString *location = [doctor objectForKey:@"location"];
                NSString *imageUrl = @"http://c.hiphotos.baidu.com/image/pic/item/aa18972bd40735fa8c6d0ec89d510fb30f240825.jpg";
                NSString *certificate = [doctor objectForKey:@"certificate"];
                NSString *GPS = [doctor objectForKey:@"GPS"];
                NSString *department = [doctor objectForKey:@"department"];
                
                Doctor *singleDoctor = [[Doctor alloc]initWithDocID:ID DocName:name DocSex:sex DocAge:age DocMark:mark DocPrice:price DocSpecial:special DocConTimes:conTimes DocIntroduction:introduction DocMore:more DocMoreSpe:moreSpecial DoccareerTimes:careerYears DocGPS:GPS PicUrl:imageUrl DocCertificate:certificate DocLocation:location DocDepartment:department DocTitle:title];
                if (localSpeTag == 6) {
                    [localDoctorsArray addObject:singleDoctor];
                }
                else{
                    if ((localSpecial != nil)&&([special characterAtIndex:localSpeTag]=='1')) {
                        [localDoctorsArray addObject:singleDoctor];
                    }
                }
                if (!localSpecial) {
                    [localDoctorsArray addObject:singleDoctor];
                }
            }
            if ((localSpecial != nil)&&([localDoctorsArray count]<6)) {
                page = page+1;
                [localSelf getDoctorsFromNetWork];
            }
            DoctorTableView *docTableView = [[DoctorTableView alloc]initWithDoctors:localDoctorsArray Delegate:self Special:localSpecial Page:page SpecialTag:localSpeTag ChooseCity:chooseCity];
            [localSelf createDocTable:docTableView];
            didFinsh = YES;
            [localSelf doctorInfoDidLoad];
        }
        
    } errorHandler:^(MKNetworkOperation *operation,NSError *error){
        NSLog(@"网络加载失败！");
        if (!didReceiveData){
            [self doctorInfoDidLoad];
            [self noticeNetWorkFail];
        }
    }
     ];
    [appDelegate.netEngine enqueueOperation:netOp];
    
}
//创建网络加载失败界面
- (void)noticeNetWorkFail{
    docTable.hidden = YES;
    netFailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,KDeviceWidth , KDeviceHeight-49-64-userLocationView.frame.size.height)];
    netFailLabel.backgroundColor = [UIColor lightGrayColor];
    netFailLabel.textAlignment = NSTextAlignmentCenter;
    netFailLabel.font = [UIFont systemFontOfSize:12];
    netFailLabel.text = @"网络连接失败,请点击屏幕重新加载";
    [self.view addSubview:netFailLabel];
    
    UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singalTap];
}
//轻触手势调用函数
- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    netFailLabel.text = @"";
    [netFailLabel removeFromSuperview];
    [self.view removeGestureRecognizer:sender];
    [self getDoctorsFromNetWork];
}
//活动指示器开启
- (void)doctorInfoWillLoad{
    [self.view addSubview:NetIndicator];
    [self.view addSubview:loadingLabel];
    [NetIndicator startAnimating];
}

//活动指示器关闭
- (void)doctorInfoDidLoad{
    [NetIndicator stopAnimating];
    [loadingLabel removeFromSuperview];
    [NetIndicator removeFromSuperview];
}

//settingButton点击触发函数，从医师列表跳转至设置用户地理位置
- (void)setUserLocation{
    userInfoView = [[InformationViewController alloc]initWithPath:@"out"];
    userInfoView.hidesBottomBarWhenPushed = YES;
    userInfoView.title = @"地址管理";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    [homeNavPushDelegate.navigationController pushViewController:userInfoView animated:YES];
}

//从数据库获得病人数据
- (NSMutableDictionary *)getCurrentPosition{
   // NSMutableDictionary *answer = [[NSMutableDictionary alloc]init];
    
    //获取plist字典
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableArray *patients = [plistDictionary objectForKey:@"patients"];
    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
    if (!patients){
        return nil;
    }
    else{
        for (NSDictionary *patient in patients) {
            if ([[patient objectForKey:@"isDefault"]isEqualToString:@"yes"]) {
                [currentPosition setObject:[patient objectForKey:@"patientNeighbourhood"] forKey:@"currentAddress"];
                [currentPosition setObject:[patient objectForKey:@"lat"] forKey:@"lat"];
                [currentPosition setObject:[patient objectForKey:@"lng"] forKey:@"lng"];
                [plistDictionary writeToFile:[self getFilePath] atomically:YES];
                return currentPosition;
            }
        }
   }
    return nil;
}

- (void)updateUserLocationLabel:(NSNotification*) notification{
    NSMutableDictionary *location = (NSMutableDictionary *)[notification object];
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
    if ([[location objectForKey:@"patientNeighbourhood"]isEqualToString:@""]) {
        userLocationLabel.text = @"";
    }
    else{
        [currentPosition setObject:[location objectForKey:@"patientNeighbourhood"] forKey:@"currentAddress"];
        [currentPosition setObject:[location objectForKey:@"lat"] forKey:@"lat"];
        [currentPosition setObject:[location objectForKey:@"lng"] forKey:@"lng"];
        [plistDictionary writeToFile:[self getFilePath] atomically:YES];
        [self readLocationDataFromDataBase];
    }
    docTable.userLocation = location;
    [docTable reloadData];
}

- (void)updateUserLocationBydataBase{
    userLocation = [self getCurrentPosition];
    if (userLocation) {
        userLocationLabel.text =[NSString stringWithFormat:@"预约地址:%@",[userLocation objectForKey:@"currentAddress"]];
        docTable.userLocation = userLocation;
        [docTable reloadData];
    }
    else{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserLocationLabel:) name:@"chooseDefaultAddressByAppdelegate" object:nil];
        [self readLocationDataFromDataBase];
    }
}

- (NSString *)getFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    return documentPlistPath;
}

- (void)readLocationDataFromDataBase{
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
    userLocationLabel.text = [currentPosition objectForKey:@"currentAddress"];
    NSLog(@"currentPosition address is %@",userLocationLabel.text);
}

- (void)createDocTable:(DoctorTableView *)docTableView{
    docTable = nil;
    [docTable removeFromSuperview];
    docTable = docTableView;
    [self.view addSubview:docTable];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
