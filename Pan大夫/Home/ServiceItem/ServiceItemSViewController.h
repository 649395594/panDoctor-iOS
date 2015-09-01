//
//  ServiceItemSViewController.h
//  Pan大夫
//
//  Created by nineteen. on 8/25/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface ServiceItemSViewController : UIViewController
@property (nonatomic , strong) UITableView *myTableView;
@property (nonatomic , strong) HomeViewController *pushDelegate;
- (id)initWithPushDelegate:(HomeViewController *)Delegate;
@end
