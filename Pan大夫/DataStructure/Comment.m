//
//  Comment.m
//  Pan大夫
//
//  Created by zxy on 3/12/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (id)initWithPatientName:(NSString *)patientName PatientTel:(NSString *)patientTel Mark:(NSString *)mark CommentDate:(NSString *)commentDate Information:(NSString *)information DoctorId:(NSString *)doctorId CommentId:(NSString *)commentId{
    self = [super init];
    if (self) {
        self.patientName = patientName;
        self.patientTel = patientTel;
        self.mark = mark;
        self.commentDate = commentDate;
        self.information = information;
        self.doctorId = doctorId;
        self.commentId = commentId;
    }
    return self;
}

@end
