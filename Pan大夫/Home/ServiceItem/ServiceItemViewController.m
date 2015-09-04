//
//  ViewController.m
//  Demo_homepage
//
//  Created by lf on 15/3/7.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import "ServiceItemViewController.h"
#import "ServiceItemTableView.h"

@interface ServiceItemViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) ServiceItemTableView *tableView;

@end

@implementation ServiceItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 -49)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[ServiceItemTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
}

@end
