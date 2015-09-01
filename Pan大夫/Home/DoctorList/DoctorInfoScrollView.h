//
//  DoctorInfoScrollView.h
//  Pan大夫
//
//  Created by tiny on 15/3/9.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctor.h"
#import "CertificationViewController.h"
#import "CommentViewController.h"
#import "TimeTableViewController.h"
#import "DoctorInformationViewController.h"

@interface DoctorInfoScrollView : UIScrollView<UIScrollViewDelegate>{
    CGFloat userConOffsetX;
}

@property (strong, nonatomic)TimeTableViewController *timeTableViewController;
@property (strong, nonatomic)DoctorInformationViewController *docInfoViewController;

- (void)getButtonID:(long)tag;
- (id)initWithFrame:(CGRect)frame AndDoctor:(Doctor *)doc;
@end
