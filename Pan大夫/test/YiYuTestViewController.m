//
//  YiYuTestViewController.m
//  REFrostedViewControllerExample
//
//  Created by 张星宇 on 14-9-18.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//
#define IS_IPHONE_5_SCREEN [[UIScreen mainScreen] bounds].size.height >= 568.0f && [[UIScreen mainScreen] bounds].size.height < 1024.0f
#import "YiYuTestViewController.h"
#import "TestAnalysisViewController.h"
#import "CoreDataManager.h"
#import "Question.h"
@interface YiYuTestViewController ()

@property (nonatomic , strong) UITextView *testTitle;
@property (nonatomic , strong) UILabel *statusLabel;
@property (nonatomic , strong) CoreDataManager *manager;
@property (nonatomic , strong) UIButton *record;
@property (nonatomic) BOOL isAnythingSelected;
@property (nonatomic , strong) UIView *buttonView;
@property (nonatomic) NSInteger intTag;
@property (nonatomic , strong) NSMutableArray *questionLabels;
@property (nonatomic) NSInteger questionNumber;
@property (nonatomic) NSInteger currentPosition;

@end

@implementation YiYuTestViewController
@synthesize tag,kind,testTitle,manager,record,isAnythingSelected;
@synthesize aButton,bButton,cButton,dButton,eButton,nextButton,previousButton,endButton,tempButton,buttonView,statusLabel,intTag;
@synthesize delegate,tags,questionLabels,questionNumber,currentPosition;
-(id)initWithKind:(NSString *)newKind{
    self = [super init];
    if (self) {
        kind = newKind;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-40);//设置测试视图的frame
    
    UIImageView *grayConver1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, 45)];
    grayConver1.backgroundColor = [UIColor grayColor];
    grayConver1.alpha = 0.3;
    [self.view addSubview:grayConver1];
    
    UIImageView *grayConver2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-110.5, [[UIScreen mainScreen] bounds].size.width, 70)];
    grayConver2.backgroundColor = [UIColor grayColor];
    grayConver2.alpha = 0.3;
    [self.view addSubview:grayConver2];
    
    aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setTitle:@"A.没有" forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(chooseA:) forControlEvents:UIControlEventTouchUpInside];
    [aButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchDown];
    aButton.tag = 1;
    
    bButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bButton setTitle:@"B.轻度" forState:UIControlStateNormal];
    [bButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bButton addTarget:self action:@selector(chooseB:) forControlEvents:UIControlEventTouchUpInside];
    [bButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchDown];
    bButton.tag = 2;
    
    cButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cButton setTitle:@"C.中度" forState:UIControlStateNormal];
    [cButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cButton addTarget:self action:@selector(chooseC:) forControlEvents:UIControlEventTouchUpInside];
    [cButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchDown];
    cButton.tag = 3;
    
    dButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dButton setTitle:@"D.重度" forState:UIControlStateNormal];
    [dButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dButton addTarget:self action:@selector(chooseD:) forControlEvents:UIControlEventTouchUpInside];
    [dButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchDown];
    dButton.tag = 4;
    
    eButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [eButton setTitle:@"E.非常严重" forState:UIControlStateNormal];
    [eButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [eButton addTarget:self action:@selector(chooseE:) forControlEvents:UIControlEventTouchUpInside];
    [eButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchDown];
    eButton.tag = 5;
    
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextQuestion:) forControlEvents:UIControlEventTouchUpInside];
    [nextButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchDown];

    previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousButton setTitle:@"上一题" forState:UIControlStateNormal];
    [previousButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousQuestion:) forControlEvents:UIControlEventTouchUpInside];
    if ([[UIScreen mainScreen] bounds].size.height < 568) {//适配4s的屏幕
        UIImageView *frame = [[UIImageView alloc]init];
        if ([kind isEqualToString:@"SCL"]) {
            frame.frame = CGRectMake(0, 108, 320, 250);
            frame.image = [UIImage imageNamed:@"app_tests_框5_phone4_小"];
        }
        else{
            frame.frame = CGRectMake(0, 108, 320, 250);
            frame.image = [UIImage imageNamed:@"app_tests_bg"];
        }
        [self.view addSubview:frame];
        
        aButton.frame = CGRectMake(0, 260, 160, 50);
        bButton.frame = CGRectMake(160, 260, 160, 50);
        if ([kind isEqualToString:@"SCL"]) {
            cButton.frame = CGRectMake(0, 310, 107, 50);
            dButton.frame = CGRectMake(107, 310, 107, 50);
            eButton.frame = CGRectMake(213, 310, 107, 50);
        }
        else{
            cButton.frame = CGRectMake(0, 309, 160, 50);
            dButton.frame = CGRectMake(160, 309, 160, 50);
        }
        nextButton.frame = CGRectMake(230, 380, 60, 40);
        previousButton.frame = CGRectMake(30, 380, 60, 40);
        
        if ([kind isEqualToString:@"SCL"]) {
            [self.view addSubview:eButton];
        }
        
        CGRect labelFrame = CGRectMake(0, 110, 320, 100);
        testTitle = [[UITextView alloc]initWithFrame:labelFrame];
        testTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        testTitle.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:testTitle];
        
        CGRect statusLabelFrame = CGRectMake(0, 150, 320, 100);
        statusLabel = [[UILabel alloc]initWithFrame:statusLabelFrame];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:statusLabel];
        
    }
    else if([[UIScreen mainScreen] bounds].size.height>=568&&[[UIScreen mainScreen]bounds].size.height<580){//适配5s的屏幕
        UIImageView *frame = [[UIImageView alloc]init];
        if ([kind isEqualToString:@"SCL"]) {
            frame.frame = CGRectMake(0, 108, 320, 350);
            frame.image = [UIImage imageNamed:@"app_tests_框5_H720"];
        }
        else{
            frame.frame = CGRectMake(0, 108, 320, 305);
            frame.image = [UIImage imageNamed:@"app_tests_backgroud_4"];
        }
        [self.view addSubview:frame];
        
        aButton.frame = CGRectMake(0, 235, 320, 45);
        aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        aButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        bButton.frame = CGRectMake(0, 280, 320, 45);
        bButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    
        cButton.frame = CGRectMake(0, 324, 320, 45);
        cButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        cButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        dButton.frame = CGRectMake(0, 368, 320, 45);
        dButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        dButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        eButton.frame = CGRectMake(0, 412, 320, 45);
        eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        eButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        nextButton.frame = CGRectMake(230, 470, 60, 40);
        previousButton.frame = CGRectMake(30,470, 60, 40);
        
        if ([kind isEqualToString:@"SCL"]) {
            [self.view addSubview:eButton];
        }
        
        CGRect labelFrame = CGRectMake(0, 110, 320, 100);
        testTitle = [[UITextView alloc]initWithFrame:labelFrame];
        testTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        testTitle.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:testTitle];
        
        CGRect statusLabelFrame = CGRectMake(0, 150, 320, 100);
        statusLabel = [[UILabel alloc]initWithFrame:statusLabelFrame];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:statusLabel];
    }
    else if ([[UIScreen mainScreen]bounds].size.height>=667&&[[UIScreen mainScreen]bounds].size.height<670){
        UIImageView *frame = [[UIImageView alloc]init];
        if ([kind isEqualToString:@"SCL"]) {
            frame.frame = CGRectMake(0, 108, [[UIScreen mainScreen]bounds].size.width, 350);
            frame.image = [UIImage imageNamed:@"frame6 750*5"];
        }
        else{
            frame.frame = CGRectMake(0, 108, [[UIScreen mainScreen]bounds].size.width, 305);
            frame.image = [UIImage imageNamed:@"frame6 750*4"];
        }
        [self.view addSubview:frame];
        
        aButton.frame = CGRectMake(0, 235, [[UIScreen mainScreen]bounds].size.width, 45);
        aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        aButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        bButton.frame = CGRectMake(0, 280, [[UIScreen mainScreen]bounds].size.width, 45);
        bButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        cButton.frame = CGRectMake(0, 324, [[UIScreen mainScreen]bounds].size.width, 45);
        cButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        cButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        dButton.frame = CGRectMake(0, 368, [[UIScreen mainScreen]bounds].size.width, 45);
        dButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        dButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        eButton.frame = CGRectMake(0, 412, [[UIScreen mainScreen]bounds].size.width, 45);
        eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        eButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        nextButton.frame = CGRectMake(280, 566, 60, 40);
        previousButton.frame = CGRectMake(30,566, 60, 40);

        if ([kind isEqualToString:@"SCL"]) {
            [self.view addSubview:eButton];
        }
        
        CGRect labelFrame = CGRectMake(0, 110, [[UIScreen mainScreen]bounds].size.width, 100);
        testTitle = [[UITextView alloc]initWithFrame:labelFrame];
        testTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        testTitle.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:testTitle];
        
        CGRect statusLabelFrame = CGRectMake(0, 150, [[UIScreen mainScreen]bounds].size.width, 100);
        statusLabel = [[UILabel alloc]initWithFrame:statusLabelFrame];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:statusLabel];

    }
    else{
        UIImageView *frame = [[UIImageView alloc]init];
        if ([kind isEqualToString:@"SCL"]) {
            frame.frame = CGRectMake(0, 108, [[UIScreen mainScreen]bounds].size.width, 350);
            frame.image = [UIImage imageNamed:@"frame6+ 1242*5"];
        }
        else{
            frame.frame = CGRectMake(0, 108, [[UIScreen mainScreen]bounds].size.width, 305);
            frame.image = [UIImage imageNamed:@"frame6+ 1242*4"];
        }
        [self.view addSubview:frame];
        
        aButton.frame = CGRectMake(0, 235, [[UIScreen mainScreen]bounds].size.width, 45);
        aButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        aButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        bButton.frame = CGRectMake(0, 280, [[UIScreen mainScreen]bounds].size.width, 45);
        bButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        cButton.frame = CGRectMake(0, 324, [[UIScreen mainScreen]bounds].size.width, 45);
        cButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        cButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        dButton.frame = CGRectMake(0, 368, [[UIScreen mainScreen]bounds].size.width, 45);
        dButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        dButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        eButton.frame = CGRectMake(0, 412, [[UIScreen mainScreen]bounds].size.width, 45);
        eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        eButton.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        
        nextButton.frame = CGRectMake(320, 635, 60, 40);
        previousButton.frame = CGRectMake(30,635, 60, 40);
        
        if ([kind isEqualToString:@"SCL"]) {
            [self.view addSubview:eButton];
        }
        
        CGRect labelFrame = CGRectMake(0, 110, [[UIScreen mainScreen]bounds].size.width, 100);
        testTitle = [[UITextView alloc]initWithFrame:labelFrame];
        testTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        testTitle.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:testTitle];
        
        CGRect statusLabelFrame = CGRectMake(0, 150, [[UIScreen mainScreen]bounds].size.width, 100);
        statusLabel = [[UILabel alloc]initWithFrame:statusLabelFrame];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:statusLabel];
    }
    
    currentPosition = 0;
    
    [self.view addSubview:aButton];
    [self.view addSubview:bButton];
    [self.view addSubview:cButton];
    [self.view addSubview:dButton];
    [self.view addSubview:nextButton];
    [self.view addSubview:previousButton];
    [self.view addSubview:buttonView];
    previousButton.enabled = NO;
    nextButton.enabled = NO;
    [previousButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [previousButton setBackgroundColor:[UIColor clearColor]];
    [nextButton setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    manager = [[CoreDataManager alloc]init];
    Question *now = [manager findById:tag kind:kind];
    testTitle.text = now.questionLabel;
    testTitle.text = [self changeQuestionLabel:testTitle.text];
    testTitle.editable = NO;
    
    questionLabels = [manager findQuestionLabelsByKind:kind andTags:tags];
    questionNumber = [questionLabels count];
    statusLabel.text = [[NSString alloc]initWithFormat:@"%@测试  ： %ld/%ld",kind,(long)currentPosition + 1,(long)questionNumber];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextQuestion:(id)sender {
    intTag = [tag intValue];
    nextButton.enabled = NO;
    record.enabled = YES;
    NSLog(@"1");
    if (currentPosition < questionNumber - 1) {
        currentPosition = currentPosition + 1;
        tag = [tags objectAtIndex:currentPosition];
        Question *now = [manager findById:tag kind:kind];
        testTitle.text = now.questionLabel;
        testTitle.text = [self changeQuestionLabel:testTitle.text];
    }
    if (currentPosition) {
        previousButton.enabled = YES;
        [previousButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    statusLabel.text = [[NSString alloc]initWithFormat:@"%@测试  ： %ld/%ld",kind,(long)currentPosition + 1,(long)questionNumber];
    [nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [record setBackgroundColor:[UIColor clearColor]];
}

- (IBAction)previousQuestion:(id)sender {
    [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.enabled = NO;
    [nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    if (currentPosition) {
        currentPosition = currentPosition - 1;
        tag = [tags objectAtIndex:currentPosition];
        Question *now = [manager findById:tag kind:kind];
        testTitle.text = now.questionLabel;
        testTitle.text = [self changeQuestionLabel:testTitle.text];
        if (currentPosition == 0) {
            previousButton.enabled = NO;
            [previousButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        if ([now.answer isEqualToString:@"A"]) {
            [aButton setTitleColor:[UIColor colorWithRed:163.0/255.0 green:229.0/255.0 blue:215.0/255.0 alpha:100] forState:UIControlStateNormal];
            aButton.enabled = YES;
            tempButton = aButton;
        }
        if ([now.answer isEqualToString:@"B"]) {
            bButton.enabled = YES;
            [bButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:100] forState:UIControlStateNormal];
            tempButton = bButton;
        }
        if ([now.answer isEqualToString:@"C"]) {
            cButton.enabled = YES;
            [cButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:100] forState:UIControlStateNormal];
            tempButton = cButton;
        }
        if ([now.answer isEqualToString:@"D"]) {
            dButton.enabled = YES;
            [dButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:100] forState:UIControlStateNormal];
            tempButton = dButton;
        }
        if ([now.answer isEqualToString:@"E"]) {
            eButton.enabled = YES;
            [eButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:100] forState:UIControlStateNormal];
            tempButton = eButton;
        }
    }
    [record setBackgroundColor:[UIColor clearColor]];
    statusLabel.text = [[NSString alloc]initWithFormat:@"%@测试  ： %ld/%ld",kind,(long)currentPosition + 1,(long)questionNumber];
    if (currentPosition == questionNumber -2) {
        [nextButton setTitle:@"下一题" forState:UIControlStateNormal];
        [nextButton removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpOutside];
        [nextButton addTarget:self action:@selector(nextQuestion:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)chooseA:(id)sender {
    if (record.tag != 1) {
        record.enabled = YES;
        [record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [record setBackgroundColor:[UIColor clearColor]];
    }
    aButton.enabled = NO;
    //[aButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:100] forState:UIControlStateNormal];
    record = aButton;
    [manager modify:tag kind:kind answer:@"A"];
    nextButton.enabled = YES;
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (currentPosition == questionNumber -1) {
        [nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)chooseB:(id)sender {
    record.enabled = YES;
    if (record.tag != 2) {
        record.enabled = YES;
        [record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [record setBackgroundColor:[UIColor clearColor]];
    }
    bButton.enabled = NO;
    record = bButton;
    [manager modify:tag kind:kind answer:@"B"];
    nextButton.enabled = YES;
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (currentPosition == questionNumber -1) {
        [nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)chooseC:(id)sender {
    if (record.tag != 3) {
        [record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        record.enabled = YES;
        [record setBackgroundColor:[UIColor clearColor]];
    }
    cButton.enabled = NO;
    record = cButton;
    [manager modify:tag kind:kind answer:@"C"];
    nextButton.enabled = YES;
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (currentPosition == questionNumber -1) {
        [nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)chooseD:(id)sender {
    if (record.tag != 4) {
        [record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        record.enabled = YES;
        [record setBackgroundColor:[UIColor clearColor]];
    }
    dButton.enabled = NO;
    record = dButton;
    [manager modify:tag kind:kind answer:@"D"];
    nextButton.enabled = YES;
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (currentPosition == questionNumber -1) {
        [nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)chooseE:(id)sender {
    if (record.tag != 5) {
        [record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        record.enabled = YES;
        [record setBackgroundColor:[UIColor clearColor]];
    }
    eButton.enabled = NO;
    record = eButton;
    [manager modify:tag kind:kind answer:@"E"];
    nextButton.enabled = YES;
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (currentPosition == questionNumber -1) {
        [nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (IBAction)end:(id)sender {
    self.view.hidden = YES;
}

- (void)changeColorGreen:(id)sender{
    [sender setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:229.0/255.0 blue:215.0/255.0 alpha:100]];
    if (tempButton) {
        [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)changeColor:(id)sender{
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void)submit:(id)sender{
    
    [delegate submit];
}

-(NSString *)changeQuestionLabel:(NSString *)questionLabel{
    NSArray *separator = [questionLabel componentsSeparatedByString:@"."];
    NSString *later = [[NSString alloc]init];
    if ([separator count] > 1) {
        later = [separator objectAtIndex:1];
    }
    else{
        later = [questionLabel substringFromIndex:2];
    }
    NSString *changedQuestinoLabel = [NSString stringWithFormat:@"%d.%@",currentPosition+1,later];
    return changedQuestinoLabel;
}
@end
