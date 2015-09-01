//
//  InformationConfirmViewController.m
//  AppointmentTAble
//
//  Created by Robin on 15/3/12.
//  Copyright (c) 2015年 Robin. All rights reserved.
//
#define UISCREEREALHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define buttonTopLocation 10
#define buttonHight  ((UISCREEREALHEIGHT > 479) && (UISCREEREALHEIGHT < 481)? 38 : 45)
#define buttonWidthExcursion  ((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569)? 10 : 0)
#define buttonXExcursion  ((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569)? 20 : 0)
#define fixFontSize  (((UISCREENHEIGHT > 567) && (UISCREENHEIGHT < 569))?14 :(((UISCREENHEIGHT > 666) && (UISCREENHEIGHT < 668))? 15 : 16))
#define UISCREENHEIGHT  ((self.view.bounds.size.height < 481.0)? 568.0 : self.view.bounds.size.height)

#define greenButtonColor colorWithRed:0/255.0 green:175/255.0 blue:170/255.0 alpha:1.0
#define greenWordColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0
#define grayWordColor  colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0
#define customBackgroundColor colorWithRed:240/255.0 green:239/255.0 blue:244/255.0 alpha:1.0

#define lineSeparationDistance (25.0/414.0)*self.view.bounds.size.width
#define labelContentBeginlocaltion (110.0/414.0)*self.view.bounds.size.width
#define labelFixBeginLocaltion (20.0/414.0)*self.view.bounds.size.width
#define labelTopBegin (5.0/568.0)*self.view.bounds.size.height
#define imageSize (90.0/736.0)*UISCREENHEIGHT
#define oderButtonBeginLocation (270/414.0)*UISCREENWIDTH

#define specialButtonTop (280.0/736.0)*UISCREENHEIGHT

#define kBottomViewTopInterval 22/667.0
#define kBottomViewHeight 64/667.0

#import "InformationViewController.h"
#import "InformationConfirmViewController.h"
#import "PaymentViewController.h"
#import "BMapKit.h"
#import "AppDelegate.h"
@interface InformationConfirmViewController ()

@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UILabel *specialLabel;
@property(nonatomic, strong) Order *order;


@property (nonatomic, strong) UIPickerView *specialPickerView;
@property (nonatomic, strong) UITextView *conditionField;
@property (nonatomic, strong) NSArray *specialItems;
@property (nonatomic, strong) UITableView *mainTable;
@property (nonatomic, strong) UIView *chooseFieldView;
@property (nonatomic, strong) UIButton *chooseFieldButton;
@property (nonatomic, strong) UILabel *chooseFieldLabel;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITableView *chooseFieldTable;
@property (nonatomic, strong) NSString *startTimeString;

@property (nonatomic, strong) NSDictionary *translation;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *paymentLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *secPriceLabel;
@property (nonatomic, strong) UILabel *thirdPriceLabel;
@property (nonatomic, strong) UIButton *orderButton;
@property (strong, nonatomic) MKNetworkOperation *netOp;

@property (strong, nonatomic) DoctorDetailViewController *docDetailView;
@end

