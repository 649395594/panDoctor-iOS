
#import <UIKit/UIKit.h>
#import "CommentCommitViewController.h"
@class UserStarRateView;
@protocol CWStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(UserStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface UserStarRateView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property (nonatomic, assign) BOOL isTouch;
@property (nonatomic, weak) id<CWStarRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars EvaluationView:(CommentCommitViewController *)evaluation;
@end