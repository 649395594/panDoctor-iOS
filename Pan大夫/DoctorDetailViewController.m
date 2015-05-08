//
//  DoctorDetailViewController.m
//  Pan大夫
//
//  Created by tiny on 15/3/6.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "DoctorDetailViewController.h"
#import "Doctor.h"
#import "DoctorInfoScrollView.h"
#import "StarRateView.h"
#import "Order.h"
#import "InformationConfirmViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SettingsViewController.h"
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define kInterval 4
#define kTopInterval 0.008802
#define kLeftInterval 0.0125
#define kBasicViewWidth 0.975
#define kBasicViewHeight 0.211267
#define kPicTopInterval 0.012323
#define kPicLeftInterval 0.01875
#define kPicWidth 0.2625
#define kStarHeight 0.035211
#define kNameTopInterval 0.021126
#define kNameDownInterval 0.008802
#define kNameLabelWidth 100/375.0
#define kNameLabelHeight 0.035211
#define kSexLabelwidth 0.04375
#define kAgeLabelWidth 0.05
#define kSecAgeLabelWidth 0.04375
#define kMarkLeftInterval 0.046875
#define kMarkLabelWidth 0.08125
#define kSecMarkWidth 0.15625
#define kTextViewWidth 0.65625
#define kTextViewHeight 0.132042
#define kPicWidthRatio 85.0f/320.0f
#define kButtonWidth 0.24375*2
#define kButtonHeight 0.056338
#define kScrollViewHeight 0.492957
#define kBasicDownInterval 0.007042
#define kLineViewHeight 0.5
#define kEmptyViewHeight 0.017605
#define kTabBarHeight 100.0/736.0

@interface DoctorDetailViewController ()
@property (strong, nonatomic) Doctor *localDoctor;
@property (strong, nonatomic) UIView *basicInfoView;
@property (strong, nonatomic) UIImageView *docPic;
@property (strong, nonatomic) UILabel *docNameLabel;
@property (strong, nonatomic) UILabel *sexLabel;
@property (strong, nonatomic) UILabel *ageLabel;
@property (strong, nonatomic) UILabel *secAgeLabel;
@property (strong, nonatomic) UILabel *markLabel;
@property (strong, nonatomic) UILabel *secMarkLabel;

@property (strong, nonatomic) UIButton *timeTableButton;
@property (strong, nonatomic) UIButton *docInfoButton;
@property (strong, nonatomic) UIButton *previousButton;

@property (strong, nonatomic) UITextView *introductionTextView;

@property (strong, nonatomic) DoctorInfoScrollView *docScrollView;
@property (strong, nonatomic) LoginViewController *loginView;
@property (strong, nonatomic) InformationConfirmViewController *infoVC;
@property (strong, nonatomic) StarRateView *docStarRate;
@property (strong, nonatomic) NSString *speStr;
@property (strong, nonatomic) MKNetworkOperation *netOp;

@end

