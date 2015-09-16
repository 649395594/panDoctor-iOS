//
//  YiYuTestViewController.m
//  REFrostedViewControllerExample
//
//  Created by 张星宇 on 14-9-18.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "YiYuTestViewController.h"
#import "TestAnalysisViewController.h"
#import "CoreDataManager.h"
#import "Question.h"
#import "ChoicesImageView.h"
#import "OperationImageView.h"

@interface YiYuTestViewController ()
// 将choicesImageView设置为全局变量，在所有方法中均可调用
{
    ChoicesImageView *choicesImageView;
    OperationImageView *operationImageView;
}

@property (nonatomic , strong) CoreDataManager *manager;
@property (nonatomic , strong) UIButton *record;
@property (nonatomic , strong) NSMutableArray *questionLabels;
@property (nonatomic , assign) NSInteger questionNumber;
@property (nonatomic , assign) NSInteger currentPosition;
@property (nonatomic , assign) NSInteger intTag;
@property (strong, nonatomic) UIButton *endButton;
@property (strong, nonatomic) UIButton *tempButton;


@end

@implementation YiYuTestViewController

// 自定义初始化
-(id)initWithKind:(NSString *)newKind
{
    self = [super init];
    if (self) {
        _kind = newKind;
    }
    return self;
}

#pragma mark - 视图的加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1、最上面的grayConver
    UIImageView *grayConver = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, 45)];
    grayConver.backgroundColor = [UIColor grayColor];
    grayConver.alpha = 0.3;
    [self.view addSubview:grayConver];

    // 2、OperationImageView的初始化
    operationImageView = [[OperationImageView alloc]initWithScreenSize:[UIScreen mainScreen].bounds.size];
    // 使ImageView上面的控件能够进行交互
    operationImageView.userInteractionEnabled = YES;
    [self.view addSubview:operationImageView];
    
    // 3、为operationImageView的两个button添加事件
    [operationImageView.nextButton addTarget:self action:@selector(nextQuestion:) forControlEvents:UIControlEventTouchUpInside];
    [operationImageView.nextButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    [operationImageView.previousButton addTarget:self action:@selector(previousQuestion:) forControlEvents:UIControlEventTouchUpInside];
    
    // 4、对operationImageView的两个button进行初始化设置（第一次进入测试的界面展示）
    operationImageView.previousButton.enabled = NO;
    operationImageView.nextButton.enabled = NO;
    [operationImageView.previousButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [operationImageView.nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [operationImageView.previousButton setBackgroundColor:[UIColor clearColor]];
    [operationImageView.nextButton setBackgroundColor:[UIColor clearColor]];
    
     _currentPosition = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _manager = [[CoreDataManager alloc]init];
    Question *now = [_manager findById:_tag kind:_kind];
    _questionLabels = [_manager findQuestionLabelsByKind:_kind andTags:_tags];
    _questionNumber = [_questionLabels count];
    
    // 1、选项和题目序号所在的View的初始化(由于数据因为某种原因需要在视图加载之前进行处理，所以将view的加载也放在这个方法里面)
    choicesImageView = [[ChoicesImageView alloc]initWithScreenHeight:[UIScreen mainScreen].bounds.size.height withKind:_kind];
    
    // 2、将coreData的数据传入view中(标题和序号)
    [choicesImageView setTestTitleWithText:[self changeQuestionLabel:now.questionLabel]];
    [choicesImageView setStatusLabelWithText:[[NSString alloc]initWithFormat:@"%@测试  ： %ld/%ld",_kind,(long)_currentPosition + 1,(long)_questionNumber]];
    [self.view addSubview:choicesImageView];
    // 使得UIImageView具有交互功能
    [choicesImageView setUserInteractionEnabled:YES];
    
    // 3、为button添加事件
    [choicesImageView.aButton addTarget:self action:@selector(chooseA:) forControlEvents:UIControlEventTouchUpInside];
    [choicesImageView.aButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchUpInside];
    [choicesImageView.bButton addTarget:self action:@selector(chooseB:) forControlEvents:UIControlEventTouchUpInside];
    [choicesImageView.bButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchDown];
    [choicesImageView.cButton addTarget:self action:@selector(chooseC:) forControlEvents:UIControlEventTouchUpInside];
    [choicesImageView.cButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchDown];
    [choicesImageView.dButton addTarget:self action:@selector(chooseD:) forControlEvents:UIControlEventTouchUpInside];
    [choicesImageView.dButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchDown];
    [choicesImageView.eButton addTarget:self action:@selector(chooseE:) forControlEvents:UIControlEventTouchUpInside];
    [choicesImageView.eButton addTarget:self action:@selector(changeColorGreen:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - 操作按钮事件
- (void)nextQuestion:(id)sender
{
    _intTag = [_tag intValue];
    operationImageView.nextButton.enabled = NO;
    _record.enabled = YES;
    NSLog(@"1");
    if (_currentPosition < _questionNumber - 1) {
        _currentPosition = _currentPosition + 1;
        _tag = [_tags objectAtIndex:_currentPosition];
        Question *now = [_manager findById:_tag kind:_kind];
        choicesImageView.testTitle.text = now.questionLabel;
        choicesImageView.testTitle.text = [self changeQuestionLabel:choicesImageView.testTitle.text];
    }
    if (_currentPosition) {
        operationImageView.previousButton.enabled = YES;
        [operationImageView.previousButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    choicesImageView.statusLabel.text = [[NSString alloc]initWithFormat:@"%@测试  ： %ld/%ld",_kind,(long)_currentPosition + 1,(long)_questionNumber];
    [operationImageView.nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_record setBackgroundColor:[UIColor clearColor]];
}

- (void)previousQuestion:(id)sender {
    [_tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    operationImageView.nextButton.enabled = NO;
    [operationImageView.nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    if (_currentPosition) {
        _currentPosition = _currentPosition - 1;
        _tag = [_tags objectAtIndex:_currentPosition];
        Question *now = [_manager findById:_tag kind:_kind];
        choicesImageView.testTitle.text = now.questionLabel;
        choicesImageView.testTitle.text = [self changeQuestionLabel:choicesImageView.testTitle.text];
        if (_currentPosition == 0) {
            operationImageView.previousButton.enabled = NO;
            [operationImageView.previousButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        if ([now.answer isEqualToString:@"A"]) {
            [choicesImageView.aButton setTitleColor:[UIColor colorWithRed:163.0/255.0 green:229.0/255.0 blue:215.0/255.0 alpha:100] forState:UIControlStateNormal];
            choicesImageView.aButton.enabled = YES;
            _tempButton = choicesImageView.aButton;
        }
        if ([now.answer isEqualToString:@"B"]) {
            choicesImageView.bButton.enabled = YES;
            [choicesImageView.bButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:100] forState:UIControlStateNormal];
            _tempButton = choicesImageView.bButton;
        }
        if ([now.answer isEqualToString:@"C"]) {
            choicesImageView.cButton.enabled = YES;
            [choicesImageView.cButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:100] forState:UIControlStateNormal];
            _tempButton = choicesImageView.cButton;
        }
        if ([now.answer isEqualToString:@"D"]) {
            choicesImageView.dButton.enabled = YES;
            [choicesImageView.dButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:100] forState:UIControlStateNormal];
            _tempButton = choicesImageView.dButton;
        }
        if ([now.answer isEqualToString:@"E"]) {
            choicesImageView.eButton.enabled = YES;
            [choicesImageView.eButton setTitleColor:[UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:100] forState:UIControlStateNormal];
            _tempButton = choicesImageView.eButton;
        }
    }
    [_record setBackgroundColor:[UIColor clearColor]];
    choicesImageView.statusLabel.text = [[NSString alloc]initWithFormat:@"%@测试  ： %ld/%ld",_kind,(long)_currentPosition + 1,(long)_questionNumber];
    if (_currentPosition == _questionNumber -2) {
        [operationImageView.nextButton setTitle:@"下一题" forState:UIControlStateNormal];
        [operationImageView.nextButton removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpOutside];
        [operationImageView.nextButton addTarget:self action:@selector(nextQuestion:) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark - 5个选项的按钮操作
- (void)chooseA:(id)sender {
    if (_record.tag != 1) {
        _record.enabled = YES;
        [_record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_record setBackgroundColor:[UIColor clearColor]];
    }
    // 防止重复选中
    choicesImageView.aButton.enabled = NO;
    _record = choicesImageView.aButton;
    [_manager modify:_tag kind:_kind answer:@"A"];
    
    operationImageView.nextButton.enabled = YES;
    [operationImageView.nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (_currentPosition == _questionNumber -1) {
        [operationImageView.nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [operationImageView.nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)chooseB:(id)sender {
    _record.enabled = YES;
    if (_record.tag != 2) {
        _record.enabled = YES;
        [_record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_record setBackgroundColor:[UIColor clearColor]];
    }
    choicesImageView.bButton.enabled = NO;
    _record = choicesImageView.bButton;
    [_manager modify:_tag kind:_kind answer:@"B"];
    
    operationImageView.nextButton.enabled = YES;
    [operationImageView.nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (_currentPosition == _questionNumber -1) {
        [operationImageView.nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [operationImageView.nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)chooseC:(id)sender {
    if (_record.tag != 3) {
        [_record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _record.enabled = YES;
        [_record setBackgroundColor:[UIColor clearColor]];
    }
    choicesImageView.cButton.enabled = NO;
    _record = choicesImageView.cButton;
    [_manager modify:_tag kind:_kind answer:@"C"];
    operationImageView.nextButton.enabled = YES;
    [operationImageView.nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (_currentPosition == _questionNumber -1) {
        [operationImageView.nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [operationImageView.nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)chooseD:(id)sender {
    if (_record.tag != 4) {
        [_record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _record.enabled = YES;
        [_record setBackgroundColor:[UIColor clearColor]];
    }
    choicesImageView.dButton.enabled = NO;
    _record = choicesImageView.dButton;
    [_manager modify:_tag kind:_kind answer:@"D"];
    operationImageView.nextButton.enabled = YES;
    [operationImageView.nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (_currentPosition == _questionNumber -1) {
        [operationImageView.nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [operationImageView.nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)chooseE:(id)sender {
    if (_record.tag != 5) {
        [_record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _record.enabled = YES;
        [_record setBackgroundColor:[UIColor clearColor]];
    }
    choicesImageView.eButton.enabled = NO;
    _record = choicesImageView.eButton;
    [_manager modify:_tag kind:_kind answer:@"E"];
    operationImageView.nextButton.enabled = YES;
    [operationImageView.nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (_currentPosition == _questionNumber -1) {
        [operationImageView.nextButton setTitle:@"提交" forState:UIControlStateNormal];
        [operationImageView.nextButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -

- (void)changeColor:(id)sender{
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (void)submit:(id)sender{
    [_delegate submit];
}

// 改变button颜色
- (void)changeColorGreen:(id)sender{
    [sender setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:229.0/255.0 blue:215.0/255.0 alpha:100]];
    if (_tempButton) {
        [_tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

// 标题字符串的处理
- (NSString *)changeQuestionLabel:(NSString *)questionLabel{
    NSArray *separator = [questionLabel componentsSeparatedByString:@"."];
    NSString *later = [[NSString alloc]init];
    if ([separator count] > 1) {
        later = [separator objectAtIndex:1];
    }
    else{
        later = [questionLabel substringFromIndex:2];
    }
    NSString *changedQuestinoLabel = [NSString stringWithFormat:@"%ld.%@",_currentPosition+1,later];
    return changedQuestinoLabel;
}

@end
