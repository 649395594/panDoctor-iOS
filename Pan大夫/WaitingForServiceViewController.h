//
//  WaitingForServiceViewController.h
//  AppointmentTAble
//
//  Created by Robin on 15/3/17.
//  Copyright (c) 2015年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "DoctorDetailViewController.h"
#import "OrdersListViewController.h"
@interface WaitingForServiceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSString *path;
- (id)initWithOrder:(Order *)order DocDetail:(DoctorDetailViewController *)docDetail Path:(NSString *)path OrderListView:(OrdersListViewController *)orderList;
@end
