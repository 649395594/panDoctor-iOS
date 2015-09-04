//
//  MyOrderViewController.m
//  Pan大夫
//
//  Created by lf on 15/3/10.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderItemViewCell.h"
#import "OrdersListViewController.h"
#import "Order.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

@interface MyOrderViewController (){
    int orderPage;
}

@property (nonatomic ,strong) NSMutableArray *ordersArray;
@property (nonatomic ,strong) NSMutableArray *commentsArray;
@property (nonatomic ,strong) OrdersListViewController *pushDelegate;
@property (strong, nonatomic) MKNetworkOperation *netOp;

@end

@implementation MyOrderViewController
@synthesize ordersArray,commentsArray;
@synthesize netOp;
- (id)initWithOrders:(NSMutableArray *)orders Comments:(NSMutableArray *)comments Delegate:(OrdersListViewController *)delegate{
    
    self = [super initWithFrame:CGRectMake(0,64, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height-64)];
    if (self) {
        ordersArray = orders;
        commentsArray = comments;
        self.pushDelegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = NO;
        
        self.pullDelegate = self;
        self.canPullUp = YES;
        self.canPullDown = YES;
      
    }
    return self;
}

//根据手势的上拉和下拉判断加载或者刷新
- (void)scrollView:(UIScrollView *)scrollView loadWithState:(LoadState)state{
    if (state == PullDownLoadState) {
        [self refreshOrderTable];
    }
    if (state == PullUpLoadState) {
        orderPage = orderPage+1;
        [self requestOrderFromNetWork];
        [self performSelector:@selector(PullUpLoadEnd) withObject:nil afterDelay:0];
    }
}

- (void)refreshOrderTable{
    orderPage = 1;
    [self requestOrderFromNetWork];
    [self performSelector:@selector(PullDownLoadEnd) withObject:nil afterDelay:0];
}

//上拉加载结束调用的函数
- (void)PullUpLoadEnd {
    [self reloadData];
    [self stopLoadWithState:PullUpLoadState];
}
//下拉刷新结束调用的函数
- (void)PullDownLoadEnd {
    self.canPullUp = YES;
    [self reloadData];
    [self stopLoadWithState:PullDownLoadState];
}


- (void)requestOrderFromNetWork{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *path = [NSString stringWithFormat:@"/orderdb.php?&patientTel=18602412071&nextPage=%d",orderPage];
    netOp = [appDelegate.netEngine operationWithPath:path];
    netOp.customExpireTime = [NSString stringWithFormat:@"%d",2];
    
    __block NSMutableArray *localOrders = ordersArray;
    __block int localPage = orderPage;
    __block MyOrderViewController *localSelf = self;
    
    [netOp addCompletionHandler:^(MKNetworkOperation *operation){
        id json = [operation responseJSON];
        NSDictionary *dictionary = (NSDictionary *)json;
        int orderNumber = [[dictionary objectForKey:@"orderNumber"]intValue];
        NSMutableArray *allOrdersArray = [dictionary objectForKey:@"orders"];
        
        if (orderNumber == 0) {
            
        }
        else{
            if (localPage <= 1) {
                [localOrders removeAllObjects];
            }
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
                NSString *rejectReason = [[NSString alloc]initWithFormat:@""];
                if ([status isEqualToString:@"doctor_closed"]) {
                    rejectReason = [order objectForKey:@"rejectReason"];
                }
                int patientAge = [[order objectForKey:@"patientAge"]intValue];
                float distance = [[order objectForKey:@"distance"]floatValue];
                float price = [[order objectForKey:@"price"]floatValue];
                NSString *doctorId = [order objectForKey:@"doctorId"];
                
                unsigned int intUnixTime = [startTime intValue];
                
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
        
    } errorHandler:^(MKNetworkOperation *operation,NSError *error){
    }
     ];
    [appDelegate.netEngine enqueueOperation:netOp];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"cell";
    tableView.allowsSelection = NO;
    OrderItemViewCell *cell = (OrderItemViewCell *)[tableView dequeueReusableCellWithIdentifier:indentifier];
    cell.row = indexPath.row;
    if (!cell) {
        cell = [[OrderItemViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    Order *order = [ordersArray objectAtIndex:indexPath.row];
    [cell setContentWithOrder:order];
    cell.backgroundColor = [UIColor whiteColor];

    NSString *stringInt = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.numberLable.text = stringInt;
    cell.order = order;
    
    //NSInteger row= [indexPath row];
    //[self setCellContent:cell Rows:row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IPHONE_5S_SCREEN) {
        return 168;
    }
    else if (IS_IPHONE_6_SCREEN)
        return ([[UIScreen mainScreen]bounds].size.width/320.0)*168;
    else if (IS_IPHONE_4S_SCREEN){
        return 168;
    }
    else return [[UIScreen mainScreen]bounds].size.width/320*168;
}

//-(void)setCellContent:(OrderItemViewCell *)cell Rows:(NSInteger)row{
//    Order *order = (Order *)[ordersArray objectAtIndex:row];
//        }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ordersArray count];
}

- (void)cellTapedBackToHomeWithRow:(int)row{
    Order *order = [ordersArray objectAtIndex:row];
    Comment *comment = [commentsArray objectAtIndex:row];
    [self.pushDelegate jumpToViewControllerByOrder:order Comment:comment];
}

- (void)addObjectToComments:(Comment *)singleComment{
    [commentsArray addObject:singleComment];
}

- (void)addObjectToOrders:(Order *)singleOrder{
    [ordersArray addObject:singleOrder];
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
