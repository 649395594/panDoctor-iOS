//
//  DiagnosisViewController.h
//  心理助手
//
//  Created by tiny on 15/1/25.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YiYuTestViewController.h"
@interface DiagnosisViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,submitAnswers>

@property (strong, nonatomic) UIImageView *bottomSquare;

@end
