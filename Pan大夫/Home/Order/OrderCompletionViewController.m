//
//  OderCompletionViewController.m
//  AppointmentTAble
//
//  Created by Robin on 15/3/17.
//  Copyright (c) 2015年 Robin. All rights reserved.
//

#import "OrderCompletionViewController.h"
#import "CommentCommitViewController.h"
@interface OrderCompletionViewController ()

#define UISCREENWIDTH  self.view.bounds.size.width
//#define fixFontSize systemFontOfSize:16
#define UISCREEREALHEIGHT  self.view.bounds.size.height
#define UISCREENHEIGHT  ((self.view.bounds.size.height < 481.0)? 568.0 : self.view.bounds.size.height)
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height

#define greenButtonColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0
#define greenWordColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0
#define grayWordColor  colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0
#define customBackgroundColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0
#define orangeWordColor colorWithRed:247/255.0 green:114/255.0 blue:68/255.0 alpha:1.0

#define lineSeparationDistance (25.0/414.0)*self.view.bounds.size.width
#define labelContentBeginlocaltion  (110.0/414.0)*self.view.bounds.size.width
#define labelFixBeginLocaltion (20.0/414.0)*self.view.bounds.size.width
#define labelTopBegin (10/568.0)*self.view.bounds.size.height

#define doctorImagR  (50.0/414.0)*self.view.bounds.size.width
#define doctorLabelBegin (140.0/414.0)*self.view.bounds.size.width

#define imageSize (84.0/736.0)*UISCREENHEIGHT
#define orderViewSize (30.0/736)*UISCREENHEIGHT

#define oderLabelHeightBegin (18.0/736.0)*UISCREENHEIGHT
#define oderLabelWidth (24.0/736.0)*UISCREENHEIGHT

#define compeletButtonBeginLoction (270/414.0)*UISCREENWIDTH
#define againButtonBeginLocation (10/414.0)*UISCREENWIDTH

#define   buttonTopLocation  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?5 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 5 : 10))
#define   buttonHight  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?37 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 40 : 40))

#define   fixFontSize  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?14 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 15 : 16))

#define kBottomViewTopInterval 20/667.0
#define kBottomViewHeight 54/667.0

@property (nonatomic, retain) Order *order;
@property (nonatomic, strong) UIImageView *docImage;
@property (nonatomic, strong) StarRateView *starRate;
@property (nonatomic, strong) CommentCommitViewController *evaluateView;
@property (nonatomic, strong) UILabel *secCommentLabel;//评分内容等级
@property (nonatomic, strong) UIButton *evaluateButton;
@property (nonatomic, strong) Comment *userComment;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITableView *mainTable;
@property (nonatomic, strong) NSString *commentNotice;
@end

