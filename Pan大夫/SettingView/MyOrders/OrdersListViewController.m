//
//  OrdersListViewController.m
//  Pan大夫
//
//  Created by lf on 15/3/10.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "OrdersListViewController.h"
#import "MyOrderViewController.h"
#import "Order.h"
#import "Comment.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

#import "PaymentViewController.h"
#import "WaitingForServiceViewController.h"
#import "OrderCompletionViewController.h"
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
@interface OrdersListViewController ()
@property (strong, nonatomic) MKNetworkOperation *netOp;
@property (strong, nonatomic) UIActivityIndicatorView *NetIndicator;
@property (strong, nonatomic) UILabel *loadingLabel;
@property (strong, nonatomic) UILabel *netFailLabel;
@end

@implementation OrdersListViewController
@synthesize orders,comments;
@synthesize netOp;
@synthesize NetIndicator,loadingLabel,netFailLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    orders = [[NSMutableArray alloc]init];
    comments = [[NSMutableArray alloc]init];
    [self getOrdersFromNetWork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getOrdersFromNetWork{
    NetIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    NetIndicator.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width - 10)/2, (self.view.frame.size.height - 100)/2-20, 10, 10);
    
    loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width - 120)/2, (self.view.frame.size.height - 40)/2-20, 150, 40)];
    loadingLabel.text = @"拼命加载中。。。";
    
    [self doctorInfoWillLoad];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    NSString *path = [NSString stringWithFormat:@"/orderdb.php?&patientTel=18602412071&nextPage=%d",1];
    NSString *path = [NSString stringWithFormat:@"/orderdb.php?&patientTel=18602412071&nextPage=%d",1];

    netOp = [appDelegate.netEngine operationWithPath:path];
    netOp.customExpireTime = [NSString stringWithFormat:@"%d",2];
    __block NSMutableArray *localOrders = orders;
    __block NSMutableArray *localComments = comments;
    __block OrdersListViewController *localSelf = self;
    
    [netOp addCompletionHandler:^(MKNetworkOperation *operation){
        id json = [operation responseJSON];
        NSDictionary *dictionary = (NSDictionary *)json;
        int orderNumber = [[dictionary objectForKey:@"orderNumber"]intValue];
        NSMutableArray *allOrdersArray = [dictionary objectForKey:@"orders"];
        
        if (orderNumber == 0) {
            
        }
        else{
            for (int i=0; i<[allOrdersArray count]; i++) {
                NSDictionary *order = [allOrdersArray objectAtIndex:i];
                NSString *orderId = [order objectForKey:@"orderId"];
                NSString *doctorName = [order objectForKey:@"doctorName"];
                NSString *orderDate = [order objectForKey:@"orderDate"];
                int duration = [[order objectForKey:@"duration"]intValue];
                NSString *patientName = [order objectForKey:@"patientName"];
                NSString *status = [order objectForKey:@"status"];
                NSString *patientTel = [order objectForKey:@"patientTel"];
                NSString *special = [order objectForKey:@"special"];
                NSString *startTime = [order objectForKey:@"startTime"];
                NSString *address = [order objectForKey:@"address"];
                NSString *description = [order objectForKey:@"description"];
                NSString *patientSex = [order objectForKey:@"patientSex"];
                int patientAge = [[order objectForKey:@"patientAge"]intValue];
                float distance = [[order objectForKey:@"distance"]floatValue];
                float price = [[order objectForKey:@"price"]floatValue];
                NSString *doctorId = [order objectForKey:@"doctorId"];
                
                unsigned int intUnixTime = [startTime intValue];
                NSString *rejectReason = [[NSString alloc]initWithFormat:@""];
                if ([status isEqualToString:@"doctor_closed"]) {
                    rejectReason = [order objectForKey:@"rejectReason"];
                }
                Order *singleOrder = [[Order alloc]initWithOrderId:orderId Doctorname:doctorName OrderDate:orderDate Duration:duration PatientName:patientName PatientTel:patientTel DoctorId:doctorId StartTime:intUnixTime Special:special Address:address CommentId:nil Description:description Status:status Price:price Distane:distance Age:patientAge Sex:patientSex RejectReason:rejectReason];
                //添加评论对象，根据订单状态来区分
                if ([status isEqualToString:@"order_finished"]) {
                    NSString *mark = [order objectForKey:@"commentMark"];
                    NSString *commentInformation = [order objectForKey:@"commentInformation"];
                    Comment *singleComment = [[Comment alloc]initWithPatientName:patientName PatientTel:patientTel Mark:mark CommentDate:nil Information:commentInformation DoctorId:doctorId CommentId:nil];
                    [localSelf addObjectToComments:singleComment];
                }
                else{
                    Comment *singleComment = [[Comment alloc]initWithPatientName:nil PatientTel:nil Mark:nil CommentDate:nil Information:nil DoctorId:nil CommentId:nil];
                    [localSelf addObjectToComments:singleComment];
                }
                
                [localSelf addObjectToOrders:singleOrder];
            }
        }
        [localSelf doctorInfoDidLoad];
        
        
        MyOrderViewController *myOrderViewController = [[MyOrderViewController alloc]initWithOrders:localOrders Comments:localComments Delegate:localSelf];
        [localSelf.view addSubview:myOrderViewController];
        
    } errorHandler:^(MKNetworkOperation *operation,NSError *error){
        NSLog(@"网络加载失败！");
        [localSelf doctorInfoDidLoad];
        [localSelf noticeNetWorkFail];
    }
     ];
    [appDelegate.netEngine enqueueOperation:netOp];
}

