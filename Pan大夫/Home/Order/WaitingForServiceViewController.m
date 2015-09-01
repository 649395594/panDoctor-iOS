//
//  WaitingForServiceViewController.m
//  AppointmentTAble
//
//  Created by Robin on 15/3/17.
//  Copyright (c) 2015年 Robin. All rights reserved.
//

#import "WaitingForServiceViewController.h"
#import "OrderCompletionViewController.h"
@interface WaitingForServiceViewController ()

#define UISCREEREALHEIGHT  self.view.bounds.size.height

#define UISCREENHEIGHT  ((self.view.bounds.size.height < 481.0)? 568.0 : self.view.bounds.size.height)
#define UISCREENWIDTH  self.view.bounds.size.width
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define greenButtonColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0
#define greenWordColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0
#define grayWordColor  colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0
#define customBackgroundColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0

#define lineSeparationDistance (25.0/414.0)*self.view.bounds.size.width
#define labelContentBeginlocaltion  (110.0/414.0)*self.view.bounds.size.width
#define labelFixBeginLocaltion (20.0/414.0)*self.view.bounds.size.width
#define labelFixCell5BeginLocaltion (110.0/414.0)*self.view.bounds.size.width
#define labelTopBegin (10/568.0)*self.view.bounds.size.height

#define imageSize (84.0/736.0)*UISCREENHEIGHT
#define orderViewSize (30.0/736)*UISCREENHEIGHT

#define oderLabelHeightBegin (18.0/736.0)*UISCREENHEIGHT
#define oderLabelWidth (24.0/736.0)*UISCREENHEIGHT

#define compeletButtonBeginLoction (270/414.0)*UISCREENWIDTH
#define againButtonBeginLocation (10/414.0)*UISCREENWIDTH

#define   buttonTopLocation  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?5 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 5 : 10))
#define   buttonHight  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?36 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 40 : 40))

#define   fixFontSize  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?14 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 15 : 16))

#define kBottomViewTopInterval 20/667.0
#define kBottomViewHeight 54/667.0

@property (nonatomic, retain)Order *order;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) DoctorDetailViewController *docDetailView;
@property (nonatomic, strong) OrdersListViewController *orderList;

@end

