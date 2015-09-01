//
//  ViewCell.h
//  Pan大夫
//
//  Created by tiny on 15/3/4.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorTableView.h"
#import "Doctor.h"
#import "StarRateView.h"
@interface DoctorItemViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *secRankLabel;
@property (strong, nonatomic) UITextView *specialView;
//@property (strong, nonatomic) UILabel *secPriceLabel;
@property (strong, nonatomic) UILabel *secLocationLabel;
//@property (strong, nonatomic) UILabel *secConTimesLabel;
//@property (strong, nonatomic) UILabel *secGPSLabel;
@property (strong, nonatomic) UILabel *departmentLabel;
@property (strong, nonatomic) UILabel *docTitleLabel;
@property (strong, nonatomic) Doctor *doctor;
//@property (strong, nonatomic) StarRateView *starRate;
@end
