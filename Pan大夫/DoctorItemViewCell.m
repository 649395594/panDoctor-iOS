//
//  ViewCell.m
//  Pan大夫
//
//  Created by tiny on 15/3/4.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "DoctorItemViewCell.h"
#import "DashLineView.h"
#import "UIImageView+WebCache.h"
#define kInterval 5
#define kTopInterval 0.02264
#define kImageLeftInterval 0.016908
#define kImageWidth 0.153985
#define kImageDownInterval 0.004529
#define kImageRightInterval 0.012077
#define kStarRateHeight 0.029891
#define kDownInterval 0.016304
#define kNameLabelHeight 0.031702
#define kLabelFirstInterval 1/568.0
#define kTextFieldHeight 0.067934
#define kLabelSecondInterval 0.011322
#define kDetailLabelHeight 0.067934
#define kNameLabelWidth 0.213365
#define kHospitalLabelWidth 0.2818035
#define kCareerLabelWidth 0.202898
#define kSpecialWidth 0.108695
#define kSpecialHeight 11/568.0
#define kTextFieldWidth 0.589372
#define kDashLineWidth 0.698067
#define kRankLabelHeight 0.033967
#define kRankLabelWidth 0.079710
#define ksecRankWidth 0.38
#define kSecContimesWidth 45.0/375.0
#define kSecLocationWidth 230/375.0
#define kConTimes 0.108695
#define KThirdConTimeWidth 0.043478
#define kSecPriceWidth 60.0/375.0
#define kSecPlaceWidth 0.169082
#define kTextColor [UIColor colorWithRed:25.0/255.0 green:189.0/255.0 blue:154.0/255.0 alpha:1.0]
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
@interface DoctorItemViewCell ()
@property (strong, nonatomic) UILabel *specialLabel;
//@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *locationLabel;
//@property (strong, nonatomic) UILabel *conTimesLabel;
@property (strong, nonatomic) UILabel *rankLabel;
//@property (strong, nonatomic) UILabel *GPSLabel;
@end
@implementation DoctorItemViewCell
@synthesize doctor;
@synthesize imageView;
//@synthesize starRate;
//cell的初始化函数
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kImageLeftInterval*KDeviceWidth,kTopInterval*KDeviceHeight, kImageWidth*KDeviceHeight, kImageWidth*KDeviceHeight)];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = (kImageWidth*[[UIScreen mainScreen]bounds].size.height)/2;

        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+kImageRightInterval*KDeviceWidth, kTopInterval*KDeviceHeight,kNameLabelWidth*KDeviceWidth, kNameLabelHeight*KDeviceHeight)];
        
        self.departmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame), CGRectGetMinY(self.nameLabel.frame), kHospitalLabelWidth*KDeviceWidth,kNameLabelHeight*KDeviceHeight)];
        self.departmentLabel.textColor = [UIColor grayColor];
        
        self.docTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.departmentLabel.frame), CGRectGetMinY(self.nameLabel.frame), kCareerLabelWidth*KDeviceWidth, kNameLabelHeight*KDeviceHeight)];
        self.docTitleLabel.textColor = [UIColor grayColor];
        
        self.specialLabel= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame)+kLabelFirstInterval*KDeviceHeight, kSpecialWidth*KDeviceWidth, kSpecialHeight*KDeviceHeight)];
        self.specialLabel.textColor = [UIColor blackColor];
        self.specialLabel.text = @"专项：";
        
        if (KDeviceHeight >= 567) {
        self.specialView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.specialLabel.frame)-3, CGRectGetMinY(self.specialLabel.frame)-2, kTextFieldWidth*KDeviceWidth, kTextFieldHeight*KDeviceHeight)];
        self.specialView.userInteractionEnabled = NO;
        self.specialView.editable = NO;
            self.specialView.textContainerInset = UIEdgeInsetsZero;
        }
        if (KDeviceHeight >= 479 &&KDeviceHeight <=481) {
            self.specialView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.specialLabel.frame)-3, CGRectGetMinY(self.specialLabel.frame)-2, kTextFieldWidth*KDeviceWidth, kTextFieldHeight*KDeviceHeight)];
            self.specialView.userInteractionEnabled = NO;
            self.specialView.editable = NO;
            self.specialView.textContainerInset = UIEdgeInsetsZero;
        }
        
        DashLineView *dashLine = [[DashLineView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.specialView.frame), kDashLineWidth*KDeviceWidth, 1)];
        [dashLine setLineColor:[UIColor grayColor] LineWidth:0.5];
        dashLine.backgroundColor = [UIColor whiteColor];
        [self addSubview:dashLine];
        
        self.rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(dashLine.frame)+kLabelSecondInterval*KDeviceHeight, kRankLabelWidth*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
        self.rankLabel.textColor = [UIColor grayColor];
        self.rankLabel.text = @"资质:";
        
        self.secRankLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.rankLabel.frame), CGRectGetMinY(self.rankLabel.frame), ksecRankWidth*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
        self.secRankLabel.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];
        
