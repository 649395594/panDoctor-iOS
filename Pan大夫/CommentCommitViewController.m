//
//  EvaluateViewController.m
//  Evaluate
//
//  Created by tiny on 15/3/20.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import "CommentCommitViewController.h"
#import "UserStarRateView.h"
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define kMarkViewTopInterval 50.0/736.0
#define kMarkViewHeight 57.0/736.0
#define kMarkViewBottomInterval 20.0/736.0
#define kCommentViewHeight 180.0/736.0
#define kIconTopInterval 10.0/736.0
#define kIconLeftInterval 290/414.0
#define kButtonLeftInterval 15/414.0
#define kButtonHeight 50/736.0
#define kButtonWidth 384/414.0
#define kMarkLabelHeight 20/667.0
#define kMarkLabelWidth 50/375.0
#define kMarkLabelTop 17/667.0
#define kMarkLabelLeft 20/375.0
#define kStarRateWidth 120/375.0
#define kStarRateHeight 30/667.0
#define kSecMarkWidth 80/375.0
#define kSecMarkHeight 20/667.0
#define kPlaceholderLeft 10/375.0
#define kPlaceholderTop 15/667.0
#define kStatusLeft 330.0/375.0
#define kStatusTop 130/667.0
#define kStatusWidth 40/375.0
#define kStatusHeight 25/667.0
#define kSubmitWidth 24/375.0
#define kSecSubmitWidth 90/375.0
#define kSecSubmitHeight 20/667.0
#define kSaveButtonTopInterval 80.0/667.0
@interface CommentCommitViewController ()

@property (strong, nonatomic) UIView *markView;
@property (strong, nonatomic) UILabel *markLabel;
@property (strong, nonatomic) UILabel *secMarkLabel;
@property (strong, nonatomic) UserStarRateView *userStarRate;
@property (strong, nonatomic) UITextView *commentView;
@property (strong, nonatomic) UILabel *placeholderLabel;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UILabel *statusLabel;//动态显示textView中的输入字数
@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UIButton *secSubmitButton;

@property (strong, nonatomic) NSString *userComment;
@property (strong, nonatomic) NSString *userMark;

@property (strong, nonatomic) Order *order;
@property (strong, nonatomic) OrderCompletionViewController *orderCompletionDelegate;
@end

@implementation CommentCommitViewController
@synthesize markView;
@synthesize markLabel,secMarkLabel,placeholderLabel,statusLabel,secSubmitButton;
@synthesize userStarRate;
@synthesize commentView;
@synthesize saveButton,submitButton,userComment;
@synthesize userMark;
@synthesize orderCompletionDelegate;
- (id)initWithOrder:(Order *)order PushDelegate:(OrderCompletionViewController *)orderCompletionView UserComment:(Comment *)comment{
    self = [super init];
    if (self) {
        
        self.order = order;
        orderCompletionDelegate = orderCompletionView;
        self.comment = comment;
        
        self.view.frame = CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height-64);
        self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:245.0/255.0 alpha:1.0];
        markView = [[UIView alloc]initWithFrame:CGRectMake(0,64+kMarkViewTopInterval*KDeviceHeight, KDeviceWidth, kMarkViewHeight*KDeviceHeight)];
        markView.backgroundColor = [UIColor whiteColor];
        
        markLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMarkLabelLeft*KDeviceWidth, kMarkLabelTop*KDeviceHeight, kMarkLabelWidth*KDeviceWidth, kMarkLabelHeight*KDeviceHeight)];
        markLabel.textColor = [UIColor grayColor];
        markLabel.text = @"评分:";
        
        //评分星控件
        userStarRate = [[UserStarRateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(markLabel.frame), CGRectGetMinY(markLabel.frame)-5, kStarRateWidth*KDeviceWidth, kStarRateHeight*KDeviceHeight) numberOfStars:5 EvaluationView:self];
        userStarRate.allowIncompleteStar = NO;
        userStarRate.hasAnimation = NO;
        userStarRate.backgroundColor = [UIColor whiteColor];
        
        secMarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userStarRate.frame)+20, CGRectGetMinY(markLabel.frame), kSecMarkWidth*KDeviceWidth, kSecMarkHeight*KDeviceHeight)];
        secMarkLabel.textColor = [UIColor grayColor];

        //评论的textView
        commentView = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(markView.frame)+KDeviceHeight*kMarkViewBottomInterval, KDeviceWidth, KDeviceHeight*kCommentViewHeight)];
        commentView.backgroundColor = [UIColor whiteColor];
        commentView.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];
        commentView.delegate = self;
   
        //占位Label，点击commentView开始编辑后消失
        placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(kPlaceholderLeft*KDeviceWidth, kPlaceholderTop*KDeviceHeight, KDeviceWidth, kSecMarkHeight*KDeviceHeight)];
        placeholderLabel.textColor = [UIColor grayColor];
        
        //动态显示commentView中用户编辑的字数，最大字数限制为80字
        statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(kStatusLeft*KDeviceWidth, kStatusTop*KDeviceHeight, kStatusWidth*KDeviceWidth, kStatusHeight*KDeviceHeight)];
        statusLabel.textColor = [UIColor grayColor];
        
        //保存并返回的按钮
        saveButton = [[UIButton alloc]initWithFrame:CGRectMake(kButtonLeftInterval*KDeviceWidth, CGRectGetMaxY(commentView.frame)+kSaveButtonTopInterval*KDeviceHeight, kButtonWidth*KDeviceWidth, KDeviceHeight*kButtonHeight)];
        saveButton.layer.cornerRadius = 5;
        [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0]];
        [saveButton addTarget:self action:@selector(commitComment) forControlEvents:UIControlEventTouchUpInside];
        
        [self chooseFont];
        
        [self.view addSubview:markView];
        [self.view addSubview:commentView];
        [self.view addSubview:saveButton];
        [self.view addSubview:submitButton];
        [self.view addSubview:secSubmitButton];
        [markView addSubview:markLabel];
        [markView addSubview:userStarRate];
        [markView addSubview:secMarkLabel];
        [commentView addSubview:placeholderLabel];
        [commentView addSubview:statusLabel];
        
        if (self.comment) {
            userStarRate.scorePercent = [self.comment.mark floatValue];
            [saveButton setTitle:@"返回" forState:UIControlStateNormal];
            secMarkLabel.text = [NSString stringWithFormat:@"%.1f/5",userStarRate.scorePercent*5];
            commentView.text = self.comment.information;
            commentView.userInteractionEnabled = NO;
            commentView.editable = NO;
        }
        else{
            secMarkLabel.text = @"尚未打分";
            placeholderLabel.text = @"感谢您使用潘大夫,请在此写下您对该医生的评价：）";
            [saveButton setTitle:@"提交并返回" forState:UIControlStateNormal];
            statusLabel.text = [NSString stringWithFormat:@"0/80"];
            
            //手势一，作用是点击commentView后，占位label消失，键盘出现，commentView开始编辑
            UITapGestureRecognizer *singalTapOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapOne:)];
            [commentView addGestureRecognizer:singalTapOne];
            
            //手势二，当commentView点击除自身以外的屏幕其他位置时，键盘收回，结束编辑，并判断commentView的字数，若为0则占位label出现提示用户未编辑
            UITapGestureRecognizer *singalTapTwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapTwo:)];
            [self.view addGestureRecognizer:singalTapTwo];
        }
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSingleTapOne:(UITapGestureRecognizer *)sender{
    [placeholderLabel removeFromSuperview];
    [commentView becomeFirstResponder];
}

