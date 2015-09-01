//
//  MyScollViewController.h
//  SlideView
//
//  Created by zxy on 14/12/6.
//  Copyright (c) 2014年 Chen Yaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVTopScrollView.h"
#import "SVRootScrollView.h"


@interface MyScollViewController : UIViewController

- (id)initWithNameArray:(NSArray *)nameArray diseaseArray:(NSArray*)diseaseArray AndTables:(NSMutableArray *)tables;

@end
