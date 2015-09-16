//
//  YiYuTestViewController.h
//  REFrostedViewControllerExample
//
//  Created by 张星宇 on 14-9-18.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol submitAnswers <NSObject>

@required
- (void)submit;
@end

@interface YiYuTestViewController : UIViewController

@property (nonatomic, weak) id<submitAnswers> delegate;

@property (nonatomic, copy) NSMutableString *tag;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, strong) NSArray *tags;

-(id)initWithKind:(NSString *)newKind;

@end

