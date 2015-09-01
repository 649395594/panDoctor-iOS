//
//  questionManagedObject.h
//  REFrostedViewControllerExample
//
//  Created by 张星宇 on 14-9-22.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface questionManagedObject : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSString * questionLabel;
@property (nonatomic, retain) NSString * tag;

@end
