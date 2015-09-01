//
//  SettingsViewController.m
//  Pan大夫
//
//  Created by zxy on 2/24/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "SettingsViewController.h"
#import "UserTableViewController.h"
#import "MyScrollView.h"
#import "TestViewController.h"
#import "LoginViewController.h"

@interface SettingsViewController ()


@property (strong, nonatomic) UserTableViewController *userTableView;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UILabel *userLabel;
@property (nonatomic, strong) NSArray  *imageArray;
@property (nonatomic, strong) MyScrollView *myScrollView;
@property(nonatomic) int firstLoad;
@property (strong, nonatomic)UILabel *IDlabel;

@end

@implementation SettingsViewController

@synthesize loginButton;
@synthesize userTableView;
@synthesize userLabel;
@synthesize imageArray;
@synthesize myScrollView;
@synthesize IDlabel;

-(id)init{
    self = [super init];
    if (self) {
        NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory =[paths objectAtIndex:0];
        NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
        NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
        
        NSString *localNum = [NSString new];
        if ([plistDictionary objectForKey:@"login"]) {
            localNum = [plistDictionary objectForKey:@"login"];
        }
        if (localNum.length == 11) {
            self.IDNum = localNum;
        }else{
            self.IDNum = nil;
        }


    }
    NSLog(@"in the setting view %@ ~~~~~~~~~~~~~~~~~%@", self, self.navigationController);
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
#if 1
    if (self.IDNum) {
        
        NSLog(@"******id num is :%@ ******", self.IDNum);
    }else{
        LoginViewController *loginViewController = [[LoginViewController alloc]initWithNav:YES SettingsViewController:self];
        loginViewController.hidesBottomBarWhenPushed = YES;
        loginViewController.title = @"注册";
        [self.navigationController pushViewController:loginViewController animated:NO];
        NSLog(@"******nil******");
    }
#endif
}

//-(NSString *)IDNum{
//    if (! IDlabel) {
//        _IDNum = [NSString new];
//        NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//        NSString *documentsDirectory =[paths objectAtIndex:0];
//        NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
//        NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
//        NSString *localNum = [[NSString alloc]initWithString:[plistDictionary objectForKey:@"login"]];
//        if (localNum.length == 11) {
//            _IDNum = localNum;
//        }else{
//            _IDNum = nil;
//        }
//    }
//    NSLog(@" id num :%@", _IDNum);
//    return _IDNum;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //下方表格
    userTableView = [[UserTableViewController alloc]initWithFrame:CGRectMake(0, 64 + userImageH, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height- userImageH -tableUp)];
    [self.view addSubview:userTableView.tableView];
    userTableView.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    
    // 登录的lable
    IDlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, userImageH + 64, [[UIScreen mainScreen]bounds].size.width, 60)];
    IDlabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:230/255.0 blue:230/255.0 alpha:0.3];
    IDlabel.textAlignment = NSTextAlignmentCenter;
    IDlabel.font = [UIFont systemFontOfSize:25];
    if (self.IDNum == nil) {
        IDlabel.text = @"请登陆";
    }else{
        IDlabel.text = self.IDNum;
    }
    [self.view addSubview:IDlabel];
}


-(void)pushNavigationController
{
    int index = self.myScrollView.contentOffset.x / userImageW;
    if (index + 2 - self.myScrollView.contentSize.width/userImageW >= 0) {
        index = index + 2 - self.myScrollView.contentSize.width/userImageW;
    }   //此时的index对应myscrollView 中第index张图片，从0开始计算
    
    TestViewController *testViewController = [[TestViewController alloc]init];
    [testViewController setIndex:index];
    [myScrollView endTimer];
    [self.navigationController pushViewController:testViewController animated:YES];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_firstLoad == 0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"introduction"], [UIImage imageNamed:@"question"],[UIImage imageNamed:@"report"],nil];
        myScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 64, userImageW, userImageH) ImageArray:imageArray isURL:NO TimeInterval:3.0];
        [myScrollView setPageControlWithFrame:CGRectMake(0, scrollY+64 , scrollW, scrollH)];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushNavigationController)];
        singleTap.numberOfTapsRequired = 1;
        [myScrollView addGestureRecognizer:singleTap];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        doubleTap.numberOfTapsRequired = 2;
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [myScrollView addGestureRecognizer:doubleTap];
        
        [self.view addSubview:myScrollView];
        _firstLoad++;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userDidLogin:(NSString*)IDNum{
    self.IDNum = IDNum;
    IDlabel.text = IDNum;
}


@end