@implementation OrderCompletionViewController
@synthesize docImage,starRate;
@synthesize evaluateView;
@synthesize secCommentLabel,evaluateButton;
@synthesize userComment;
@synthesize bottomView;
@synthesize mainTable;
@synthesize commentNotice;
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置右侧分享按钮
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.view.backgroundColor = [UIColor customBackgroundColor];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, imageSize+orderViewSize)];
    
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, imageSize)] ;
    if (UISCREENWIDTH>=319&&UISCREENWIDTH<=321&&UISCREEREALHEIGHT>=479&&UISCREEREALHEIGHT<=481){
        [header setImage:[UIImage imageNamed:@"orderCompletion_header_4s"]];
    }
    [header setImage:[UIImage imageNamed:@"orderCompletion_header"]];
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
    orderFixLabel.font =[UIFont systemFontOfSize: fixFontSize];
    orderFixLabel.textColor = [UIColor grayWordColor];
    [headerView addSubview:orderFixLabel];
    
    UILabel *orderContentLabel = [[UILabel alloc]initWithFrame:CGRectMake((190.0/414)*UISCREENWIDTH, imageSize, UISCREENWIDTH, orderViewSize)];
    orderContentLabel.text = self.order.orderId;
    orderContentLabel.font =[UIFont systemFontOfSize: fixFontSize];
    orderContentLabel.textColor = [UIColor greenWordColor];
    [headerView addSubview:orderContentLabel];
    
    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREEREALHEIGHT-kBottomViewHeight*KDeviceHeight-kBottomViewTopInterval*KDeviceHeight)];
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    mainTable.tableHeaderView = headerView;
    [self.view addSubview:mainTable];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"取消";
    self.navigationItem.backBarButtonItem = backItem;

    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mainTable.frame)+kBottomViewTopInterval*KDeviceHeight, KDeviceWidth, kBottomViewHeight*KDeviceHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *completButton = [[UIButton alloc]initWithFrame:CGRectMake(labelFixBeginLocaltion, (buttonTopLocation/667.0)*UISCREENHEIGHT, (374.0/414.0)*UISCREENWIDTH, (buttonHight/667.0)*UISCREENHEIGHT)];
    completButton.layer.cornerRadius = 5;
    if (UISCREENHEIGHT < 569.0) {
        completButton.titleLabel.font = [UIFont  systemFontOfSize: 14];
    }
    [completButton setTitle:@"分   享" forState:UIControlStateNormal];
    [completButton setBackgroundColor:[UIColor greenButtonColor]];
    [completButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:completButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithOrder:(Order *)order{
    self = [super init];
    self.order = order;
    starRate = [[StarRateView alloc]initWithFrame:CGRectMake(doctorLabelBegin +  (60.0/414.0)*UISCREENWIDTH, labelTopBegin+lineSeparationDistance, (100.0/414.0)*UISCREENWIDTH, (20.0/667.0)*UISCREENHEIGHT) numberOfStars:5];
    secCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake((274.0/375.0)*KDeviceWidth, (35/667.0)*KDeviceHeight, 200, 20)];
    secCommentLabel.text = @"尚未打分";
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
        
        NSString *stringTime = [self expandTimeWithOrder:self.order];
        [cell.contentView addSubview:[self creatContentLabelWithName:stringTime labelLactionX:0 labelLactionY:lineSeparationDistance]];
        
    }if (indexPath.section == 0 && indexPath.row ==1) {
        [cell.contentView addSubview:[self creatFixLabelWithName:@"咨询专项 ：" labelLactionX:0 labelLactionY:0]];
        [cell.contentView addSubview:[self creatFixLabelWithName:@"情况说明 ：" labelLactionX:0 labelLactionY:lineSeparationDistance]];
        [cell.contentView addSubview:[self creatContentLabelWithName:_order.special labelLactionX:0 labelLactionY:0]];
        //内容情况说明
        [cell.contentView addSubview:[self creatContentLabelWithName:_order.special labelLactionX:0 labelLactionY:lineSeparationDistance]];
        
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
        [cell.contentView addSubview:[self creatContentLabelWithName:_order.orderDate labelLactionX:0 labelLactionY:0]];
        [cell.contentView addSubview:[self creatContentLabelWithName:[NSString stringWithFormat:@"%.0f", _order.price]labelLactionX:0 labelLactionY:lineSeparationDistance]];
    }if (indexPath.section == 0 && indexPath.row == 4) {
        UIView *view = [self docotorEvaluateCellWith:_order DocotorImgName:@"panda"];
        [cell.contentView addSubview:view];
        
        
    }
    return cell;
}

- (UILabel *)creatFixLabelWithName:(NSString *)name labelLactionX:(int)x labelLactionY:(int)y{
    UILabel *fixLale = [[UILabel alloc]initWithFrame:CGRectMake(labelFixBeginLocaltion+x, labelTopBegin+y, 200, 20)];
    fixLale.textColor = [UIColor grayWordColor];
    fixLale.font =[UIFont systemFontOfSize:fixFontSize];
    fixLale.text = name;
    return fixLale;
}

- (UILabel *)creatContentLabelWithName:(NSString *)name labelLactionX:(int)x labelLactionY:(int)y{
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelContentBeginlocaltion+x, labelTopBegin+y, 300, 20)];
    contentLabel.textColor = [UIColor greenWordColor];
    contentLabel.font =[UIFont systemFontOfSize: fixFontSize];
    contentLabel.text = name;
    return contentLabel;
}

