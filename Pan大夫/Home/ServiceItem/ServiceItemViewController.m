//
//  ViewController.m
//  Demo_homepage
//
//  Created by lf on 15/3/7.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import "ServiceItemViewController.h"
#import "ServiceItemViewModel.h"
#import "UIImageView+WebCache.h"
#import <MJRefresh.h>

#define kCellHeight 160.f
#define kImageMargin 5.f

@interface ServiceItemViewController ()<UITableViewDataSource, UITableViewDelegate>{
    int _currentPageNumber;
}

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
        _currentPageNumber = 1;
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
        _currentPageNumber = 1;
        [[_serviceItemViewModel fetchItemPictureUrlWithPage:_currentPageNumber] subscribeNext:^(id x) {
            _modelArray = x;
        } error:^(NSError *error) {
            ;
        } completed:^{
            [_tableView.header endRefreshing];
            [_tableView reloadData];
        }];
    }];
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _currentPageNumber ++;
        [[_serviceItemViewModel fetchItemPictureUrlWithPage:_currentPageNumber] subscribeNext:^(id x) {
            _modelArray = x;
        } error:^(NSError *error) {
            ;
        } completed:^{
            [_tableView.footer endRefreshing];
            [_tableView reloadData];
        }];
    }];

    [self.view addSubview:_tableView];
    if ([_modelArray count] == 0) {
        [_tableView.header beginRefreshing];
    }
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
    [_cellImageView sd_setImageWithURL:[NSURL URLWithString:[_modelArray objectAtIndex:[indexPath row]]] placeholderImage:[UIImage imageNamed:@"ImageLoadError"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];  // 取消选中状态
}

@end
