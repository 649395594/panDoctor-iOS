//
//  AppDelegate.m
//  Pan大夫
//
//  Created by zxy on 2/16/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "DiagnosisViewController.h"
#import "ResourcesViewController.h"
#import "SettingsViewController.h"

#import "SDImageCache.h"//清除此前缓存

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <RennSDK/RennSDK.h>
#import <SMS_SDK/SMS_SDK.h>
#import "MobClick.h"

#define KSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
@interface AppDelegate ()
@property (strong, nonatomic) HomeViewController *homeView;
@property (strong, nonatomic) DiagnosisViewController *diagnosisView;
@property (strong, nonatomic) ResourcesViewController *resourcesView;
@property (strong, nonatomic) SettingsViewController *settingsView;
@property (strong, nonatomic) NSData *receiveData;
@property (strong, nonatomic) NSString *userLocationLat;
@property (strong, nonatomic) NSString *userLocationLng;
@end

@implementation AppDelegate
@synthesize homeView,diagnosisView,resourcesView,settingsView;
@synthesize _mapManager,netEngine,currentCity,currentAddress;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化MKNetworkKit引擎
    netEngine = [[MKNetworkEngine alloc]initWithHostName:HOSTNAME customHeaderFields:nil];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabBarController = [[UITabBarController alloc]init];

    homeView = [[HomeViewController alloc]init];
    homeView.view.backgroundColor = [UIColor whiteColor];
    diagnosisView = [[DiagnosisViewController alloc]init];
    diagnosisView.view.backgroundColor = [UIColor whiteColor];
    resourcesView = [[ResourcesViewController alloc]init];
    resourcesView.view.backgroundColor = [UIColor whiteColor];
    settingsView = [[SettingsViewController alloc]init];
    settingsView.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *homeNavigationController = [[UINavigationController alloc]initWithRootViewController:homeView];
    UINavigationController *diagnosisNavigationController = [[UINavigationController alloc]initWithRootViewController:diagnosisView];
    UINavigationController *resourcesNavigationController = [[UINavigationController alloc]initWithRootViewController:resourcesView];
    UINavigationController *settingsNavigationController = [[UINavigationController alloc]initWithRootViewController:settingsView];
    
    resourcesNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    homeNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    diagnosisNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    settingsNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    
    [[UINavigationBar appearance]setTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0]];
    
    homeNavigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0],NSFontAttributeName : [UIFont boldSystemFontOfSize:20]};
    diagnosisNavigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0],NSFontAttributeName : [UIFont boldSystemFontOfSize:28]};
    diagnosisView.title = @"Pan 大夫";
    resourcesNavigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0],NSFontAttributeName : [UIFont boldSystemFontOfSize:28]};
    resourcesView.title = @"Pan 大夫";
    settingsNavigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0],NSFontAttributeName : [UIFont boldSystemFontOfSize:28]};
    settingsView.title = @"Pan 大夫";
    
    NSArray *viewControllers = [[NSArray alloc]initWithObjects:homeNavigationController,diagnosisNavigationController,resourcesNavigationController,settingsNavigationController, nil];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = viewControllers;
    
    UIImage *tabbar_1_nromal = [UIImage imageNamed:@"icons_01_unpressed"];
    tabbar_1_nromal = [tabbar_1_nromal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabbar_1_selected = [UIImage imageNamed:@"icons_01_pressed"];
    tabbar_1_selected = [tabbar_1_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabbar_2_normal = [UIImage imageNamed:@"icons_02_unpressed"];
    tabbar_2_normal = [tabbar_2_normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabbar_2_selected = [UIImage imageNamed:@"icons_02_pressed"];
    tabbar_2_selected = [tabbar_2_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabbar_3_normal = [UIImage imageNamed:@"icons_03_unpressed"];
    tabbar_3_normal = [tabbar_3_normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabbar_3_selected = [UIImage imageNamed:@"icons_03_pressed"];
    tabbar_3_selected = [tabbar_3_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabbar_4_normal = [UIImage imageNamed:@"icons_03_unpressed"];
    tabbar_4_normal = [tabbar_4_normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabbar_4_selected = [UIImage imageNamed:@"icons_03_pressed"];
    tabbar_4_selected = [tabbar_4_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"首页" image:tabbar_1_nromal selectedImage:tabbar_1_selected];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"自测" image:tabbar_2_normal selectedImage:tabbar_2_selected];
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTitle:@"资源" image:tabbar_3_normal selectedImage:tabbar_3_selected];
    UITabBarItem *item4 = [[UITabBarItem alloc]initWithTitle:@"我的" image:tabbar_4_normal selectedImage:tabbar_4_selected];
    
    //改变tabbarItem的字体选中颜色
    [item1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:41/255.0 green:188/255.0 blue:154/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [item2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:41/255.0 green:188/255.0 blue:154/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [item3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:41/255.0 green:188/255.0 blue:154/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [item4 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:41/255.0 green:188/255.0 blue:154/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    homeView.tabBarItem = item1;
    diagnosisView.tabBarItem = item2;
    resourcesView.tabBarItem = item3;
    settingsView.tabBarItem = item4;
    
    [self.window addSubview:self.tabBarController.view];
    [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
    
    //[[SDImageCache sharedImageCache] clearDisk];//清除缓存
    
    //创建数据库文件，不存在的话就复制过来
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentLibraryFolderPath = [documentsDirectory stringByAppendingPathComponent:@"CoreDataQuestions.sqlite"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:documentLibraryFolderPath]) {
        NSLog(@"数据库已经存在了");
    }
    else {
        NSString *resourceFolderPath =
        [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"CoreDataQuestions.sqlite"];
        NSData *mainBundleFile = [NSData dataWithContentsOfFile:resourceFolderPath];
        [[NSFileManager defaultManager] createFileAtPath:documentLibraryFolderPath
        contents:mainBundleFile attributes:nil];
        NSLog(@"%@",resourceFolderPath);
    }
    NSLog(@"%@",[[NSBundle mainBundle]resourcePath]);
    
    //创建plist文件存储信息
    NSString *ducumentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    if ([[NSFileManager defaultManager] fileExistsAtPath:ducumentPlistPath]) {
        NSLog(@"%@",ducumentPlistPath);
        NSLog(@"plist文件已经存在了");
    }
    else{
        NSString *resourcePlistPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"login.plist"];
        NSData *resourcePlistFile = [NSData dataWithContentsOfFile:resourcePlistPath];
        [[NSFileManager defaultManager] createFileAtPath:ducumentPlistPath contents:resourcePlistFile attributes:nil];
        NSLog(@"%@",resourcePlistPath);
    }
    
    ducumentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];//plist文件位置
    if ([[NSFileManager defaultManager] fileExistsAtPath:ducumentPlistPath]) {
        NSLog(@"%@",ducumentPlistPath);
        NSLog(@"plist文件已经存在了");
    }
    else{
        NSString *resourcePlistPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"test.plist"];
        NSData *resourcePlistFile = [NSData dataWithContentsOfFile:resourcePlistPath];
        [[NSFileManager defaultManager] createFileAtPath:ducumentPlistPath contents:resourcePlistFile attributes:nil];
        NSLog(@"%@",resourcePlistPath);
    }
    
    //友盟SDK
    [MobClick startWithAppkey:@"54d5d023fd98c5ef39000456" reportPolicy:BATCH   channelId:nil];
    
    [SMS_SDK registerApp:@"5cfc3e5fa7f0" withSecret:@"c3f676e1b746b4ed5e5399cadaa098a1"];
    [ShareSDK registerApp:@"5cf48837bf7a"];//字符串api20为您的ShareSDK的AppKey
    
    
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"1432634072"
                                appSecret:@"20749deef5769ae92e03a02e587d7e9c"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1104292219"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1104292219"
                           appSecret:@"DWNwr1RoWExqDZH5"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx47e8140424643cbe"   //微信APPID
                           appSecret:@"2b451d61eccbd5c326f3d6b8144ce210"  //微信APPSecret
                           wechatCls:[WXApi class]];
    
    //创建百度地图相关应用
    _mapManager = [[BMKMapManager alloc]init];
    [_mapManager start:@"dkA2wPKIfOQOINv2Uu9SFCvD"  generalDelegate:nil];
    
    //初始化BMKLocationService
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    if(KSystemVersion >= 8.0){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
        
    }
    
    if (launchOptions) {
        if([self pushNotificationOpen]){//推送打开
            //推送启动
            NSDictionary* pushNotificationKey = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
            if (pushNotificationKey) {
                if([UIApplication sharedApplication].applicationIconBadgeNumber>0){
                    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                }
                //[self didReceiveRemoteNotification:pushNotificationKey];
            }
        }
    }
    else{
        if([UIApplication sharedApplication].applicationIconBadgeNumber>0){
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.map.baidu.com/geocoder/v2/?ak=iX2vhvv808qj9Ngf1E69BcQF&location=%f,%f&output=json&pois=0",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    self.userLocationLat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    self.userLocationLng = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    
    //第二步，创建请求
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //第三步，连接服务器
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.receiveData = data;
}

//数据传完之后调用此方法

-(void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    id jsonObj = [NSJSONSerialization JSONObjectWithData:self.receiveData options:NSJSONReadingMutableLeaves error:nil];
    if (jsonObj) {
        NSDictionary *totalData = (NSDictionary *)jsonObj;
        NSDictionary *result = [totalData objectForKey:@"result"];
        NSDictionary *address = [result objectForKey:@"addressComponent"];
        NSString *city = [address objectForKey:@"city"];
        NSString *formattedAddress = [result objectForKey:@"formatted_address"];
        if (city && !([city isEqualToString:@""])) {
            currentCity = [city substringToIndex:[city length]-1];
        }
        else{
            currentCity = [NSString stringWithFormat:@""];
        }
        if (formattedAddress && !([formattedAddress isEqualToString:@""])) {
            currentAddress = formattedAddress;
        }
        else{
            currentAddress = [NSString stringWithFormat:@""];
        }
    }
    NSLog(@"current city = %@\ncurrent address = %@",currentCity,currentAddress);
//    [homeView getUserLocationFromNet];

    NSMutableDictionary *location = [[NSMutableDictionary alloc]init];
    [location setObject:currentAddress forKey:@"patientNeighbourhood"];
    [location setObject:self.userLocationLat forKey:@"lat"];
    [location setObject:self.userLocationLng forKey:@"lng"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseDefaultAddressByAppdelegate"object:location];
}

//成功向ANPS服务器发送token之后被调用的方法
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken{
    NSLog(@"token = %@",pToken);
}

//收到远程推送后执行的方法
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
}

//判断推送是否打开
- (BOOL)pushNotificationOpen{
    if (KSystemVersion >= 8.0){
        UIUserNotificationType types = [[UIApplication sharedApplication] currentUserNotificationSettings].types;
        return (types & UIUserNotificationTypeAlert);
    }
    else{
        UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        return (types & UIRemoteNotificationTypeAlert);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end