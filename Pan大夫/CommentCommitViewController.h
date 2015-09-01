//
//  EvaluateViewController.h
//  Evaluate
//
//  Created by tiny on 15/3/20.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "OrderCompletionViewController.h"
#import "Comment.h"
@interface CommentCommitViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) Comment *comment;

- (id)initWithOrder:(Order *)order PushDelegate:(OrderCompletionViewController *)orderCompletionView UserComment:(Comment *)comment;
- (void)removeSecMark;
@end
