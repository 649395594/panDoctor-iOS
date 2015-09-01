//
//  CommentTableView.h
//  Pan大夫
//
//  Created by zxy on 3/12/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentViewController.h"
#import "StarRateView.h"
#import "UIScrollView+PullLoad.h"
@interface CommentTableView : UITableView<UITableViewDelegate,UITableViewDataSource,CWStarRateViewDelegate,PullDelegate>

- (id)initWithComments:(NSMutableArray *)comments PushDelegate:(CommentViewController *)delegate Frame:(CGRect)frame Doctor:(Doctor *)doctor;
- (void)setTotalComment:(NSString *)totalCommentNumber AverageMark:(NSString *)averageMark FullMarkRate:(int) rate;

@end
