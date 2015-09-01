//
//  HomeViewController.m
//  Pan大夫
//
//  Created by zxy on 2/26/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "DoctorDetailViewController.h"
#import "ChooseCurrentCity.h"
#import "ServiceItemViewController.h"
#import "ServiceItemSViewController.h"
#import "TestViewController.h"

#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define KSegmentWidth 150
@interface HomeViewController ()

@property (strong, nonatomic) ServiceItemViewController *serviceItemVC;
@property (strong, nonatomic) ChooseCurrentCity *chooseCityView;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSString *defaultCity;
@property (strong, nonatomic) ServiceItemSViewController *serviceItemSVC;
@property (strong, nonatomic) UISegmentedControl *segment;
@end

@implementation HomeViewController

@synthesize serviceItemVC,doctorListVC,chooseCityView,serviceItemSVC;
@synthesize appDelegate;
@synthesize leftButton;
@synthesize segment;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
    [currentPosition setObject:@"沈阳" forKey:@"defaultCity"];
    [plistDictionary writeToFile:[self getFilePath] atomically:YES];
    if (![currentPosition objectForKey:@"defaultCity"]) {
       self.defaultCity = @"沈阳";
    }
    else{
        self.defaultCity = [currentPosition objectForKey:@"defaultCity"];
    }
    [self createLeftButton];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //设置segment controller
    NSArray *segmentTitles = [[NSArray alloc]initWithObjects:@"专项",@"医师", nil];
    segment = [[UISegmentedControl alloc]initWithItems:segmentTitles];
    [segment setTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0]];
    segment.frame = CGRectMake(0, (KSegmentWidth-KSegmentWidth)/2, KSegmentWidth, 30);
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    
    //设置右侧分享按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    serviceItemVC = [[ServiceItemViewController alloc]initWithPushDelegate:self];
    serviceItemVC.view.frame = CGRectMake(0, 64, KDeviceWidth, KDeviceHeight - 64 -49);
    
//    serviceItemSVC = [[ServiceItemSViewController alloc]init];
    serviceItemSVC = [[ServiceItemSViewController alloc]initWithPushDelegate:self];
    serviceItemSVC.view.frame = CGRectMake(0, 64, KDeviceWidth, KDeviceHeight - 64 - 49);
    
    doctorListVC = [[DoctorsListViewController alloc]initWithDelegate:self Special:nil];
    doctorListVC.view.frame = CGRectMake(0, 64, KDeviceWidth, KDeviceHeight - 64 -49);
    [self.view addSubview:serviceItemSVC.myTableView];
//    [self.view addSubview:serviceItemVC.view];
    [self.view addSubview:doctorListVC.view];
    doctorListVC.view.hidden = YES;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentAction:(UISegmentedControl *)segment{
    NSInteger index = segment.selectedSegmentIndex;
  
    NSLog(@"%ld",(long)index);
    switch (index) {
        case 0:{
//            serviceItemVC.view.hidden = NO;
            serviceItemSVC.view.hidden = NO;
            doctorListVC.view.hidden = YES;
            break;
        }
        case 1:{
//            serviceItemVC.view.hidden = YES;
            serviceItemSVC.view.hidden = YES;
            doctorListVC.view.hidden = NO;
            NSLog(@"%ld",(long)index);
            break;
        }
        default:
            break;
    }
}

- (void)share:(id)sender{
    //NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    id<ISSCAttachment> shareImage = [ShareSDK pngImageWithImage:[UIImage imageNamed:@"appCover"]];
    //构造分享内容
    /**
     *  @param content 副标题
     *  @param defaultContent 不知道干啥的,估计是副标题的备胎
     *  @param image 展示用的图片
     *  @param title 主标题
     *  @param url 点击进去之后跳转的网页页面
     *  @param description QQ空间分享时用到的描述
     */
    id<ISSContent> publishContent = [ShareSDK content:@"我发现了一个非常不错的应用，快来下载吧"
                                       defaultContent:@"我发现了一个非常不错的应用，快来下载吧"
                                                image:shareImage
                                                title:@"Pan大夫——您身边的健康专家"
                                                  url:@"http://itunes.apple.com/app/id963586976"
                                          description:@"我发现了一个非常不错的应用，快来下载吧"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}       
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)cellTapedPushWith:(Doctor *)doc Special:(NSString *)special DoctorList:(DoctorsListViewController *)docList{
        DoctorDetailViewController *docDetailView = [[DoctorDetailViewController alloc]initWithDoctor:doc DoctorList:docList];
        docDetailView.hidesBottomBarWhenPushed = YES;
        docDetailView.title = @"医师信息";
        [self.navigationController pushViewController:docDetailView animated:YES];
}

-(void)cellTapedPushWithNumber:(int)number{
    TestViewController *testVC = [[TestViewController alloc]initWithIndex:number];
    [self.navigationController pushViewController:testVC animated:YES];
}

//创建首页左侧顶部定位城市按钮
- (void)createLeftButton{
    leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [leftButton setTitle:self.defaultCity forState:UIControlStateNormal];
    leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [leftButton setTitleColor:[UIColor colorWithRed:3/255.0 green:175/255.0 blue:170/255.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(createChooseCityView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)createChooseCityView{
    if (!chooseCityView) {
        chooseCityView = [[ChooseCurrentCity alloc]initWithCurrentCity:appDelegate.currentCity HomeDelegate:self];
    }
    [self.navigationController presentViewController:chooseCityView animated:YES completion:^(void){}];
}

- (NSString *)getFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    return documentPlistPath;
}
@end