@implementation InformationConfirmViewController
@synthesize conditionField, specialItems, specialLabel,specialPickerView;
@synthesize chooseFieldButton,chooseFieldView,chooseFieldLabel,chooseFieldTable;
@synthesize mainTable,translation;
@synthesize startTimeString;
@synthesize bottomView;
@synthesize paymentLabel,priceLabel,secPriceLabel,thirdPriceLabel,orderButton;
@synthesize netOp;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    self.view.backgroundColor = [UIColor customBackgroundColor];
    
    startTimeString = [self expandTimeWithOrder:_order];
    specialItems = [[NSArray alloc]initWithObjects:@"婚恋情感",@"学业问题", @"亲子教育", @"人际关系", @"职场压力",@"恐艾症",@"其他专题", nil];
    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, UISCREEREALHEIGHT-kBottomViewHeight*UISCREEREALHEIGHT-kBottomViewTopInterval*UISCREEREALHEIGHT-66)];
    mainTable.tag = 0;
    mainTable.dataSource = self;
    mainTable.delegate = self;
    mainTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //添加顶部图片
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, imageSize)] ;
    if (UISCREENWIDTH>=319&&UISCREENWIDTH<=321&&UISCREEREALHEIGHT>=479&&UISCREEREALHEIGHT<=481){
        [header setImage:[UIImage imageNamed:@"appointment_header_4s"]];
    }
    [header setImage:[UIImage imageNamed:@"appointment_header"]];
    
    mainTable.tableHeaderView = header;
    
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mainTable.frame)+kBottomViewTopInterval*UISCREENHEIGHT, UISCREENWIDTH, kBottomViewHeight*UISCREENHEIGHT)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    paymentLabel = [[UILabel alloc]initWithFrame:CGRectMake((10/375.0)*UISCREENWIDTH, (8/667.0)*UISCREENHEIGHT, (255/375.0)*UISCREENWIDTH, (20/667.0)*UISCREENHEIGHT)];
    paymentLabel.textColor = [UIColor grayWordColor];
    paymentLabel.text = @"咨询费*时长+路程费*额外距离 =";
    
    priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(paymentLabel.frame), CGRectGetMaxY(paymentLabel.frame)+(8/667.0)*UISCREENHEIGHT, (200/375.0)*UISCREENWIDTH, (15/667.0)*UISCREENHEIGHT)];
    priceLabel.text = @"资费总计：";
    priceLabel.textColor = [UIColor grayWordColor];
    
    secPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame), CGRectGetMinY(priceLabel.frame)-4, (20/375.0)*UISCREENWIDTH, (20/667.0)*UISCREENHEIGHT)];
    secPriceLabel.text = @"元";
    secPriceLabel.textColor = [UIColor greenWordColor];
    
    thirdPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(secPriceLabel.frame)-(100/375.0)*UISCREENWIDTH, CGRectGetMinY(secPriceLabel.frame), (100/375.0)*UISCREENWIDTH, (20/667.0)*UISCREENHEIGHT)];
    thirdPriceLabel.textColor = [UIColor redColor];
    thirdPriceLabel.textAlignment = NSTextAlignmentRight;
    thirdPriceLabel.text =[NSString stringWithFormat:@"%.1f",self.order.price];
    
    [bottomView addSubview:paymentLabel];
    [bottomView addSubview:priceLabel];
    [bottomView addSubview:secPriceLabel];
    [bottomView addSubview:thirdPriceLabel];
    
    orderButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(paymentLabel.frame), (buttonTopLocation/667.0)*UISCREENHEIGHT, ((100.0-buttonWidthExcursion)/375.0)*UISCREENWIDTH , (buttonHight/667.0)*UISCREENHEIGHT)];
    NSLog(@"orderButton frame is %f",orderButton.frame.size.width);
    orderButton.layer.cornerRadius = 5;
    if (UISCREENHEIGHT < 569.0) {
        orderButton.titleLabel.font = [UIFont  systemFontOfSize: 14];
    }
    [orderButton setTitle:@"下订单" forState:UIControlStateNormal];
    [orderButton setBackgroundColor:[UIColor greenButtonColor]];
    [orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderButton addTarget:self action:@selector(appointMentEvents) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:orderButton];
    
    self.singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    [header addGestureRecognizer:self.singleTap];
    [self.view addSubview:mainTable];

    [self setLabelFont];
}

