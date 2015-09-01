//
//  NewsThumbnailTableViewCell.h
//  心理助手
//
//  Created by tiny on 15/1/28.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsThumbnailTableViewCell : UITableViewCell

@property (strong,nonatomic) UITextView *title;
@property (strong,nonatomic) UIImageView *image;
@property (assign,nonatomic) NSInteger row;
@property (strong,nonatomic) NSString *Id;
@end
