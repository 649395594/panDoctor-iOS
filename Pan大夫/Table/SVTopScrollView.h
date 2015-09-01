//
//  SVTopScrollView.h
//  SlideView
//
//  Created by Chen Yaoqiang on 13-12-27.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IOS7_STATUS_BAR_HEGHT (IS_IOS7 ? 20.0f : 0.0f)

@interface SVTopScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSArray *nameArray;
    NSInteger userSelectedChannelID;        //点击按钮选择名字ID
    NSInteger scrollViewSelectedChannelID;  //滑动列表选择名字ID
    UIImageView *shadowImageView;   //选中阴影
}
@property (nonatomic, retain) NSArray *nameArray;

@property(nonatomic,retain)NSMutableArray *buttonOriginXArray;
@property(nonatomic,retain)NSMutableArray *buttonWithArray;
@property(nonatomic,strong)NSMutableArray *tables;
@property(nonatomic,strong)NSMutableArray *buttons;
@property (nonatomic,strong)NSArray *diseaseArray;

@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;
@property (nonatomic)NSInteger *buttonID;

@property (nonatomic, strong) UIImageView *buttomBar;
@property (nonatomic, strong) UIButton *button;
+ (SVTopScrollView *)shareInstance;
/**
 *  加载顶部标签
 */
- (void)initWithNameButtons;
/**
 *  滑动撤销选中按钮
 */
- (void)setButtonUnSelect;
/**
 *  滑动选择按钮
 */
- (void)setButtonSelect;
/**
 *  滑动顶部标签位置适应
 */
-(void)setScrollViewContentOffset;

-(NSInteger)getButtonId;
-(NSInteger)getTableId;
- (void)selectNameButton:(UIButton *)sender;

@end