//        self.conTimesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.secRankLabel.frame), CGRectGetMinY(self.rankLabel.frame), kConTimes*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
//        self.conTimesLabel.textColor = [UIColor grayColor];
//        self.conTimesLabel.text = @"已咨询:";
//        
//        self.secConTimesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.conTimesLabel.frame), CGRectGetMinY(self.conTimesLabel.frame),kSecContimesWidth*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
//        self.secConTimesLabel.textAlignment = NSTextAlignmentLeft;
//        self.secConTimesLabel.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];

//        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.rankLabel.frame), CGRectGetMaxY(self.rankLabel.frame), kRankLabelWidth*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
//        self.priceLabel.textColor = [UIColor grayColor];
//        self.priceLabel.text = @"资费:";
//        
//        self.secPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLabel.frame), CGRectGetMinY(self.priceLabel.frame), kSecPriceWidth*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
//        self.secPriceLabel.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];
        
//        self.GPSLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.conTimesLabel.frame), CGRectGetMinY(self.priceLabel.frame), kRankLabelWidth*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
//        self.GPSLabel.textColor = [UIColor grayColor];
//        self.GPSLabel.text = @"距离:";
//        
//        self.secGPSLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.GPSLabel.frame), CGRectGetMinY(self.priceLabel.frame), 3*kRankLabelWidth*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
//        self.secGPSLabel.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];
//        self.secGPSLabel.textAlignment = NSTextAlignmentLeft;
        
        self.locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.rankLabel.frame), CGRectGetMaxY(self.rankLabel.frame), kRankLabelWidth*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
        self.locationLabel.textColor = [UIColor grayColor];
        self.locationLabel.text = @"位置:";
        
        self.secLocationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.locationLabel.frame), CGRectGetMinY(self.locationLabel.frame)-1, kSecLocationWidth*KDeviceWidth, kRankLabelHeight*KDeviceHeight)];
        self.secLocationLabel.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];
        
//        starRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.imageView.frame), CGRectGetMaxY(self.imageView.frame)+kImageDownInterval*KDeviceHeight, kImageWidth*KDeviceHeight, kStarRateHeight*KDeviceHeight) numberOfStars:5];
//        starRate.allowIncompleteStar = YES;
//        starRate.hasAnimation = NO;
//        [self addSubview:starRate];
        
        [self chooseTextFont];
        [self addAllSubView];
        
        UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singalTap];
    }
    return self;
}

- (void)addAllSubView{
    [self addSubview:self.imageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.rankLabel];
    [self addSubview:self.secRankLabel];
    [self addSubview:self.specialLabel];
    [self addSubview:self.specialView];
//    [self addSubview:self.priceLabel];
//    [self addSubview:self.secPriceLabel];
    [self addSubview:self.locationLabel];
    [self addSubview:self.secLocationLabel];
//    [self addSubview:self.conTimesLabel];
//    [self addSubview:self.secConTimesLabel];
    [self addSubview:self.departmentLabel];
    [self addSubview:self.docTitleLabel];
//    [self addSubview:self.GPSLabel];
//    [self addSubview:self.secGPSLabel];

}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    UITableViewCell *docCell = (UITableViewCell *)sender.view;
    DoctorTableView *rootTableView = (DoctorTableView *)[[docCell superview]superview];
    [rootTableView cellClickedWithDoc:doctor];
}

