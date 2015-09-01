//
//  DoctorCollectionViewController.h
//  Pan大夫
//
//  Created by tiny on 15/3/5.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorsListViewController.h"
#import "UIScrollView+PullLoad.h"
#import "Doctor.h"
@interface DoctorTableView : UITableView<UITableViewDataSource,UITableViewDelegate,PullDelegate>

@property (strong, nonatomic)DoctorsListViewController *docListNavPushDelegate;
@property (strong, nonatomic) NSMutableDictionary *userLocation;

- (id)initWithDoctors:(NSMutableArray *)doctors Delegate:(DoctorsListViewController *)delegate Special:(NSString *)special Page:(int) page SpecialTag:(int)specialTag ChooseCity:(NSString *)chooseCity;
- (void)cellClickedWithDoc:(Doctor *)doc;
@end
