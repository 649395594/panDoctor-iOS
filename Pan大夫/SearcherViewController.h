//
//  SearcherViewController.h
//  json
//
//  Created by xuyaowen on 15/3/8.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "detailView.h"

@interface SearcherViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NSURLConnectionDataDelegate>


@property (nonatomic, strong) detailView* delegate;
@property (nonatomic, strong) NSString* city;


- (id) initWithCity:(NSString *)pCity Longitude:(double)pLongitude Latitude:(double)pLatitude;//初始化方法！

@end
