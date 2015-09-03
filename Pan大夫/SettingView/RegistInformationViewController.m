//
//  RegistInformationViewController.m
//  Pan大夫
//
//  Created by Tom on 15/9/2.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kThemeColor [UIColor colorWithRed:0/255.0 green:175.0/255.0 blue:170.0/255.0 alpha:1.0]

#define kLabelSizeHeight 33*deviceWidthRate
#define kEidtiViewSizeHeight 4*kLabelSizeHeight
#define kFooterViewSizeHeight ( kScreenHeight - kHeaderViewSizeHeight - kEidtiViewSizeHeight - 64 - 49)*deviceWidthRate
#define kLeftBlankSpaceWidth 35*deviceWidthRate
#define kLabelWidth 35*deviceWidthRate
#define kMidleBlankSpaceWidth 10*deviceWidthRate
#define kHeadSize 135*deviceWidthRate
#define kHeadTopSpace 7*deviceWidthRate
#define kSexButtonSizeWidth 100*deviceWidthRate
#define kSexButtonSizeHeight 35*deviceWidthRate
#define kSexButtonMiddleSpace 25*deviceWidthRate
#define kCommitButtonSizeWidth 200*deviceWidthRate
#define kCommitButtonSizeHeight 35*deviceWidthRate


#define kLabelTag 100
#define kTextFieldTag 200

#import "RegistInformationViewController.h"
#import "ConfirmInformationViewController.h"

@interface RegistInformationViewController ()<UITextFieldDelegate>

@property(strong, nonatomic)UIView *editView;
@property(strong, nonatomic)UIScrollView *backgroundScrollView;
@property(strong, nonatomic)NSArray *infoArray;
@property(strong, nonatomic)NSArray *promptArray;
@property(strong, nonatomic)NSMutableDictionary *infoDictionary;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UIButton *boyButton;
@property(strong, nonatomic)UIButton *girlButton;
@property(nonatomic)int editingTextFieldTag;
@property(strong, nonatomic)UIButton *commitButton;
@property(strong, nonatomic)ConfirmInformationViewController *confirmInformationViewController;
@property(nonatomic)CGFloat deviceWidthRate;

@end

@implementation RegistInformationViewController
@synthesize editView, infoArray, promptArray, infoDictionary, editingTextFieldTag, backgroundScrollView, headImageView, boyButton, girlButton, commitButton, confirmInformationViewController, deviceWidthRate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    infoArray = @[@"姓名", @"学号", @"学院", @"专业"];
    promptArray = @[@"请输入您的姓名", @"请输入您的学号", @"请输入您的学院", @"请输入您的专业"];
    infoDictionary = [[NSMutableDictionary alloc]initWithCapacity:5];
    editingTextFieldTag = 0;
    NSLog(@"%@", infoArray);
    
    
    backgroundScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UITapGestureRecognizer *singleTapGestureRecoginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroudClicked)];
    [backgroundScrollView addGestureRecognizer:singleTapGestureRecoginzer];
    
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kHeadSize)/2, kHeadTopSpace + 64, kHeadSize, kHeadSize)];
    headImageView.image = [UIImage imageNamed:@"picOfBoyHead"];

    boyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    boyButton.frame = CGRectMake((kScreenWidth - kSexButtonMiddleSpace - kSexButtonSizeWidth*2)/2, CGRectGetMaxY(headImageView.frame) + 5, kSexButtonSizeWidth, kSexButtonSizeHeight);
    [boyButton setImage:[UIImage imageNamed:@"picOfBoy"] forState:UIControlStateNormal];
    [boyButton setImage:[UIImage imageNamed:@"picOfBoyYes"] forState:UIControlStateSelected];
    [boyButton addTarget:self action:@selector(setButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    boyButton.tag = 50;
    [backgroundScrollView addSubview:boyButton];
    
    girlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    girlButton.frame = CGRectMake((kScreenWidth + kSexButtonMiddleSpace)/2, CGRectGetMaxY(headImageView.frame) + 5, kSexButtonSizeWidth, kSexButtonSizeHeight);
    [girlButton setImage:[UIImage imageNamed:@"picOfGirl"] forState:UIControlStateNormal];
    [girlButton setImage:[UIImage imageNamed:@"picOfGirlYes"] forState:UIControlStateSelected];
    [girlButton addTarget:self action:@selector(setButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    girlButton.tag = 51;
    [backgroundScrollView addSubview:girlButton];
    
    editView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(boyButton.frame) + kHeadTopSpace, kScreenWidth, kEidtiViewSizeHeight)];
    
    [self initLabelAndTextField];
    
    commitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    commitButton.frame = CGRectMake((kScreenWidth - kCommitButtonSizeWidth)/2, CGRectGetMaxY(editView.frame) + 5, kCommitButtonSizeWidth, kCommitButtonSizeHeight);
    commitButton.backgroundColor = kThemeColor;
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    commitButton.layer.cornerRadius = 10;
    commitButton.layer.masksToBounds = YES;
    [backgroundScrollView addSubview:commitButton];

    [backgroundScrollView addSubview:headImageView];
    [backgroundScrollView addSubview:editView];
    [self.view addSubview:backgroundScrollView];
}

-(id)init{
    
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
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.title = @"注册信息";

    }
    return self;
}


