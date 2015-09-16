//
//  OperationImageView.h
//  Pan大夫
//
//  Created by 郑祯 on 15/9/15.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationImageView : UIImageView

@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *previousButton;

// 自定义的初始化方法
- (instancetype)initWithScreenSize :(CGSize)screenSize;

@end
