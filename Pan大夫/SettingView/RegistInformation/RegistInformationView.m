//
//  RegistInformationView.m
//  Pan大夫
//
//  Created by KT on 15/9/3.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#define kThemeColor [UIColor colorWithRed:0/255.0 green:175.0/255.0 blue:170.0/255.0 alpha:1.0]

#define kLeftBlankSpaceWidth 35 * _deviceWidthRate
#define kMidleBlankSpaceWidth 10 * _deviceWidthRate
#define kLabelSizeHeight 33 * _deviceWidthRate
#define kLabelWidth 35 * _deviceWidthRate

#define kHeadSize 135 * _deviceWidthRate
#define kHeadTopSpace ((kScreenHeight == 480) ?  7  : (25 * _deviceWidthRate))
#define kSexButtonSizeWidth 100 * _deviceWidthRate
#define kSexButtonSizeHeight 35 * _deviceWidthRate
#define kSexButtonMiddleSpace 25 * _deviceWidthRate
#define kCommitButtonSizeWidth 200 * _deviceWidthRate
#define kCommitButtonSizeHeight 35 * _deviceWidthRate
#define kVerticalEdegeHeight ((kScreenHeight == 480) ?  0  : (5 * _deviceWidthRate))

#import "RegistInformationView.h"

@interface RegistInformationView() <UITextFieldDelegate>{
    CGFloat _deviceWidthRate;
}

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *studentIdLabel;
@property (strong, nonatomic) UILabel *collegeLabel;
@property (strong, nonatomic) UILabel *majorLabel;

@end

@implementation RegistInformationView

- (id)initWithFactor:(CGFloat)factor{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _deviceWidthRate = factor;
        [self setupHeadImageView];  // 创建顶部头像
        [self setupBoyButton];  // 创建男生选项按钮
        [self setupGirlButton];  // 创建女生选项按钮
        [self setupNameLabelAndField];  // 添加姓名那一栏的label和textfield
        [self setupIdLabelAndField];  // 添加学号那一栏的label和textfield
        [self setupCollegeLabelAndField];  // 添加学院那一栏的label和textfield
        [self setupMajorLabelAndField];  // 添加专业那一栏的label和textfield
        [self setupCommitButton];  // 创建提交按钮
    }
    return self;
}

#pragma mark - begin UI

- (void)setupHeadImageView{
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kHeadSize)/2, 64 + kHeadTopSpace, kHeadSize, kHeadSize)];
    _headImageView.image = [UIImage imageNamed:@"picOfBoyHead"];
    [self addSubview:_headImageView];
}

- (void)setupBoyButton{
    _boyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _boyButton.frame = CGRectMake((kScreenWidth - kSexButtonMiddleSpace - kSexButtonSizeWidth*2)/2, CGRectGetMaxY(_headImageView.frame) + kVerticalEdegeHeight, kSexButtonSizeWidth, kSexButtonSizeHeight);
    [_boyButton setImage:[UIImage imageNamed:@"picOfBoy"] forState:UIControlStateNormal];
    [_boyButton setImage:[UIImage imageNamed:@"picOfBoyYes"] forState:UIControlStateSelected];
    _boyButton.selected = YES;
    [self addSubview:_boyButton];
}

- (void)setupGirlButton{
    _girlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _girlButton.frame = CGRectMake((kScreenWidth + kSexButtonMiddleSpace)/2, CGRectGetMaxY(_headImageView.frame) + 5, kSexButtonSizeWidth, kSexButtonSizeHeight);
    [_girlButton setImage:[UIImage imageNamed:@"picOfGirl"] forState:UIControlStateNormal];
    [_girlButton setImage:[UIImage imageNamed:@"picOfGirlYes"] forState:UIControlStateSelected];
    [self addSubview:_girlButton];
}

- (void)setupNameLabelAndField{
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth, CGRectGetMaxY(_boyButton.frame) + kLabelSizeHeight * 0 + kVerticalEdegeHeight, kLabelWidth, kLabelSizeHeight)];
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth + kLabelWidth + kMidleBlankSpaceWidth, CGRectGetMaxY(_boyButton.frame) + kLabelSizeHeight * 0 + kVerticalEdegeHeight, (kScreenWidth - kLeftBlankSpaceWidth*2 - kLabelWidth - kMidleBlankSpaceWidth), kLabelSizeHeight)];
    _nameLabel.textColor = kThemeColor;
    _nameField.textAlignment = NSTextAlignmentCenter;
    _nameField.delegate = self;
    [self addSubview:_nameField];
    [self addSubview:_nameLabel];
}