@implementation WaitingForServiceViewController
@synthesize bottomView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor customBackgroundColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, imageSize+orderViewSize)];
    
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, imageSize)] ;
    if (UISCREENWIDTH>=319&&UISCREENWIDTH<=321&&UISCREEREALHEIGHT>=479&&UISCREEREALHEIGHT<=481){
        [header setImage:[UIImage imageNamed:@"waitingForService_head_4s"]];
    }
    [header setImage:[UIImage imageNamed:@"waitingForService_head"]];
    [headerView addSubview:header];
    
    UIView *orderView = [[UIView alloc]initWithFrame:CGRectMake(0, imageSize, UISCREENWIDTH, orderViewSize)];
    orderView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    [headerView addSubview:orderView];
    
    UIImageView *upperSeperateLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageSize, UISCREENWIDTH, 0.5)];
    [upperSeperateLine setBackgroundColor:[UIColor grayWordColor]];
    [headerView addSubview:upperSeperateLine];
    
    UIImageView *downerSeperateLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageSize+orderViewSize-1, UISCREENWIDTH, 0.5)];
    [downerSeperateLine setBackgroundColor:[UIColor grayWordColor]];
    [headerView addSubview:downerSeperateLine];
    
    UILabel *orderFixLabel = [[UILabel alloc]initWithFrame:CGRectMake((125.0/414)*UISCREENWIDTH, imageSize, UISCREENWIDTH, orderViewSize)];
    orderFixLabel.text = @"订单号 ：";
    orderFixLabel.font =[UIFont  systemFontOfSize:fixFontSize];
    orderFixLabel.textColor = [UIColor grayWordColor];
    [headerView addSubview:orderFixLabel];
    
    UILabel *orderContentLabel = [[UILabel alloc]initWithFrame:CGRectMake((190.0/414)*UISCREENWIDTH, imageSize, UISCREENWIDTH, orderViewSize)];
    orderContentLabel.text = self.order.orderId;
    orderContentLabel.font =[UIFont  systemFontOfSize:fixFontSize];
    orderContentLabel.textColor = [UIColor greenWordColor];
    [headerView addSubview:orderContentLabel];
    
    UITableView *mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREEREALHEIGHT-kBottomViewHeight*KDeviceHeight-kBottomViewTopInterval*KDeviceHeight)];
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    mainTable.tableHeaderView = headerView;
    [self.view addSubview:mainTable];
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mainTable.frame)+kBottomViewTopInterval*KDeviceHeight, KDeviceWidth, kBottomViewHeight*KDeviceHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    if ([self.path isEqualToString:@"in"]) {
        UIButton *againButton = [[UIButton alloc]initWithFrame:CGRectMake(againButtonBeginLocation, (buttonTopLocation/667.0)*UISCREENHEIGHT, (120.0/375)*UISCREENWIDTH, (buttonHight/667.0)*UISCREENHEIGHT)];
        againButton.layer.cornerRadius = 5;
        againButton.layer.borderWidth = 1.0;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.0/255.0, 175.0/255, 170.0/255, 1 });
        [againButton.layer setBorderColor:colorref];
        if (UISCREENHEIGHT < 569.0) {
            againButton.titleLabel.font = [UIFont  systemFontOfSize: 14];
        }
        [againButton setTitle:@"再下一单" forState:UIControlStateNormal];
        [againButton setBackgroundColor:[UIColor whiteColor]];
        [againButton setTitleColor:[UIColor greenWordColor] forState:UIControlStateNormal];
        [againButton addTarget:self action:@selector(againEvent) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *completButton = [[UIButton alloc]initWithFrame:CGRectMake(compeletButtonBeginLoction, (buttonTopLocation/667.0)*UISCREENHEIGHT, (120.0/375)*UISCREENWIDTH, (buttonHight/667.0)*UISCREENHEIGHT)];
        completButton.layer.cornerRadius = 5;
        if (UISCREENHEIGHT < 569.0) {
            completButton.titleLabel.font = [UIFont  systemFontOfSize: 14];
        }
        [completButton setTitle:@"完成预约" forState:UIControlStateNormal];
        [completButton setBackgroundColor:[UIColor greenButtonColor]];
        [completButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [completButton addTarget:self action:@selector(completeEvent) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:againButton];
        [bottomView addSubview:completButton];
        
        //设置右侧分享按钮
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
        [leftButton setTitleColor:[UIColor greenWordColor] forState:UIControlStateNormal];
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(completeEvent) forControlEvents:UIControlEventTouchUpInside];
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 40, 20)];
        [leftView addSubview:leftButton];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    if ([self.path isEqualToString:@"out"]) {
        if ([self.order.status isEqualToString:@"wait_for_confirm"]){
            UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(againButtonBeginLocation, (buttonTopLocation/667.0)*UISCREENHEIGHT,KDeviceWidth-2*againButtonBeginLocation,(buttonHight/667.0)*UISCREENHEIGHT)];
            shareButton.backgroundColor = [UIColor greenButtonColor];
            [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [shareButton setTitle:@"分  享" forState:UIControlStateNormal];
            shareButton.layer.cornerRadius = 5;
            [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:shareButton];
            
            UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
            [leftButton setTitleColor:[UIColor greenWordColor] forState:UIControlStateNormal];
            [leftButton setTitle:@"返回" forState:UIControlStateNormal];
            [leftButton addTarget:self action:@selector(backToOrderList) forControlEvents:UIControlEventTouchUpInside];
            UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 40, 20)];
            [leftView addSubview:leftButton];
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
        if ([self.order.status isEqualToString:@"doctor_closed"]) {
            UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(againButtonBeginLocation, (buttonTopLocation/667.0)*UISCREENHEIGHT,KDeviceWidth-2*againButtonBeginLocation,(buttonHight/667.0)*UISCREENHEIGHT)];
            backButton.backgroundColor = [UIColor greenButtonColor];
            [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [backButton setTitle:@"返  回" forState:UIControlStateNormal];
            backButton.layer.cornerRadius = 5;
            [backButton addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:backButton];
        }
    }
}

- (void)backToOrderList{
    [self.navigationController popToViewController:self.orderList animated:YES];
}

