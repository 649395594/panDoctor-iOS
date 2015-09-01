//
//  ViewController.h
//  信息录入3
//
//  Created by LiYan on 15/8/19.
//  Copyright (c) 2015年 LiYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistInformationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textOfName;
@property (weak, nonatomic) IBOutlet UITextField *textOfXuehao;
@property (weak, nonatomic) IBOutlet UITextField *textOfXueyuan;
@property (weak, nonatomic) IBOutlet UITextField *textOfMajor;

@end

//学号八位检测
//用picker来代替学院，专业