//创建网络加载失败界面
- (void)noticeNetWorkFail{
    netFailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64,KDeviceWidth , KDeviceHeight-64)];
    netFailLabel.backgroundColor = [UIColor lightGrayColor];
    netFailLabel.textAlignment = NSTextAlignmentCenter;
    netFailLabel.font = [UIFont systemFontOfSize:12];
    netFailLabel.text = @"网络连接失败,请点击屏幕重新加载";
    
    UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singalTap];
    [self.view addSubview:netFailLabel];
}
//轻触手势调用函数
- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [self.view removeGestureRecognizer:sender];
    [netFailLabel removeFromSuperview];
    [self getOrdersFromNetWork];
}


//活动指示器开启
- (void)doctorInfoWillLoad{
    [self.view addSubview:NetIndicator];
    [self.view addSubview:loadingLabel];
    [NetIndicator startAnimating];
}

//活动指示器关闭
- (void)doctorInfoDidLoad{
    [NetIndicator stopAnimating];
    [loadingLabel removeFromSuperview];
    [NetIndicator removeFromSuperview];
}

- (void)jumpToViewControllerByOrder:(Order *)order Comment:(Comment *)comment{
    if ([order.status isEqualToString:@"wait_for_pay"] || [order.status isEqualToString:@"overtime_closed"]) {
        PaymentViewController *paymentViewController = [[PaymentViewController alloc]initWithOrder:order DocDetailView:nil Path:@"out" OrderListView:self];
        [self.navigationController pushViewController:paymentViewController animated:YES];
    }
    else if ([order.status isEqualToString:@"wait_for_confirm"] || [order.status isEqualToString:@"doctor_closed"]) {
        WaitingForServiceViewController *waitingForServiceViewController = [[WaitingForServiceViewController alloc]initWithOrder:order DocDetail:nil Path:@"out" OrderListView:self];
        [self.navigationController pushViewController:waitingForServiceViewController animated:YES];
    }
    else{
        OrderCompletionViewController *orderCompletionViewController = [[OrderCompletionViewController alloc]initWithOrder:order];
        if ([order.status isEqualToString:@"order_finished"]) {
            [orderCompletionViewController setNewStarRate:comment.mark UserComment:comment];
        }
        [self.navigationController pushViewController:orderCompletionViewController animated:YES];
        
    }
}

- (void)addObjectToComments:(Comment *)singleComment{
    [comments addObject:singleComment];
}

- (void)addObjectToOrders:(Order *)singleOrder{
    [orders addObject:singleOrder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