@implementation DoctorDetailViewController
@synthesize localDoctor;
@synthesize basicInfoView;
@synthesize docPic;
@synthesize docNameLabel,secAgeLabel,ageLabel,sexLabel,markLabel,secMarkLabel;
@synthesize timeTableButton,docInfoButton;
@synthesize docScrollView;
@synthesize introductionTextView;
@synthesize docStarRate,speStr;
@synthesize netOp;
@synthesize infoVC,loginView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
    self.view.frame = CGRectMake(0, 0, KDeviceWidth, KDeviceHeight);
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
}
//初始化DoctorDetailViewController对象并获取医生对象
- (id)initWithDoctor:(Doctor *)doc DoctorList:(DoctorsListViewController *)docList{
    self = [super init];
    if (self) {
        self.docListView = docList;
        speStr = self.docListView.special;
        localDoctor = doc;
        basicInfoView = [[UIView alloc]initWithFrame:CGRectMake(kLeftInterval*KDeviceWidth, kTopInterval*KDeviceHeight+64, KDeviceWidth*kBasicViewWidth, kBasicViewHeight*KDeviceHeight)];
        basicInfoView.backgroundColor = [UIColor whiteColor];
        basicInfoView.layer.cornerRadius = 5;
        [self.view addSubview:basicInfoView];
        
        [self setMoreInfoButton];
        //初始化下部的scrollView
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
            docScrollView = [[DoctorInfoScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docInfoButton.frame), CGRectGetMaxY(timeTableButton.frame), kBasicViewWidth*KDeviceWidth,336) AndDoctor:localDoctor];
            docScrollView.userInteractionEnabled = YES;
        }
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
            docScrollView = [[DoctorInfoScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docInfoButton.frame), CGRectGetMaxY(timeTableButton.frame), kBasicViewWidth*KDeviceWidth,273) AndDoctor:localDoctor];
            docScrollView.userInteractionEnabled = YES;
        }
        if (KDeviceWidth>=374&&KDeviceWidth<=376) {
            docScrollView = [[DoctorInfoScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docInfoButton.frame), CGRectGetMaxY(timeTableButton.frame), kBasicViewWidth*KDeviceWidth,408) AndDoctor:localDoctor];
            docScrollView.userInteractionEnabled = YES;
        }
        if (KDeviceWidth>=413&&KDeviceWidth<=415) {
            docScrollView = [[DoctorInfoScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docInfoButton.frame), CGRectGetMaxY(timeTableButton.frame), kBasicViewWidth*KDeviceWidth,456) AndDoctor:localDoctor];
            docScrollView.userInteractionEnabled = YES;
        }
        [self.view addSubview:docScrollView];
        
        
        UIImageView *LineView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docInfoButton.frame), CGRectGetMaxY(timeTableButton.frame)-5, 2*kButtonWidth*KDeviceWidth, kLineViewHeight)];
        [LineView setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0]];
        
        //添加覆盖圆角的View
        UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(basicInfoView.frame), CGRectGetMaxY(LineView.frame), 2*kButtonWidth*KDeviceWidth, kEmptyViewHeight*KDeviceHeight)];
        emptyView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docInfoButton.frame), CGRectGetMaxY(timeTableButton.frame)-5, 0.5, 30)];
        [leftView setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0]];
        
        UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeTableButton.frame)-0.5, CGRectGetMaxY(timeTableButton.frame)-5, 0.5, 30)];
        [rightView setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0]];
        
        docPic = [[UIImageView alloc]initWithFrame:CGRectMake(kPicLeftInterval*KDeviceWidth, kPicTopInterval*KDeviceHeight, kPicWidth*KDeviceWidth, kPicWidth*KDeviceWidth)];
        docPic.image = [UIImage imageNamed:@"appCover"];
        
        docNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(docPic.frame)+kPicLeftInterval*KDeviceWidth, KDeviceHeight*kNameTopInterval, kNameLabelWidth*KDeviceWidth, kNameLabelHeight*KDeviceHeight)];
        
        sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(docNameLabel.frame), CGRectGetMinY(docNameLabel.frame), kSexLabelwidth*KDeviceWidth, kNameLabelHeight*KDeviceHeight)];
        
        ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sexLabel.frame)+kPicLeftInterval*KDeviceWidth, CGRectGetMinY(sexLabel.frame), kAgeLabelWidth*KDeviceWidth, kNameLabelHeight*KDeviceHeight)];
        
        secAgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ageLabel.frame), CGRectGetMinY(ageLabel.frame),kSecAgeLabelWidth*KDeviceWidth , kNameLabelHeight*KDeviceHeight)];
        secAgeLabel.text = @"岁";
        
        introductionTextView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docNameLabel.frame), CGRectGetMaxY(docNameLabel.frame)+kTopInterval*KDeviceHeight, kTextViewWidth*KDeviceWidth, kTextViewHeight*KDeviceHeight)];
        introductionTextView.userInteractionEnabled = NO;
        introductionTextView.editable = NO;
        introductionTextView.textContainerInset = UIEdgeInsetsZero;
        
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
            docStarRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docPic.frame)+8, CGRectGetMaxY(docPic.frame), 70, 12) numberOfStars:5];
            docStarRate.allowIncompleteStar = YES;
            docStarRate.hasAnimation = NO;
        }
        else{
            docStarRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docPic.frame), CGRectGetMaxY(docPic.frame)+(kPicTopInterval*KDeviceHeight)/2, KDeviceWidth*kPicWidth, kStarHeight*KDeviceHeight) numberOfStars:5];
            docStarRate.allowIncompleteStar = YES;
            docStarRate.hasAnimation = NO;
        }
        
        [self setContentOfLabel];
        [self setFont];
        [self addContentToBasicInfoView];
        [self.view addSubview:emptyView];
        [self.view addSubview:LineView];
        [self.view addSubview:leftView];
        [self.view addSubview:rightView];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//填充医生基本信息
