//
//  AppDelegate.h
//  Pan大夫
//
//  Created by zxy on 2/16/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "BMKMapManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,BMKLocationServiceDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) BMKMapManager * _mapManager;
@property (strong, nonatomic) MKNetworkEngine *netEngine;
@property (strong, nonatomic) BMKLocationService *locService;

@property (strong, nonatomic) NSString *currentAddress;
@property (strong, nonatomic) NSString *currentCity;

@end