- (void)backEvent{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithOrder:(Order *)order DocDetail:(DoctorDetailViewController *)docDetail Path:(NSString *)path OrderListView:(OrdersListViewController *)orderList{
    self = [super init];
    self.order = order;
    self.path = path;
    self.docDetailView = docDetail;
    self.orderList = orderList;
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 5;
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
            headerLabel.frame = CGRectMake(0.0, 0.0, UISCREENWIDTH, 0.0);
            break;
        default:
            break;
    }
    [customView addSubview:headerLabel];
    return customView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        if (indexPath.row == 2) {
            return (120/736.0)*UISCREENHEIGHT;
        }else if (indexPath.row == 4){
            return (140/736.0)*UISCREENHEIGHT;
        }else{
            return (70/736.0)*UISCREENHEIGHT;
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    if (indexPath.section == 0 && indexPath.row ==0) {
        [cell.contentView addSubview:[self creatFixLabelWithName:@"咨询医师 ：" labelLactionX:0 labelLactionY:0]];
        [cell.contentView addSubview:[self creatFixLabelWithName:@"咨询时间 ：" labelLactionX:0 labelLactionY:lineSeparationDistance]];
        [cell.contentView addSubview:[self creatContentLabelWithName:_order.doctorName labelLactionX:0 labelLactionY:0]];
        
        NSString *timeString = [self expandTimeWithOrder:self.order];
        [cell.contentView addSubview:[self creatContentLabelWithName:timeString labelLactionX:0 labelLactionY:lineSeparationDistance]];
        
        
    }if (indexPath.section == 0 && indexPath.row ==1) {
        [cell.contentView addSubview:[self creatFixLabelWithName:@"咨询专项 ：" labelLactionX:0 labelLactionY:0]];
        [cell.contentView addSubview:[self creatFixLabelWithName:@"情况说明 ：" labelLactionX:0 labelLactionY:lineSeparationDistance]];
        [cell.contentView addSubview:[self creatContentLabelWithName:_order.special labelLactionX:0 labelLactionY:0]];
        //内容情况说明
        [cell.contentView addSubview:[self creatContentLabelWithName:_order.orderDescription labelLactionX:0 labelLactionY:lineSeparationDistance]];
        
    }if (indexPath.section ==0 && indexPath.row ==2) {
        [cell.contentView addSubview:[self creatFixLabelWithName:@"联系人 ：" labelLactionX:0 labelLactionY:0]];
        [cell.contentView addSubview:[self creatFixLabelWithName:@"性别年龄 ：" labelLactionX:0 labelLactionY:lineSeparationDistance*1]];
        [cell.contentView addSubview:[self creatFixLabelWithName:@"联系方式 ：" labelLactionX:0 labelLactionY:lineSeparationDistance*2]];
        [cell.contentView addSubview:[self creatFixLabelWithName:@"咨询地点 ：" labelLactionX:0 labelLactionY:lineSeparationDistance*3]];
        [cell.contentView addSubview:[self creatContentLabelWithName:_order.patientName labelLactionX:0 labelLactionY:0]];
        
        NSString *sexAndAge = [NSString stringWithFormat:@"%@,  %d",self.order.patientSex,self.order.patientAge];
        [cell.contentView addSubview:[self creatContentLabelWithName:sexAndAge labelLactionX:0 labelLactionY:lineSeparationDistance]];
        [cell.contentView addSubview:[self creatContentLabelWithName:_order.patientTel labelLactionX:0 labelLactionY:lineSeparationDistance*2]];
        [cell.contentView addSubview:[self creatContentLabelWithName:_order.address labelLactionX:0 labelLactionY:lineSeparationDistance*3]];
        
    }if (indexPath.section ==0 && indexPath.row ==3){
        [cell.contentView addSubview:[self creatFixLabelWithName:@"订单日期 ：" labelLactionX:0 labelLactionY:0]];
        [cell.contentView addSubview:[self creatFixLabelWithName:@"订单金额 ：" labelLactionX:0 labelLactionY:lineSeparationDistance]];
        //缺获取函数
        [cell.contentView addSubview:[self creatContentLabelWithName:@"2015-3-17  13:49" labelLactionX:0 labelLactionY:0]];
        [cell.contentView addSubview:[self creatContentLabelWithName:[NSString stringWithFormat:@"%.0f", _order.price]labelLactionX:0 labelLactionY:lineSeparationDistance]];
    }if (indexPath.section == 0 && indexPath.row == 4) {
    
        if ([self.order.status isEqualToString:@"doctor_closed"]) {
            NSString *cancelReason = [[NSString alloc]initWithFormat:@"取消原因： %@",self.order.rejectReason];
            [cell.contentView addSubview:[self creatCell5ContentLabelWithName:@"医师已取消订单，" labelLactionX:0 labelLactionY:0]];
            [cell.contentView addSubview:[self creatCell5ContentLabelWithName:cancelReason labelLactionX:0 labelLactionY:lineSeparationDistance]];
            [cell.contentView addSubview:[self creatCell5ContentLabelWithName:@"有任何疑问欢迎拨打客服电话，" labelLactionX:0 labelLactionY:lineSeparationDistance*2]];
            [cell.contentView addSubview:[self creatCell5ContentLabelWithName:@"400—820-8820" labelLactionX:0 labelLactionY:lineSeparationDistance*3]];
        }
        else{
            [cell.contentView addSubview:[self creatCell5ContentLabelWithName:@"订单已支付完毕，订单信息已发送至到手机，" labelLactionX:0 labelLactionY:0]];
            [cell.contentView addSubview:[self creatCell5ContentLabelWithName:@"请于预订时间在指定地点等待医师的咨询，" labelLactionX:0 labelLactionY:lineSeparationDistance]];
            [cell.contentView addSubview:[self creatCell5ContentLabelWithName:@"有任何疑问欢迎拨打客服电话，" labelLactionX:0 labelLactionY:lineSeparationDistance*2]];
            [cell.contentView addSubview:[self creatCell5ContentLabelWithName:@"400—820-8820" labelLactionX:0 labelLactionY:lineSeparationDistance*3]];
        }
    
    }
    return cell;
}

- (UILabel *)creatFixLabelWithName:(NSString *)name labelLactionX:(int)x labelLactionY:(int)y{
    UILabel *fixLale = [[UILabel alloc]initWithFrame:CGRectMake(labelFixBeginLocaltion+x, labelTopBegin+y, 200, 20)];
    fixLale.textColor = [UIColor grayWordColor];
    fixLale.font =[UIFont  systemFontOfSize:fixFontSize];
    fixLale.text = name;
    return fixLale;
}

- (UILabel *)creatContentLabelWithName:(NSString *)name labelLactionX:(int)x labelLactionY:(int)y{
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelContentBeginlocaltion+x, labelTopBegin+y, 300, 20)];
    contentLabel.textColor = [UIColor greenWordColor];
    contentLabel.font =[UIFont  systemFontOfSize:fixFontSize];
    contentLabel.text = name;
    return contentLabel;
}

