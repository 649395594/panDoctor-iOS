//
//  PaymentViewController.m
//  AppointmentTAble
//
//  Created by Robin on 15/3/15.
//  Copyright (c) 2015年 Robin. All rights reserved.
//

#import "PaymentViewController.h"
#define UISCREEREALHEIGHT  self.view.bounds.size.height
#define UISCREENHEIGHT  ((self.view.bounds.size.height < 481.0)? 568.0 : self.view.bounds.size.height)
#define UISCREENWIDTH  self.view.bounds.size.width

#define greenButtonColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0
#define greenWordColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0
#define grayWordColor  colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0
#define customBackgroundColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0

#define imageSize (84.0/736.0)*UISCREENHEIGHT
#define timingViewSize (30.0/736)*UISCREENHEIGHT

#define oderLabelHeightBegin (18.0/736.0)*UISCREENHEIGHT
#define oderLabelWidth (24.0/736.0)*UISCREENHEIGHT

#define paymentButtonBeginLoction (10/414.0)*UISCREENWIDTH

#define   buttonTopLocation  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?5 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 5 : 10))
#define   buttonHight  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?45 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 50 : 40))
#define   fixFontSize  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?14 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 15 : 16))
#define   fixDetailFontSize  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?12 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 13 : 14))
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define secondsCount 900

@interface PaymentViewController ()

@property(nonatomic, retain)Order *order;
@property(nonatomic, retain)NSMutableString *appendPrice;
@property(nonatomic, retain)UIButton *checkButton;
@property (nonatomic, strong) NSString *startTimeString;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITableView *mainTable;
@property (nonatomic, strong) DoctorDetailViewController *docDetailView;
@property (nonatomic, strong) OrdersListViewController *orderList;
@end

@implementation PaymentViewController

