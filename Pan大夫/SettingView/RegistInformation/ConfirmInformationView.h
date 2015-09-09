//
//  ConfirmInformationView.h
//  Pan大夫
//
//  Created by Tom on 15/9/8.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRightLabelTag 100

@protocol ConfirmInformationViewDelegate <NSObject>

-(void)backButtonClicked;
-(void)commitButtonClicked;

@end

@interface ConfirmInformationView : UIView

@property(strong, nonatomic)UIImageView *headImageView;
@property(strong, nonatomic)UILabel *nameLabel;
@property(strong, nonatomic)UILabel *sexLabel;
@property(strong, nonatomic)UILabel *IDLabel;
@property(strong, nonatomic)UILabel *collogeLabel;
@property(strong, nonatomic)UILabel *majorLabel;

@property(weak, nonatomic) id<ConfirmInformationViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame InformationDictionary:(NSDictionary *)informationDictionary;

@end