- (void)setLabelFont{
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
        paymentLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.font = [UIFont systemFontOfSize:14];
        secPriceLabel.font = [UIFont systemFontOfSize:fixFontSize+3];
        thirdPriceLabel.font = [UIFont systemFontOfSize:fixFontSize+3];
        [orderButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
        paymentLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.font = [UIFont systemFontOfSize:14];
        secPriceLabel.font = [UIFont systemFontOfSize:fixFontSize+3];
        thirdPriceLabel.font = [UIFont systemFontOfSize:fixFontSize+3];
        [orderButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
        paymentLabel.font = [UIFont systemFontOfSize:17];
        priceLabel.font = [UIFont systemFontOfSize:17];
        secPriceLabel.font = [UIFont systemFontOfSize:fixFontSize+3];
        thirdPriceLabel.font = [UIFont systemFontOfSize:fixFontSize+3];
        [orderButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415) {
        paymentLabel.font = [UIFont systemFontOfSize:18];
        priceLabel.font = [UIFont systemFontOfSize:18];
        secPriceLabel.font = [UIFont systemFontOfSize:fixFontSize+3];
        thirdPriceLabel.font = [UIFont systemFontOfSize:fixFontSize+3];
        [orderButton.titleLabel setFont:[UIFont systemFontOfSize:21]];
    }

}


- (id)initWithOrder:(Order *)order DocDetail:(DoctorDetailViewController *)docDeatilView Path:(NSString *)path{
    
    self = [super init];
    self.docDetailView = docDeatilView;
    self.order = order;
    self.path = path;
    translation = [[NSDictionary alloc]initWithObjectsAndKeys:@"婚恋情感",@"marriage",@"学业问题",@"education",@"亲子教育",@"parents",@"人际关系",@"interaction",@"职场压力",@"pressure",@"恐艾症",@"AIDS",@"其他专题",@"others", nil];
    //设置默认内容
    if (!self.order.special || [self.order.special isEqualToString:@""]) {
        self.order.special = [[NSString alloc]initWithFormat:@"请选择您的咨询主题"];
    }
    else{
        self.order.special = [translation objectForKey:self.order.special];
    }
    
    if (!self.order.orderDescription || [self.order.orderDescription isEqualToString:@""]) {
        self.order.orderDescription = [[NSString alloc]initWithFormat:@"请简要说明您的情况，如果症状变现，引发缘由，心理想法等。"];
    }
    return self;

}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 0){
        return 2;
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 0) {
        switch (section) {
            case 0:
                return 3;
                break;
            case 1:
                return 2;
                break;
            default:
                return 0;
                break;
        }
    }
    if (tableView.tag == 1) {
        return [specialItems count];
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        UIView* customView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.backgroundColor = [UIColor customBackgroundColor];
        headerLabel.opaque = NO;
        headerLabel.textColor = [UIColor grayWordColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:14];
        switch (section) {
            case 0:
                headerLabel.frame = CGRectMake(0.0, 0.0, UISCREENWIDTH, (30/736.0)*UISCREENHEIGHT);
                break;
            case 1:
                headerLabel.frame = CGRectMake(0.0, 0.0, UISCREENWIDTH, (54/736.0)*UISCREENHEIGHT);
                break;
            default:
                break;
        }
        NSArray *content = [NSArray arrayWithObjects:@"   咨询信息",@"    联系人信息",@"",nil];
        headerLabel.text = content[section];
        [customView addSubview:headerLabel];
        return customView;
    }
    else{
        return nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        if(indexPath.section == 0 && indexPath.row ==0){
            
            UITableViewCell *advisoryCell1 = [[UITableViewCell alloc]init];
            
            
            [advisoryCell1.contentView addSubview:[self creatFixLabelWithName:@"咨询医师 ：" labelLactionX:0 labelLactionY:0]];
            [advisoryCell1.contentView addSubview:[self creatFixLabelWithName:@"咨询时间 ：" labelLactionX:0 labelLactionY:lineSeparationDistance]];
            [advisoryCell1.contentView addSubview:[self creatFixLabelWithName:@"咨询费用 ：" labelLactionX:0 labelLactionY:lineSeparationDistance*2]];
            
            [advisoryCell1.contentView addSubview:[self creatContentLabelWithName:_order.doctorName labelLactionX:0 labelLactionY:0]];
            
            [advisoryCell1.contentView addSubview:[self creatContentLabelWithName:startTimeString labelLactionX:0 labelLactionY:lineSeparationDistance]];
            [advisoryCell1.contentView addSubview:[self creatRedContentLabelWithName: [NSString stringWithFormat:@"%.1f",_order.price] labelLactionX:0 labelLactionY:lineSeparationDistance*2]];
            [advisoryCell1.contentView addSubview:[self creatContentLabelWithName:@"   元" labelLactionX:(30.0/414)*UISCREENWIDTH labelLactionY:lineSeparationDistance*2]];
            
            [advisoryCell1 addGestureRecognizer:self.singleTap];
            return advisoryCell1;
            
        }
        if(indexPath.section == 0 && indexPath.row ==1){
            UITableViewCell *advisoryCell2 = [[UITableViewCell alloc]init];
            advisoryCell2.frame = CGRectMake(0, 0, UISCREENWIDTH, (40.0/736.0)*UISCREENHEIGHT);
            [advisoryCell2.contentView addSubview:[self creatFixLabelWithName:@"咨询专项 ：" labelLactionX:0 labelLactionY:0]];
            
            chooseFieldView = [[UIView alloc]initWithFrame:CGRectMake(labelContentBeginlocaltion, 0, UISCREENWIDTH - labelContentBeginlocaltion, (40.0/736.0)*UISCREENHEIGHT)];
            chooseFieldLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH - labelContentBeginlocaltion, (40.0/736.0)*UISCREENHEIGHT)];
            chooseFieldLabel.backgroundColor = [UIColor whiteColor];
            chooseFieldLabel.text = self.order.special;
            chooseFieldLabel.textColor = [UIColor greenWordColor];
            chooseFieldLabel.font = [UIFont systemFontOfSize: fixFontSize];
            [chooseFieldView addSubview:chooseFieldLabel];
            
            chooseFieldButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [chooseFieldButton setBackgroundColor:[UIColor clearColor]];
            [chooseFieldButton setFrame:CGRectMake(0, 0, UISCREENWIDTH - labelContentBeginlocaltion, (40.0/736.0)*UISCREENHEIGHT)];
            [chooseFieldButton setBackgroundImage:[UIImage imageNamed:@"home_order_informationConfirmView"] forState:UIControlStateNormal];
            [chooseFieldButton addTarget:self action:@selector(didClickChooseFieldButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [chooseFieldView addSubview:chooseFieldButton];
            [advisoryCell2 addSubview:chooseFieldView];

            return advisoryCell2;
            
        }
        if(indexPath.section == 0 && indexPath.row ==2){
            UITableViewCell *advisoryCell3 = [[UITableViewCell alloc]init];
            [advisoryCell3.contentView addSubview:[self creatFixLabelWithName:@"情况说明 ：" labelLactionX:0 labelLactionY:0]];
            
            conditionField = [[UITextView alloc]initWithFrame:CGRectMake(labelContentBeginlocaltion, 5.0, (290/414.0)*UISCREENWIDTH, (84.0/736.0)*UISCREENHEIGHT)];
            conditionField.layer.cornerRadius=6;
            conditionField.backgroundColor = [UIColor customBackgroundColor];
            conditionField.text= self.order.orderDescription;
            NSLog(@"self.order.orderDescription = %@",self.order.orderDescription);
            conditionField.delegate = self;
            conditionField.textColor = [UIColor grayWordColor];
            conditionField.font = [UIFont systemFontOfSize:fixFontSize];
            [advisoryCell3.contentView addSubview:conditionField];
            return advisoryCell3;
            
        }if (indexPath.section == 1 && indexPath.row == 0) {
            
            UITableViewCell *contactCell1 = [[UITableViewCell alloc]init];
            
            [contactCell1.contentView addSubview:[self creatFixLabelWithName:@"联系人 ：" labelLactionX:0 labelLactionY:labelTopBegin]];
            [contactCell1.contentView addSubview:[self creatFixLabelWithName:@"性别年龄 ：" labelLactionX:0 labelLactionY:labelTopBegin+lineSeparationDistance]];
            [contactCell1.contentView addSubview:[self creatFixLabelWithName:@"联系方式 ：" labelLactionX:0 labelLactionY:labelTopBegin+lineSeparationDistance*2]];
            [contactCell1.contentView addSubview:[self creatFixLabelWithName:@"咨询地点 ：" labelLactionX:0 labelLactionY:labelTopBegin+lineSeparationDistance*3]];
            
            
            [contactCell1.contentView addSubview:[self creatContentLabelWithName:_order.patientName labelLactionX:0 labelLactionY:5]];
            
            if(self.order.patientAge != 0){
                NSString *sexAndAge = [NSString stringWithFormat:@"%@,  %d",self.order.patientSex,self.order.patientAge];
                [contactCell1.contentView addSubview:[self creatContentLabelWithName:sexAndAge labelLactionX:0 labelLactionY:5+lineSeparationDistance]];
            }
            [contactCell1.contentView addSubview:[self creatContentLabelWithName:_order.patientTel labelLactionX:0 labelLactionY:5+lineSeparationDistance*2]];
            [contactCell1.contentView addSubview:[self creatContentLabelWithName:_order.address labelLactionX:0 labelLactionY:5+lineSeparationDistance*3]];
            
            contactCell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return contactCell1;
            
        }if (indexPath.section == 1 && indexPath.row ==1) {
            UITableViewCell *contactCell2 = [[UITableViewCell alloc]init];
            [contactCell2.contentView addSubview:[self creatFixLabelWithName:@"路程距离 ：" labelLactionX:0 labelLactionY:3]];
           
            BMKMapPoint doctorPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(self.doctorLat,self.doctorLng));
            BMKMapPoint userPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(self.userLat,self.userLng));
            if ((self.userLat == 0)&&(self.userLng == 0)) {
                self.order.distance = 0;
            }
            else{
                self.order.distance = BMKMetersBetweenMapPoints(doctorPosition,userPosition);
            }
            
            NSString *string = [NSString stringWithFormat:@"%1.f 公里 (5公里外，每公里加收20元)",self.order.distance/1000];
            NSMutableAttributedString *as = [[NSMutableAttributedString alloc]initWithString:string];
            [as addAttribute:NSForegroundColorAttributeName value:[UIColor greenWordColor] range:[string rangeOfString:@"公里"]];
            [as addAttribute:NSForegroundColorAttributeName value:[UIColor grayWordColor] range:[string rangeOfString:@"(5公里外，每公里加收20元)"]];
            [as addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fixFontSize-2] range:[string rangeOfString:@"(5公里外，每公里加收20元)"]];
            UILabel *contactCell2Label = [[UILabel alloc]initWithFrame:CGRectMake(labelContentBeginlocaltion, (4/667.0)*UISCREENHEIGHT, UISCREENHEIGHT-labelContentBeginlocaltion, (36.0/736.0)*UISCREENHEIGHT)];
            contactCell2Label.textColor = [UIColor redColor];
            contactCell2Label.font = [UIFont systemFontOfSize:fixFontSize];
            contactCell2Label.attributedText = as;
            [contactCell2.contentView addSubview:contactCell2Label];
            
            return contactCell2;
        }
    }
    //设置下拉cell
    if (tableView.tag == 1) {
        NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = [specialItems objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize: fixFontSize];
        cell.textLabel.textColor = [UIColor greenWordColor];
        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        chooseFieldTable.hidden = YES;
        self.order.special = [specialItems objectAtIndex:indexPath.row];
        [mainTable reloadData];
    }
    if (tableView.tag == 0) {
        if (indexPath.section == 1 && indexPath.row == 0) {
            InformationViewController *addressTable = [[InformationViewController alloc]initWithPath:@"out"];
            [self.navigationController pushViewController:addressTable animated:YES];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePatientInformation:) name:@"chooseDefaultAddress" object:nil];
            
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            return (90.0/736.0)*UISCREENHEIGHT;
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            return (40.0/736.0)*UISCREENHEIGHT;
        }
        if (indexPath.section == 0 && indexPath.row == 2) {
            return (94.0/736.0)*UISCREENHEIGHT;
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            return (128.0/736.0)*UISCREENHEIGHT;
        }
        if (indexPath.section == 1 && indexPath.row == 1) {
            return (44.0/736.0)*UISCREENHEIGHT;
        }
        
    }
    else{
        return 30;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        switch (section) {
            case 0:
                return (30/736.0)*UISCREENHEIGHT;
                break;
            case 1:
                return (54/736.0)*UISCREENHEIGHT;
                break;
//            case 2:
//                return (35/736.0)*UISCREENHEIGHT;
//                break;
                
            default:
                return 0;
                break;
        }
    }
    else{
        return 0;
    }
}

