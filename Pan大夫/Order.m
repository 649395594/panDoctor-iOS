//
//  Order.m
//  Pan大夫
//
//  Created by zxy on 3/10/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "Order.h"

@implementation Order

- (id)initWithOrderId:(NSString *)orderId Doctorname:(NSString *) doctorName OrderDate:(NSString *) orderDate Duration:(int)duration PatientName:(NSString *) patientName PatientTel:(NSString *) patientTel DoctorId:(NSString *) doctorId StartTime:(unsigned int) startTime Special:(NSString *) special Address:(NSString *) address CommentId:(NSString *) commentId Description:(NSString *) description Status:(NSString *) status Price:(float) price Distane:(float)distance Age:(int)age Sex:(NSString *)sex RejectReason:(NSString *)rejectReason{
    self = [super init];
    if (self) {
        self.orderId = orderId;
        self.doctorName = doctorName;
        self.orderDate = orderDate;
        self.duration = duration;
        self.patientName = patientName;
        self.patientTel = patientTel;
        self.doctorId = doctorId;
        self.startTime = startTime;
        self.special = special;
        self.address = address;
        self.commentId = commentId;
        self.orderDescription = description;
        self.status = status;
        self.price = price;
        self.distance = distance;
        self.patientSex = sex;
        self.patientAge = age;
        self.rejectReason = rejectReason;
    }
    return self;
}

@end
