//
//  DoctorDetailViewController.h
//  Pan大夫
//
//  Created by tiny on 15/3/6.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctor.h"
#import "DoctorsListViewController.h"
@interface DoctorDetailViewController : UIViewController<UITabBarControllerDelegate>

@property (strong, nonatomic) DoctorsListViewController *docListView;

- (id)initWithDoctor:(Doctor *)doc DoctorList:(DoctorsListViewController *)docList;
- (void)goToInformationConfirmView;
@end
