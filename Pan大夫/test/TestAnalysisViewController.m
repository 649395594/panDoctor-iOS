
//
//  testAnalysisViewController.m
//  REFrostedViewControllerExample
//
//  Created by 张星宇 on 14-9-27.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "TestAnalysisViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TestAnalysisViewController ()

@property (nonatomic , strong) UITextView *resultLabel;

@property (nonatomic , strong) UILabel *label;

@property (strong, nonatomic) UIButton *endButton;

@property (strong,nonatomic) UIButton *saveButton;

@property (nonatomic) NSInteger mark;

@property (nonatomic) NSInteger factor;


@property (nonatomic, strong) NSMutableArray *bodyTags;

@property (nonatomic, strong) NSMutableArray *obsessionTags;

@property (nonatomic, strong) NSMutableArray *sensitiveInterpersonalRelationshipTags;

@property (nonatomic, strong) NSMutableArray *depressionTags;

@property (nonatomic, strong) NSMutableArray *anxietyTags;

@property (nonatomic, strong) NSMutableArray *hostilityTags;

@property (nonatomic, strong) NSMutableArray *horrorTags;

@property (nonatomic, strong) NSMutableArray *stubbornnessTags;

@property (nonatomic) NSInteger bodyProblemNumber,obsessionProblemNumber,IRProblemNumber,depressionProblemNumber,anxietyProblemNumber,hostilityProblemNumber,horrorProblemNumber,stubbornProblemNumber;

- (IBAction)end:(id)sender;

@end

@implementation TestAnalysisViewController

