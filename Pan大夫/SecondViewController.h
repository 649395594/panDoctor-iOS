//
//  SecondViewController.h
//  信息录入3
//
//  Created by LiYan on 15/8/19.
//  Copyright (c) 2015年 LiYan. All rights reserved.
//

#import "RegistInformationViewController.h"

@interface SecondViewController : RegistInformationViewController

@property (weak, nonatomic) IBOutlet UILabel *lableOfName;
@property (weak, nonatomic) IBOutlet UILabel *lableOfXuehao;
@property (weak, nonatomic) IBOutlet UILabel *lableOfXueyuan;
@property (weak, nonatomic) IBOutlet UILabel *lableOfMajor;
@property (weak, nonatomic) IBOutlet UILabel *lableOfSex;

@property(strong,nonatomic)NSString *dataOfName;
@property(strong,nonatomic)NSString *dataOfXuehao;
@property(strong,nonatomic)NSString *dataOfXueyuan;
@property(strong,nonatomic)NSString *dataOfMajor;
@property(strong,nonatomic)NSString *dataOfSex;
@end
