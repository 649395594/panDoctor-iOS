//
//  LoginViewController.h
//  Pan大夫
//
//  Created by zxy on 2/21/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) SettingsViewController *settingsView;

@property (strong, nonatomic) UIScrollView *scroll;
- (id)initWithNav:(BOOL)hasNav SettingsViewController:(SettingsViewController *)settingsViewController;

@end