- (UILabel *)creatFixLabelWithName:(NSString *)name labelLactionX:(int)x labelLactionY:(int)y{
    UILabel *fixLale = [[UILabel alloc]initWithFrame:CGRectMake(labelFixBeginLocaltion+x, labelTopBegin+y, 300, 20)];
    fixLale.textColor = [UIColor grayWordColor];
    fixLale.font =[UIFont systemFontOfSize: fixFontSize];
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
    UILabel *fixLale = [[UILabel alloc]initWithFrame:CGRectMake(labelContentBeginlocaltion+x, labelTopBegin+y, 300, 20)];
    fixLale.textColor = [UIColor redColor];
    fixLale.font =[UIFont systemFontOfSize: fixFontSize];
    fixLale.text = name;
    return fixLale;
}

- (void)specialButtonEvents{
    specialLabel.text = @"";
}

- (BOOL)canMakeReservation{
    BOOL returnValue = YES;
    if (!self.order.patientName || [self.order.patientName isEqualToString:@""]) {
        returnValue = NO;
    }
    if (!self.order.patientSex || [self.order.patientSex isEqualToString:@""]) {
        returnValue = NO;
    }
    if (!self.order.patientTel || [self.order.patientTel isEqualToString:@""]) {
        returnValue = NO;
    }
    if (!self.order.address || [self.order.address isEqualToString:@""]) {
        returnValue = NO;
    }
    return returnValue;
}

