//
//  detailView.h
//  New-part
//
//  Created by xuyaowen on 15/3/14.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZAreaPickerView.h"
#import "Patient.h"
#import "InformationViewController.h"
#import "MyTableView.h"

@class InformationViewController;
@interface detailView : UIViewController<UITextFieldDelegate,HZAreaPickerDelegate>

@property (nonatomic, strong) UITextField* fieldOfUser;
@property (nonatomic, strong) UITextField* fieldOfdate;
@property (nonatomic, strong) UITextField* fieldOfPhone;
@property (nonatomic, strong) UITextField*  fieldOfProvince;
@property (nonatomic, strong) UITextField*  fieldOfNeighborhood;
@property (nonatomic, strong) UITextField*  fieldOfDoorNum;
@property (nonatomic, strong) NSIndexPath*  informationIndex;


@property (nonatomic, strong) Patient* data;
@property (nonatomic, strong) MyTableView * dele;
@property (nonatomic, strong) NSIndexPath* myMyIndexPath;
@property (nonatomic) NSInteger action;
@property (nonatomic ) NSInteger sexNum;

@property (nonatomic) double Lng;
@property (nonatomic) double Lat;
@property (nonatomic, strong) NSString* path;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;

- (id) initWithUser:(NSString* )name Age:(NSString* ) age Del:(NSString* ) tel Provience:(NSString* ) province Neighborhood:(NSString* ) neighborhood DoorNum:(NSString* )doornum SexNum:(NSInteger) sexnum;


@end
