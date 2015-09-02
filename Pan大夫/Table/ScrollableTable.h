//
//  scrollableTable.h
//  1.0.5
//
//  Created by tiny on 15/1/30.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+PullLoad.h"
#import "ResourcesViewController.h"
@interface ScrollableTable : UITableView <UITableViewDataSource,UITableViewDelegate,PullDelegate>

@property (strong, nonatomic) NSMutableArray *articles;
@property (nonatomic) NSInteger *refreshCount;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) ResourcesViewController *navPushDelegate;

- (void)refreshTable;
- (void)scrollrefreshTable;
- (NSInteger *)returnRefreshCount;
- (void)cellClickedWithID:(NSString *)Id;
- (id)initWithNavPushController:(ResourcesViewController *)delegate;
@end
