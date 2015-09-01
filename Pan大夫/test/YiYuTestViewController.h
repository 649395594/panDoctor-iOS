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
@interface YiYuTestViewController : UIViewController{
    //id <submitAnswers> delegate;
}
@property (nonatomic, weak) id<submitAnswers> delegate;

@property (nonatomic) NSMutableString *tag;

@property (strong, nonatomic) NSString *kind;

-(id)initWithKind:(NSString *)newKind;

- (IBAction)nextQuestion:(id)sender;

- (IBAction)previousQuestion:(id)sender;

- (IBAction)chooseA:(id)sender;

- (IBAction)chooseB:(id)sender;

- (IBAction)chooseC:(id)sender;

- (IBAction)chooseD:(id)sender;

- (IBAction)chooseE:(id)sender;

- (IBAction)end:(id)sender;

@property (strong, nonatomic) UIButton *aButton;

@property (strong, nonatomic) UIButton *bButton;

@property (strong, nonatomic) UIButton *cButton;

@property (strong, nonatomic) UIButton *dButton;

@property (strong, nonatomic) UIButton *eButton;

@property (strong, nonatomic) UIButton *nextButton;

@property (strong, nonatomic) UIButton *previousButton;

@property (strong, nonatomic) UIButton *endButton;

@property (strong, nonatomic) UIButton *tempButton;

@property (strong,nonatomic) NSArray *tags;

@end

