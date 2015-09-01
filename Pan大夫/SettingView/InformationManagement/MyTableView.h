//
//  ViewController.h
//  New-part
//
//  Created by xuyaowen on 15/3/13.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellForUserTableViewCell.h"
@class InformationViewController;
#import "Patient.h"

@interface MyTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) NSInteger action;


@property (nonatomic, strong) InformationViewController *rootVC;

@property (nonatomic, strong) NSMutableArray *patientsInformation;//总的数据源
@property (nonatomic, strong) NSMutableArray *defaultInformationArray;//section0的数据源
@property (nonatomic, strong) NSMutableArray *backupInformationArray;//section1的数据源
@property (nonatomic, strong) NSString* path;



- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style DefaultUser:(Patient *)defaulPatient BackUpUsers:(NSMutableArray *)backupPatients;
- (void)setDefaultInformationAtIndex:(NSIndexPath *)index;
-(void) setCell:(NSIndexPath *) selectedIndexPath;
- (void)writeDataIntoDatabase;

@end

