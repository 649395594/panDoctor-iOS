//
//  Patient.h
//  New-part
//
//  Created by xuyaowen on 15/3/16.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Patient : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *tel;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *neighborhood;
@property (strong, nonatomic) NSString *doorNum;
@property (strong, nonatomic) NSString *defaultInfo;

//经纬度
//BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(39.915,116.404));
@property (nonatomic) double lng;
@property (nonatomic) double lat;


- (id)initWithName:(NSString *)name Tel:(NSString *)tel Age:(NSString *)age Address:(NSString *)address Location:(NSString *)location Sex:(NSString *)sex DoorNum:(NSString* ) door Province:(NSString* ) province Neigh: (NSString* ) neigh Default:(NSString *)defaultInfo Lng:(double) lng Lat:(double) lat;
- (id)initWithPatient:(Patient *)originalPatient;
@end