- (void)chooseTextFont{
    if (KDeviceWidth <=415&&KDeviceWidth >=413) {
        self.nameLabel.font = [UIFont systemFontOfSize:22];
        self.departmentLabel.font = [UIFont systemFontOfSize:16];
        self.docTitleLabel.font = [UIFont systemFontOfSize:16];
        self.specialLabel.font = [UIFont systemFontOfSize:14];
        self.specialView.font = [UIFont systemFontOfSize:18];
        self.rankLabel.font = [UIFont systemFontOfSize:13];
        self.secRankLabel.font = [UIFont systemFontOfSize:15];
//        self.conTimesLabel.font = [UIFont systemFontOfSize:13];
//        self.secConTimesLabel.font = [UIFont systemFontOfSize:15];
//        self.priceLabel.font = [UIFont systemFontOfSize:13];
//        self.secPriceLabel.font = [UIFont systemFontOfSize:15];
        self.locationLabel.font = [UIFont systemFontOfSize:13];
        self.secLocationLabel.font = [UIFont systemFontOfSize:15];
//        self.GPSLabel.font = [UIFont systemFontOfSize:13];
//        self.secGPSLabel.font = [UIFont systemFontOfSize:15];

    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
        self.nameLabel.font = [UIFont systemFontOfSize:18];
        self.departmentLabel.font = [UIFont systemFontOfSize:13];
        self.docTitleLabel.font = [UIFont systemFontOfSize:13];
        self.specialLabel.font = [UIFont systemFontOfSize:13];
        self.specialView.font = [UIFont systemFontOfSize:15];
        self.rankLabel.font = [UIFont systemFontOfSize:12];
        self.secRankLabel.font = [UIFont systemFontOfSize:14];
//        self.conTimesLabel.font = [UIFont systemFontOfSize:12];
//        self.secConTimesLabel.font = [UIFont systemFontOfSize:14];
//        self.priceLabel.font = [UIFont systemFontOfSize:12];
//        self.secPriceLabel.font = [UIFont systemFontOfSize:14];
        self.locationLabel.font = [UIFont systemFontOfSize:12];
        self.secLocationLabel.font = [UIFont systemFontOfSize:14];
//        self.GPSLabel.font = [UIFont systemFontOfSize:12];
//        self.secGPSLabel.font = [UIFont systemFontOfSize:14];
    }
    if (KDeviceWidth >=319&&KDeviceWidth <=321&&KDeviceHeight<=569&&KDeviceHeight>=567) {
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.departmentLabel.font = [UIFont systemFontOfSize:12];
        self.docTitleLabel.font = [UIFont systemFontOfSize:12];
        self.specialLabel.font = [UIFont systemFontOfSize:11];
        self.specialView.font = [UIFont systemFontOfSize:13];
        self.rankLabel.font = [UIFont systemFontOfSize:10];
        self.secRankLabel.font = [UIFont systemFontOfSize:12];
//        self.conTimesLabel.font = [UIFont systemFontOfSize:10];
//        self.secConTimesLabel.font = [UIFont systemFontOfSize:12];
//        self.priceLabel.font = [UIFont systemFontOfSize:10];
//        self.secPriceLabel.font = [UIFont systemFontOfSize:12];
        self.locationLabel.font = [UIFont systemFontOfSize:10];
        self.secLocationLabel.font = [UIFont systemFontOfSize:12];
//        self.GPSLabel.font = [UIFont systemFontOfSize:10];
//        self.secGPSLabel.font = [UIFont systemFontOfSize:12];
    }
    if (KDeviceWidth >=319&&KDeviceWidth <=321&&KDeviceHeight<=481&&KDeviceHeight>=479) {
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.departmentLabel.font = [UIFont systemFontOfSize:12];
        self.docTitleLabel.font = [UIFont systemFontOfSize:12];
        self.specialLabel.font = [UIFont systemFontOfSize:11];
        self.specialView.font = [UIFont systemFontOfSize:11];
        self.rankLabel.font = [UIFont systemFontOfSize:10];
        self.secRankLabel.font = [UIFont systemFontOfSize:12];
//        self.conTimesLabel.font = [UIFont systemFontOfSize:10];
//        self.secConTimesLabel.font = [UIFont systemFontOfSize:12];
//        self.priceLabel.font = [UIFont systemFontOfSize:10];
//        self.secPriceLabel.font = [UIFont systemFontOfSize:12];
        self.locationLabel.font = [UIFont systemFontOfSize:10];
        self.secLocationLabel.font = [UIFont systemFontOfSize:12];
//        self.GPSLabel.font = [UIFont systemFontOfSize:10];
//        self.secGPSLabel.font = [UIFont systemFontOfSize:12];
    }
}

@end
