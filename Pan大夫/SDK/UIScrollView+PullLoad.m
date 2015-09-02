//
//  UIScrollView+PullLoad.m
//  UIScrollViewCatergory
//
//  Created by 徐 传勇 on 13-2-18.
//  Copyright (c) 2013年 徐 传勇. All rights reserved.
//

#import "UIScrollView+PullLoad.h"
#import "ScrollableTable.h"
#import <objc/runtime.h>

#define LOADVIEW_HEIGHT         60.0f

static const char *pullDelegate = "pullDelegate";
static const char *interceptor = "interceptor";
static const char *canPullUp = "canPullUp";
static const char *canPullDown = "canPullDown";

//加载界面状态
typedef enum {
    PullStateNormal = 0,            //正常状态
    PullStateUpPulling = 1,         //上拉状态
    PullStateUpHitTheEnd = 2,       //上拉越界状态
    PullStateDownPulling = 3,       //下拉状态
    PullStateDownHitTheEnd = 4,     //下拉越界状态
    PullStateLoading = 5,           //加载状态
} PullState;

/****************************************************************************/
//上拉下拉视图
@interface PullRefreshView : UIView {
    UILabel *_stateLabel;
    UILabel *_dateLabel;
    UIImageView *_arrowView;
    UIActivityIndicatorView *_activityView;
    PullState   state;
}
@property PullState state;
- (void)setTextColor:(UIColor*)color;
- (void)setActivityStytle:(UIActivityIndicatorViewStyle)style;
//根据加载状态更新加载界面
- (void)refreshDateLabel:(LoadState)loadState;
@end

@implementation PullRefreshView
@dynamic state;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];;
        _stateLabel = [[UILabel alloc] init ];
        _stateLabel.font = [UIFont fontWithName:@"ArialMT" size:14.f];
        _stateLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
        _stateLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
		_stateLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.backgroundColor = [UIColor clearColor];
        _stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_stateLabel];
        [_stateLabel release];
        
        _dateLabel = [[UILabel alloc] init ];
        _dateLabel.font = [UIFont fontWithName:@"ArialMT" size:13.f];;
        _dateLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
        _stateLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
		_stateLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_dateLabel];
        [_dateLabel release];
        
        _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20) ];
        _arrowView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowView.clipsToBounds = NO;
        _arrowView.image = [UIImage imageNamed:@"blueArrow.png"];
        [self addSubview:_arrowView];
        [_arrowView release];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityView];
        [_activityView release];
        
    }
    return self;
}

//设置加载状态
- (void)setState:(PullState)pullstate {
    state = pullstate;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    switch (state) {
        case PullStateNormal:{
            _arrowView.hidden = NO;
            [_activityView stopAnimating];
        }
            break;
        case PullStateUpPulling:
            _stateLabel.frame = CGRectMake(0, 10, self.frame.size.width, 20);
            _dateLabel.frame = CGRectMake(0, 35, self.frame.size.width, 15);
            _arrowView.frame = CGRectMake(25.0f, 5, 20.0f, 60.0f);
            _arrowView.image = [UIImage imageNamed:@"blueArrow.png"];
            _arrowView.transform = CGAffineTransformMakeRotation(M_PI);
            _activityView.frame = CGRectMake(25.0f, 20.0f, 20.0f, 20.0f);
            _stateLabel.text = @"上拉加载更多...";
            break;
        case PullStateDownHitTheEnd:
            _arrowView.transform = CGAffineTransformMakeRotation(M_PI);
            _stateLabel.text = @"松开即可更新...";
            break;
        case PullStateUpHitTheEnd:
            _arrowView.transform = CGAffineTransformIdentity;
            _stateLabel.text = @"松开即可更新...";
            break;
        case PullStateDownPulling:
            _stateLabel.frame = CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 20);
            _dateLabel.frame = CGRectMake(0, self.frame.size.height - 25, self.frame.size.width, 15);
            _arrowView.frame = CGRectMake(25.0f, self.frame.size.height - 65.0f, 20.0f, 60.0f);
            _arrowView.image = [UIImage imageNamed:@"blueArrow.png"];
            _arrowView.transform = CGAffineTransformIdentity;
            _activityView.frame = CGRectMake(25.0f, self.frame.size.height - 40.0f, 20.0f, 20.0f);
            _stateLabel.text = @"下拉刷新...";
            break;
        case PullStateLoading:{
            UIScrollView *scrollView = (UIScrollView*)self.superview;
            if (scrollView.contentOffset.y <0) {
                UIEdgeInsets insets = scrollView.contentInset;
                insets = UIEdgeInsetsMake(insets.top+LOADVIEW_HEIGHT, 0, insets.bottom, 0);
                [scrollView setContentInset:insets];
            }
            else {
                UIEdgeInsets insets = scrollView.contentInset;
                insets = UIEdgeInsetsMake(insets.top, 0, insets.bottom+LOADVIEW_HEIGHT, 0);
                [scrollView setContentInset:insets];
            }
            _stateLabel.text = @"加载中...";
            _arrowView.hidden = YES;
            [_activityView startAnimating];
        }
            break;
        default:
            break;
    }
    [UIView commitAnimations];
}