- (UILabel *)creatRedContentLabelWithName:(NSString *)name labelLactionX:(int)x labelLactionY:(int)y{
    UILabel *fixLale = [[UILabel alloc]initWithFrame:CGRectMake(labelContentBeginlocaltion+x, labelTopBegin+y, 200, 20)];
    fixLale.textColor = [UIColor redColor];
    fixLale.font =[UIFont systemFontOfSize:fixFontSize];
    fixLale.text = name;
    return fixLale;
}

- (UILabel *)creatCell5ContentLabelWithName:(NSString *)name labelLactionX:(int)x labelLactionY:(int)y{
    UILabel *fixLale = [[UILabel alloc]initWithFrame:CGRectMake(labelFixCell5BeginLocaltion+x, labelTopBegin+y,(300/414.0)*UISCREENWIDTH, 20)];
    fixLale.textColor = [UIColor orangeColor];
    fixLale.font =[UIFont systemFontOfSize:fixFontSize-3];
    fixLale.text = name;
    fixLale.textAlignment = NSTextAlignmentCenter;
    return fixLale;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
}

-(void)againEvent{
    [self.navigationController popToViewController:self.docDetailView animated:YES];
}

-(void)completeEvent{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)share:(id)sender{
    //NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    id<ISSCAttachment> shareImage = [ShareSDK pngImageWithImage:[UIImage imageNamed:@"appCover"]];
    //构造分享内容
    /**
     *  @param content 副标题
     *  @param defaultContent 不知道干啥的,估计是副标题的备胎
     *  @param image 展示用的图片
     *  @param title 主标题
     *  @param url 点击进去之后跳转的网页页面
     *  @param description QQ空间分享时用到的描述
     */
    id<ISSContent> publishContent = [ShareSDK content:@"我发现了一个非常不错的应用，快来下载吧"
                                       defaultContent:@"我发现了一个非常不错的应用，快来下载吧"
                                                image:shareImage
                                                title:@"Pan大夫——您身边的健康专家"
                                                  url:@"http://itunes.apple.com/app/id963586976"
                                          description:@"我发现了一个非常不错的应用，快来下载吧"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}


@end
