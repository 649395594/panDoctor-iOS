//
//  InformationViewController.h
//  New-part
//
//  Created by xuyaowen on 15/3/14.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailView.h"

#import "Patient.h"

@interface InformationViewController : UIViewController

@property (nonatomic, strong) Patient* tmpOfPatient;
@property (nonatomic, strong) Patient* tmpOfPatient1;

@property (nonatomic ) NSInteger sexSeNum;
@property (nonatomic, strong) NSString* callPath;

- (id) initWithPath:(NSString* ) path ;
- (void) jump:(NSIndexPath *) cellIndex;
-(void) printf;
- (void)readPatientsFromDatabase;
@end
