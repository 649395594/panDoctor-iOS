//
//  ViewController.m
//  信息录入3
//
//  Created by LiYan on 15/8/19.
//  Copyright (c) 2015年 LiYan. All rights reserved.
//

#import "RegistInformationViewController.h"
#import "SecondViewController.h"

@interface RegistInformationViewController ()<UITextFieldDelegate>
//头像的定义
@property (weak, nonatomic) IBOutlet UIButton *buttonOfHead;

@property (weak, nonatomic) IBOutlet UIButton *buttonBoy;
@property (weak, nonatomic) IBOutlet UIButton *buttonGirl;
 // 初始化性别选择的标示符
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,strong)NSString *sex;
//键盘是否出现的标示符
@property (nonatomic,assign)BOOL isShowKeyboard;

@end

@implementation RegistInformationViewController
#pragma mark - 对键盘的4个操作方法
// 开始编辑
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    // 开始动画
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    // 设置动画时长
    [UIView setAnimationDuration:animationDuration];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    self.view.frame = CGRectMake(0.0f, -120, self.view.frame.size.width, self.view.frame.size.height);
    // 提交动画
    [UIView commitAnimations];
    // 设置标示符为已经跳转
    self.isShowKeyboard = YES;
}

-(void)regsignKeyboard{
    [UIView beginAnimations:@"resignFirstResponder" context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}


// 点击return
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self regsignKeyboard];
    return YES;
}

// 结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // 如果键盘已经跳出来了，就直接返回
    if (self.isShowKeyboard == YES)return;
//    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self regsignKeyboard];
}

// 点击屏幕
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    // 当点击屏幕其他位子，表示已经编辑完成，将view变为原来位子
//    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self regsignKeyboard];
}

#pragma mark -
//确认信息按钮事件
- (IBAction)confirmButtton:(id)sender {
    SecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Confirm"];
    
    // 1、向下一个试图控制器传值
    secondViewController.dataOfName = self.textOfName.text;
    secondViewController.dataOfXuehao = self.textOfXuehao.text;
    secondViewController.dataOfXueyuan = self.textOfXueyuan.text;
    secondViewController.dataOfMajor = self.textOfMajor.text;
    if(picturecountGirl==0&&picturecountBoy==1){
        secondViewController.dataOfSex = @"男生";
    }
    else if (picturecountGirl==1&&picturecountBoy==0){
        secondViewController.dataOfSex = @"女生";
    }
    
    
#if 0
    // 2、检查有没有没填的信息
    if(self.textOfName.text.length!=0){
        if(self.textOfXuehao.text.length==8){
            if(self.textOfXueyuan.text.length!=0){
                if(self.textOfMajor.text.length!=0){
                    //下面这个！=0是因为总要选择一个性别，都为零就是没有选择
                    if(picturecountBoy+picturecountGirl!=0){
                        //跳转到第二个
//                        [self presentViewController:secondViewController animated:YES completion:nil];
                        [self.navigationController pushViewController:secondViewController animated:YES];
                    }
                    else {
                        NSString *rowString5 = @"您还没有填写性别";
                        UIAlertView * alter5 = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString5           delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        [alter5 show];
                    }
                }
                else{
                    NSString *rowString4 = @"您还没有填写学院";
                    UIAlertView * alter4 = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString4           delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alter4 show];
                }
            }
            else{
                NSString *rowString3 = @"您还没有填写学院";
                UIAlertView * alter3 = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString3 delegate: nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alter3 show];
            }
        }
        else if(self.textOfXuehao.text.length==0){
            NSString *rowString2 = @"您还没有填写学号";
            UIAlertView * alter2 = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString2            delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alter2 show];
        }
        else{
            NSString *rowString2 = @"您的学号格式有误";
            UIAlertView * alter2 = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString2            delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alter2 show];

        }
    }
    else{
        NSString *rowString = @"您还没有填写姓名";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString            delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alter show];
    }
    
#else
    [self.navigationController pushViewController:secondViewController animated:YES];
#endif
}

