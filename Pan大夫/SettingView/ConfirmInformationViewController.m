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

#define kPromptViewOrigneY 50
#define kPromptViewSizeWidth 230
#define kPromptViewSizeHeight 43
#define kEidtiViewSizeHeight 35*4
#define kFooterViewSizeHeight ( kScreenHeight - kHeaderViewSizeHeight - kEidtiViewSizeHeight - 64 - 49)
#define kLineLeftSpace 35
#define kLineSpace1 27
#define kLineSpace2 37
#define kLeftBlankSpaceWidth 35
#define kLabelWidth 35
#define kMidleBlankSpaceWidth 5
#define kHeadSize 135
#define kButtonSizeWidth 100
#define kButtonSizeHeight 35
#define kButtonMiddleSpace 25


#define kLabelTag 100
#define kTextFieldTag 200

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

@end

@implementation ConfirmInformationViewController
@synthesize promptImageView, informationView, line1, line2, headImageView, backButton, commitButton;
@synthesize infoDictionay, keyArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    promptImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kPromptViewSizeWidth)/2, kPromptViewOrigneY, kPromptViewSizeWidth, kPromptViewSizeHeight)];
    promptImageView.image = [UIImage imageNamed:@"picOfWarning"];
    [self.view addSubview:promptImageView];
    
    line1 = [[UIView alloc]initWithFrame:CGRectMake(kLineLeftSpace, CGRectGetMaxY(promptImageView.frame) + kLineSpace1, (kScreenWidth - kLineLeftSpace)/2, 1)];
    line1.backgroundColor = kThemeColor;
    [self.view addSubview:line1];
    
    
    
}

-(id)initWithInformationDictionary:(NSDictionary *)informationDictionary keyArray:(NSArray *)aKeyArray{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        infoDictionay = [[NSDictionary alloc]initWithDictionary:informationDictionary];
        keyArray = [[NSArray alloc]initWithArray:aKeyArray];
        NSLog(@"%@        %@", infoDictionay, keyArray);
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
