//
//  ServiceItemTableView.m
//  Pan大夫
//
//  Created by KT on 15/9/4.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "ServiceItemTableView.h"
#import <MJRefresh.h>

@implementation ServiceItemTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            NSLog(@"hello");
        }];
    }
    return self;
}

@end
