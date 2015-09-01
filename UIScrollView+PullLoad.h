//
//  UIScrollView+PullLoad.h
//  UIScrollViewCatergory
//
//  Created by 徐 传勇 on 13-2-18.
//  Copyright (c) 2013年 徐 传勇. All rights reserved.
//

#import <UIKit/UIKit.h>

//下拉上拉加载状态
typedef enum {
    PullUpLoadState,    //上拉加载状态
    PullDownLoadState,  //下拉加载状态
}LoadState;

//拖拽刷新代理
@protocol PullDelegate <NSObject>
@optional
//- (void)loadWithState:(LoadState)state;
- (void)scrollView:(UIScrollView*)scrollView loadWithState:(LoadState)state;
- (void)showMessage:(NSString *)actionKind;

@end

//带有拖拽刷新的UIScrollView扩展
@interface UIScrollView (PullLoad)
//可不设置代理，但如需要设置代理，需要在设置是否上下拉之前设置，否则无效
@property (assign,nonatomic) BOOL canPullUp;                //是否可以上拉
@property (assign,nonatomic) BOOL canPullDown;              //是否可以下拉
@property (assign,nonatomic) id <PullDelegate> pullDelegate;//代理,拖拽完成需要更新时会调用回调函数

//加载完成后外部调用停止加载状态
- (void)stopLoadWithState:(LoadState)state;
//设置加载视图背景颜色
- (void)setRefreshViewColor:(UIColor*)color;
//设置加载视图文字颜色
- (void)setRefreshViewTextColor:(UIColor *)color;
//设置转圈风格
- (void)setActivityStyle:(UIActivityIndicatorViewStyle)style;
@end
