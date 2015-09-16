//
//  ChoicesImageView.m
//  Pan大夫
//
//  Created by 郑祯 on 15/9/15.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "ChoicesImageView.h"

@implementation ChoicesImageView

- (instancetype)initWithScreenHeight :(CGFloat)height withKind :(NSString *)kind
{
    if (self = [super init]) {
        // 1、初始化所有的button
        [self loadButtons];
        // 2、创建选项视图
        [self loadChoicesView:height withKind:kind];
    }
    return self;
}

- (void)loadChoicesView :(CGFloat)height withKind :(NSString *)kind
{
    // 1、适配4s的屏幕
    if (height < 568) {
        if ([kind isEqualToString:@"SCL"]) {
            self.frame = CGRectMake(0, 108, 320, 250);
            self.image = [UIImage imageNamed:@"app_tests_框5_phone4_小"];
        }
        else{
            self.frame = CGRectMake(0, 108, 320, 250);
            self.image = [UIImage imageNamed:@"app_tests_bg"];
        }
        // grayConver1的高度为45,导航栏的高度为64,所以choicesImageView的Y坐标起点是109
        _aButton.frame = CGRectMake(0, 151, 160, 50);
        _bButton.frame = CGRectMake(160, 151, 160, 50);
        if ([kind isEqualToString:@"SCL"]) {
            _cButton.frame = CGRectMake(0, 201, 107, 50);
            _dButton.frame = CGRectMake(107, 201, 107, 50);
            _eButton.frame = CGRectMake(213, 201, 107, 50);
        }
        else{
            _cButton.frame = CGRectMake(0, 200, 160, 50);
            _dButton.frame = CGRectMake(160, 200, 160, 50);
        }

        if ([kind isEqualToString:@"SCL"]) {
            [self addSubview:_eButton];
        }
        _testTitle = [[UITextView alloc]initWithFrame:CGRectMake(0, 1, 320, 100)];
        _testTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        _testTitle.textAlignment = NSTextAlignmentCenter;
        _testTitle.editable = NO;
        [self addSubview:_testTitle];
        
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, 320, 100)];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
    }
    // 2、适配5s的屏幕
    else if(height>=568&&height<580){
        if ([kind isEqualToString:@"SCL"]) {
            self.frame = CGRectMake(0, 108, 320, 350);
            self.image = [UIImage imageNamed:@"app_tests_框5_H720"];
        }
        else{
            self.frame = CGRectMake(0, 108, 320, 305);
            self.image = [UIImage imageNamed:@"app_tests_backgroud_4"];
        }
        
        // grayConver1的高度为45,导航栏的高度为64,所以choicesImageView的Y坐标起点是109
        _aButton.frame = CGRectMake(0, 126, 320, 45);
        _aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _aButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _bButton.frame = CGRectMake(0, 171, 320, 45);
        _bButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _bButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _cButton.frame = CGRectMake(0, 215, 320, 45);
        _cButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _cButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _dButton.frame = CGRectMake(0, 259, 320, 45);
        _dButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _dButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _eButton.frame = CGRectMake(0, 303, 320, 45);
        _eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _eButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);

        if ([kind isEqualToString:@"SCL"]) {
            [self addSubview:_eButton];
        }
        
        _testTitle = [[UITextView alloc]initWithFrame:CGRectMake(0, 1, 320, 100)];
        _testTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        _testTitle.textAlignment = NSTextAlignmentCenter;
        _testTitle.editable = NO;
        [self addSubview:_testTitle];
        
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, 320, 100)];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
    }
    // 3、适配6的屏幕
    else if (height>=667&&height<670){
        if ([kind isEqualToString:@"SCL"]) {
            // iphone6的宽度是375
            self.frame = CGRectMake(0, 108, 375, 350);
            self.image = [UIImage imageNamed:@"frame6 750*5"];
        }
        else{
            self.frame = CGRectMake(0, 108, 375, 305);
            self.image = [UIImage imageNamed:@"frame6 750*4"];
        }
        // grayConver1的高度为45,导航栏的高度为64,所以choicesImageView的Y坐标起点是109
        _aButton.frame = CGRectMake(0, 126, 375, 45);
        _aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _aButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _bButton.frame = CGRectMake(0, 171, 375, 45);
        _bButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _bButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _cButton.frame = CGRectMake(0, 215, 375, 45);
        _cButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _cButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _dButton.frame = CGRectMake(0, 259, 375, 45);
        _dButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _dButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _eButton.frame = CGRectMake(0, 303, 375, 45);
        _eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _eButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);

        if ([kind isEqualToString:@"SCL"]) {
            [self addSubview:_eButton];
        }
        
        // 设置题目
        _testTitle = [[UITextView alloc]initWithFrame:CGRectMake(0, 1, 375, 100)];
        _testTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        _testTitle.textAlignment = NSTextAlignmentCenter;
        _testTitle.editable = NO;
        [self addSubview:_testTitle];
        
        // 设置引导序号
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, 375, 100)];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
    }
    
    // 4、适配6plus的屏幕
    // iphone6plus的屏幕宽度是414
    else{
        if ([kind isEqualToString:@"SCL"]) {
            self.frame = CGRectMake(0, 108, 414, 350);
            self.image = [UIImage imageNamed:@"frame6+ 1242*5"];
        }
        else{
            self.frame = CGRectMake(0, 108, 414, 305);
            self.image = [UIImage imageNamed:@"frame6+ 1242*4"];
        }
        // grayConver1的高度为45,导航栏的高度为64,所以choicesImageView的Y坐标起点是109
        _aButton.frame = CGRectMake(0, 126, [[UIScreen mainScreen]bounds].size.width, 45);
        _aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _aButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _bButton.frame = CGRectMake(0, 171, [[UIScreen mainScreen]bounds].size.width, 45);
        _bButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _bButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _cButton.frame = CGRectMake(0, 215, [[UIScreen mainScreen]bounds].size.width, 45);
        _cButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _cButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _dButton.frame = CGRectMake(0, 259, [[UIScreen mainScreen]bounds].size.width, 45);
        _dButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _dButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        _eButton.frame = CGRectMake(0, 303, [[UIScreen mainScreen]bounds].size.width, 45);
        _eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _eButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        if ([kind isEqualToString:@"SCL"]) {
            [self addSubview:_eButton];
        }
        
        _testTitle = [[UITextView alloc]initWithFrame:CGRectMake(0, 1, 414, 100)];
        _testTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        _testTitle.textAlignment = NSTextAlignmentCenter;
        _testTitle.editable = NO;
        [self addSubview:_testTitle];
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, 414, 100)];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
    }
    // 添加button到ImageView上面
    [self addSubview:_aButton];
    [self addSubview:_bButton];
    [self addSubview:_cButton];
    [self addSubview:_dButton];
}
- (void)loadButtons
{
    _aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_aButton setTitle:@"A.没有" forState:UIControlStateNormal];
    [_aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _aButton.tag = 1;
    
    _bButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bButton setTitle:@"B.轻度" forState:UIControlStateNormal];
    [_bButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _bButton.tag = 2;
    
    _cButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cButton setTitle:@"C.中度" forState:UIControlStateNormal];
    [_cButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cButton.tag = 3;
    
    _dButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dButton setTitle:@"D.重度" forState:UIControlStateNormal];
    [_dButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _dButton.tag = 4;
    
    _eButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_eButton setTitle:@"E.非常严重" forState:UIControlStateNormal];
    [_eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _eButton.tag = 5;
}
- (void)setTestTitleWithText :(NSString *)text
{
    _testTitle.text = text;
}
- (void)setStatusLabelWithText :(NSString *)text
{
    _statusLabel.text = text;
}

@end