//boy图片的打钩与否
//picturecountBoy=0表示该图片尚未表示为打钩状态
int picturecountBoy=0;
- (IBAction)buttonOfBoy:(UIButton *)button {
       //当男生女生都未打钩时为男生打钩
    if(picturecountBoy == 0&&picturecountGirl==0){
        [button setBackgroundImage:[UIImage imageNamed:@"picOfBoyYes"] forState:UIControlStateNormal];
        //确认各button状态
        picturecountBoy=1;
        picturecountGirl=0;
        [self.buttonOfHead setBackgroundImage:[UIImage imageNamed:@"picOfBoyHead"] forState:UIControlStateNormal];
        
    }
    //当男生没有打钩女生打钩时点击男生为男生打钩，同时女生取消打钩
    else if (picturecountBoy == 0&&picturecountGirl==1){
      [button setBackgroundImage:[UIImage imageNamed:@"picOfBoyYes"] forState:UIControlStateNormal];
        //让女生失去打钩的代码

        [self.buttonGirl setBackgroundImage:[UIImage imageNamed:@"picOfGirl"] forState:UIControlStateNormal];
        //确认各button状态
        picturecountBoy=1;
        picturecountGirl=0;
        [self.buttonOfHead setBackgroundImage:[UIImage imageNamed:@"picOfBoyHead"] forState:UIControlStateNormal];
        

    }
    //当男生打钩女生没打勾时点击男生为男生取消打钩
    else if (picturecountBoy == 1&&picturecountGirl==0){
      [button setBackgroundImage:[UIImage imageNamed:@"picOfBoy"] forState:UIControlStateNormal];
        //确认各button状态
        picturecountBoy=0;
        picturecountGirl=0;
        [self.buttonOfHead setBackgroundImage:[UIImage imageNamed:@"picOfBoyHead"] forState:UIControlStateNormal];
    }
}
//Girl图片的打钩与否
// picturecountGirl=0表示该图片尚未表示为打钩状态
int picturecountGirl=0;
- (IBAction)buttonOfGirl:(UIButton *)button {
       //当男生女生都未打钩时为女生打钩
    if(picturecountBoy == 0&&picturecountGirl==0){
        [button setBackgroundImage:[UIImage imageNamed:@"picOfGirlYes"] forState:UIControlStateNormal];
        //确认各button状态
        picturecountBoy=0;
        picturecountGirl=1;
        [self.buttonOfHead setBackgroundImage:[UIImage imageNamed:@"picOfGirlHead"] forState:UIControlStateNormal];

           }
    //当女生没有打钩而男生打钩时点击女生为女生打钩，同时男生取消打钩
    else if (picturecountBoy == 1&&picturecountGirl==0){
        [button setBackgroundImage:[UIImage imageNamed:@"picOfGirlYes"] forState:UIControlStateNormal];
        //让男生失去打钩的代码
        [self.buttonBoy setBackgroundImage:[UIImage imageNamed:@"picOfBoy"] forState:UIControlStateNormal];
        //确认各button状态
        picturecountBoy=0;
        picturecountGirl=1;
        [self.buttonOfHead setBackgroundImage:[UIImage imageNamed:@"picOfGirlHead"] forState:UIControlStateNormal];
    }
    //当男生打钩女生没打勾时点击女生为女生取消打钩
    else if (picturecountBoy == 0&&picturecountGirl==1){
        [button setBackgroundImage:[UIImage imageNamed:@"picOfGirl"] forState:UIControlStateNormal];
        //确认各button状态
        picturecountBoy=0;
        picturecountGirl=0;
        [self.buttonOfHead setBackgroundImage:[UIImage imageNamed:@"picOfGirlHead"] forState:UIControlStateNormal];
    }
}

// 提示用户只能有一个性别
//- (void)showAlertView
//{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告"
//                                                       message:@"只能选择一个性别"
//                                                      delegate:nil
//                                             cancelButtonTitle:@"确定"
//                                             otherButtonTitles:nil, nil];
//    [alertView show];
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置代理
    self.textOfName.delegate = self;
    self.textOfXuehao.delegate = self;
    self.textOfXueyuan.delegate = self;
    self.textOfMajor.delegate = self;
    // 初始化性别选择的标示符
    self.isSelected = NO;
    self.isShowKeyboard = NO;
    self.buttonOfHead.userInteractionEnabled = NO;
}

@end