@synthesize orderFixList;
@synthesize orderDataList;
@synthesize payTextList;
@synthesize payDetailList;
@synthesize payIamgeName;
@synthesize appendPrice, checkButton;
@synthesize startTimeString;
@synthesize bottomView;
@synthesize mainTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor customBackgroundColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, imageSize+timingViewSize)];
    
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, imageSize)] ;
    if (UISCREENWIDTH>=319&&UISCREENWIDTH<=321&&UISCREEREALHEIGHT>=479&&UISCREEREALHEIGHT<=481){
        [header setImage:[UIImage imageNamed:@"payment_header_4s"]];
    }
    [header setImage:[UIImage imageNamed:@"payment_header"]];
    [headerView addSubview:header];
    
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, imageSize, UISCREENWIDTH, timingViewSize)];
    timeView.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:218.0/255.0 alpha:1.0];
    [headerView addSubview:timeView];

    if (KDeviceWidth >=319&&KDeviceWidth <=321) {
        mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH,UISCREEREALHEIGHT-(75/667.0)*UISCREENHEIGHT)];
        mainTable.dataSource = self;
        mainTable.delegate = self;
        mainTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        mainTable.tableHeaderView =headerView;
        
        bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mainTable.frame)+(25/667.0)*UISCREENHEIGHT, UISCREENWIDTH, (50/667.0)*UISCREENHEIGHT)];
        bottomView.backgroundColor = [UIColor whiteColor];
    
    }
    else{
        mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH,UISCREEREALHEIGHT-(87/667.0)*UISCREENHEIGHT)];
        mainTable.dataSource = self;
        mainTable.delegate = self;
        mainTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        mainTable.tableHeaderView =headerView;
        
        bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mainTable.frame)+(27/667.0)*UISCREENHEIGHT, UISCREENWIDTH, (60/667.0)*UISCREENHEIGHT)];
        bottomView.backgroundColor = [UIColor whiteColor];
        
    }
    
    [self.view addSubview:mainTable];
    [self.view addSubview:bottomView];
    UIButton *paymentButton = [[UIButton alloc]initWithFrame:CGRectMake(paymentButtonBeginLoction, (buttonTopLocation/667.0)*UISCREENHEIGHT, (355.0/375.0)*UISCREENWIDTH, (buttonHight/667.0)*UISCREENHEIGHT)];
    paymentButton.layer.cornerRadius = 5;
    
    if (UISCREENHEIGHT < 569.0) {
        paymentButton.titleLabel.font = [UIFont  systemFontOfSize: 14];
    }
    if ([self.order.status isEqualToString:@"overtime_closed"]) {
        [paymentButton setBackgroundColor:[UIColor lightGrayColor]];
        paymentButton.enabled = NO;
        [paymentButton setTitle:@"已关闭" forState:UIControlStateNormal];
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((45.0/414)*UISCREENWIDTH, imageSize, UISCREENWIDTH, timingViewSize)];
        timeLabel.text = @"   支付时间超过30分钟 已自动取消订单";
        timeLabel.font =[UIFont systemFontOfSize:fixFontSize];
        timeLabel.textColor = [UIColor redColor];
        timeLabel.textColor = [UIColor grayWordColor];
        [headerView addSubview:timeLabel];
    }
    else{
        NSLog(@"%f",UISCREENHEIGHT);
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((45.0/414)*UISCREENWIDTH, imageSize, UISCREENWIDTH, timingViewSize)];
        timeLabel.text = @"   请于 30分钟 内完成支付,否则自动取消订单";
        timeLabel.font =[UIFont systemFontOfSize:fixFontSize];
        timeLabel.textColor = [UIColor redColor];
        timeLabel.textColor = [UIColor grayWordColor];
        [headerView addSubview:timeLabel];
        
        [paymentButton setBackgroundColor:[UIColor greenButtonColor]];
        [paymentButton setTitle:@"去支付" forState:UIControlStateNormal];
    }
    [paymentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [paymentButton addTarget:self action:@selector(paymentEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:paymentButton];
    //[bottomView addSubview:cancelButton];
    
}

- (id)initWithOrder:(Order *)order DocDetailView:(DoctorDetailViewController *)docDetail Path:(NSString *)path OrderListView:(OrdersListViewController *)orderList{
    self = [super init];
    self.order = order;
    self.path = path;
    self.docDetailView = docDetail;
    self.orderList = orderList;
    return self;
}

- (void) initData{
    orderFixList = [NSArray arrayWithObjects:@"订单名称 ：", @"订单日期 ：", @"交易金额 ：", nil];
    appendPrice = [NSMutableString stringWithFormat:@"%.0f",_order.price];
    [appendPrice appendString:@" 元"];
    payTextList = [NSArray arrayWithObjects:@"支付宝网页支付", @"支付宝客户端", @"微信支付", nil];
    payDetailList =[NSArray arrayWithObjects:@"推荐有支付宝账号的用户使用", @"推荐有支付宝客户端的用户使用", @"推荐已安装微信5.0及以上的用户安装", nil];
    payIamgeName = [NSArray arrayWithObjects:@"pay_icon_1",@"pay_icon_2",@"pay_icon_3",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor customBackgroundColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor grayWordColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    switch (section) {
        case 0:
            headerLabel.frame = CGRectMake(0.0, 0.0, UISCREENWIDTH, (45/736.0)*UISCREENHEIGHT);
            break;
        case 1:
            headerLabel.frame = CGRectMake(0.0, 0.0, UISCREENWIDTH, (50/736.0)*UISCREENHEIGHT);
            break;
        default:
            break;
    }
    NSArray *content = [NSArray arrayWithObjects:@"   订单信息",@"    选择支付方式",@"   ",nil];
    headerLabel.text = content[section];
    [customView addSubview:headerLabel];
    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return (50/736.0)*UISCREENHEIGHT;
    }
    if (indexPath.section == 1) {
        return (70/736.0)*UISCREENHEIGHT;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return (45/736.0)*UISCREENHEIGHT;
            break;
        case 1:
            return (50/736.0)*UISCREENHEIGHT;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(indexPath.section == 0){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 1) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }else{
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
 
    if (indexPath.section == 0) {
        cell.textLabel.font = [UIFont systemFontOfSize:fixFontSize];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:fixFontSize ];
        cell.textLabel.textColor = [UIColor grayWordColor];
        cell.detailTextLabel.textColor = [UIColor greenWordColor];
        [[cell textLabel]setText:[orderFixList objectAtIndex:indexPath.row]];
        switch (indexPath.row) {
            case 0:
                [[cell detailTextLabel]setText:_order.orderId];
                break;
            case 1:
                startTimeString = [self expandTimeWithOrder:self.order];
                [[cell detailTextLabel]setText:startTimeString];
                break;
            case 2:
                [[cell detailTextLabel]setText:appendPrice];
                break;
            default:
                break;
        }
    }if (indexPath.section == 1) {
        cell.textLabel.font = [UIFont systemFontOfSize:fixFontSize];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:fixDetailFontSize];
        cell.textLabel.textColor = [UIColor greenWordColor];
        cell.detailTextLabel.textColor = [UIColor grayWordColor];
        [[cell textLabel]setText:[payTextList objectAtIndex:indexPath.row]];
        [[cell detailTextLabel]setText:[payDetailList objectAtIndex:indexPath.row]];
        [[cell imageView]setImage:[UIImage imageNamed:[payIamgeName objectAtIndex:indexPath.row]]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (UILabel *)creatFixOderLabelWithName:(NSString *)name{
    UILabel *fixLabel = [[UILabel alloc]initWithFrame:CGRectMake((20.0/414.0)*UISCREENWIDTH, oderLabelHeightBegin, oderLabelWidth, 100)];
    fixLabel.font = [UIFont systemFontOfSize:fixFontSize];
    fixLabel.textColor = [UIColor grayWordColor];
    fixLabel.text = name;
    return fixLabel;
}


- (void)paymentEvent{
   // [self appendOrder];
    
    if ([self.path isEqualToString:@"out"]) {
        self.order.status = @"wait_for_confirm";
    }
    WaitingForServiceViewController *waitView = [[WaitingForServiceViewController alloc]initWithOrder:self.order DocDetail:self.docDetailView Path:self.path OrderListView:self.orderList];
    waitView.title =  @"预约";
    [self.navigationController pushViewController:waitView animated:YES];
    
}

- (IBAction)didCheck:(id)sender {
    if(checkButton.selected)
    {
        [checkButton setSelected:NO];
    }else{
        [checkButton setSelected:YES];
    }
}

- (NSString *)expandTimeWithOrder:(Order *)order{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:order.startTime];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *string1 = [formatter stringFromDate:date];
    
    if (string1.length == 16) {
        NSString *string2 = [string1 substringWithRange:NSMakeRange(11, 2)];
        NSString *string3 = [string1 substringWithRange:NSMakeRange(14, 2)];
        
        NSString *finish1;
        NSString *finish2;
        
        int intString2 = [string2 intValue];
        int intString3 = [string3 intValue];
        
        if (intString3 == 30) {
            if (order.duration%2) {
                finish1 = [NSString stringWithFormat:@"%d", (order.duration/2+intString2+1)];
                finish2 = @":00";
            }else{
                finish1 = [NSString stringWithFormat:@"%d", (order.duration/2+intString2)];
                finish2 = @":30";
            }
        }else {
            if (order.duration%2) {
                finish1 = [NSString stringWithFormat:@"%d", (order.duration/2+intString2)];
                finish2 = @":30";
            }else{
                finish1 = [NSString stringWithFormat:@"%d", (order.duration/2+intString2)];
                finish2 = @":00";
            }
        }
        NSString *expandTime = [NSString stringWithFormat:@"%@ ~ %@%@",string1, finish1, finish2];
        return expandTime;
        
    }else{
        
        return string1;
    }
}

- (void)cancelEvent{
    
}

- (Order *)appendOrder{
   
    
    return _order;
}


@end
