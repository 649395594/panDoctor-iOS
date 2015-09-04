//
//  PreDefination.h
//  Pan大夫
//
//  Created by zxy on 3/16/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

//adsfasfadf
#ifndef Pan___PreDefination_h
#define Pan___PreDefination_h

//#define HOSTNAME @"192.168.1.108:8888/mental"

//#define HOSTNAME @"zhangxingyu.sinaapp.com.cn/"

#define HOSTNAME @"pandoctor.sinaapp.com"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define IS_IPHONE_4S_SCREEN [[UIScreen mainScreen]bounds].size.height<=485.0f&&[[UIScreen mainScreen]bounds].size.height>=475.0f
#define IS_IPHONE_5S_SCREEN [[UIScreen mainScreen]bounds].size.height<=570.0f&&[[UIScreen mainScreen]bounds].size.height>=565.0f
#define IS_IPHONE_6_SCREEN [[UIScreen mainScreen]bounds].size.height<=670.0f&&[[UIScreen mainScreen]bounds].size.height>=660.0f
#define IS_IPHONE_6plus_SCREEN [[UIScreen mainScreen]bounds].size.height<=740.0f&&[[UIScreen mainScreen]bounds].size.height>=735.0f
#define DEVICE_ID IS_IPHONE_4S_SCREEN?1:(IS_IPHONE_5S_SCREEN?2:(IS_IPHONE_6_SCREEN?3:(IS_IPHONE_6plus_SCREEN?4:5)))

#endif
