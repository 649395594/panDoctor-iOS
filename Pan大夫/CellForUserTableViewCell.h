//
//  CellForUserTableViewCell.h
//  New-part
//
//  Created by xuyaowen on 15/3/13.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableView.h"

@interface CellForUserTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField* fieldOfAge;
@property (nonatomic, strong) UITextField* fieldOfPhone;
@property (nonatomic, strong) UITextField* fieldOfLocation;
@property (nonatomic, strong) UITextView * fieldOfAddress;
@property (nonatomic, strong) UILabel* labelOfSet;
@property (nonatomic, strong) UILabel* labelOfName;
@property (nonatomic, strong) UIButton* leftBtn;
@property (nonatomic, strong) NSIndexPath* myIndexPath;
@property (nonatomic, strong) NSString* sexes;
@property (nonatomic, strong) UIView* footerView;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(NSIndexPath*) myIndex ID:(NSInteger ) buttonId;
- (void) setsexImage:(NSString*) sexess;


@end
