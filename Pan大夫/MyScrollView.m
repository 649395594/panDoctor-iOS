//
//  ScrollView.m
//  UIScrollView
//
//  Created by Tom on 15/2/4.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "MyScrollView.h"

@interface MyScrollView ()

@property (nonatomic,strong) NSMutableArray *imageMutableArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) float interval;

@end

@implementation MyScrollView

@synthesize pageControl, imageMutableArray, interval, timer;

-(id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray isURL:(BOOL)isURL TimeInterval:(float)timeInterval
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.bounces = NO;
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        
        if (isURL) {//while images are from net
            // 此处需要写入来源网络图片的相关代码
        }else{
            imageMutableArray = [[NSMutableArray alloc]initWithCapacity:[imageArray count]+2];
            [imageMutableArray addObjectsFromArray:imageArray];
            [imageMutableArray addObject:imageArray[0]];
            [imageMutableArray addObject:imageArray[1]];
        }
        
        float _x = 0;
        for (int i=0 ; i<imageMutableArray.count; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0+_x, 0, kScreenWidth, frame.size.height)];
            imageView.image = imageMutableArray[i];
            [self addSubview:imageView];
            _x += kScreenWidth;
        }
        [self setContentOffset:CGPointMake(kScreenWidth*imageArray.count,0)];
        interval = timeInterval;
        [self startTimer];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
    }
    self.contentSize = CGSizeMake(kScreenWidth * imageMutableArray.count, frame.size.height);
    return self;
}

//设置pageControl
-(void)setPageControlWithFrame:(CGRect)pageControlFrame
{
    pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
    pageControl.numberOfPages = imageMutableArray.count - 2;
    pageControl.userInteractionEnabled = NO;
    [self performSelector:@selector(addPageControl) withObject:nil afterDelay:.0f];
}
-(void)addPageControl{
    [[self superview] addSubview:pageControl];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView  //随时改变pageControl的current
{
    int index = scrollView.contentOffset.x / kScreenWidth;
    if (index<[imageMutableArray count]-2) {
        pageControl.currentPage = index;
    }else{
        pageControl.currentPage = index+2-[imageMutableArray count];
    }
    if (index == 0) {
        [scrollView setContentOffset:CGPointMake(kScreenWidth*([imageMutableArray count]-2),0) animated:NO];
    }else if(index == [imageMutableArray count]-1)
    {
        [scrollView setContentOffset:CGPointMake(kScreenWidth,0) animated:NO];
    }
}

//计时器
- (void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(updateScrollView:) userInfo:nil repeats:YES];
}
-(void)endTimer
{
    [timer invalidate];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  //开始拖动scrollView时，计时器失效
{
    [timer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate  //结束拖动时，计时器重新开始计时
{
    [self startTimer];
}
-(void)longPress:(UIGestureRecognizer *)gestureRecognizer   //长按图片时，计时器停止失效，松动后，计时器重新计时
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [timer invalidate];
    }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self startTimer];
    }
}
//根据计时器自动切换
-(void)updateScrollView:(UIScrollView *)scrollView
{
    int index = self.contentOffset.x / kScreenWidth;
    
    [self setContentOffset:CGPointMake(kScreenWidth*(index+1),0) animated:YES];
}
@end
