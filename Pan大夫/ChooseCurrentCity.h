//
//  ChooseCurrentCity.h
//  Pan大夫
//
//  Created by tiny on 15/3/24.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
@interface ChooseCurrentCity : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) HomeViewController *homeDelegate;
- (id)initWithCurrentCity:(NSString *)city HomeDelegate:(HomeViewController *)delegate;
@end
