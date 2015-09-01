//
//  TimeTableViewController.h
//  timeTableView_1
//
//  Created by Tom on 15/3/7.
//  Copyright (c) 2015年 Tom. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface TimeTableViewController : UIViewController

@property(nonatomic)NSInteger selectedTimeLong;//订单持续时长，单位是半小时
@property(nonatomic)NSInteger outputStartPosition;//开始时间点在时间表字符串中的下表
@property(nonatomic)NSInteger outputTimeInterval;//字符串开始时间的时间戳

-(id)initWithTimeTable:(NSString *)_timeTable Frame:(CGRect)frame;
-(void)setCurrentDate:(NSString *)currentDate;

@end