- (UILabel *)creatRedContentLabelWithName:(NSString *)name labelLactionX:(int)x labelLactionY:(int)y{
    UILabel *fixLale = [[UILabel alloc]initWithFrame:CGRectMake(labelContentBeginlocaltion+x, labelTopBegin+y, 200, 20)];
    fixLale.textColor = [UIColor redColor];
    fixLale.font =[UIFont systemFontOfSize: fixFontSize];
    fixLale.text = name;
    return fixLale;
}
- (UILabel *)creatDocoterContentLabelWithName:(NSString *)name labelLactionX:(int)x labelLactionY:(int)y{
    UILabel *fixLale = [[UILabel alloc]initWithFrame:CGRectMake(doctorLabelBegin+x, labelTopBegin+y, 300, 20)];
    fixLale.textColor = [UIColor orangeWordColor];
    fixLale.font =[UIFont systemFontOfSize: fixFontSize];
    fixLale.text = name;
    return fixLale;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (UIView *)docotorEvaluateCellWith:(Order *)order DocotorImgName:(NSString *)name{
    UIView *doctorCell = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, (140/736.0)*UISCREENHEIGHT)];
    
    docImage = [[UIImageView alloc]initWithFrame:CGRectMake(labelFixBeginLocaltion, labelTopBegin,  doctorImagR*2, doctorImagR*2)];
    docImage.layer.masksToBounds = YES;
    docImage.layer.cornerRadius = ( doctorImagR );
    docImage.image = [UIImage imageNamed:name];
    [doctorCell addSubview:docImage];
   
    [doctorCell addSubview:[self creatFixLabelWithName:@"评分：" labelLactionX:doctorLabelBegin labelLactionY:lineSeparationDistance]];
    
    secCommentLabel.textColor = [UIColor grayWordColor];
    secCommentLabel.font =[UIFont systemFontOfSize:fixFontSize];
    [doctorCell addSubview:secCommentLabel];
    
    
    //starRate.scorePercent = 0;
    [doctorCell addSubview:starRate];
    
    evaluateButton = [[UIButton alloc]initWithFrame:CGRectMake(doctorLabelBegin, lineSeparationDistance*3, (260.0/414.0)*UISCREENWIDTH, (35.0/667.0)*UISCREENHEIGHT)];
    evaluateButton.layer.cornerRadius = 5;
    evaluateButton.layer.borderWidth = 1.0;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.0/255, 175.0/255.0, 170.0/255, 1 });
    [evaluateButton.layer setBorderColor:colorref];
    if (UISCREENHEIGHT < 569.0) {
        evaluateButton.titleLabel.font = [UIFont  systemFontOfSize: 14];
    }
    if ([self.order.status isEqualToString:@"order_finished"]) {
        [doctorCell addSubview:[self creatDocoterContentLabelWithName:commentNotice labelLactionX:0 labelLactionY:0]];
        [evaluateButton setTitle:@"查看评价" forState:UIControlStateNormal];
    }
    else{
        [doctorCell addSubview:[self creatDocoterContentLabelWithName:commentNotice labelLactionX:0 labelLactionY:0]];
        [evaluateButton setTitle:@"评价" forState:UIControlStateNormal];
    }
    
    [evaluateButton setBackgroundColor:[UIColor whiteColor]];
    [evaluateButton setTitleColor:[UIColor greenWordColor] forState:UIControlStateNormal];
    [evaluateButton addTarget:self action:@selector(evaluateEvent) forControlEvents:UIControlEventTouchUpInside];
    [doctorCell addSubview:evaluateButton];
    

    return doctorCell;
}

- (void)evaluateEvent{
    evaluateView = [[CommentCommitViewController alloc]initWithOrder:self.order PushDelegate:self UserComment:userComment];
    evaluateView.title = @"评价";
    [self.navigationController pushViewController:evaluateView animated:YES];
}

- (void)setNewStarRate:(NSString *)userMark UserComment:(Comment *)comment{
    CGFloat percentMark = [comment.mark floatValue]/5;
    
    starRate.scorePercent = percentMark;
    NSArray *starComments = [[NSArray alloc]initWithObjects:@"非常不满意",@"不满意",@"一般",@"基本满意",@"满意", nil];
    secCommentLabel.text = [starComments objectAtIndex:(starRate.scorePercent*5-1)];
    userComment = comment;
    [evaluateButton setTitle:@"查看评价" forState:UIControlStateNormal];
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

- (void)viewWillAppear:(BOOL)animated{
    if (starRate.scorePercent > 0||[self.order.status isEqualToString:@"order_finished"]) {
        commentNotice = @"您已完成评价：";
    }
    else{
        commentNotice = @"您已完成咨询，请对医师进行评价：";
    }
    [mainTable reloadData];
}
@end
