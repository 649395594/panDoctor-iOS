//
//  DoctorInformationViewController.h
//  Pan大夫
//
//  Created by tiny on 15/3/7.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctor.h"
@interface DoctorInformationViewController : UIViewController
- (id)initWithDocInfo:(Doctor *)doctor AndView:(UIView *)view;
@end
