//
//  ViewController.h
//  Demo_homepage
//
//  Created by lf on 15/3/7.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface ServiceItemViewController : UIViewController

@property(nonatomic, strong) HomeViewController *pushDelegate;
-(id)initWithPushDelegate:(HomeViewController *)Delegate;
@end

