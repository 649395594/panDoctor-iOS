//
//  ServiceItemViewModel.h
//  Pan大夫
//
//  Created by 张星宇 on 15/9/8.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

#define NoUrlError     @"HttpGetNoUrlError"

@interface ServiceItemViewModel : NSObject

- (RACSignal *)fetchItemPictureUrlWithPage:(int)pageNumber;

@end