@synthesize resultLabel,label,saveButton;
@synthesize endButton,answers,tags,kind,mark,subKind,factor;
@synthesize bodyTags,obsessionTags,sensitiveInterpersonalRelationshipTags,depressionTags,anxietyTags,hostilityTags,horrorTags,stubbornnessTags;
@synthesize bodyProblemNumber,obsessionProblemNumber,IRProblemNumber,depressionProblemNumber,anxietyProblemNumber,hostilityProblemNumber,horrorProblemNumber,stubbornProblemNumber;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIImageView *frame = [[UIImageView alloc]init];
    frame.frame = CGRectMake(0, 91, 320, 410);
    frame.image = [UIImage imageNamed:@"app_tests_result_background_4s"];
    [self.view addSubview:frame];
    
    UIImageView *grayConver1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, 27)];
    grayConver1.backgroundColor = [UIColor grayColor];
    grayConver1.alpha = 0.3;
    [self.view addSubview:grayConver1];
    
    UIImageView *grayConver2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-67, [[UIScreen mainScreen] bounds].size.width, 27)];
    grayConver2.backgroundColor = [UIColor grayColor];
    grayConver2.alpha = 0.3;
    [self.view addSubview:grayConver2];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 95, [[UIScreen mainScreen] bounds].size.width, 27)];
    label.text = @"诊断结果";
    resultLabel = [[UITextView alloc]init];
    resultLabel.editable = NO;
    
    saveButton = [[UIButton alloc]init];
    [saveButton.layer setMasksToBounds:YES];
    [saveButton.layer setCornerRadius:4.0]; //设置矩形四个圆角半径
    [saveButton.layer setBorderWidth:1.0]; //边框宽度
    [saveButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.frame = CGRectMake((kScreenWidth - kScreenWidth/5)/2,0.75 * kScreenHeight, kScreenWidth/5, kScreenWidth/10);
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveResultToImage) forControlEvents:UIControlEventTouchUpInside];
    switch (DEVICE_ID) {
        case 1:{
            label.frame = CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 40);
            label.font = [UIFont systemFontOfSize:30];
            resultLabel.frame = CGRectMake(0, 160, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-118-107);
            resultLabel.font = [UIFont systemFontOfSize:16];
            break;
        }
        case 2:{
            label.frame = CGRectMake(0, 120, [[UIScreen mainScreen] bounds].size.width, 45);
            label.font = [UIFont systemFontOfSize:35];
            resultLabel.frame = CGRectMake(0, 180, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-118-107);
            resultLabel.font = [UIFont systemFontOfSize:20];
            break;
        }
        case 3:{
            label.frame = CGRectMake(0, 140, [[UIScreen mainScreen] bounds].size.width, 50);
            label.font = [UIFont systemFontOfSize:35];
            resultLabel.frame = CGRectMake(0, 200, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-118-107);
            resultLabel.font = [UIFont systemFontOfSize:24];
            break;
        }
        case 4:{
            label.frame = CGRectMake(0, 140, [[UIScreen mainScreen] bounds].size.width, 60);
            label.font = [UIFont systemFontOfSize:40];
            resultLabel.frame = CGRectMake(0, 220, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-118-107);
            resultLabel.font = [UIFont systemFontOfSize:27];
            break;
        }
            
        default:
            break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    resultLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [self.view addSubview:resultLabel];
    [self.view addSubview:saveButton];
    
    UIView *backButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 40)];
    UIButton *backButton  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 40)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icons_back_1"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToRootView) forControlEvents:UIControlEventTouchUpInside];
    [backButtonView addSubview:backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButtonView];
    
    mark = 0;
    if([kind isEqualToString:@"SAS"]){
        for (int i = 0 ; i < 20 ; i++) {
            NSString *answer = [answers objectAtIndex:i];
            if (i == 4 || i == 8 || i == 12 || i == 16 || i ==18) {
                if ([answer isEqualToString:@"A"]) {
                    mark += 4;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 3;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 2;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 1;
                }
            }
            else{
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                }
            }
        }
        NSLog(@"%ld",(long)mark);
        if (mark < 50) {
            NSLog(@"No Problem");
        }
        else if (mark >= 50 && mark <60){
            NSLog(@"轻度抑郁");
        }
        else if (mark >= 60 && mark < 70){
            NSLog(@"中度抑郁");
        }
        else{
            NSLog(@"重度抑郁");
        }
    }
    
    else if ([kind isEqualToString:@"SDS"]) {
        for (int i = 0; i < 20; i++) {
            NSString *answer = [answers objectAtIndex:i];
            if (i == 1 || i == 4 || i == 5 || i == 10 || i ==11 || i ==13 || i ==15 || i ==16 || i ==17 || i ==19) {
                if ([answer isEqualToString:@"A"]) {
                    mark += 4;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 3;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 2;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 1;
                }
            }
            else{
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                }
            }
        }
    }
    
    else if ([kind isEqualToString:@"SCL"]) {
        factor = 0;
        NSLog(@"%@",subKind);
        if ([subKind isEqualToString:@"body"]) {
            for (int i = 0; i < [answers count]; i++ ) {
                NSString *answer = [answers objectAtIndex:i];
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                    continue;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                    continue;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"E"]) {
                    mark += 5;
                    factor +=1;
                }
            }
            if (factor >= 2) {
                NSLog(@"Maybe there is some problem about %@",subKind);
            }
            else{
                NSLog(@"Perfect !");
            }
        }
        else if ([subKind isEqualToString:@"obsession"]){
            for (int i = 0; i < [answers count]; i++ ) {
                NSString *answer = [answers objectAtIndex:i];
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                    continue;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                    continue;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"E"]) {
                    mark += 5;
                    factor +=1;
                }
            }
            if (factor >= 2) {
                NSLog(@"Maybe there is some problem about %@",subKind);
            }
            else{
                NSLog(@"Perfect !");
            }
        }
        else if ([subKind isEqualToString:@"sensitiveInterpersonalRelationship"]){
            for (int i = 0; i < [answers count]; i++ ) {
                NSString *answer = [answers objectAtIndex:i];
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                    continue;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                    continue;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"E"]) {
                    mark += 5;
                    factor +=1;
                }
            }
            if (factor >= 2) {
                NSLog(@"Maybe there is some problem about %@",subKind);
            }
            else{
                NSLog(@"Perfect !");
            }
        }
        else if ([subKind isEqualToString:@"depression"]){
            for (int i = 0; i < [answers count]; i++ ) {
                NSString *answer = [answers objectAtIndex:i];
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                    continue;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                    continue;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"E"]) {
                    mark += 5;
                    factor +=1;
                }
            }
            if (factor >= 2) {
                NSLog(@"Maybe there is some problem about %@",subKind);
            }
            else{
                NSLog(@"Perfect !");
            }
        }
        else if ([subKind isEqualToString:@"anxiety"]){
            for (int i = 0; i < [answers count]; i++ ) {
                NSString *answer = [answers objectAtIndex:i];
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                    continue;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                    continue;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"E"]) {
                    mark += 5;
                    factor +=1;
                }
            }
            if (factor >= 2) {
                NSLog(@"Maybe there is some problem about %@",subKind);
            }
            else{
                NSLog(@"Perfect !");
            }
        }
        else if ([subKind isEqualToString:@"hostility"]){
            for (int i = 0; i < [answers count]; i++ ) {
                NSString *answer = [answers objectAtIndex:i];
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                    continue;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                    continue;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"E"]) {
                    mark += 5;
                    factor +=1;
                }
            }
            if (factor >= 2) {
                NSLog(@"Maybe there is some problem about %@",subKind);
            }
            else{
                NSLog(@"Perfect !");
            }
        }
        else if ([subKind isEqualToString:@"horror"]){
            for (int i = 0; i < [answers count]; i++ ) {
                NSString *answer = [answers objectAtIndex:i];
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                    continue;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                    continue;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"E"]) {
                    mark += 5;
                    factor +=1;
                }
            }
            if (factor >= 2) {
                NSLog(@"Maybe there is some problem about %@",subKind);
            }
            else{
                NSLog(@"Perfect !");
            }
        }
        else if ([subKind isEqualToString:@"stubbornness"]){
            for (int i = 0; i < [answers count]; i++ ) {
                NSString *answer = [answers objectAtIndex:i];
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                    continue;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                    continue;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                    factor +=1;
                    continue;
                }
                if ([answer isEqualToString:@"E"]) {
                    mark += 5;
                    factor +=1;
                }
            }
            if (factor >= 2) {
                NSLog(@"Maybe there is some problem about %@",subKind);
            }
            else{
                NSLog(@"Perfect !");
            }
        }
        else if ([subKind isEqualToString:@"general"]){
            [self loadData];
            for (int i = 0; i < [answers count]; i++ ) {
                NSString *answer = [answers objectAtIndex:i];
                if ([answer isEqualToString:@"A"]) {
                    mark += 1;
                    continue;
                }
                if ([answer isEqualToString:@"B"]) {
                    mark += 2;
                    continue;
                }
                if ([answer isEqualToString:@"C"]) {
                    mark += 3;
                    [self addNumberByInt:i];
                    continue;
                }
                if ([answer isEqualToString:@"D"]) {
                    mark += 4;
                    [self addNumberByInt:i];
                    continue;
                }
                if ([answer isEqualToString:@"E"]) {
                    mark += 5;
                    [self addNumberByInt:i];
                }
            }
            
        }
        NSLog(@"%ld %ld",(long)mark,(long)factor);
        NSLog(@"%ld %ld %ld %ld %ld %ld %ld %ld",(long)bodyProblemNumber,(long)obsessionProblemNumber,(long)IRProblemNumber,(long)depressionProblemNumber,(long)anxietyProblemNumber,(long)horrorProblemNumber,(long)hostilityProblemNumber,(long)stubbornProblemNumber);
    }
    
    
    if ([kind isEqualToString:@"SCL"]) {
        resultLabel.text = [self addResultLabelWithsubKind:subKind];
    }
    else{
        resultLabel.text = [self addResultLabelWithKind:kind];
    }
}