- (void)addContentToBasicInfoView{
    [basicInfoView addSubview:docPic];
    [basicInfoView addSubview:docNameLabel];
    [basicInfoView addSubview:sexLabel];
    [basicInfoView addSubview:ageLabel];
    [basicInfoView addSubview:secAgeLabel];
    [basicInfoView addSubview:introductionTextView];
    [basicInfoView addSubview:docStarRate];
}

- (void)setContentOfLabel{
    if (!localDoctor.docName) {
        docNameLabel.text = @"";
    }
    else{
        docNameLabel.text = localDoctor.docName;
    }
    if (!localDoctor.docSex) {
        sexLabel.text = @"";
    }
    else{
        sexLabel.text = localDoctor.docSex;
    }
    if (!localDoctor.docAge) {
        ageLabel.text = @"";
    }
    else{
        ageLabel.text = localDoctor.docAge;
    }
    if (!localDoctor.docIntroduction) {
        introductionTextView.text = @"";
    }
    else{
        introductionTextView.text = localDoctor.docIntroduction;
    }
    if (!localDoctor.docMark) {
        docStarRate.scorePercent = 0/5.0;
    }
    else{
        docStarRate.scorePercent = [localDoctor.docMark floatValue]/5.0;
    }
}

- (void)setFont{
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
        docNameLabel.font = [UIFont systemFontOfSize:18];
        sexLabel.font = [UIFont systemFontOfSize:14];
        ageLabel.font = [UIFont systemFontOfSize:14];
        secAgeLabel.font = [UIFont systemFontOfSize:14];
        markLabel.font = [UIFont systemFontOfSize:11];
        secMarkLabel.font = [UIFont systemFontOfSize:11];
        introductionTextView.font = [UIFont systemFontOfSize:12];
        
        timeTableButton.titleLabel.font = [UIFont systemFontOfSize:15];
        docInfoButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
        docNameLabel.font = [UIFont systemFontOfSize:16];
        sexLabel.font = [UIFont systemFontOfSize:12];
        ageLabel.font = [UIFont systemFontOfSize:12];
        secAgeLabel.font = [UIFont systemFontOfSize:12];
        markLabel.font = [UIFont systemFontOfSize:10];
        secMarkLabel.font = [UIFont systemFontOfSize:10];
        introductionTextView.font = [UIFont systemFontOfSize:11];
        
        timeTableButton.titleLabel.font = [UIFont systemFontOfSize:13];
        docInfoButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
        docNameLabel.font = [UIFont systemFontOfSize:22];
        sexLabel.font = [UIFont systemFontOfSize:16];
        ageLabel.font = [UIFont systemFontOfSize:16];
        secAgeLabel.font = [UIFont systemFontOfSize:16];
        markLabel.font = [UIFont systemFontOfSize:13];
        secMarkLabel.font = [UIFont systemFontOfSize:13];
        introductionTextView.font = [UIFont systemFontOfSize:15];
        
        timeTableButton.titleLabel.font = [UIFont systemFontOfSize:17];
        docInfoButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415) {
        docNameLabel.font = [UIFont systemFontOfSize:24];
        sexLabel.font = [UIFont systemFontOfSize:18];
        ageLabel.font = [UIFont systemFontOfSize:18];
        secAgeLabel.font = [UIFont systemFontOfSize:18];
        markLabel.font = [UIFont systemFontOfSize:14];
        secMarkLabel.font = [UIFont systemFontOfSize:14];
        introductionTextView.font = [UIFont systemFontOfSize:17];
        
        timeTableButton.titleLabel.font = [UIFont systemFontOfSize:19];
        docInfoButton.titleLabel.font = [UIFont systemFontOfSize:19];
    }
}

