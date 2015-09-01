    //
//  InformationConfirmViewController.h
//  AppointmentTAble
//
//  Created by Robin on 15/3/12.
//  Copyright (c) 2015年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "DoctorDetailViewController.h"
@interface InformationConfirmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UITextViewDelegate>

- (id)initWithOrder:(Order *)order DocDetail:(DoctorDetailViewController *)docDeatilView Path:(NSString *)path;
- (NSString *)expandTimeWithOrder:(Order *)order;

@property (nonatomic) double doctorLng;
@property (nonatomic) double doctorLat;
@property (nonatomic) double userLng;
@property (nonatomic) double userLat;
@property (nonatomic ,strong) NSString *path;
@property (nonatomic) int outputStartPosition;
@end