- (id)initWithAnswers:(NSMutableArray *)aanswers{
    self = [super init];
    if (self) {
        self.answers = aanswers;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)end:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
//    self.view.hidden = YES;
}

- (void)loadData{
    bodyTags = [[NSMutableArray alloc]init];
    [bodyTags addObject:@"1"];[bodyTags addObject:@"4"];[bodyTags addObject:@"12"];[bodyTags addObject:@"27"];[bodyTags addObject:@"40"];[bodyTags addObject:@"42"];[bodyTags addObject:@"48"];[bodyTags addObject:@"49"];[bodyTags addObject:@"52"];
    [bodyTags addObject:@"53"];[bodyTags addObject:@"56"];[bodyTags addObject:@"58"];
    
    obsessionTags = [[NSMutableArray alloc]init];
    [obsessionTags addObject:@"3"];[obsessionTags addObject:@"9"];[obsessionTags addObject:@"10"];[obsessionTags addObject:@"28"];[obsessionTags addObject:@"38"];[obsessionTags addObject:@"45"];[obsessionTags addObject:@"46"];[obsessionTags addObject:@"51"];[obsessionTags addObject:@"55"];[obsessionTags addObject:@"65"];
    
    sensitiveInterpersonalRelationshipTags = [[NSMutableArray alloc]init];
    [sensitiveInterpersonalRelationshipTags addObject:@"6"];[sensitiveInterpersonalRelationshipTags addObject:@"21"];[sensitiveInterpersonalRelationshipTags addObject:@"34"];[sensitiveInterpersonalRelationshipTags addObject:@"36"];[sensitiveInterpersonalRelationshipTags addObject:@"37"];[sensitiveInterpersonalRelationshipTags addObject:@"41"];[sensitiveInterpersonalRelationshipTags addObject:@"61"];[sensitiveInterpersonalRelationshipTags addObject:@"69"];[sensitiveInterpersonalRelationshipTags addObject:@"73"];
    
    depressionTags = [[NSMutableArray alloc]init];
    [depressionTags addObject:@"5"];[depressionTags addObject:@"14"];[depressionTags addObject:@"15"];[depressionTags addObject:@"20"];[depressionTags addObject:@"22"];[depressionTags addObject:@"26"];[depressionTags addObject:@"29"];[depressionTags addObject:@"30"];
    [depressionTags addObject:@"31"];[depressionTags addObject:@"32"];[depressionTags addObject:@"54"];[depressionTags addObject:@"71"];[depressionTags addObject:@"79"];
    
    anxietyTags = [[NSMutableArray alloc]init];
    [anxietyTags addObject:@"2"];[anxietyTags addObject:@"17"];[anxietyTags addObject:@"23"];[anxietyTags addObject:@"33"];[anxietyTags addObject:@"39"];[anxietyTags addObject:@"57"];[anxietyTags addObject:@"72"];[anxietyTags addObject:@"78"];[anxietyTags addObject:@"80"];[anxietyTags addObject:@"86"];
    
    hostilityTags = [[NSMutableArray alloc]init];
    [hostilityTags addObject:@"11"];[hostilityTags addObject:@"14"];[hostilityTags addObject:@"63"];[hostilityTags addObject:@"67"];[hostilityTags addObject:@"74"];[hostilityTags addObject:@"81"];
    
    horrorTags = [[NSMutableArray alloc]init];
    [horrorTags addObject:@"13"];[horrorTags addObject:@"25"];[horrorTags addObject:@"47"];[horrorTags addObject:@"50"];[horrorTags addObject:@"70"];[horrorTags addObject:@"75"];[horrorTags addObject:@"82"];
    
    stubbornnessTags = [[NSMutableArray alloc]init];
    [stubbornnessTags addObject:@"8"];[stubbornnessTags addObject:@"18"];[stubbornnessTags addObject:@"43"];[stubbornnessTags addObject:@"68"];[stubbornnessTags addObject:@"76"];[stubbornnessTags addObject:@"83"];
    
}

