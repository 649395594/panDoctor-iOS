//
//  EventDetailViewController.m
//  Pan大夫
//
//  Created by 张星宇 on 15/10/20.
//  Copyright © 2015年 Neil. All rights reserved.
//

#import "EventDetailViewController.h"

@implementation EventDetailViewController

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 175, 100)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"活动详情页面" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
}

@end
