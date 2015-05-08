//
//  TestCell.h
//  Pan大夫
//
//  Created by Juvia Xin on 15/5/3.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCell : UITableViewCell

@property (strong,nonatomic) UITextView *title;
@property (strong,nonatomic) UIImageView *picture;
@property (strong,nonatomic) UIButton *heart;
@property (assign,nonatomic) NSInteger row;
@property (strong,nonatomic) NSString *Id;

@end
