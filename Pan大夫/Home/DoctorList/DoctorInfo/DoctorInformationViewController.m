//
//  DoctorInformationViewController.m
//  Pan大夫
//
//  Created by tiny on 15/3/7.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "DoctorInformationViewController.h"
#define kLabelLeftInterval 0.028125
#define kLabelTopInterval 0.015845
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define kInterval 4
#define kLabelWidth 0.1125
#define kLabelHeight 0.021126
#define kConTimesLabel 0.1875
#define kUnFixLabelWidth 0.828125
#define kUnFixLabelHeight 0.0246478
#define kMoreViewHeight 0.193662
@interface DoctorInformationViewController ()
@property (strong, nonatomic) Doctor *singleDoctor;
@property (strong, nonatomic) UILabel *docRankLabel;
@property (strong, nonatomic) UILabel *docSpecialLabel;
@property (strong, nonatomic) UILabel *careerYearsLabel;
@property (strong, nonatomic) UILabel *docPriceLabel;
@property (strong, nonatomic) UILabel *docPlaceLabel;
@property (strong, nonatomic) UILabel *docTelLabel;
@property (strong, nonatomic) UILabel *docConTimesLabel;
@property (strong, nonatomic) UILabel *docMoreLabel;

@property (strong, nonatomic) UILabel *secRankLabel;
@property (strong, nonatomic) UILabel *secSpecialLabel;
@property (strong, nonatomic) UILabel *secCareerYearsLabel;
@property (strong, nonatomic) UILabel *secPriceLabel;
@property (strong, nonatomic) UILabel *secPlaceLabel;
@property (strong, nonatomic) UILabel *secTelLabel;
@property (strong, nonatomic) UILabel *secConTimesLabel;
@property (strong, nonatomic) UITextView *secMoreView;
@end

@implementation DoctorInformationViewController
@synthesize singleDoctor;
@synthesize docRankLabel,docSpecialLabel,docConTimesLabel,careerYearsLabel,docMoreLabel,docPlaceLabel,docTelLabel,docPriceLabel;
@synthesize secCareerYearsLabel,secConTimesLabel,secMoreView,secPlaceLabel,secRankLabel,secSpecialLabel,secTelLabel,secPriceLabel;
- (id)initWithDocInfo:(Doctor *)doctor AndView:(UIView *)view{
    self = [super init];
    if (self) {
        self.view = view;
        singleDoctor = doctor;
        [self initWithFixedLabel];
        [self initWithUnfixedLabel];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//初始化医师信息页面的固定的label
- (void)initWithFixedLabel{
    docRankLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftInterval*KDeviceWidth, kLabelTopInterval*KDeviceHeight, kLabelWidth*KDeviceWidth, kLabelHeight*KDeviceHeight)];
    docRankLabel.textColor = [UIColor grayColor];
    docRankLabel.text = @"等级：";
    
    docSpecialLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftInterval*KDeviceWidth, CGRectGetMaxY(docRankLabel.frame)+kLabelTopInterval*KDeviceHeight, kLabelWidth*KDeviceWidth, kLabelHeight*KDeviceHeight)];
    docSpecialLabel.textColor = [UIColor grayColor];
    docSpecialLabel.text = @"领域：";
    
    careerYearsLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftInterval*KDeviceWidth, CGRectGetMaxY(docSpecialLabel.frame)+kLabelTopInterval*KDeviceHeight, kLabelWidth*KDeviceWidth, kLabelHeight*KDeviceHeight)];
    careerYearsLabel.textColor = [UIColor grayColor];
    careerYearsLabel.text = @"职龄：";
    
    docPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftInterval*KDeviceWidth, CGRectGetMaxY(careerYearsLabel.frame)+kLabelTopInterval*KDeviceHeight, kLabelWidth*KDeviceWidth, kLabelHeight*KDeviceHeight)];
    docPriceLabel.textColor = [UIColor grayColor];
    docPriceLabel.text = @"资费：";
    
    docPlaceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftInterval*KDeviceWidth, CGRectGetMaxY(docPriceLabel.frame)+kLabelTopInterval*KDeviceHeight, kLabelWidth*KDeviceWidth, kLabelHeight*KDeviceHeight)];
    docPlaceLabel.textColor = [UIColor grayColor];
    docPlaceLabel.text = @"地点：";
    
    docConTimesLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftInterval*KDeviceWidth, CGRectGetMaxY(docPlaceLabel.frame)+kLabelTopInterval*KDeviceHeight, kConTimesLabel*KDeviceWidth, kLabelHeight*KDeviceHeight)];
    docConTimesLabel.textColor = [UIColor grayColor];
    docConTimesLabel.text = @"咨询次数：";
    
    docMoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLabelLeftInterval*KDeviceWidth, CGRectGetMaxY(docConTimesLabel.frame)+kLabelTopInterval*KDeviceHeight, kLabelWidth*KDeviceWidth, kLabelHeight*KDeviceHeight)];
    docMoreLabel.textColor = [UIColor grayColor];
    docMoreLabel.text = @"备注：";
    
    [self setFixLabelFont];
    
    [self.view addSubview:docRankLabel];
    [self.view addSubview:docSpecialLabel];
    [self.view addSubview:careerYearsLabel];
    [self.view addSubview:docPriceLabel];
    [self.view addSubview:docPlaceLabel];
    [self.view addSubview:docConTimesLabel];
    [self.view addSubview:docMoreLabel];
}