- (void)addNumberByInt:(int)i {
    NSString *tag = [NSString stringWithFormat:@"%d",i+1];
    if ([bodyTags containsObject:tag]) {
        bodyProblemNumber ++;
    }
    else if ([obsessionTags containsObject:tag]){
        obsessionProblemNumber ++;
    }
    else if ([sensitiveInterpersonalRelationshipTags containsObject:tag]){
        IRProblemNumber ++;
    }
    else if ([depressionTags containsObject:tag]){
        depressionProblemNumber ++;
    }
    else if ([anxietyTags containsObject:tag]){
        anxietyProblemNumber ++;
    }
    else if ([hostilityTags containsObject:tag]){
        hostilityProblemNumber ++;
    }
    else if ([horrorTags containsObject:tag]){
        horrorProblemNumber ++;
    }
    else if ([stubbornnessTags containsObject:tag]){
        stubbornProblemNumber ++;
    }
}

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([[UIScreen mainScreen] bounds].size.height < 568) {
        CGFloat buttonW = 71;
        CGFloat buttonH = 20;
        button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-buttonW/2, [[UIScreen mainScreen] bounds].size.height-87-20, buttonW + 1, buttonH + 1);
    }
    else{
        CGFloat buttonW = 71 * 1.5;
        CGFloat buttonH = 20 * 1.5;
        button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-buttonW/2, [[UIScreen mainScreen] bounds].size.height-87-30, buttonW + 1, buttonH + 1);
    }
    
    [button setImage: [UIImage imageNamed:normal]forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(saveButtonDidClicked:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)saveButtonDidClicked:(UIButton *)sender{
    sender.enabled = NO;
    
}

- (NSMutableString *)addResultLabelWithKind:(NSString *)_kind{
    NSMutableString *resultLabelText = [[NSMutableString alloc]init];
    
    if ([_kind isEqualToString:@"SAS"]) {
        [resultLabelText appendString:@"测试名称： 抑郁症自我测试\n"];
        [resultLabelText appendString:[NSString stringWithFormat:@"测试得分： %ld\n\n",(long)mark]];
        if (mark < 50) {
            [resultLabelText appendString:@"恭喜您，测试结果完全正常。"];
        }
        else if (mark >= 50 && mark <60){
            [resultLabelText appendString:@"您的抑郁指数略高于标准值，可能存在轻度抑郁症。\n\n您可以选择重新测试，或者向心理医生寻求帮助"];
        }
        else if (mark >= 60 && mark < 70){
            [resultLabelText appendString:@"您的抑郁指数比标准值高出不少哦\n\n建议向心理医生寻求帮助或者前往附近医院的相关科室就诊"];
        }
        else{
            [resultLabelText appendString:@"您的抑郁症状已经非常严重了，请尽快前往医院就诊！"];
        }
    }
    
    else if ([_kind isEqualToString:@"SDS"]) {
        [resultLabelText appendString:@"测试名称： 抑郁症自我测试\n"];
        [resultLabelText appendString:[NSString stringWithFormat:@"测试得分： %ld\n\n\n",(long)mark]];
        if (mark < 40) {
            [resultLabelText appendString:@"恭喜您，测试结果完全正常。"];
        }
        else if (mark >= 40 && mark <48){
            [resultLabelText appendString:@"您的抑郁指数略高于标准值，可能存在轻度抑郁症。\n\n您可以选择重新测试，或者向心理医生寻求帮助"];
        }
        else if (mark >= 48 && mark < 56){
            [resultLabelText appendString:@"您的抑郁指数比标准值高出不少哦\n\n建议向心理医生寻求帮助或者前往附近医院的相关科室就诊"];
        }
        else{
            [resultLabelText appendString:@"您的抑郁症状已经非常严重了，请尽快前往医院就诊！"];
        }
    }
    return resultLabelText;
}

- (NSMutableString *)addResultLabelWithsubKind:(NSString *)_subkind{
    NSMutableString *resultLabelText = [[NSMutableString alloc]init];
    
    [resultLabelText appendString:[NSString stringWithFormat:@"您的阳性因子个数为 %ld\n\n",(long)factor]];
    if (![_subkind isEqualToString:@"general"]) {
        if ([_subkind isEqualToString:@"body"]) {
            if(factor >= 2){
                [resultLabelText appendString:@"您存在较严重的身体不适现象，可能由于某些心理问题引起，请咨询专业人士"];
            }
            else{
                [resultLabelText appendString:@"您的测试结果正常，心理状况很健康"];
            }
        }
        if ([_subkind isEqualToString:@"obsession"]) {
            if(factor >= 2){
                [resultLabelText appendString:@"您存在较严重的强迫症在，需要考虑强迫症的可能，进一步了解详情请咨询专业人士"];
            }
            else{
                [resultLabelText appendString:@"您的测试结果正常，心理状况很健康"];
            }
        }
        if ([_subkind isEqualToString:@"sensitiveInterpersonalRelationship"]) {
            if(factor >= 2){
                [resultLabelText appendString:@"您存在较严重的人际关系敏感，请及时作出调整，进一步了解详情请咨询专业人士"];
            }
            else{
                [resultLabelText appendString:@"您的测试结果正常，心理状况很健康"];
            }
        }
        if ([_subkind isEqualToString:@"depression"]) {
            if(factor >= 2){
                [resultLabelText appendString:@"您存在较严重的抑郁虑症状，需要考虑抑郁症的可能，进一步了解详情请咨询专业人士"];
            }
            else{
                [resultLabelText appendString:@"您的测试结果正常，心理状况很健康"];
            }
        }
        if ([_subkind isEqualToString:@"anxiety"]) {
            if(factor >= 2){
                [resultLabelText appendString:@"您存在较严重的焦虑症状，需要考虑焦虑症的可能，进一步了解详情请咨询专业人士"];
            }
            else{
                [resultLabelText appendString:@"您的测试结果正常，心理状况很健康"];
            }
        }
        if ([_subkind isEqualToString:@"hostility"]) {
            if(factor >= 2){
                [resultLabelText appendString:@"您存在较严重的敌对情绪，请及时作出调整，进一步了解详情请咨询专业人士"];
            }
            else{
                [resultLabelText appendString:@"您的测试结果正常，心理状况很健康"];
            }
        }
        if ([_subkind isEqualToString:@"horror"]) {
            if(factor >= 2){
                [resultLabelText appendString:@"您存在较严重的恐惧感，请及时作出调整，进一步了解详情请咨询专业人士"];
            }
            else{
                [resultLabelText appendString:@"您的测试结果正常，心理状况很健康"];
            }
        }
        if ([_subkind isEqualToString:@"stubbornness"]) {
            if(factor >= 2){
                [resultLabelText appendString:@"您存在较严重的偏执情绪，请及时作出调整，进一步了解详情请咨询专业人士"];
            }
            else{
                [resultLabelText appendString:@"您的测试结果正常，心理状况很健康"];
            }
        }
        if ([_subkind isEqualToString:@"general"]) {
            if (mark > 160) {
                [resultLabelText appendString:@"您的测试结果并不理想，或许在某个方面存在问题，请联系专业人士做进一步检查。"];
            }
            else{
                [resultLabelText appendString:@"您的测试结果正常，心理状况很健康"];
            }
        }
    }
    else{
        
    }
    
    return resultLabelText;
}
-(void)backToRootView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)saveResultToImage{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    
    [[screenWindow layer]renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"恭喜您" message:@"已保存成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"保存失败，请重试" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
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

