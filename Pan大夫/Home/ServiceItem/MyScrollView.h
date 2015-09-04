//
//  ScrollView.h
//  UIScrollView
//
//  Created by Tom on 15/2/4.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollView : UIScrollView<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIPageControl *pageControl;


// 图片来自网络部分还未完成


//初始化，传入图片（本地或网络） 设置自动切换时间间隔
-(id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray isURL:(BOOL)isURL TimeInterval:(float)timeInterval;
-(void)setPageControlWithFrame: (CGRect)pageControlFrame;
-(void)startTimer;
-(void)endTimer;

@end
