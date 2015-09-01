//
//  OrdersListViewController.h
//  Pan大夫
//
//  Created by lf on 15/3/10.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order;
@class Comment;
@interface OrdersListViewController : UIViewController

@property(nonatomic,strong) NSMutableArray* orders;
@property(nonatomic,strong) NSMutableArray* comments;
- (void)jumpToViewControllerByOrder:(Order *)order Comment:(Comment *)comment;
@end
