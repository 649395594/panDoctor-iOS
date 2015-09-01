//
//  Patient.m
//  New-part
//
//  Created by xuyaowen on 15/3/16.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import "Patient.h"

@implementation Patient

- (id)initWithName:(NSString *)name Tel:(NSString *)tel Age:(NSString *)age Address:(NSString *)address Location:(NSString *)location Sex:(NSString *)sex DoorNum:(NSString* ) door Province:(NSString* ) province Neigh: (NSString* ) neigh Default:(NSString *)defaultInfo Lng:(double) lng Lat:(double) lat{
    self = [super init];
    if (self) {
        self.name = name;
        self.tel = tel;
        self.age = age;
        self.address = address;
        self.location = location;
        self.sex = sex;
        self.doorNum = door;
        self.province = province;
        self.neighborhood = neigh;
        self.defaultInfo = defaultInfo;
        self.lat = lat;
        self.lng = lng;
    }
    return self;
}

- (id)initWithPatient:(Patient *)originalPatient{
    self = [super init];
    if (self) {
        self.name = [[NSString alloc]initWithFormat:@"%@",originalPatient.name];
        self.tel = [[NSString alloc]initWithFormat:@"%@",originalPatient.tel];
        self.age = [[NSString alloc]initWithFormat:@"%@",originalPatient.age];
        self.address = [[NSString alloc]initWithFormat:@"%@",originalPatient.address];
        self.location = [[NSString alloc]initWithFormat:@"%@",originalPatient.location];
        self.sex = [[NSString alloc]initWithFormat:@"%@",originalPatient.sex];
        self.doorNum = [[NSString alloc]initWithFormat:@"%@",originalPatient.doorNum];
        self.province = [[NSString alloc]initWithFormat:@"%@",originalPatient.province];
        self.neighborhood = [[NSString alloc]initWithFormat:@"%@",originalPatient.neighborhood];
        self.defaultInfo = [[NSString alloc]initWithFormat:@"%@",originalPatient.defaultInfo];
        self.lat = originalPatient.lat;
        self.lng = originalPatient.lng;
    }
    return self;
    
}

@end
