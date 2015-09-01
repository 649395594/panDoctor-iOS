//
//  OrderItemViewCell.h
//  Pan大夫
//
//  Created by lf on 15/3/10.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderViewController.h"
#import "Order.h"
#import "Comment.h"
@interface OrderItemViewCell : UITableViewCell

@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UILabel *doctorNameLable;
@property(strong,nonatomic)UILabel *lastingTimeLable;
@property(strong,nonatomic)UILabel *descriptionLable;
@property(strong,nonatomic)UILabel *yearLable;
@property(strong,nonatomic)UILabel *monthLable;
@property(strong,nonatomic)UILabel *dayLable;
@property(strong,nonatomic)UILabel *patientNameLable;
@property(strong,nonatomic)UILabel *priceLable;
@property(strong,nonatomic)UILabel *detailLable;//查看 按钮
@property(strong,nonatomic)UILabel *startHourLable;
@property(strong,nonatomic)UILabel *startMinLable;
@property(strong,nonatomic)UILabel *endHourLable;
@property(strong,nonatomic)UILabel *endMinLable;
@property(strong,nonatomic)Order *singleOrder;
@property(nonatomic)NSInteger *row;
@property(nonatomic,strong)UILabel *numberLable;
@property(nonatomic,strong)Order *order;

- (void)setContentWithOrder:(Order *)order;
@end
