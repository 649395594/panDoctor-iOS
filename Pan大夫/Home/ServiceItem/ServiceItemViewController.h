//
//  ViewController.h
//  Demo_homepage
//
//  Created by lf on 15/3/7.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@protocol ServiceItemViewControllerProtocol <NSObject>

- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;

@end

@interface ServiceItemViewController : UIViewController

@property (weak, nonatomic) id<ServiceItemViewControllerProtocol> delegate;

@end

