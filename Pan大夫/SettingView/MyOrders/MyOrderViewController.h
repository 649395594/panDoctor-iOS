//
//  MyOrderViewController.h
//  Pan大夫
//
//  Created by lf on 15/3/10.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrdersListViewController.h"
#import "UIScrollView+PullLoad.h"

@class Order;
@class Comment;
@interface MyOrderViewController : UITableView<UITableViewDataSource,UITableViewDelegate,PullDelegate>

- (void)cellTapedBackToHomeWithRow:(int)row;
- (id)initWithOrders:(NSMutableArray *)orders Comments:(NSMutableArray *)comments Delegate:(OrdersListViewController *)delegate;


@end
