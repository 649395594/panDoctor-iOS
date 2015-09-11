//
//  ViewController.m
//  Demo_homepage
//
//  Created by lf on 15/3/7.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import "ServiceItemViewController.h"
#import "ServiceItemViewModel.h"
#import <MJRefresh.h>

#define kCellHeight 160.f
#define kImageMargin 5.f

@interface ServiceItemViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ServiceItemViewModel *serviceItemViewModel;
@property (strong, nonatomic) NSArray *modelArray;
@property (strong, nonatomic) UIImageView *cellImageView;

@end

@implementation ServiceItemViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _serviceItemViewModel = [[ServiceItemViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 -49)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[_serviceItemViewModel fetchItemPictureUrlWithPage:1] subscribeNext:^(id x) {
            _modelArray = x;
        } error:^(NSError *error) {
            ;
        } completed:^{
            [_tableView.header endRefreshing];
            [_tableView reloadData];
        }];
    }];
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [_tableView.footer endRefreshing];
    }];

    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_modelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceItemCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ServiceItemCell"];
        _cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kImageMargin, kImageMargin, kScreenWidth - 2 * kImageMargin, kCellHeight - 2 * kImageMargin)];
        _cellImageView.layer.masksToBounds = YES;
        _cellImageView.layer.cornerRadius = 10;
        [cell.contentView addSubview:_cellImageView];
    }
    _cellImageView.image = [UIImage imageNamed:@"2x_star_bigfull"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];  // 取消选中状态
}

@end
