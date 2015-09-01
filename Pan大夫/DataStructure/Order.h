//
//  Order.h
//  Pan大夫
//
//  Created by zxy on 3/10/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (nonatomic ,strong) NSString *orderId;
@property (nonatomic ,strong) NSString *doctorName;
@property (nonatomic ,strong) NSString *orderDate;
@property (nonatomic ,strong) NSString *patientName;
@property (nonatomic ,strong) NSString *patientTel;
@property (nonatomic ,strong) NSString *doctorId;
@property (nonatomic ,strong) NSString *special;
@property (nonatomic ,strong) NSString *address;
@property (nonatomic ,strong) NSString *commentId;
@property (nonatomic ,strong) NSString *orderDescription;
@property (nonatomic ,strong) NSString *status;
@property (nonatomic ,strong) NSString *patientSex;
@property (nonatomic ,strong) NSString *rejectReason;
@property (nonatomic) float price;
@property (nonatomic) float distance;
@property (nonatomic) int row;
@property (nonatomic) int duration;
@property (nonatomic) int patientAge;
@property (nonatomic) unsigned int startTime;

- (id)initWithOrderId:(NSString *)orderId Doctorname:(NSString *) doctorName OrderDate:(NSString *) orderDate Duration:(int)duration PatientName:(NSString *) patientName PatientTel:(NSString *) patientTel DoctorId:(NSString *) doctorId StartTime:(unsigned int) startTime Special:(NSString *) special Address:(NSString *) address CommentId:(NSString *) commentId Description:(NSString *) description Status:(NSString *) status Price:(float) price Distane:(float)distance Age:(int)age Sex:(NSString *)sex RejectReason:(NSString *)rejectReason;

@end
