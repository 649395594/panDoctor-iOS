//
//  OderCompletionViewController.h
//  AppointmentTAble
//
//  Created by Robin on 15/3/17.
//  Copyright (c) 2015年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarRateView.h"
#import "Order.h"
#import "Comment.h"
@interface OrderCompletionViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
- (id)initWithOrder:(Order *)order;
- (void)setNewStarRate:(NSString *)userMark UserComment:(Comment *)comment;
@end
