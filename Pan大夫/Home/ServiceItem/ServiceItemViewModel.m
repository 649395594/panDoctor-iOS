//
//  ServiceItemViewModel.m
//  Pan大夫
//
//  Created by 张星宇 on 15/9/8.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "ServiceItemViewModel.h"
#import "AppDelegate.h"


@interface ServiceItemViewModel()

@property (strong, nonatomic) MKNetworkOperation *netOp;

@end


@implementation ServiceItemViewModel

- (RACSignal *)fetchItemPictureUrlWithPage:(int)pageNumber{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSString *path = [NSString stringWithFormat:@"/picInHome/getPicInHome.php?page=%d",pageNumber];
        _netOp = [appDelegate.netEngine operationWithPath:path];
        [_netOp addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            id json = [completedOperation responseJSON];
            NSDictionary *jsonDic = (NSDictionary *)json;
            NSArray *urlArray = [jsonDic objectForKey:@"URLs"];
            [subscriber sendNext:urlArray];  // 传过来的是url的数组，其中每个元素是一个键值对。key = "1" value = "URL"
            [subscriber sendCompleted];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        
        [appDelegate.netEngine enqueueOperation:_netOp];
        [subscriber sendNext:@"aa"];
        return nil;
    }];
}

@end