//设置选项卡的按钮
- (void)setMoreInfoButton{
    
    docInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    docInfoButton.frame = CGRectMake(CGRectGetMinX(basicInfoView.frame), CGRectGetMaxY(basicInfoView.frame)+kBasicDownInterval*KDeviceHeight, kButtonWidth*KDeviceWidth, kButtonHeight*KDeviceHeight);
    [docInfoButton setBackgroundColor:[UIColor whiteColor]];
    [docInfoButton setTitle:@"医师信息" forState:UIControlStateNormal];
    [docInfoButton setTitleColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [docInfoButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    docInfoButton.layer.cornerRadius = 5;
    docInfoButton.tag = 0;
    [docInfoButton.layer setMasksToBounds:YES];
    [docInfoButton.layer setBorderWidth:0.5];
    CGColorSpaceRef infoColorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef infoColorref = CGColorCreate(infoColorSpace,(CGFloat[]){ 150.0/255.0,150.0/255.0, 150.0/255.0, 1 });
    [docInfoButton.layer setBorderColor:infoColorref];
    [docInfoButton addTarget:self action:@selector(chooseScrollViewPage:) forControlEvents:UIControlEventTouchUpInside];
    docInfoButton.selected = YES;
    [self.view addSubview:docInfoButton];
    
    timeTableButton = [UIButton buttonWithType:UIButtonTypeCustom];
    timeTableButton.frame = CGRectMake(CGRectGetMaxX(docInfoButton.frame), CGRectGetMinY(docInfoButton.frame), kButtonWidth*KDeviceWidth, kButtonHeight*KDeviceHeight);
    [timeTableButton setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255 blue:235.0/255.0 alpha:1.0]];
    timeTableButton.selected = NO;
    [timeTableButton setTitleColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [timeTableButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [timeTableButton setTitle:@"出诊时间" forState:UIControlStateNormal];
    timeTableButton.layer.cornerRadius = 5;
    timeTableButton.tag = 1;
    [timeTableButton.layer setMasksToBounds:YES];
    [timeTableButton.layer setBorderWidth:0.5];
    CGColorSpaceRef timecolorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef timecolorref = CGColorCreate(timecolorSpace,(CGFloat[]){ 150.0/255.0,150.0/255.0, 150.0/255.0, 1 });
    [timeTableButton.layer setBorderColor:timecolorref];
    [timeTableButton addTarget:self action:@selector(chooseScrollViewPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeTableButton];
    
    self.previousButton = docInfoButton;
}
//获取点击按钮的tag值，并且改变选中按钮的背景颜色
- (void)chooseScrollViewPage:(UIButton *)sender{
    [docScrollView getButtonID:sender.tag];
    self.previousButton.selected = NO;
    sender.selected = YES;
    [self.previousButton setBackgroundColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255 blue:235.0/255.0 alpha:1.0]];
    [sender setBackgroundColor:[UIColor whiteColor]];
    self.previousButton = sender;
}

- (void)pushToOrderConfirmViewWithPrice:(float)price{
    if (price != 0) {
        //正常获取到订单价格数据
        Order *newOrder = [[Order alloc]initWithOrderId:nil Doctorname:localDoctor.docName OrderDate:nil Duration:docScrollView.timeTableViewController.selectedTimeLong PatientName:nil PatientTel:nil DoctorId:localDoctor.docID StartTime:docScrollView.timeTableViewController.outputTimeInterval Special:speStr Address:nil CommentId:nil Description:nil Status:@"wait_for_pay" Price:price Distane:0 Age:0 Sex:nil RejectReason:@""];
        infoVC = [[InformationConfirmViewController alloc]initWithOrder:newOrder DocDetail:self Path:@"in"];
        docScrollView.timeTableViewController.selectedTimeLong = 0;//清空数据
        [self updateOrderInformation:newOrder];
        NSArray *gpsArray = [self.localDoctor.docGPS componentsSeparatedByString:@","];
        infoVC.doctorLng = [[gpsArray objectAtIndex:1]doubleValue];
        infoVC.doctorLat = [[gpsArray objectAtIndex:0]doubleValue];
        infoVC.outputStartPosition = docScrollView.timeTableViewController.outputStartPosition;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    else{
        //初试订单金额为0
        Order *newOrder = [[Order alloc]initWithOrderId:nil Doctorname:localDoctor.docName OrderDate:nil Duration:docScrollView.timeTableViewController.selectedTimeLong PatientName:nil PatientTel:nil DoctorId:localDoctor.docID StartTime:docScrollView.timeTableViewController.outputTimeInterval Special:speStr Address:nil CommentId:nil Description:nil Status:@"wait_for_pay" Price:0 Distane:0 Age:0 Sex:nil RejectReason:@""];
        infoVC = [[InformationConfirmViewController alloc]initWithOrder:newOrder DocDetail:self Path:@"in"];
        docScrollView.timeTableViewController.selectedTimeLong = 0;//清空数据
        [self updateOrderInformation:newOrder];
        NSArray *gpsArray = [self.localDoctor.docGPS componentsSeparatedByString:@","];
        infoVC.doctorLng = [[gpsArray objectAtIndex:1]doubleValue];
        infoVC.doctorLat = [[gpsArray objectAtIndex:0]doubleValue];
        infoVC.outputStartPosition = docScrollView.timeTableViewController.outputStartPosition;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}

- (void)updateOrderInformation:(Order *)order{
    
    NSDictionary *defaultPatinet = [self getCurrentPosition];
    if (defaultPatinet) {
        order.patientName = [defaultPatinet objectForKey:@"patientName"];
        if ([[defaultPatinet objectForKey:@"patientSex"] isEqualToString:@"female.jpg"]) {
            order.patientSex = @"女";
        }
        else{
            order.patientSex = @"男";
        }
        order.patientAge = [[defaultPatinet objectForKey:@"patientAge"]intValue];
        order.patientTel = [defaultPatinet objectForKey:@"patientTel"];
        order.address = [defaultPatinet objectForKey:@"patientAddress"];
        infoVC.userLng = [[defaultPatinet objectForKey:@"lng"]doubleValue];
        infoVC.userLat = [[defaultPatinet objectForKey:@"lat"]doubleValue];
    }
}

//从数据库获得病人数据
- (NSDictionary *)getCurrentPosition{
    // NSMutableDictionary *answer = [[NSMutableDictionary alloc]init];
    
    //获取plist字典
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableArray *patients = [plistDictionary objectForKey:@"patients"];
    if (!patients){
        return nil;
    }
    else{
        for (NSDictionary *patient in patients) {
            if ([[patient objectForKey:@"isDefault"]isEqualToString:@"yes"]) {
                return patient;
            }
        }
    }
    return nil;
}

- (NSString *)getFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    return documentPlistPath;
}

- (NSMutableDictionary *)getDefaultUserPosition{
    //获取plist字典
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
    return currentPosition;
}

- (void)goToInformationConfirmView{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSMutableDictionary *userLocation = [self getDefaultUserPosition];
    double userLng = [[userLocation objectForKey:@"lng"]doubleValue];
    double userLat = [[userLocation objectForKey:@"lat"]doubleValue];
    if (userLat == 0 && userLng == 0) {
        //没有用户定位数据
        docScrollView.timeTableViewController.selectedTimeLong = 0;//清空数据
        [self pushToOrderConfirmViewWithPrice:0];
    }
    else{
        NSArray *gpsArray = [self.localDoctor.docGPS componentsSeparatedByString:@","];
        double doctorLng = [[gpsArray objectAtIndex:1]doubleValue];
        double doctorLat = [[gpsArray objectAtIndex:0]doubleValue];
        
        BMKMapPoint doctorPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(doctorLat,doctorLng));
        BMKMapPoint userPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(userLat,userLng));
        
        CLLocationDistance distance = BMKMetersBetweenMapPoints(doctorPosition,userPosition)/1000;
        int intDistance = ceil(distance);
        NSLog(@"int distance = %d",intDistance);
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        NSString *durationString = [NSString stringWithFormat:@"%ld",(long)docScrollView.timeTableViewController.selectedTimeLong];
        NSString *distanceString = [NSString stringWithFormat:@"%d",intDistance];
        [data setValue:durationString forKey:@"duration"];
        [data setValue:distanceString forKey:@"distance"];
        [data setValue:self.localDoctor.docID forKey:@"doctorId"];
        
        netOp = [appDelegate.netEngine operationWithPath:@"/price.php" params:data httpMethod:@"POST"];
        __block DoctorDetailViewController *localSelf = self;
        [netOp addCompletionHandler:^(MKNetworkOperation *operation){
            id json = [operation responseJSON];
            NSDictionary *dic = (NSDictionary *)json;
            NSString *code = [dic objectForKey:@"code"];
            float orderPrice = 0;
            if ([code isEqualToString:@"100"]) {
                orderPrice = [[dic objectForKey:@"price"]floatValue];
                [localSelf pushToOrderConfirmViewWithPrice:orderPrice];
            }
            
        } errorHandler:^(MKNetworkOperation *operation,NSError *error){
            NSLog(@"网络加载失败！");
        }
         ];
        [appDelegate.netEngine enqueueOperation:netOp];
    }
}

@end
