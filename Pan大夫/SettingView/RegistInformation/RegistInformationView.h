//
//  RegistInformationView.h
//  Pan大夫
//
//  Created by KT on 15/9/3.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistInformationView : UIScrollView

@property(strong, nonatomic) NSArray *infoArray;
@property(strong, nonatomic) NSArray *promptArray;

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UIButton *boyButton;
@property (strong, nonatomic) UIButton *girlButton;
@property (strong, nonatomic) UIButton *commitButton;

@property (strong, nonatomic) UITextField *nameField;
@property (strong, nonatomic) UITextField *studentIdField;
@property (strong, nonatomic) UITextField *collegeField;
@property (strong, nonatomic) UITextField *majorField;

- (void)refreshText;
- (id)initWithFactor:(CGFloat)factor;

@end
