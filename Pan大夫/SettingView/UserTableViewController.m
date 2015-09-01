//
//  userTableViewController.m
//  Pan大夫
//
//  Created by xjq on 15/3/11.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "UserTableViewController.h"
#import "AboutUSViewController.h"
#import "InformationViewController.h"
#import "MyOrderViewController.h"
#import "OrdersListViewController.h"
#import "RegistInformationViewController.h"

#import "LoginViewController.h"

@interface UserTableViewController ()
@property (strong, nonatomic) AboutUSViewController *aboutUsView;
@property (strong, nonatomic) InformationViewController *informationViewController;
@property (strong, nonatomic) RegistInformationViewController *registinformationViewController;
@end

@implementation UserTableViewController

@synthesize dataList;
@synthesize aboutUsView,informationViewController, registinformationViewController;
//table创建
- (id)initWithFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.dataList = [NSArray arrayWithObjects:@"信息管理", @"关于我们", nil];
        self.tableView.scrollEnabled = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

//添加分组的footer,header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //int height =
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, userImageW,tableUp)];
    header.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, tableUp + cellH, userImageW, bgH - tableUp - cellH)];
    footer.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (CGFloat)tableUp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (CGFloat)(bgH - tableUp - cellH);
}

//cell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:tableFont];
    }
    //左侧图片 字体颜色
    switch (indexPath.row)
    {
        case 0:
            if (FrameH > 319 && FrameH < 321) {
                cell.imageView.image = [UIImage imageNamed:@"message-4s.png"];
            }else{
                cell.imageView.image = [UIImage imageNamed:@"message.png"];
            }
            cell.textLabel.textColor = [UIColor colorWithRed:158.0/255.0 green:54.0/255.0 blue:74.0/255.0 alpha:1];
            break;
            
//        case 1:
//            if (FrameH > 319 && FrameH < 321) {
//                cell.imageView.image = [UIImage imageNamed:@"order-4s.png"];
//            }else{
//                cell.imageView.image = [UIImage imageNamed:@"order.png"];
//            }
//            cell.textLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:128.0/255.0 blue:39.0/255.0 alpha:1];
//            break;
            
//        case 2:
//            if (FrameH > 319 && FrameH < 321) {
//                cell.imageView.image = [UIImage imageNamed:@"credit-4s.png"];
//            }else{
//                cell.imageView.image = [UIImage imageNamed:@"credit.png"];
//            }
//            cell.textLabel.textColor = [UIColor colorWithRed:17.0/255.0 green:135.0/255.0 blue:127.0/255.0 alpha:1];
//            break;
            
        default:
            if (FrameH > 319 && FrameH < 321) {
                cell.imageView.image = [UIImage imageNamed:@"about-4s.png"];
            }else{
                cell.imageView.image = [UIImage imageNamed:@"about.png"];
            }
            cell.textLabel.textColor = [UIColor colorWithRed:190.0/255.0 green:86.0/255.0 blue:18.0/255.0 alpha:1];
            break;
    }
    [[cell textLabel]setText:[dataList objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellH/4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:{  
//            informationViewController = [[InformationViewController alloc]initWithPath:@"in"];
//            informationViewController.hidesBottomBarWhenPushed = YES;
//            informationViewController.title = @"地址管理";
//            [[self viewController].navigationController pushViewController:informationViewController animated:YES];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RegistInformation" bundle:[NSBundle mainBundle]];
            registinformationViewController = [storyboard instantiateViewControllerWithIdentifier:@"Regist"];
            [[self viewController].navigationController pushViewController:registinformationViewController animated:YES];
            
            break;
        }
//        case 1:{
//            OrdersListViewController *orderListViewController = [[OrdersListViewController alloc]init];
//            orderListViewController.title = @"我的订单";
//            orderListViewController.hidesBottomBarWhenPushed = YES;
//            [[self viewController].navigationController pushViewController:orderListViewController animated:YES];
////            NSLog(@"%d ~~~~~~~~~~~ %@", [self viewController].navigationController.viewControllers.count, self.navigationController);
//            break;
//        }
//        case 1:
//        { NSLog(@"third cell");
//            LoginViewController *lg = [[LoginViewController alloc]initWithNav:YES SettingsViewController:(SettingsViewController *)[self viewController]];
//            lg.hidesBottomBarWhenPushed = YES;
//            lg.title = @"注册";
//            NSLog(@"~~~~~~~~~~~~~~ %@", [self viewController]);
//            [[self viewController].navigationController pushViewController:lg animated:YES];
//            break;}
        case 1:{
            if (!aboutUsView) {
                aboutUsView = [[AboutUSViewController alloc]initWithTable];
                aboutUsView.title = @"关于我们";
                aboutUsView.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
                aboutUsView.hidesBottomBarWhenPushed = YES;
            }
            [[self viewController].navigationController pushViewController:aboutUsView animated:YES];
            break;
        }
        default:
            break;
    }
}

- (UIViewController *)viewController{
    for (UIView *next = [self.view superview] ;next;next = next.superview){
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]){
            NSLog(@"selfController is %@",nextResponder);
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
