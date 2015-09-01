//
//  ServiceItemSViewController.m
//  Pan大夫
//
//  Created by nineteen. on 8/25/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "ServiceItemSViewController.h"
#import "ServiceItemSTableViewCell.h"
#import "TestViewController.h"

@interface ServiceItemSViewController () <UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong) NSMutableArray *arrayM;
@end
@implementation ServiceItemSViewController
@synthesize myTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.rowHeight = 160;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
}
// 懒加载
- (NSMutableArray *)arrayM
{
    if (_arrayM == nil) {
        _arrayM  = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"first"],[UIImage imageNamed:@"second"],[UIImage imageNamed:@"third"], nil];
    }
    return _arrayM;
}

#pragma mark - dataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    ServiceItemSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ServiceItemSTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setMyImage:self.arrayM[indexPath.row]];
    }
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"跳转");
//    TestViewController *testVC = [[TestViewController alloc]init];
//    [testVC setIndex:indexPath.row];
//    NSLog(@"%@",self.navigationController);
//    [self.navigationController pushViewController:testVC animated:YES];
//    [self presentViewController:testVC animated:YES completion:nil];
    [self.pushDelegate cellTapedPushWithNumber:indexPath.row];
}

#pragma mark -
- (id)initWithPushDelegate:(HomeViewController *)Delegate
{
    self = [super init];
    if (self) {
        self.pushDelegate = Delegate;
    }
    return self;
}

@end
