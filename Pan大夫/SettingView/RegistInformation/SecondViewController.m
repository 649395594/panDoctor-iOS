//
//  SecondViewController.m
//  信息录入3
//
//  Created by LiYan on 15/8/19.
//  Copyright (c) 2015年 LiYan. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonOfHead2;

@end

@implementation SecondViewController

//赋值一定要写在willappear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.buttonOfHead2.userInteractionEnabled = NO;
    self.lableOfName.text = self.dataOfName;
    self.lableOfXuehao.text = self.dataOfXuehao;
    self.lableOfXueyuan.text = self.dataOfXueyuan;
    self.lableOfMajor.text = self.dataOfMajor;
    self.lableOfSex.text = self.dataOfSex;
    if([self.lableOfSex.text isEqualToString:@"男生"]){
        [self.buttonOfHead2 setBackgroundImage:[UIImage imageNamed:@"picOfBoyHead"] forState:UIControlStateNormal];
    }
    else if([self.lableOfSex.text isEqualToString:@"女生"]){
        [self.buttonOfHead2 setBackgroundImage:[UIImage imageNamed:@"picOfGirlHead"] forState:UIControlStateNormal];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)backToEdit:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
