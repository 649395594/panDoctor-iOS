//
//  ConfirmInformationView.m
//  Pan大夫
//
//  Created by Tom on 15/9/8.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "ConfirmInformationView.h"

#define kPromptViewOrigneY 80 * _deviceWidthRate
#define kPromptViewSizeWidth 230 * _deviceWidthRate
#define kPromptViewSizeHeight 43 * _deviceWidthRate
#define kLabelSizeHeight 30 * _deviceWidthRate
#define kEidtiViewSizeHeight 5 * kLabelSizeHeight
#define kLineLeftSpace 35 * _deviceWidthRate
#define kLineSpace1 27 * _deviceWidthRate
#define kLineSpace2 30 * _deviceWidthRate
#define kLeftBlankSpaceWidth 30 * _deviceWidthRate
#define kLabelLeftWidth 35 * _deviceWidthRate
#define kMidleBlankSpaceWidth 5 * _deviceWidthRate
#define kHeadSize 125 * _deviceWidthRate
#define kButtonSizeWidth 100 * _deviceWidthRate
#define kButtonSizeHeight 35 * _deviceWidthRate
#define kButtonMiddleSpace 25 * _deviceWidthRate

#define kThemeColor [UIColor colorWithRed:0/255.0 green:175.0/255.0 blue:170.0/255.0 alpha:1.0]

@interface ConfirmInformationView ()

@property(strong, nonatomic) NSArray *keyArray;
@property(strong, nonatomic) UIImageView *promptImageView;
@property(strong, nonatomic) UIView *line1;
@property(strong, nonatomic) UIView *line2;
@property(strong, nonatomic) UIButton *backButton;
@property(strong, nonatomic) UIButton *commitButton;
@property(strong, nonatomic) UILabel *nameLabelLelf;
@property(strong, nonatomic) UILabel *sexLabelLelf;
@property(strong, nonatomic) UILabel *IDLabelLelf;
@property(strong, nonatomic) UILabel *collogeLabelLelf;
@property(strong, nonatomic) UILabel *majorLabelLelf;

@property(nonatomic) CGFloat deviceWidthRate;


@end

@implementation ConfirmInformationView

-(instancetype)initWithFrame:(CGRect)frame InformationDictionary:(NSDictionary *)informationDictionary{
    self = [super initWithFrame:frame];
    if (self) {
    
        //适配机型
        if (kScreenWidth == 320) {
            _deviceWidthRate = 1.0;
        }else if (kScreenWidth == 375){
            _deviceWidthRate = 1.172;
        }else if (kScreenWidth == 414){
            _deviceWidthRate = 1.294;
        }else{
            _deviceWidthRate = kScreenWidth/320.0;
        }
        
        _keyArray = @[@"姓名", @"性别", @"学号", @"学院", @"专业"];
        
        
        _promptImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kPromptViewSizeWidth)/2, kPromptViewOrigneY, kPromptViewSizeWidth, kPromptViewSizeHeight)];
        _promptImageView.image = [UIImage imageNamed:@"picOfWarning"];
        [self addSubview:_promptImageView];
        
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(kLineLeftSpace, CGRectGetMaxY(_promptImageView.frame) + kLineSpace1, kScreenWidth - kLineLeftSpace*2, 1)];
        _line1.backgroundColor = kThemeColor;
        [self addSubview:_line1];
        _line2 = [[UIView alloc]initWithFrame:CGRectMake(kLineLeftSpace, CGRectGetMaxY(_promptImageView.frame) + kLineSpace1 + kLineSpace2*2 + kEidtiViewSizeHeight, kScreenWidth - kLineLeftSpace*2, 1)];
        _line2.backgroundColor = kThemeColor;
        [self addSubview:_line2];
        
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth, kLineSpace2 + CGRectGetMaxY(_line1.frame), kHeadSize, kHeadSize)];
        [self addSubview:_headImageView];
        
        
        
        [self setupLabels];

        
        self.userInteractionEnabled = YES;
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake((kScreenWidth - kButtonMiddleSpace - kButtonSizeWidth*2)/2, CGRectGetMaxY(_line2.frame) + kLineSpace1, kButtonSizeWidth, kButtonSizeHeight);
        [_backButton setImage:[UIImage imageNamed:@"picOfCheckAgain"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.frame = CGRectMake((kScreenWidth + kButtonMiddleSpace)/2, CGRectGetMaxY(_line2.frame) + kLineSpace1, kButtonSizeWidth, kButtonSizeHeight);
        _commitButton.layer.cornerRadius = 10;
        _commitButton.layer.masksToBounds = YES;
        _commitButton.backgroundColor = kThemeColor;
        [_commitButton setTitle:@"提交注册" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commitButton];
        
    }
    return self;
}

-(void)setupLabels{
    _nameLabelLelf = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2, kLabelLeftWidth, kLabelSizeHeight)];
    _nameLabelLelf.text = @"姓名";
    _nameLabelLelf.textColor = [UIColor lightGrayColor];
    [self addSubview:_nameLabelLelf];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftWidth + kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2, kScreenWidth/2 - kLabelLeftWidth, kLabelSizeHeight)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    
    
    _sexLabelLelf = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2 + kLabelSizeHeight, kLabelLeftWidth, kLabelSizeHeight)];
    _sexLabelLelf.text = @"性别";
    _sexLabelLelf.textColor = [UIColor lightGrayColor];
    [self addSubview:_sexLabelLelf];
    
    _sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftWidth + kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2 + kLabelSizeHeight, kScreenWidth/2 - kLabelLeftWidth, kLabelSizeHeight)];
    _sexLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sexLabel];
    
    
    _IDLabelLelf = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2 + kLabelSizeHeight * 2, kLabelLeftWidth, kLabelSizeHeight)];
    _IDLabelLelf.text = @"学号";
    _IDLabelLelf.textColor = [UIColor lightGrayColor];
    [self addSubview:_IDLabelLelf];
    
    _IDLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftWidth + kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2 + kLabelSizeHeight * 2, kScreenWidth/2 - kLabelLeftWidth, kLabelSizeHeight)];
    _IDLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_IDLabel];
    
    
    _collogeLabelLelf = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2 + kLabelSizeHeight * 3, kLabelLeftWidth, kLabelSizeHeight)];
    _collogeLabelLelf.text = @"学院";
    _collogeLabelLelf.textColor = [UIColor lightGrayColor];
    [self addSubview:_collogeLabelLelf];
    
    _collogeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftWidth + kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2 + kLabelSizeHeight * 3, kScreenWidth/2 - kLabelLeftWidth, kLabelSizeHeight)];
    _collogeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_collogeLabel];

    
    _majorLabelLelf = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2 + kLabelSizeHeight * 4, kLabelLeftWidth, kLabelSizeHeight)];
    _majorLabelLelf.text = @"专业";
    _majorLabelLelf.textColor = [UIColor lightGrayColor];
    [self addSubview:_majorLabelLelf];
    
    _majorLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftWidth + kScreenWidth/2, CGRectGetMaxY(_line1.frame) + kLineSpace2 + kLabelSizeHeight * 4, kScreenWidth/2 - kLabelLeftWidth, kLabelSizeHeight)];
    _majorLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_majorLabel];
}


-(void)backButtonClicked{
    [_delegate backButtonClicked];
}

-(void)commitButtonClicked{
    [_delegate commitButtonClicked];
}

@end
