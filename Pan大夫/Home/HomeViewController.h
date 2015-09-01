//
//  HomeViewController.h
//  Pan大夫
//
//  Created by zxy on 2/26/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctor.h"
#import "DoctorsListViewController.h"

@interface HomeViewController : UIViewController

@property (strong, nonatomic) DoctorsListViewController *doctorListVC;
@property (strong, nonatomic) UIButton *leftButton;

- (void)cellTapedPushWithNumber:(int)number;
- (void)cellTapedPushWith:(Doctor *)doc Special:(NSString *)special DoctorList:(DoctorsListViewController *)docList;
//- (void)getUserLocationFromNet;

@end
