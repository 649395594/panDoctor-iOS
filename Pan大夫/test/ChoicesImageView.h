//
//  ChoicesImageView.h
//  Pan大夫
//
//  Created by 郑祯 on 15/9/15.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoicesImageView : UIImageView

@property (strong, nonatomic) UIButton *aButton;
@property (strong, nonatomic) UIButton *bButton;
@property (strong, nonatomic) UIButton *cButton;
@property (strong, nonatomic) UIButton *dButton;
@property (strong, nonatomic) UIButton *eButton;
@property (strong, nonatomic) UITextView *testTitle;
@property (strong, nonatomic) UILabel *statusLabel;

// 自定义的初始化方法
- (instancetype)initWithScreenHeight :(CGFloat)height withKind :(NSString *)kind;

// 暴露出给ImageView赋值的方法，于controller进行交互
- (void)setTestTitleWithText :(NSString *)text;
- (void)setStatusLabelWithText :(NSString *)text;

@end
