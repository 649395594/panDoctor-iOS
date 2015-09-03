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
//#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RegistInformationViewController ()<UITextFieldDelegate>

@property(strong, nonatomic)UIView *editView;
@property(strong, nonatomic)UIScrollView *backgroundScrollView;
@property(strong, nonatomic)NSArray *infoArray;
@property(strong, nonatomic)NSArray *promptArray;
@property(strong, nonatomic)NSMutableDictionary *infoDictionary;
@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UIButton *boyButton;
@property(strong, nonatomic)UIButton *girlButton;
@property(strong, nonatomic)UIButton *commitButton;
@property(strong, nonatomic)ConfirmInformationViewController *confirmInformationViewController;
@property(nonatomic)CGFloat deviceWidthRate;

@end

@implementation RegistInformationViewController
@synthesize editView, infoArray, promptArray, infoDictionary, backgroundScrollView, headImageView, boyButton, girlButton, commitButton, confirmInformationViewController, deviceWidthRate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RegistInformationView *view = [[RegistInformationView alloc] initWithFactor:[self adjustDevice]];
    view.infoArray = @[@"姓名", @"学号", @"学院", @"专业"];
    view.promptArray = @[@"请输入您的姓名", @"请输入您的学号", @"请输入您的学院", @"请输入您的专业"];
    [view refreshText];
    [self.view addSubview:view];
    
//    view.boyButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        view.girlButton.selected = NO;
//        view.headImageView.image = [UIImage imageNamed:@"picOfBoyHead"];
//        return [RACSignal empty];
//    }];
//    view.girlButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        view.boyButton.selected = NO;
//        view.headImageView.image = [UIImage imageNamed:@"picOfGirlHead"];
//        return [RACSignal empty];
//    }];
}

-(id)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.title = @"注册信息";
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
