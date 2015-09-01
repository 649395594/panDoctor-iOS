//
//  DoctorsListViewController.h
//  Pan大夫
//
//  Created by zxy on 2/27/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewController;
#import "Doctor.h"
@interface DoctorsListViewController : UIViewController

@property (strong, nonatomic) UILabel *userLocationLabel;
@property (strong, nonatomic) NSMutableDictionary *userLocation;
@property (strong, nonatomic) NSString *special;

- (id)initWithDelegate:(HomeViewController *)homeDelegate Special:(NSString *)special;
- (void)cellTapedBackToHomeWith:(Doctor *)doc;
@end
