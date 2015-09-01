//
//  ViewController.m
//  Demo_homepage
//
//  Created by lf on 15/3/7.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import "ServiceItemViewController.h"

#define IS_IPHONE_4S_SCREEN [[UIScreen mainScreen]bounds].size.height<=485.0f&&[[UIScreen mainScreen]bounds].size.height>=475.0f
#define IS_IPHONE_5S_SCREEN [[UIScreen mainScreen]bounds].size.height<=570.0f&&[[UIScreen mainScreen]bounds].size.height>=565.0f
#define IS_IPHONE_6_SCREEN [[UIScreen mainScreen]bounds].size.height<=670.0f&&[[UIScreen mainScreen]bounds].size.height>=660.0f
#define IS_IPHONE_6plus_SCREEN [[UIScreen mainScreen]bounds].size.height<=740.0f&&[[UIScreen mainScreen]bounds].size.height>=735.0f

@interface ServiceItemViewController ()

@end

@implementation ServiceItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (id)initWithPushDelegate:(HomeViewController *)Delegate
{
    self = [super init];
    if (self) {
        self.pushDelegate = Delegate;
    }
    return self;
}

@end