- (PullState)state {
    return state;
}

- (void)setTextColor:(UIColor*)color {
    _stateLabel.textColor = color;
    _dateLabel.textColor = color;
}

- (void)setActivityStytle:(UIActivityIndicatorViewStyle)style {
    [_activityView setActivityIndicatorViewStyle:style];
}

- (void)refreshDateLabel:(LoadState)loadState {
    NSString *dateKey = nil;
    NSString *text = nil;
    if (loadState == PullUpLoadState) {
        dateKey = @"PullUp_LastRefresh";
        text = @"最后加载";
    }
    else {
        dateKey = @"PullDown_LastRefresh";
        text = @"最后更新";
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"上午"];
    [formatter setPMSymbol:@"下午"];
    [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
    _dateLabel.text = [NSString stringWithFormat:@"%@: %@",text,[formatter stringFromDate:date]];
    
    [[NSUserDefaults standardUserDefaults] setObject:_dateLabel.text forKey:dateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [formatter release];
}

@end
/****************************************************************************/


/****************************************************************************/
//函数拦截器，用于拦截UIScrollView的代理函数调用
@interface Interceptor:NSObject {
    id receiver;
    UIScrollView *scrollView;
    PullRefreshView *upView;
    PullRefreshView *downView;
    
}
@property (nonatomic,assign) id receiver;
@property (nonatomic,assign) UIScrollView *scrollView;
@property (retain,nonatomic) PullRefreshView *upView;
@property (retain,nonatomic) PullRefreshView *downView;

@end

/****************************************************************************/


/****************************************************************************/
//扩展私有函数，本扩展类内部使用
@interface UIScrollView (Private)
//函数拦截器
@property (retain,nonatomic) Interceptor *interceptor;
//根据加载状态回调外部函数
- (void)loadWithState:(LoadState)state;
@end

@implementation UIScrollView (Private)
@dynamic interceptor;

- (void)setInterceptor:(NSString *)messageInterceptor {
    //使用associative来扩展属性
    objc_setAssociatedObject(self, &interceptor, messageInterceptor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)interceptor {
    //获取属性
    return objc_getAssociatedObject(self, &interceptor);
}

- (void)loadWithState:(LoadState)state {
//    if (self.pullDelegate && [self.pullDelegate respondsToSelector:@selector(loadWithState:)]) {
//        [self.pullDelegate loadWithState:state];
//    }
    if (self.pullDelegate && [self.pullDelegate respondsToSelector:@selector(scrollView:loadWithState:)]) {
        [self.pullDelegate scrollView:self loadWithState:state];
    }
}

@end
/****************************************************************************/

/****************************************************************************/
@implementation Interceptor
@synthesize receiver;
@synthesize scrollView;
@synthesize upView;
@synthesize downView;

//快速转发函数，在此实现函数拦截，实现自己功能后再转发给原代理
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *selectorName = NSStringFromSelector(aSelector);
    
    if ([selectorName isEqualToString:NSStringFromSelector(@selector(scrollViewDidScroll:))]) {
        CGFloat viewOffset = scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height;
        //当scrollView上拉到内容完全显示还继续上拉，并且内容视图高度大于视图高度时，上拉界面设为上拉状态
        if (viewOffset > 0 &&scrollView.contentSize.height > scrollView.frame.size.height) {
            if (scrollView.canPullUp && downView.state == PullStateNormal) {
                //上拉在上拉状态进行上拉界面位置设定，这个时候scrollView的contentSize已经确定
                [downView setState:PullStateUpPulling];
                downView.hidden = NO;
                CGRect frame = downView.frame;
                frame = CGRectMake(0, scrollView.contentSize.height, scrollView.frame.size.width, 300);
                downView.frame=frame;
            }
        }
        //当上拉越过限定高度并且上拉界面处于上拉状态，将上拉界面设置为越界状态
        if (viewOffset > LOADVIEW_HEIGHT && downView.state == PullStateUpPulling) {
            [downView setState:PullStateUpHitTheEnd];
        }
        //当上拉返回限定高度并且上拉界面处于越界状态，将上拉界面设置为上拉状态
        else if (viewOffset > 0 && viewOffset < LOADVIEW_HEIGHT && downView.state == PullStateUpHitTheEnd) {
            [downView setState:PullStateUpPulling];
        }//下拉原理同上
        viewOffset = scrollView.contentOffset.y;
        if (viewOffset <0) {
            if (scrollView.canPullDown && upView.state == PullStateNormal) {
                [upView setState:PullStateDownPulling];
            }
        }
        if (viewOffset < -LOADVIEW_HEIGHT && upView.state == PullStateDownPulling) {
            [upView setState:PullStateDownHitTheEnd];
        }
        else if (viewOffset > -LOADVIEW_HEIGHT && viewOffset < 0 && upView.state == PullStateDownHitTheEnd) {
            [upView setState:PullStateDownPulling];
        }
    }
    //拖拽放开根据位置进行是否刷新操作
    if ([selectorName isEqualToString:NSStringFromSelector(@selector(scrollViewDidEndDragging:willDecelerate:))]) {
        CGFloat viewOffset = scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height;
        if (viewOffset > LOADVIEW_HEIGHT && downView.state == PullStateUpHitTheEnd) {
            [downView setState:PullStateLoading];
            [scrollView loadWithState:PullUpLoadState];
        }
        viewOffset = scrollView.contentOffset.y;;
        if (viewOffset < -LOADVIEW_HEIGHT && upView.state == PullStateDownHitTheEnd) {
            [upView setState:PullStateLoading];
            [scrollView loadWithState:PullDownLoadState];
        }
    }
    
    if ([receiver respondsToSelector:aSelector]) {
        return receiver;
    }
    if ([scrollView respondsToSelector:aSelector]) {
        return scrollView;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([receiver respondsToSelector:aSelector]) {
        return YES;
    }
    if ([scrollView respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (void)dealloc {
    
    [upView release];
    [downView release];
    [super dealloc];
}

@end
/****************************************************************************/

/****************************************************************************/
@implementation UIScrollView (PullLoad)
@dynamic canPullUp;
@dynamic canPullDown;
@dynamic pullDelegate;

- (void)setPullDelegate:(id)delegate {
    objc_setAssociatedObject(self, &pullDelegate, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id)pullDelegate {
    return objc_getAssociatedObject(self, &pullDelegate);
}

- (void)setRefreshViewColor:(UIColor*)color {
    if (self.canPullDown) {
        self.interceptor.upView.backgroundColor = color;
    }
    if (self.canPullUp) {
        self.interceptor.downView.backgroundColor = color;
    }
}

- (void)setRefreshViewTextColor:(UIColor *)color {
    if (self.canPullDown) {
        [self.interceptor.upView setTextColor:color];
    }
    if (self.canPullUp) {
        [self.interceptor.downView setTextColor:color];
    }
}

- (void)setActivityStyle:(UIActivityIndicatorViewStyle)style {
    if (self.canPullDown) {
        [self.interceptor.upView setActivityStytle:style];
    }
    if (self.canPullUp) {
        [self.interceptor.downView setActivityStytle:style];
    }
}

//初始化拦截器
- (void)InitInterceptor {
    if (!self.interceptor) {
        Interceptor *tmpInterceptor = [[Interceptor alloc] init];
        self.interceptor = tmpInterceptor;
        [tmpInterceptor release];
        self.interceptor.scrollView = self;
        if (self.delegate) {
            self.interceptor.receiver = self.delegate;
        }
        self.delegate = (id)self.interceptor;
    }
}

- (void)setCanPullUp:(BOOL)canPull {
    if (canPull) {
        [self InitInterceptor];
        if (!self.interceptor.downView) {
            PullRefreshView *view = [[PullRefreshView alloc] init];
            view.hidden = YES;
            [view refreshDateLabel:PullUpLoadState];
            [self addSubview:view];
            [view release];
            self.interceptor.downView = view;
        }
        else {
            [self addSubview:self.interceptor.downView];
        }
    }
    else {
        if (self.interceptor.downView.superview) {
            [self.interceptor.downView removeFromSuperview];
        }
    }
    NSNumber *number = [NSNumber numberWithBool:canPull];
    objc_setAssociatedObject(self, &canPullUp, number, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)canPullUp {
    NSNumber *number = objc_getAssociatedObject(self,&canPullUp);
    return [number boolValue];
}

- (void)setCanPullDown:(BOOL)canPull {
    if (canPull) {
        [self InitInterceptor];
        if (!self.interceptor.upView) {
            PullRefreshView *view = [[PullRefreshView alloc] initWithFrame:CGRectMake(0, -300, self.frame.size.width, 300)];
            [view refreshDateLabel:PullDownLoadState];
            [self addSubview:view];
            [view release];
            self.interceptor.upView = view;
        }
        else {
            [self addSubview:self.interceptor.upView];
        }
    }
    else {
        if (self.interceptor.upView.superview) {
            [self.interceptor.upView removeFromSuperview];
        }
    }
    NSNumber *number = [NSNumber numberWithBool:canPull];
    objc_setAssociatedObject(self, &canPullDown, number, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)canPullDown {
    NSNumber *number = objc_getAssociatedObject(self,&canPullDown);
    return [number boolValue];
}


- (void)stopLoadWithState:(LoadState)state {
    if (state == PullDownLoadState && self.interceptor.upView.state == PullStateLoading) {
//        [UIView animateWithDuration:0.2 animations:^{
//            UIEdgeInsets insets = self.contentInset;
//            insets = UIEdgeInsetsMake(0, 0, insets.bottom, 0);
//            [self setContentInset:insets];
//        }];
        [UIView animateWithDuration:0.2 animations:^{
            UIEdgeInsets insets = self.contentInset;
            insets = UIEdgeInsetsMake(0, 0, insets.bottom, 0);
            [self setContentInset:insets];
        } completion:^(BOOL finished){
            if (finished) {
                if([self.pullDelegate isKindOfClass:[ScrollableTable class]]){
                    [self.pullDelegate showMessage:@"refresh"];
                }
            }
        }];
        [self.interceptor.upView refreshDateLabel:state];
        [self.interceptor.upView setState:PullStateNormal];
    }
    else if (state == PullUpLoadState && self.interceptor.downView.state == PullStateLoading) {
        [UIView animateWithDuration:0.2 animations:^{
            UIEdgeInsets insets = self.contentInset;
            insets = UIEdgeInsetsMake(insets.top, 0, 0, 0);
            [self setContentInset:insets];
        }completion:^(BOOL finished){
            if (finished) {
                if([self.pullDelegate isKindOfClass:[ScrollableTable class]]){
                    [self.pullDelegate showMessage:@"load"];
                }
            }
        }];
        [self.interceptor.downView refreshDateLabel:state];
        [self.interceptor.downView setState:PullStateNormal];
    }
    if(self.interceptor.downView)
        [self.interceptor.downView setFrame:CGRectMake(0, self.contentSize.height, self.frame.size.width, 300)];
}

- (void)scrollViewDidScroll:(UIScrollView*)scView {
    //    NSLog(@"scrollViewDidScroll");
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scView willDecelerate:(BOOL)decelerate {
    //    NSLog(@"scrollViewDidEndDragging");
}

@end
/****************************************************************************/


