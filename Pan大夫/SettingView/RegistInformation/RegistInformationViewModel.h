//
//  RegistInformationViewModel.h
//  Pan大夫
//
//  Created by KT on 15/9/4.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RegistInformationViewModel : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *studentId;
@property (copy, nonatomic) NSString *college;
@property (copy, nonatomic) NSString *major;
@property (copy, nonatomic) NSString *sex;

@end