- (void)setFixLabelFont{
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
        docRankLabel.font = [UIFont systemFontOfSize:12];
        docSpecialLabel.font = [UIFont systemFontOfSize:12];
        careerYearsLabel.font = [UIFont systemFontOfSize:12];
        docPriceLabel.font = [UIFont systemFontOfSize:12];
        docPlaceLabel.font = [UIFont systemFontOfSize:12];
        docConTimesLabel.font = [UIFont systemFontOfSize:12];
        docMoreLabel.font = [UIFont systemFontOfSize:12];
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
        docRankLabel.font = [UIFont systemFontOfSize:11];
        docSpecialLabel.font = [UIFont systemFontOfSize:11];
        careerYearsLabel.font = [UIFont systemFontOfSize:11];
        docPriceLabel.font = [UIFont systemFontOfSize:11];
        docPlaceLabel.font = [UIFont systemFontOfSize:11];
        docConTimesLabel.font = [UIFont systemFontOfSize:11];
        docMoreLabel.font = [UIFont systemFontOfSize:11];

    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
        docRankLabel.font = [UIFont systemFontOfSize:14];
        docSpecialLabel.font = [UIFont systemFontOfSize:14];
        careerYearsLabel.font = [UIFont systemFontOfSize:14];
        docPriceLabel.font = [UIFont systemFontOfSize:14];
        docPlaceLabel.font = [UIFont systemFontOfSize:14];
        docConTimesLabel.font = [UIFont systemFontOfSize:14];
        docMoreLabel.font = [UIFont systemFontOfSize:14];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415){
        docRankLabel.font = [UIFont systemFontOfSize:15];
        docSpecialLabel.font = [UIFont systemFontOfSize:15];
        careerYearsLabel.font = [UIFont systemFontOfSize:15];
        docPriceLabel.font = [UIFont systemFontOfSize:15];
        docPlaceLabel.font = [UIFont systemFontOfSize:15];
        docConTimesLabel.font = [UIFont systemFontOfSize:15];
        docMoreLabel.font = [UIFont systemFontOfSize:15];
    }
}
//初始化可以获取医师信息的label
- (void)initWithUnfixedLabel{
    secRankLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(docRankLabel.frame), CGRectGetMinY(docRankLabel.frame)-1,KDeviceWidth*kUnFixLabelWidth, kUnFixLabelHeight*KDeviceHeight)];
    secRankLabel.textColor = [UIColor colorWithRed:3/255.0 green:133.0/255.0 blue:125.0/255.0 alpha:1.0];
    
    secSpecialLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(docSpecialLabel.frame), CGRectGetMinY(docSpecialLabel.frame)-1,KDeviceWidth*kUnFixLabelWidth, kUnFixLabelHeight*KDeviceHeight)];
    secSpecialLabel.textColor = [UIColor colorWithRed:3/255.0 green:133.0/255.0 blue:125.0/255.0 alpha:1.0];
    
    secCareerYearsLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(careerYearsLabel.frame), CGRectGetMinY(careerYearsLabel.frame)-1,KDeviceWidth*kUnFixLabelWidth, kUnFixLabelHeight*KDeviceHeight)];
    secCareerYearsLabel.textColor = [UIColor colorWithRed:3/255.0 green:133.0/255.0 blue:125.0/255.0 alpha:1.0];
    
    secPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(docPriceLabel.frame), CGRectGetMinY(docPriceLabel.frame)-1,KDeviceWidth*kUnFixLabelWidth, kUnFixLabelHeight*KDeviceHeight)];
    secPriceLabel.textColor = [UIColor colorWithRed:3/255.0 green:133.0/255.0 blue:125.0/255.0 alpha:1.0];
    
    secPlaceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(docPlaceLabel.frame), CGRectGetMinY(docPlaceLabel.frame)-1,KDeviceWidth*kUnFixLabelWidth, kUnFixLabelHeight*KDeviceHeight)];
    secPlaceLabel.textColor = [UIColor colorWithRed:3/255.0 green:133.0/255.0 blue:125.0/255.0 alpha:1.0];
    
    secConTimesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(docConTimesLabel.frame), CGRectGetMinY(docConTimesLabel.frame)-1,KDeviceWidth*kUnFixLabelWidth, kUnFixLabelHeight*KDeviceHeight)];
    secConTimesLabel.textColor = [UIColor colorWithRed:3/255.0 green:133.0/255.0 blue:125.0/255.0 alpha:1.0];
    
    secMoreView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(docMoreLabel.frame), CGRectGetMaxY(docMoreLabel.frame)+kLabelTopInterval*KDeviceHeight,KDeviceWidth-6*kLabelLeftInterval*KDeviceWidth, kMoreViewHeight*KDeviceHeight)];
    secMoreView.textColor = [UIColor colorWithRed:3/255.0 green:133.0/255.0 blue:125.0/255.0 alpha:1.0];
    secMoreView.userInteractionEnabled = NO;
    secMoreView.editable = NO;
    secMoreView.textContainerInset = UIEdgeInsetsZero;
    [self setUnFixedLabelContent];
    [self setUnFixedLabelFont];
    
    [self.view addSubview:secRankLabel];
    [self.view addSubview:secSpecialLabel];
    [self.view addSubview:secCareerYearsLabel];
    [self.view addSubview:secPriceLabel];
    [self.view addSubview:secPlaceLabel];
    [self.view addSubview:secConTimesLabel];
    [self.view addSubview:secMoreView];
}

