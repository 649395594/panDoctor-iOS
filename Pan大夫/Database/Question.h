//
//  Question.h
//  REFrostedViewControllerExample
//
//  Created by 张星宇 on 14-9-21.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, strong) NSString *questionLabel;

@property (nonatomic, strong) NSString *kind;

@property (nonatomic, strong) NSMutableString *answer;

@property (nonatomic, strong) NSString *tag;


@end
