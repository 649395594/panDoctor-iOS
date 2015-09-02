//
//  SVRootScrollView.m
//  SlideView
//
//  Created by Chen Yaoqiang on 13-12-27.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import "SVRootScrollView.h"
#import "SVTopScrollView.h"
#import "ScrollableTable.h"
#define POSITIONID (int)(scrollView.contentOffset.x/[[UIScreen mainScreen]bounds].size.width)

@interface SVRootScrollView ()

@property (strong , nonatomic) UITableView *destinationTable;
@property (strong , nonatomic) UITableView *sourceTable;

@property (nonatomic) CGRect previousFrame;

@end

@implementation SVRootScrollView

@synthesize viewNameArray,destinationTable,sourceTable,previousFrame,tables,diseaseArray;

+ (SVRootScrollView *)shareInstance {
    static SVRootScrollView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] initWithFrame:CGRectMake(0, 44+IOS7_STATUS_BAR_HEGHT+[SVTopScrollView shareInstance].frame.size.height, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height-(44+20+32+49))];//修改topScrollView的实例位置，大小
    });
    return _instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor lightGrayColor];
        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        userContentOffsetX = 0;
    }
    return self;
}

- (void)initWithTables{
    
    for (int i = 0 ; i < [tables count] ; i++) {
        UITableView *table = [tables objectAtIndex:i];
        if ([[UIScreen mainScreen]bounds].size.width<=320) {
           table.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width * i, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - (64+49+32));
        }
        else if ([[UIScreen mainScreen]bounds].size.width>320&&[[UIScreen mainScreen]bounds].size.width<=375){
             table.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width * i, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - (64+49+40));
        }
        else{
             table.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width * i, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - (64+49+48));
        }
    
        [self addSubview:table];
    }
    self.contentSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width*[viewNameArray count], 0);
}

//当拖动rootscrollview时自动调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    userContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (userContentOffsetX < scrollView.contentOffset.x) {
        isLeftScroll = YES;
    }
    else {
        isLeftScroll = NO;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self reset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //调整顶部滑条按钮状态
    [self adjustTopScrollViewButton:scrollView];
    if ([[self.tables objectAtIndex:POSITIONID] refreshCount] >0) {
        
    }
    else{
        [[self.tables objectAtIndex:POSITIONID] scrollrefreshTable];
    }
}
//滚动后修改顶部滚动条
- (void)adjustTopScrollViewButton:(UIScrollView *)scrollView
{
    [[SVTopScrollView shareInstance] setButtonUnSelect];
    [SVTopScrollView shareInstance].scrollViewSelectedChannelID = POSITIONID+100;
    [[SVTopScrollView shareInstance] setButtonSelect];
    [[SVTopScrollView shareInstance] setScrollViewContentOffset];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)duplicateTableFromIndex:(int)source ToIndex:(int)destination{
    destinationTable = [[UITableView alloc]init];
    sourceTable = [[UITableView alloc]init];
    
    destinationTable = [self.subviews objectAtIndex:destination];//需要被覆盖的table
    sourceTable = [self.subviews objectAtIndex:source];//将要被复制的table
    
    previousFrame = sourceTable.frame;
    sourceTable.frame = destinationTable.frame;
   // destinationTable.hidden = YES;
    
}
- (void)reset{
    if (sourceTable != nil) {
        sourceTable.frame = previousFrame;
    }
    if (destinationTable != nil) {
        //destinationTable.hidden = NO;
    }
}


@end