- (void)setupIdLabelAndField{
    _studentIdLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth, CGRectGetMaxY(_boyButton.frame) + kLabelSizeHeight * 1 + kVerticalEdegeHeight, kLabelWidth, kLabelSizeHeight)];
    _studentIdField = [[UITextField alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth + kLabelWidth + kMidleBlankSpaceWidth, CGRectGetMaxY(_boyButton.frame) + kLabelSizeHeight * 1 + kVerticalEdegeHeight, (kScreenWidth - kLeftBlankSpaceWidth * 2 - kLabelWidth - kMidleBlankSpaceWidth), kLabelSizeHeight)];
    _studentIdLabel.textColor = kThemeColor;
    _studentIdField.textAlignment = NSTextAlignmentCenter;
    _studentIdField.keyboardType = UIKeyboardTypeNumberPad;
    _studentIdField.delegate = self;
    [self addSubview:_studentIdField];
    [self addSubview:_studentIdLabel];
}

- (void)setupCollegeLabelAndField{
    _collegeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth, CGRectGetMaxY(_boyButton.frame) + kLabelSizeHeight * 2 + kVerticalEdegeHeight, kLabelWidth, kLabelSizeHeight)];
    _collegeField = [[UITextField alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth + kLabelWidth + kMidleBlankSpaceWidth, CGRectGetMaxY(_boyButton.frame) + kLabelSizeHeight * 2 + kVerticalEdegeHeight, (kScreenWidth - kLeftBlankSpaceWidth * 2 - kLabelWidth - kMidleBlankSpaceWidth), kLabelSizeHeight)];
    _collegeLabel.textColor = kThemeColor;
    _collegeField.textAlignment = NSTextAlignmentCenter;
    _collegeField.delegate = self;
    [self addSubview:_collegeField];
    [self addSubview:_collegeLabel];
}

- (void)setupMajorLabelAndField{
    _majorLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth, CGRectGetMaxY(_boyButton.frame) + kLabelSizeHeight * 3 + kVerticalEdegeHeight, kLabelWidth, kLabelSizeHeight)];
    _majorField = [[UITextField alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth + kLabelWidth + kMidleBlankSpaceWidth, CGRectGetMaxY(_boyButton.frame) + kLabelSizeHeight * 3 + kVerticalEdegeHeight, (kScreenWidth - kLeftBlankSpaceWidth * 2 - kLabelWidth - kMidleBlankSpaceWidth), kLabelSizeHeight)];
    _majorLabel.textColor = kThemeColor;
    _majorField.textAlignment = NSTextAlignmentCenter;
    _majorField.delegate = self;
    [self addSubview:_majorField];
    [self addSubview:_majorLabel];
}

- (void)setupCommitButton{
    _commitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _commitButton.frame = CGRectMake((kScreenWidth - kCommitButtonSizeWidth)/2, CGRectGetMaxY(_boyButton.frame) + 4 * kLabelSizeHeight + 5 + kVerticalEdegeHeight, kCommitButtonSizeWidth, kCommitButtonSizeHeight);
    [_commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitButton.layer.cornerRadius = 10;
    _commitButton.layer.masksToBounds = YES;
    [self addSubview:_commitButton];
}

#pragma mark - end UI

- (void)refreshText{
    _nameLabel.text = _infoArray[0];
    _nameField.placeholder = _promptArray[0];
    _studentIdLabel.text = _infoArray[1];
    _studentIdField.placeholder = _promptArray[1];
    _collegeLabel.text = _infoArray[2];
    _collegeField.placeholder = _promptArray[2];
    _majorLabel.text = _infoArray[3];
    _majorField.placeholder = _promptArray[3];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEdit];
}

-(void)beginEdit{
    if (kScreenHeight == 480) {
        [self setContentOffset:CGPointMake(0, 150) animated:YES];
    }else if (kScreenHeight == 568) {
        [self setContentOffset:CGPointMake(0, 130) animated:YES];
    }else{
        [self setContentOffset:CGPointMake(0, 100) animated:YES];
    }
}

-(void)endEdit{
    [self endEditing:YES];
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self beginEdit];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
     [self endEdit];
    return YES;
}

@end
