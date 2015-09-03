//
//  ComfirmInformationViewController.m
//  Pan大夫
//
//  Created by Tom on 15/9/2.
//  Copyright (c) 2015年 Neil. All rights reserved.
//


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kThemeColor [UIColor colorWithRed:0/255.0 green:175.0/255.0 blue:170.0/255.0 alpha:1.0]

#define kPromptViewOrigneY 80*deviceWidthRate
#define kPromptViewSizeWidth 230*deviceWidthRate
#define kPromptViewSizeHeight 43*deviceWidthRate
#define kLabelSizeHeight 30*deviceWidthRate
#define kEidtiViewSizeHeight 5*kLabelSizeHeight
#define kLineLeftSpace 35*deviceWidthRate
#define kLineSpace1 27*deviceWidthRate
#define kLineSpace2 30*deviceWidthRate
#define kLeftBlankSpaceWidth 30*deviceWidthRate
#define kLabelLeftWidth 35*deviceWidthRate
#define kMidleBlankSpaceWidth 5*deviceWidthRate
#define kHeadSize 125*deviceWidthRate
#define kButtonSizeWidth 100*deviceWidthRate
#define kButtonSizeHeight 35*deviceWidthRate
#define kButtonMiddleSpace 25*deviceWidthRate


#define kRightLabelTag 100

#import "ConfirmInformationViewController.h"

@interface ConfirmInformationViewController ()

@property(strong, nonatomic)UIImageView *promptImageView;
@property(strong, nonatomic)UIView *line1;
@property(strong, nonatomic)UIView *line2;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UIView *informationView;
@property(strong, nonatomic)UIButton *backButton;
@property(strong, nonatomic)UIButton *commitButton;

@property(strong, nonatomic)NSDictionary *infoDictionay;
@property(strong, nonatomic)NSArray *keyArray;

@property(nonatomic)CGFloat deviceWidthRate;

@end

@implementation ConfirmInformationViewController
@synthesize promptImageView, informationView, line1, line2, headImageView, backButton, commitButton;
@synthesize infoDictionay, keyArray, deviceWidthRate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    promptImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kPromptViewSizeWidth)/2, kPromptViewOrigneY, kPromptViewSizeWidth, kPromptViewSizeHeight)];
    promptImageView.image = [UIImage imageNamed:@"picOfWarning"];
    [self.view addSubview:promptImageView];
    
    line1 = [[UIView alloc]initWithFrame:CGRectMake(kLineLeftSpace, CGRectGetMaxY(promptImageView.frame) + kLineSpace1, kScreenWidth - kLineLeftSpace*2, 1)];
    line1.backgroundColor = kThemeColor;
    [self.view addSubview:line1];
    line2 = [[UIView alloc]initWithFrame:CGRectMake(kLineLeftSpace, CGRectGetMaxY(promptImageView.frame) + kLineSpace1 + kLineSpace2*2 + kEidtiViewSizeHeight, kScreenWidth - kLineLeftSpace*2, 1)];
    line2.backgroundColor = kThemeColor;
    [self.view addSubview:line2];
    
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth, kLineSpace2 + CGRectGetMaxY(line1.frame), kHeadSize, kHeadSize)];
    [self.view addSubview:headImageView];
    
    
    informationView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(line1.frame) + kLineSpace2, kScreenWidth/2, kEidtiViewSizeHeight)];
    for (int index = 0; index < keyArray.count; index++) {
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kLabelSizeHeight * index, kLabelLeftWidth, kLabelSizeHeight)];
        leftLabel.text = keyArray[index];
        leftLabel.textColor = [UIColor lightGrayColor];
        [informationView addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftWidth, kLabelSizeHeight * index, kScreenWidth/2 - kLabelLeftWidth, kLabelSizeHeight)];
        rightLabel.tag = kRightLabelTag + index;
        rightLabel.textAlignment = NSTextAlignmentCenter;
        [informationView addSubview:rightLabel];
    }
    [self.view addSubview:informationView];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake((kScreenWidth - kButtonMiddleSpace - kButtonSizeWidth*2)/2, CGRectGetMaxY(line2.frame) + kLineSpace1, kButtonSizeWidth, kButtonSizeHeight);
    [backButton setImage:[UIImage imageNamed:@"picOfCheckAgain"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake((kScreenWidth + kButtonMiddleSpace)/2, CGRectGetMaxY(line2.frame) + kLineSpace1, kButtonSizeWidth, kButtonSizeHeight);
    commitButton.layer.cornerRadius = 10;
    commitButton.layer.masksToBounds = YES;
    commitButton.backgroundColor = kThemeColor;
    [commitButton setTitle:@"提交注册" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
}

//初始化试图控制器，通过字典传值
-(id)initWithInformationDictionary:(NSDictionary *)informationDictionary{
    keyArray = @[@"姓名", @"性别", @"学号", @"学院", @"专业"];

    //适配机型
    if (kScreenWidth == 320) {
        deviceWidthRate = 1.0;
    }else if (kScreenWidth == 375){
        deviceWidthRate = 1.172;
    }else if (kScreenWidth == 414){
        deviceWidthRate = 1.294;
    }else{
        deviceWidthRate = kScreenWidth/320.0;
    }
    
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        if ([@"男" isEqualToString: [infoDictionay objectForKey:@"性别"] ]) {
            headImageView.image = [UIImage imageNamed:@"picOfBoyHead"];
        }else{
            headImageView.image = [UIImage imageNamed:@"picOfGirlHead"];
        }
        for (int index = 0; index < keyArray.count; index++) {
            UILabel *rightLabel = (UILabel *)[informationView viewWithTag:index + kRightLabelTag];
            rightLabel.text = [infoDictionay objectForKey:keyArray[index]];
        }
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitButtonClicked{
    NSLog(@"commitButtonClicked");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
