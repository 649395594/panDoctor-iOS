//
//  PaymentViewController.h
//  AppointmentTAble
//
//  Created by Robin on 15/3/15.
//  Copyright (c) 2015年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "WaitingForServiceViewController.h"
#import "DoctorDetailViewController.h"
#import "OrdersListViewController.h"
@interface PaymentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)NSArray *orderFixList;
@property (nonatomic, retain) NSArray *orderDataList;
@property (nonatomic, retain) NSArray *payTextList;
@property (nonatomic, retain) NSArray *payDetailList;
@property (nonatomic, retain) NSArray *payIamgeName;
@property (nonatomic, retain) NSString *path;
- (id)initWithOrder:(Order *)order DocDetailView:(DoctorDetailViewController *)docDetail Path:(NSString *)path OrderListView:(OrdersListViewController *)orderList;
@end
