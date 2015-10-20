//
//  ViewController.m
//  Demo_homepage
//
//  Created by lf on 15/3/7.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import "ServiceItemViewController.h"
#import "EventDetailViewController.h"
#import "ServiceItemViewModel.h"


#import "UIImageView+WebCache.h"
#import <MJRefresh.h>
#import <MBProgressHUD.h>

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
        [self showHud];

        [[_serviceItemViewModel fetchItemPictureUrlWithPage:_currentPageNumber] subscribeNext:^(id x) {
            _modelArray = x;
        } error:^(NSError *error) {
            
        } completed:^{
            [self hideHud];
            [_tableView.header endRefreshing];
            [_tableView reloadData];
        }];
    }];
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _currentPageNumber ++;
        [self showHud];
        [[_serviceItemViewModel fetchItemPictureUrlWithPage:_currentPageNumber] subscribeNext:^(id x) {
            _modelArray = x;
        } error:^(NSError *error) {
            if ([error.domain isEqualToString:NoUrlError]) {
                [self hideHud];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有更多数据了" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
            };
            [_tableView.footer endRefreshing];
        } completed:^{
            [self hideHud];
            [_tableView.footer endRefreshing];
            [_tableView reloadData];
        }];
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
    [_cellImageView sd_setImageWithURL:[NSURL URLWithString:[_modelArray objectAtIndex:[indexPath row]]] placeholderImage:[UIImage imageNamed:@"ImageLoadError"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];  // 取消选中状态
    EventDetailViewController *eventDetailViewController = [[EventDetailViewController alloc] init];
    [self.delegate pushViewController:eventDetailViewController animated:YES];
}

- (void)showHud{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:_tableView];
    [self.view addSubview:hud];
    hud.labelText = @"加载中";
    [hud show:YES];
}

- (void)hideHud{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end