- (void)handleSingleTapTwo:(UITapGestureRecognizer *)sender{
    [commentView resignFirstResponder];
    if ([commentView.text length]<=0) {
      [commentView addSubview:placeholderLabel];
    }
}

- (void)removeSecMark{
    if (userStarRate.scorePercent>0) {
        secMarkLabel.text = [NSString stringWithFormat:@"%.1f/5",userStarRate.scorePercent*5];
    }
}
//提交评论
- (void)commitComment{
    if (!self.comment) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"评分和评论不能为空哦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        if ([commentView.text length]<=0||userStarRate.scorePercent == 0) {
            [alert show];
        }
        else{
            userComment = commentView.text;
            userMark = [NSString stringWithFormat:@"%.1f",userStarRate.scorePercent*5];
            self.comment = [[Comment alloc]initWithPatientName:self.order.patientName PatientTel:self.order.patientTel Mark:userMark CommentDate:nil Information:userComment DoctorId:self.order.doctorId CommentId:nil];
            [orderCompletionDelegate setNewStarRate:userMark UserComment:self.comment];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//限制textView的输入字数
- (void)textViewDidChange:(UITextView *)textView{
    NSInteger number = [textView.text length];
    if (number>80) {
        textView.text = [textView.text substringToIndex:80];
        number = 80;
    }
    statusLabel.text = [NSString stringWithFormat:@"%ld/80",(long)number];
}
//点击键盘上的done键结束编辑，收回键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)chooseFont{
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
        markLabel.font = [UIFont systemFontOfSize:14];
        secMarkLabel.font = [UIFont systemFontOfSize:14];
        commentView.font = [UIFont systemFontOfSize:18];
        placeholderLabel.font = [UIFont systemFontOfSize:13];
        statusLabel.font = [UIFont systemFontOfSize:13];
        submitButton.layer.cornerRadius = 10.5;
        saveButton.titleLabel.font = [UIFont systemFontOfSize:20];
        secSubmitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
        markLabel.font = [UIFont systemFontOfSize:14];
        secMarkLabel.font = [UIFont systemFontOfSize:14];
        commentView.font = [UIFont systemFontOfSize:18];
        placeholderLabel.font = [UIFont systemFontOfSize:13];
        statusLabel.font = [UIFont systemFontOfSize:13];
        submitButton.layer.cornerRadius = 10.75;
        saveButton.titleLabel.font = [UIFont systemFontOfSize:18];
        secSubmitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
        markLabel.font = [UIFont systemFontOfSize:16];
        secMarkLabel.font = [UIFont systemFontOfSize:16];
        commentView.font = [UIFont systemFontOfSize:20];
        placeholderLabel.font = [UIFont systemFontOfSize:15];
        statusLabel.font = [UIFont systemFontOfSize:15];
        submitButton.layer.cornerRadius = 12;
        saveButton.titleLabel.font = [UIFont systemFontOfSize:22];
        secSubmitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415) {
        markLabel.font = [UIFont systemFontOfSize:17];
        secMarkLabel.font = [UIFont systemFontOfSize:17];
        commentView.font = [UIFont systemFontOfSize:21];
        placeholderLabel.font = [UIFont systemFontOfSize:16];
        statusLabel.font = [UIFont systemFontOfSize:15];
        submitButton.layer.cornerRadius = 13.15;
        saveButton.titleLabel.font = [UIFont systemFontOfSize:24];
        secSubmitButton.titleLabel.font = [UIFont systemFontOfSize:21];
    }

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
