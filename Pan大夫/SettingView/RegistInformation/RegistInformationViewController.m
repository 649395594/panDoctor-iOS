//
//  RegistInformationViewController.m
//  Pan大夫
//
//  Created by Tom on 15/9/2.
//  Copyright (c) 2015年 Neil. All rights reserved.
//


#define kThemeColor [UIColor colorWithRed:0/255.0 green:175.0/255.0 blue:170.0/255.0 alpha:1.0]




#define kLabelTag 100
#define kTextFieldTag 200

#import "RegistInformationViewController.h"
#import "ConfirmInformationViewController.h"
#import "RegistInformationView.h"
#import "RegistInformationViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RegistInformationViewController ()

@property (strong, nonatomic) RegistInformationView *registView;
@property (strong, nonatomic) RegistInformationViewModel *viewModel;
@property (strong, nonatomic) ConfirmInformationViewController *confirmInformationViewController;
@property (strong, nonatomic) NSArray *infoArray;
@property (strong, nonatomic) NSArray *promptArray;

@end

@implementation RegistInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _registView = [[RegistInformationView alloc] initWithFactor:[self adjustDevice]];
    _registView.infoArray = _infoArray;
    _registView.promptArray = _promptArray;
    [_registView refreshText];
    [self.view addSubview:_registView];
    
    [self bindViewModelData];  //绑定视图模型中的数据
    [self setCommitButtonStatus];  // 绑定commit按钮的状态，根据输入信息动态改变
    [self bindChooseSexButton];  // 设置选择性别的按钮按下后的事件
    [self bindCommitButton];  // 设置选择提交的按钮按下后的事件
}

- (id)init{
    self = [super init];
    if (self) {
        self.title = @"注册信息";
        _infoArray = @[@"姓名", @"学号", @"学院", @"专业"];
        _promptArray = @[@"请输入您的姓名", @"请输入您的学号", @"请输入您的学院", @"请输入您的专业"];
        _viewModel = [[RegistInformationViewModel alloc] init];
        self.view.backgroundColor = [UIColor whiteColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    return self;
}


- (CGFloat)adjustDevice{

   if (kScreenWidth == 320) {
       return 1.0;
   }else if (kScreenWidth == 375){
       return 1.172;
   }else if (kScreenWidth == 414){
       return 1.294;
   }else{
       return kScreenWidth/320.0;
   }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)isValidName:(NSString *)name {
    return name.length >= 2 && name.length <=4;
}

- (BOOL)isValidStudentId:(NSString *)studentId {
    return studentId.length == 8;
}

- (BOOL)isValidInformation:(NSString *)input {
    return input.length > 0;
}

- (void)bindViewModelData{
    RAC(self.viewModel, name) = _registView.nameField.rac_textSignal;
    RAC(self.viewModel, studentId) = _registView.studentIdField.rac_textSignal;
    RAC(self.viewModel, college) = _registView.collegeField.rac_textSignal;
    RAC(self.viewModel, major) = _registView.majorField.rac_textSignal;
}

- (void)setCommitButtonStatus{
    RACSignal *validNameSingal = [_registView.nameField.rac_textSignal map:^id(NSString *name) {
        return @([self isValidName:name]);
    }];
    RACSignal *validStudentIdSingal = [_registView.studentIdField.rac_textSignal map:^id(NSString *studentId) {
        return @([self isValidStudentId:studentId]);
    }];
    RACSignal *validCollegeSingal = [_registView.collegeField.rac_textSignal map:^id(NSString *college) {
        return @([self isValidInformation:college]);
    }];
    RACSignal *validMajorSingal = [_registView.majorField.rac_textSignal map:^id(NSString *major) {
        return @([self isValidInformation:major]);
    }];
    
    [[RACSignal combineLatest:@[validNameSingal,validStudentIdSingal,validMajorSingal,validCollegeSingal] reduce:^id(NSNumber *nameValid, NSNumber *studentIdValid, NSNumber *collegeValid, NSNumber *majorValid){
        return @([nameValid boolValue] && [studentIdValid boolValue] && [collegeValid boolValue] && [majorValid boolValue]);
    }]
     subscribeNext:^(NSNumber *isValid) {
         _registView.commitButton.enabled = [isValid boolValue];
         _registView.commitButton.backgroundColor = [isValid boolValue] ? kThemeColor : [UIColor lightGrayColor];
     }];
}

- (void)bindChooseSexButton{
    [[_registView.boyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _registView.boyButton.selected = YES;
        _registView.girlButton.selected = NO;
        _registView.headImageView.image = [UIImage imageNamed:@"picOfBoyHead"];
        self.viewModel.sex = @"男";
    }];
    
    [[_registView.girlButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        _registView.boyButton.selected = NO;
        _registView.girlButton.selected = YES;
        _registView.headImageView.image = [UIImage imageNamed:@"picOfGirlHead"];
        self.viewModel.sex = @"女";
    }];
}

- (void)bindCommitButton{
    [[_registView.commitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] initWithObjects:@[_viewModel.name,
                                                                               _viewModel.studentId,
                                                                               _viewModel.college,
                                                                               _viewModel.major
                                                                               ]
                                                                     forKeys:_infoArray];
        [infoDictionary setObject:_viewModel.sex forKey:@"性别"];
        _confirmInformationViewController = [[ConfirmInformationViewController alloc]initWithInformationDictionary:infoDictionary];
        [self.navigationController pushViewController:_confirmInformationViewController animated:YES];
    }];
}

@end
