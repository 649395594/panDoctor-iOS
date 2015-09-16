//
//  OperationImageView.m
//  Pan大夫
//
//  Created by 郑祯 on 15/9/15.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "OperationImageView.h"

#define KOperationButtonWidth 60
#define KOperationButtonHeight 40
// 如果宏定义的数据要参与到运算的话，那么一定要使用括号括起来
#define KOperationImageViewOrignY (screenSize.height-110.5)

@implementation OperationImageView

- (instancetype)initWithScreenSize :(CGSize)screenSize
{
    if (self = [super init])
    {
        // 1、ImageView自身的初始化
        self.frame = CGRectMake(0, KOperationImageViewOrignY, screenSize.width, 70);
        // 由于父视图的透明度会影响到子视图，所以这里设置颜色要通过RGB值来直接设置颜色
        self.backgroundColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1];
        
        // 2、两个button的初始化
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setTitle:@"下一题" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
        _previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_previousButton setTitle:@"上一题" forState:UIControlStateNormal];
        [_previousButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        // 两个button位子的适配
        // View的起始Y值为 screenSize.height - 110.5
        if (screenSize.height < 568) {// 适配4s的屏幕
            _nextButton.frame = CGRectMake(230, 271 - KOperationImageViewOrignY, KOperationButtonWidth, KOperationButtonHeight);
            _previousButton.frame = CGRectMake(30, 271 - KOperationImageViewOrignY, KOperationButtonWidth, KOperationButtonHeight);
        }else if (screenSize.height >= 568 && screenSize.height < 580) { // 适配5s的屏幕
            _nextButton.frame = CGRectMake(230, 470 - KOperationImageViewOrignY, KOperationButtonWidth, KOperationButtonHeight);
            _previousButton.frame = CGRectMake(30,470 - KOperationImageViewOrignY, KOperationButtonWidth, KOperationButtonHeight);
        }else if (screenSize.height >= 667 && screenSize.height < 670) { // 适配6的屏幕
            _nextButton.frame = CGRectMake(280, 566 - KOperationImageViewOrignY, KOperationButtonWidth, KOperationButtonHeight);
            _previousButton.frame = CGRectMake(30, 566 - KOperationImageViewOrignY, KOperationButtonWidth, KOperationButtonHeight);
        }else { // 适配6plus的屏幕
            _nextButton.frame = CGRectMake(320, 635 - KOperationImageViewOrignY, KOperationButtonWidth, KOperationButtonHeight);
            _previousButton.frame = CGRectMake(30, 635 - KOperationImageViewOrignY, KOperationButtonWidth, KOperationButtonHeight);
        }
        
        // 3、添加两个按钮到ImageView
        [self addSubview:_nextButton];
        [self addSubview:_previousButton];
    }
    return self;
}



@end
