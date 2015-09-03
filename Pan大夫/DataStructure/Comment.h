//
//  Comment.h
//  Pan大夫
//
//  Created by zxy on 3/12/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (strong, nonatomic) NSString *patientName;
@property (strong, nonatomic) NSString *patientTel;
@property (strong, nonatomic) NSString *mark;
@property (strong, nonatomic) NSString *commentDate;
@property (strong, nonatomic) NSString *information;
@property (strong, nonatomic) NSString *doctorId;
@property (strong, nonatomic) NSString *commentId;

- (id)initWithPatientName:(NSString *)patientName PatientTel:(NSString *)patientTel Mark:(NSString *)mark CommentDate:(NSString *)commentDate Information:(NSString *)information DoctorId:(NSString *)doctorId CommentId:(NSString *)commentId;
@end