//点击预约按钮触发事件
- (void)appointMentEvents{
    if ([self canMakeReservation]) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setObject:self.order.doctorId forKey:@"doctorId"];
        [data setObject:self.order.doctorName forKey:@"doctorName"];
        [data setObject:self.order.patientTel forKey:@"patientTel"];
        NSString *stringDuration = [NSString stringWithFormat:@"%d",self.order.duration];
        NSString *stringStarttime = [NSString stringWithFormat:@"%d",self.order.startTime];
        NSString *stringStartPositioin = [NSString stringWithFormat:@"%d",self.outputStartPosition];
        NSString *stringDistance = [NSString stringWithFormat:@"%.0f",ceil(self.order.distance/1000)];
        NSString *stringPatientAge = [NSString stringWithFormat:@"%f",self.order.distance];
        [data setObject:stringDuration forKey:@"duration"];
        [data setObject:stringStarttime forKey:@"startTime"];
        [data setObject:self.order.special forKey:@"special"];
        [data setObject:self.order.description forKey:@"description"];
        [data setObject:self.order.patientName forKey:@"patientName"];
        [data setObject:self.order.address forKey:@"address"];
        [data setObject:stringStartPositioin forKey:@"startPosition"];
        [data setObject:stringDistance forKey:@"distance"];
        [data setObject:stringPatientAge forKey:@"patientAge"];
        [data setObject:self.order.patientSex forKey:@"patientSex"];
        netOp = [appDelegate.netEngine operationWithPath:@"/commitOrder.php" params:data httpMethod:@"POST"];
        
        __block InformationConfirmViewController *localSelf = self;
        [netOp addCompletionHandler:^(MKNetworkOperation *operation){
            id json = [operation responseJSON];
            NSDictionary *dic = (NSDictionary *)json;
            NSLog(@"success = %@",[dic objectForKey:@"success"]);
            NSString *code = [dic objectForKey:@"success"];
            if ([code isEqualToString:@"100"]) {
                [localSelf jumpToPaymentViewWithDiectionary:dic];
            }
            else{
                NSLog(@"code is %@",code);
                NSLog(@"dic is %@",dic);
            }
            
        } errorHandler:^(MKNetworkOperation *operation,NSError *error){
            NSLog(@"网络加载失败！");
        }
         ];
        [appDelegate.netEngine enqueueOperation:netOp];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"您还没有完善联系人信息" delegate:nil cancelButtonTitle:@"去完善" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)jumpToPaymentViewWithDiectionary:(NSDictionary *)dic{
    self.order.orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderId"]];
    self.order.price = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]]floatValue];
    NSLog(@"orderId = %f",self.order.price);
    PaymentViewController *payView = [[PaymentViewController alloc]initWithOrder:self.order DocDetailView:self.docDetailView Path:self.path OrderListView:nil];
    payView.title =  @"预约";
    [self.navigationController pushViewController:payView animated:YES];

}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    conditionField.textColor = [UIColor greenWordColor];
    if ([conditionField.text isEqualToString:@"请简要说明您的情况，如果症状变现，引发缘由，心理想法等。"]) {
        conditionField.text= @"";
    }
    
    CGRect frame = textView.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    _order.orderDescription = conditionField.text;
}