//设置编辑部分
-(void)initLabelAndTextField{
    for (int index = 0; index < promptArray.count; index++) {
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth, kLabelSizeHeight * index, kLabelWidth, kLabelSizeHeight)];
        UITextField *infoTextField = [[UITextField alloc]initWithFrame:CGRectMake(kLeftBlankSpaceWidth + kLabelWidth + kMidleBlankSpaceWidth, kLabelSizeHeight * index, (kScreenWidth - kLeftBlankSpaceWidth*2 - kLabelWidth - kMidleBlankSpaceWidth), kLabelSizeHeight)];
        infoLabel.textColor = kThemeColor;
        infoLabel.text = infoArray[index];
        infoTextField.placeholder = promptArray[index];
        infoLabel.tag = index + kLabelTag;
        infoTextField.tag = index + kTextFieldTag;
        infoTextField.delegate = self;
        infoTextField.textAlignment = NSTextAlignmentCenter;
        [editView addSubview:infoTextField];
        [editView addSubview:infoLabel];
        NSLog(@"come here");
        if (index == 1) {
            infoTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
    }
}



-(void)setButtonClicked:(UIButton *)button{
    NSLog(@"cliced");
    if (button.selected) {
        return;
    }
    button.selected = YES;
    if (button.tag == 50) {
        girlButton.selected = NO;
        headImageView.image = [UIImage imageNamed:@"picOfBoyHead"];
    }else{
        boyButton.selected = NO;
        headImageView.image = [UIImage imageNamed:@"picOfGirlHead"];
    }
}

-(void)commitButtonClicked{
    NSLog(@"commitButtonClicked");
    for (int index = 0; index<promptArray.count; index++) {
        UITextField *textField = (UITextField*)[editView viewWithTag:index + kTextFieldTag];
        [infoDictionary setObject:textField.text forKey:infoArray[index]];
        NSLog(@"%@", [infoDictionary objectForKey: infoArray[index]]);
    }
    if (boyButton.selected) {
        [infoDictionary setObject:@"男" forKey:@"性别"];
    }else{
        [infoDictionary setObject:@"女" forKey:@"性别"];
    }
    confirmInformationViewController = [[ConfirmInformationViewController alloc]initWithInformationDictionary:infoDictionary];
    [self.navigationController pushViewController:confirmInformationViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backgroudClicked{
    [self endEdit];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    editingTextFieldTag = textField.tag;
    NSLog(@"%d", editingTextFieldTag);
    [self beginEdit];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
     [self endEdit];
    return YES;
}

-(void)beginEdit{
    if (kScreenHeight == 480) {
        [backgroundScrollView setContentOffset:CGPointMake(0, 150) animated:YES];
    }else if (kScreenHeight == 568) {
        [backgroundScrollView setContentOffset:CGPointMake(0, 120) animated:YES];
    }else{
        [backgroundScrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
}

-(void)endEdit{
    [self.view endEditing:YES];
    [backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


@end