- (void)setUnFixedLabelFont{
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
    secRankLabel.font = [UIFont systemFontOfSize:14];
    secSpecialLabel.font = [UIFont systemFontOfSize:14];
    secPriceLabel.font = [UIFont systemFontOfSize:14];
    secPlaceLabel.font = [UIFont systemFontOfSize:14];
    secConTimesLabel.font = [UIFont systemFontOfSize:14];
    secMoreView.font = [UIFont systemFontOfSize:14];
    secCareerYearsLabel.font = [UIFont systemFontOfSize:14];
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
    secRankLabel.font = [UIFont systemFontOfSize:13];
    secSpecialLabel.font = [UIFont systemFontOfSize:13];
    secPriceLabel.font = [UIFont systemFontOfSize:13];
    secPlaceLabel.font = [UIFont systemFontOfSize:13];
    secConTimesLabel.font = [UIFont systemFontOfSize:13];
    secMoreView.font = [UIFont systemFontOfSize:13];
    secCareerYearsLabel.font = [UIFont systemFontOfSize:13];
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
    secRankLabel.font = [UIFont systemFontOfSize:17];
    secSpecialLabel.font = [UIFont systemFontOfSize:17];
    secPriceLabel.font = [UIFont systemFontOfSize:17];
    secPlaceLabel.font = [UIFont systemFontOfSize:17];
    secConTimesLabel.font = [UIFont systemFontOfSize:17];
    secMoreView.font = [UIFont systemFontOfSize:17];
    secCareerYearsLabel.font = [UIFont systemFontOfSize:17];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415){
    secRankLabel.font = [UIFont systemFontOfSize:18];
    secSpecialLabel.font = [UIFont systemFontOfSize:18];
    secPriceLabel.font = [UIFont systemFontOfSize:18];
    secPlaceLabel.font = [UIFont systemFontOfSize:18];
    secConTimesLabel.font = [UIFont systemFontOfSize:18];
    secMoreView.font = [UIFont systemFontOfSize:18];
    secCareerYearsLabel.font = [UIFont systemFontOfSize:18];
    }
}

- (void)setUnFixedLabelContent{
    if (!singleDoctor.docCertificate) {
      secRankLabel.text = @"";
    }
    else{
      secRankLabel.text = singleDoctor.docCertificate;
    }
    if (!singleDoctor.docSpecial) {
      secSpecialLabel.text = @"";
    }
    else{
      secSpecialLabel.text =[self getRealSpecialField:singleDoctor.docSpecial];
    }
    if (!singleDoctor.careerTimes) {
      secCareerYearsLabel.text = @"";
    }
    else{
      secCareerYearsLabel.text = singleDoctor.careerTimes;
    }
    if (!singleDoctor.docPrice) {
      secPriceLabel.text = @"";
    }
    else{
      secPriceLabel.text = singleDoctor.docPrice;
    }
    if (!singleDoctor.docLocation) {
      secPlaceLabel.text = @"";
    }
    else{
      secPlaceLabel.text = singleDoctor.docLocation;
    }
   if (!singleDoctor.docConTimes) {
      secConTimesLabel.text = @"";
    }
    else{
      secConTimesLabel.text = singleDoctor.docConTimes;
    }
    if (!singleDoctor.docMore) {
      secMoreView.text = @"";
    }
    else{
    secMoreView.text = singleDoctor.docMore;
    }
}
//将医师领域信息的字符值转化为string类型的值
- (NSString *)getRealSpecialField:(NSString *)special{
    BOOL isBegun = false;
    NSMutableString *result = [[NSMutableString alloc]init];
    NSArray *array = [[NSArray alloc]initWithObjects:@"婚恋情感",@"学业问题",@"亲子教育",@"职场压力",@"人际交往",@"恐艾症", nil];
    for (int i=0; i < special.length; i++) {
        if ([special characterAtIndex:i] == '1') {
            if (isBegun) {
                [result appendString:@","];
            }
            [result appendString:[array objectAtIndex:i]];
            isBegun = true;
        }
    }
    return result;
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