//return退出键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


//双击退出键盘
- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    _order.orderDescription = conditionField.text;
    [conditionField resignFirstResponder];
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
-(void)comeBack{
    NSLog(@"back");
}

- (void)didClickChooseFieldButton:(id)sender{
    NSIndexPath *chooseSpeicialIndex = [NSIndexPath indexPathForRow:1 inSection:0];
    
    UITableViewCell *cell = [self tableView:mainTable cellForRowAtIndexPath:chooseSpeicialIndex];
    [cell setFrame:CGRectMake(labelContentBeginlocaltion-10, 0, UISCREENWIDTH - labelContentBeginlocaltion, (160.0/736.0)*UISCREENHEIGHT)];
    if (!chooseFieldTable) {
        
        CGRect rectInTableView = [mainTable rectForRowAtIndexPath:chooseSpeicialIndex];
        CGRect rectInSuperview = [mainTable convertRect:rectInTableView toView:self.view];
        chooseFieldTable = [[UITableView alloc]initWithFrame:CGRectMake(labelContentBeginlocaltion-10, rectInSuperview.size.height + rectInSuperview.origin.y, UISCREENWIDTH - labelContentBeginlocaltion, (180.0/736.0)*UISCREENHEIGHT) style:UITableViewStylePlain];
        
        chooseFieldTable.tag = 1;
        chooseFieldTable.delegate = self;
        chooseFieldTable.dataSource = self;
        [self.view addSubview:chooseFieldTable];
    }
    else{
        CGRect rectInTableView = [mainTable rectForRowAtIndexPath:chooseSpeicialIndex];
        CGRect rectInSuperview = [mainTable convertRect:rectInTableView toView:self.view];
        chooseFieldTable.frame = CGRectMake(labelContentBeginlocaltion-10, rectInSuperview.size.height + rectInSuperview.origin.y, UISCREENWIDTH - labelContentBeginlocaltion, (180.0/736.0)*UISCREENHEIGHT);
        if (chooseFieldTable.hidden) {
            chooseFieldTable.hidden = NO;
        }
        else{
            chooseFieldTable.hidden = YES;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    UITableView *table = (UITableView *)scrollView;
    if (table.tag == 0) {
        if (!chooseFieldTable.hidden) {
            chooseFieldTable.hidden = YES;
        }
    }
}

- (void)updatePatientInformation:(NSNotification*) notification{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSDictionary *defaultPatinet = [self getCurrentPosition];
    if (defaultPatinet) {
        self.order.patientName = [defaultPatinet objectForKey:@"patientName"];
        if ([[defaultPatinet objectForKey:@"patientSex"] isEqualToString:@"female.jpg"]) {
            self.order.patientSex = @"女";
        }
        else{
            self.order.patientSex = @"男";
        }
        
        self.order.patientAge = [[defaultPatinet objectForKey:@"patientAge"]intValue];
        self.order.patientTel = [defaultPatinet objectForKey:@"patientTel"];
        self.order.address = [defaultPatinet objectForKey:@"patientAddress"];
        self.userLng = [[defaultPatinet objectForKey:@"lng"]doubleValue];
        self.userLat = [[defaultPatinet objectForKey:@"lat"]doubleValue];
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        BMKMapPoint doctorPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(self.doctorLat,self.doctorLng));
        BMKMapPoint userPosition = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(self.userLat,self.userLng));
        if ((self.userLat == 0)&&(self.userLng == 0)) {
            self.order.distance = 0;
        }
        else{
            self.order.distance = BMKMetersBetweenMapPoints(doctorPosition,userPosition);
        }
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        int intDistance = ceil(self.order.distance)/1000;
        NSString *durationString = [NSString stringWithFormat:@"%d",self.order.duration];
        NSString *distanceString = [NSString stringWithFormat:@"%d",intDistance];
        [data setValue:durationString forKey:@"duration"];
        [data setValue:distanceString forKey:@"distance"];
        [data setValue:self.order.doctorId forKey:@"doctorId"];
        
        netOp = [appDelegate.netEngine operationWithPath:@"/price.php" params:data httpMethod:@"POST"];
        
        __block Order *localOrder = self.order;
        __block UITableView *localTable = mainTable;
        __block UILabel *localPriceLabel = thirdPriceLabel;
        [netOp addCompletionHandler:^(MKNetworkOperation *operation){
            id json = [operation responseJSON];
            NSDictionary *dic = (NSDictionary *)json;
            NSString *code = [dic objectForKey:@"code"];
            float orderPrice = 0;
            if ([code isEqualToString:@"100"]) {
                orderPrice = [[dic objectForKey:@"price"]floatValue];
                localOrder.price = orderPrice;
                localPriceLabel.text = [NSString stringWithFormat:@"%.1f",orderPrice];
                [localTable reloadData];
            }
            
        } errorHandler:^(MKNetworkOperation *operation,NSError *error){
            NSLog(@"网络加载失败！");
        }
         ];
        
        [appDelegate.netEngine enqueueOperation:netOp];
        
    }
}

//从数据库获得病人数据
- (NSDictionary *)getCurrentPosition{
    // NSMutableDictionary *answer = [[NSMutableDictionary alloc]init];
    
    //获取plist字典
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableArray *patients = [plistDictionary objectForKey:@"patients"];
    if (!patients){
        return nil;
    }
    else{
        for (NSDictionary *patient in patients) {
            if ([[patient objectForKey:@"isDefault"]isEqualToString:@"yes"]) {
                return patient;
            }
        }
    }
    return nil;
}

- (NSString *)getFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    return documentPlistPath;
}
@end
