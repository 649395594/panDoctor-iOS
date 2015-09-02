//
//  testAnalysisViewController.h
//  REFrostedViewControllerExample
//
//  Created by 张星宇 on 14-9-27.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestAnalysisViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *answers;

@property (strong, nonatomic) NSMutableArray *tags;

@property (strong, nonatomic) NSString *kind;

@property (strong, nonatomic) NSString *subKind;

- (id)initWithAnswers:(NSMutableArray *)aanswers;

- (void)loadData;

- (void)addNumberByInt:(int)i;

@end
