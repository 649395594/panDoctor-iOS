//
//  userTableViewController.h
//  Pan大夫
//
//  Created by xjq on 15/3/11.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface UserTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSArray *dataList;

- (id)initWithFrame:(CGRect)frame;
@end
