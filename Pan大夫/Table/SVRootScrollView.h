//
//  SVRootScrollView.h
//  SlideView
//
//  Created by Chen Yaoqiang on 13-12-27.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IOS7_STATUS_BAR_HEGHT (IS_IOS7 ? 20.0f : 0.0f)

@interface SVRootScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSArray *viewNameArray;
    CGFloat userContentOffsetX;
    BOOL isLeftScroll;
}
@property (nonatomic, retain) NSArray *viewNameArray;
@property (nonatomic, strong) NSMutableArray *tables;
@property (nonatomic, strong) NSMutableArray *diseaseArray;

+ (SVRootScrollView *)shareInstance;
- (void)initWithTables;


- (void)duplicateTableFromIndex:(int)source ToIndex:(int)destination;
- (void)reset;

/**
 *  加载主要内容
 */
//- (void)loadData;

@end
