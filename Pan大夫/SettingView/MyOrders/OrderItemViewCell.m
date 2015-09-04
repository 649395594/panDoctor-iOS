
//
//  OrderItemViewCell.m
//  Pan大夫
//
//  Created by lf on 15/3/10.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "OrderItemViewCell.h"
#define kx 25.0;
#define kColor1 [UIColor colorWithRed:2/255.0 green:133/255.0  blue:100/255.0  alpha:1.0]//表格中不变的字体颜色
#define kColor2 [UIColor colorWithRed:232.0/255.0 green:128.0/255.0  blue:33.0/255.0  alpha:1.0]//wait_for_pay的颜色
#define kColor3 [UIColor colorWithRed:5/255.0 green:169.0/255.0  blue:232/255.0  alpha:1.0]//order_serving
#define kColor4 [UIColor colorWithRed:1.0/255.0 green:175/255.0  blue:173/255.0  alpha:1.0]//order_finished
#define kColor_cancle [UIColor colorWithRed:160/255.0 green:160/255.0  blue:160/255.0  alpha:1.0]//order_finished

#define kInch1 370.0/320.0;





@interface OrderItemViewCell()

@property(strong,nonatomic)UIView *cellView;
@property(strong,nonatomic)UILabel *endTimeLable;//剩余时间
@property(strong,nonatomic)UIImage *pic1;
@property(strong,nonatomic)UIImage *pic2;
@property(strong,nonatomic)UIImage *pic3;
@property(strong,nonatomic)UIImage *pic4;
@property(strong,nonatomic)UILabel *DocName_lable;
@property(strong,nonatomic)UILabel *time_lable;
@property(strong,nonatomic)UILabel *patientName_lable;
@property(strong,nonatomic)UILabel *price_lable;
@property(strong,nonatomic)UIView *spareView;
@property(strong,nonatomic)UIView *detailViewUp;
@property(strong,nonatomic)UIView *detailViewDown;
@property(strong,nonatomic)UILabel *payLable;
@property(strong,nonatomic)UIImageView *numberImage;
@property(strong,nonatomic)UILabel *minLable;
@property(strong,nonatomic)UILabel *sLable;
@property(strong,nonatomic) UIImageView *roundImage;
@property(strong,nonatomic)UIView *line1;
@property(strong,nonatomic)UIView *line2;
@property(strong,nonatomic)UIView *line3;
@property(strong,nonatomic)UIView *line4;
@property(strong,nonatomic)UIView *line5;
@property(strong,nonatomic)UIView *line6;
@property(strong,nonatomic)UIView *line_vertical1;
@property(strong,nonatomic)UIView *line_vertical2;
@property(strong,nonatomic)UILabel *minTextLable;
@property(strong,nonatomic)UILabel *sTextLable;
@property(strong,nonatomic)UILabel *detailLable1;
@property(strong,nonatomic)UIImageView *pic5;
@property(strong,nonatomic)UILabel *DocLable;
@property(strong,nonatomic)UILabel *timeLable;
@property(strong,nonatomic)UILabel *patientLable;
@property(strong,nonatomic)UILabel *_lable1;
@property(strong,nonatomic)UILabel *_lable2;
@property(strong,nonatomic)UILabel *_lable3;
@property(strong,nonatomic)UILabel *_lable4;
@property(strong,nonatomic)UILabel *_lable5;
@property(strong,nonatomic)UILabel *_lable6;
@property(strong,nonatomic)UILabel *_lable7;
@property(strong,nonatomic)UILabel *_lable8;
@property(strong,nonatomic)UILabel *numLable;
@property(strong,nonatomic)UIImageView *timeView;
@property(strong,nonatomic)UILabel *year_Lable;
@property(strong,nonatomic)UILabel *month_Lable;
@property(strong,nonatomic)UILabel *day_Lable;
@property(strong,nonatomic)UIImageView *detailButton;
@property(nonatomic)float k;
@property(nonatomic,strong)UILabel *LableOfTime;
@property(nonatomic,strong)UIImageView *picView1;
@property(nonatomic,strong)UIImageView *picView2;
@property(nonatomic,strong)UIImageView *picView3;
@property(nonatomic,strong)UIImageView *picView4;
@property(nonatomic,strong)UIButton *commentButton;
@property(nonatomic,strong)UILabel *wait_for_confirmLable;//医生取消订单等信息
@property(nonatomic,strong)UIImage *detailPic;


@end
@implementation OrderItemViewCell

//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}


@synthesize cellView,imageView,spareView,detailViewUp,detailViewDown,payLable,numberImage,endTimeLable,minLable,sLable,roundImage,numberLable,numLable,_lable7,_lable8,year_Lable,month_Lable,day_Lable,timeLable,line_vertical1,line_vertical2,picView1,picView2,picView3,picView4,commentButton,detailPic;
@synthesize line1,line2,line3,line4,line5,line6,minTextLable,sTextLable,detailLable1,pic5,_lable1,_lable2,_lable3,_lable4,_lable5,_lable6,k;
@synthesize pic1,pic2,pic3,pic4,DocName_lable,patientName_lable,DocLable,time_lable,price_lable;
@synthesize doctorNameLable,lastingTimeLable,description,yearLable,monthLable,dayLable,priceLable,detailLable,LableOfTime,startHourLable,startMinLable,endHourLable,endMinLable,patientNameLable,detailButton,timeView ;
@synthesize wait_for_confirmLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (IS_IPHONE_6_SCREEN) {
        k = [[UIScreen mainScreen]bounds].size.width/320.0;
    }
    else if (IS_IPHONE_5S_SCREEN){
        k = 1.0;}
    else if (IS_IPHONE_6plus_SCREEN){
        k = [[UIScreen mainScreen]bounds].size.width/320.0;}
    else if (IS_IPHONE_4S_SCREEN){
        k = 1.0;
    }//按照屏幕的尺寸来适配机型
    if (self) {


        cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, k*168)];

        cellView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cellView];
        spareView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, k*10)];
        spareView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:239.0/255.0  blue:245.0/255.0  alpha:1.0];//cell上面的空白条
        [cellView addSubview:spareView];
        detailViewUp = [[UIView alloc]initWithFrame:CGRectMake(0, k*10, [[UIScreen mainScreen]bounds].size.width, k*35)];
        detailViewUp.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0  blue:245/255.0  alpha:1.0];
;

        [cellView addSubview:detailViewUp];
        UIImageView *lineGray1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 0.5)];
        lineGray1.backgroundColor = [UIColor lightGrayColor];
        [detailViewUp addSubview:lineGray1];
        UIImageView *lineGray2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, k*34.5, [[UIScreen mainScreen]bounds].size.width, 0.5)];
        lineGray2.backgroundColor = [UIColor lightGrayColor];
        [detailViewUp addSubview:lineGray2];
        detailViewDown = [[UIImageView alloc]initWithFrame:CGRectMake(0,k*45 , [[UIScreen mainScreen]bounds].size.width, k*123)];
        detailViewDown.backgroundColor = [UIColor whiteColor];
        detailViewDown.userInteractionEnabled = YES;

        [cellView addSubview:detailViewDown];//下面关于订单的详细信息
        
        numberLable = [[UILabel alloc]initWithFrame:CGRectMake(k*10, k*10, k*15, k*15)];
        numberLable.textAlignment = NSTextAlignmentCenter;
        [detailViewUp addSubview:numberLable];

        payLable = [[UILabel alloc]initWithFrame:CGRectMake(k*33, 0,k*50,k*35)];
        payLable.font = [UIFont systemFontOfSize:15*k];
        [detailViewUp addSubview:payLable];

        
        line_vertical1 =[[UIImageView alloc]initWithFrame:CGRectMake(90*k, 8*k, 0.5*k, 19*k)];
        line_vertical2 =[[UIImageView alloc]initWithFrame:CGRectMake(257*k, 8*k, 0.5*k, 19*k)];
        endTimeLable  = [[UILabel alloc]initWithFrame:CGRectMake(113*k-7*k-4*k, 0, 82*k, 35*k)];
        [detailViewUp addSubview:endTimeLable];
        


        line_vertical1.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0  blue:180/255.0  alpha:1.0];

        [detailViewUp addSubview:line_vertical1];
        line_vertical2.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0  blue:180/255.0  alpha:1.0];

        [detailViewUp addSubview:line_vertical2];
        numLable = [[UILabel alloc]initWithFrame:CGRectMake(5*k, 5*k, 25*k, 25*k)];
        [detailViewUp addSubview:numLable];
        
        picView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5*k, 8*k,20*k,20*k )];
        [detailViewDown addSubview:picView1];
        picView2 = [[UIImageView alloc]initWithFrame:CGRectMake(5*k, 35*k,20*k,20*k )];
        [detailViewDown addSubview:picView2];
        picView3 = [[UIImageView alloc]initWithFrame:CGRectMake(5*k, 66*k,20*k,20*k )];
        [detailViewDown addSubview:picView3];
        picView4 = [[UIImageView alloc]initWithFrame:CGRectMake(5*k, 95*k,20*k,20*k )];
        [detailViewDown addSubview:picView4];

        line1 = [[UIImageView alloc]initWithFrame:CGRectMake(30*k, 30*k, [[UIScreen mainScreen]bounds].size.width-25*k,1)];
        line1.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0  blue:180/255.0  alpha:0.3]
;
        [detailViewDown addSubview:line1];
        line2 = [[UIImageView alloc]initWithFrame:CGRectMake(30*k, 60*k, [[UIScreen mainScreen]bounds].size.width-25*k,1)];
        line2.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0  blue:180/255.0  alpha:0.3];
        [detailViewDown addSubview:line2];
        line3 = [[UIImageView alloc]initWithFrame:CGRectMake(30*k, 90*k, [[UIScreen mainScreen]bounds].size.width-25*k,1)];
        line3.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0  blue:180/255.0  alpha:0.3];
        [detailViewDown addSubview:line3];
        line6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 167.5*k, [[UIScreen mainScreen]bounds].size.width,1)];
        line6.backgroundColor = [UIColor lightGrayColor];
        [cellView addSubview:line6];
        DocName_lable = [[UILabel alloc]initWithFrame:CGRectMake(30*k, 1*k, 80*k, 28*k)];
        DocName_lable.text = @"咨询医师:";
        DocName_lable.textColor = [UIColor lightGrayColor];
        DocName_lable.font =[UIFont systemFontOfSize:14*k];
        [detailViewDown addSubview:DocName_lable];

        time_lable =[[UILabel alloc]initWithFrame:CGRectMake(30*k, 31*k, 80*k, 28*k)];
        time_lable.text = @"咨询时间:";
        time_lable.textColor = [UIColor lightGrayColor];
        time_lable.font = [UIFont systemFontOfSize:14*k];
        [detailViewDown addSubview:time_lable];


        patientName_lable = [[UILabel alloc]initWithFrame:CGRectMake(30*k, 61*k, 80*k, 28*k)];
        patientName_lable.text = @"联系人:";
        patientName_lable.textColor = [UIColor lightGrayColor];
        patientName_lable.font =[UIFont systemFontOfSize:14*k];
        [detailViewDown addSubview:patientName_lable];
        
        patientNameLable = [[UILabel alloc]initWithFrame:CGRectMake(80*k, 61*k, [[UIScreen mainScreen]bounds].size.width-95*k, 28*k)];
        patientNameLable.font = [UIFont systemFontOfSize:14*k];
        patientNameLable.textAlignment = NSTextAlignmentRight;
        [detailViewDown addSubview:patientNameLable];
        
        price_lable = [[UILabel alloc]initWithFrame:CGRectMake(30*k, 91*k, 80*k, 29*k)];
        price_lable.text = @"交易额:";
        price_lable.textColor = [UIColor lightGrayColor];
        price_lable.font = [UIFont systemFontOfSize:14*k];
        [detailViewDown addSubview:price_lable];
        
        doctorNameLable = [[UILabel alloc]initWithFrame:CGRectMake(80*k, 1*k, [[UIScreen mainScreen]bounds].size.width-95*k, 28*k)];
        doctorNameLable.font = [UIFont systemFontOfSize:14*k];
        doctorNameLable.textAlignment = NSTextAlignmentRight;
        [detailViewDown addSubview:doctorNameLable];

        LableOfTime = [[UILabel alloc]initWithFrame:CGRectMake(80*k, 31*k, [[UIScreen mainScreen]bounds].size.width-95*k, 28*k)];
        LableOfTime.font = [UIFont systemFontOfSize:14*k];
        LableOfTime.textAlignment = NSTextAlignmentRight;
        [detailViewDown addSubview:LableOfTime];
        
        _lable6 = [[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width-50*k, 91*k, 13*k, 30*k)];
        _lable6.font = [UIFont systemFontOfSize:14*k];
        [detailViewDown addSubview:_lable6];

        priceLable = [[UILabel alloc]initWithFrame:CGRectMake(80*k, 91*k, [[UIScreen mainScreen]bounds].size.width-95*k, 29*k)];
        priceLable.font = [UIFont systemFontOfSize:14*k];
        [detailViewDown addSubview:priceLable];
        
        numberImage = [[UIImageView alloc]initWithFrame:CGRectMake(8*k, 8*k, k*18.8, k*18.8)];
        [detailViewUp addSubview:numberImage];
        
        wait_for_confirmLable = [[UILabel alloc]initWithFrame:CGRectMake(115*k, 0, 120*k, 35*k)];
        wait_for_confirmLable.textAlignment = NSTextAlignmentCenter;
        wait_for_confirmLable.font = [UIFont systemFontOfSize:16*k];
        [detailViewUp addSubview:wait_for_confirmLable];
        
       commentButton = [[UIButton alloc]initWithFrame:CGRectMake(160*k, 4*k, 100*k, 22*k)];
       [detailViewDown addSubview:commentButton];
        
        detailButton = [[UIImageView alloc]initWithFrame:CGRectMake(265*k, 0, [[UIScreen mainScreen]bounds].size.width-267*k,35*k )];
        [detailViewUp addSubview:detailButton];



        
    }
    return self;
}


- (void)setContentWithOrder:(Order *)order{
    
    if (IS_IPHONE_6_SCREEN) {
        k = [[UIScreen mainScreen]bounds].size.width/320.0;
    }
    else if (IS_IPHONE_5S_SCREEN){
        k = 1.0;}
    else if (IS_IPHONE_6plus_SCREEN){
        k = [[UIScreen mainScreen]bounds].size.width/320.0;
    }
    else if (IS_IPHONE_4S_SCREEN){
        k = 1.0;
    }


    if (IS_IPHONE_4S_SCREEN) {
        if ([order.status isEqualToString:@"overtime_closed"]  || [order.status isEqualToString:@"doctor_closed"] ) {

            pic1 = [UIImage imageNamed:@"order_ChatBubbleGrey-4s.png"];
            pic2 = [UIImage imageNamed:@"orderClockGrey-4s.png"];
            pic3 = [UIImage imageNamed:@"orderPeopleGrey-4s.png"];
            pic4 = [UIImage imageNamed:@"orderMoneyGrey-4s.png"];

        }
        else{
        pic1 = [UIImage imageNamed:@"order_ChatBubbleGrey-4s.png"];
        pic2 = [UIImage imageNamed:@"clock-4s.png"];
        pic3 = [UIImage imageNamed:@"people-4s.png"];
        pic4 = [UIImage imageNamed:@"money-4s.png"];
    }
    }
    else{
        if ([order.status isEqualToString:@"overtime_closed"]  || [order.status isEqualToString:@"doctor_closed"] ) {
            pic1 = [UIImage imageNamed:@"order_chatBubbleGrey.png"];
            pic2 = [UIImage imageNamed:@"orderClockGrey.png"];
            pic3 = [UIImage imageNamed:@"orderPeopleGrey.png"];
            pic4 = [UIImage imageNamed:@"orderMoneyGrey.png"];

        }
                else{
        pic1 = [UIImage imageNamed:@"orderChatBubble.png"];
        pic2 = [UIImage imageNamed:@"clock.png"];
        pic3 = [UIImage imageNamed:@"people.png"];
        pic4 = [UIImage imageNamed:@"money.png"];
                }
    }


    if ([order.status isEqualToString:@"overtime_closed"]  || [order.status isEqualToString:@"doctor_closed"] ){
        doctorNameLable. textColor = kColor_cancle;}
    else doctorNameLable. textColor = kColor1;

    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(into:)];
    self.singleOrder = order;
    doctorNameLable.text = self.singleOrder.doctorName;
    patientNameLable.text = self.singleOrder.patientName;
    if ([order.status isEqualToString:@"overtime_closed"]  || [order.status isEqualToString:@"doctor_closed"] ){
    patientNameLable.textColor =kColor_cancle;}
    else patientNameLable.textColor =kColor1;
    patientNameLable.font = [UIFont systemFontOfSize:14*k];
    numberLable.font = [UIFont systemFontOfSize:10*k];
    
    NSString *time = [self expandTimeWithOrder:order];
    LableOfTime.text = time;
    if ([order.status isEqualToString:@"overtime_closed"]  || [order.status isEqualToString:@"doctor_closed"] ){
        LableOfTime.textColor = kColor_cancle;
    }
    else LableOfTime.textColor = kColor1;
    



     if ([order.status isEqualToString:@"wait_for_pay"] || [order.status isEqualToString:@"wait_for_confirm"]) {//待支付状态的订单
         commentButton.layer.cornerRadius = 5;
         commentButton.layer.borderWidth = 1.0;
         CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
         CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0 });
         [commentButton setTitle:nil forState:UIControlStateNormal];
         [commentButton.layer setBorderColor:colorref];

         numberLable.textColor = [UIColor clearColor];
         _lable6.text = @"￥";
        if ([order.status isEqualToString:@"wait_for_pay"]) {
            _lable6.textColor = [UIColor redColor];}
        else if ([order.status isEqualToString:@"wait_for_confirm"]){
            _lable6.textColor = kColor1;
        }

        NSString* s = [NSString stringWithFormat:@"%g", self.singleOrder.price];
        priceLable.text = s;
        if ([order.status isEqualToString:@"wait_for_pay"]) {
            priceLable.textColor = [UIColor redColor];}
        else if ([order.status isEqualToString:@"wait_for_confirm"]){
            priceLable.textColor = kColor1;
        }
        priceLable.font = [UIFont systemFontOfSize:14*k];
        priceLable.textAlignment = NSTextAlignmentRight;
        endTimeLable.textColor = kColor2;
        minLable.textColor =kColor2;
        sLable.textColor = kColor2;
        minTextLable.textColor = kColor2;
        sTextLable.textColor = kColor2;
        numLable.textColor = kColor2;
        
        if ([order.status isEqualToString:@"wait_for_pay"]) {
            payLable.text = @"未支付";}
        else payLable.text = @"已支付";
        payLable.font = [UIFont systemFontOfSize:15*k];
        payLable.textColor = kColor2;
        if (IS_IPHONE_4S_SCREEN) {
            detailPic = [UIImage imageNamed:@"checkOrange-4s.png"];

        }
        else{
            detailPic = [UIImage imageNamed:@"checkOrange.png"];
        }


        if (IS_IPHONE_4S_SCREEN) {
            if ([order.status isEqualToString:@"wait_for_pay"]) {
                numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unpaid-4s.png"]];}
            else if ([order.status isEqualToString:@"wait_for_confirm"]){
                numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"order_paid-4s.png"]];
            }

        }
        else{
            if ([order.status isEqualToString:@"wait_for_pay"]) {
            numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"unpaid.png"]];}
            else if([order.status isEqualToString:@"wait_for_confirm"]){
                numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"order_paid.png"]];
            }
        }
        
        
        
        if ([order.status isEqualToString:@"wait_for_confirm"]) {
//            wait_for_confirmLable.font = [UIFont systemFontOfSize:16*k];
//            payLable.font = [UIFont systemFontOfSize:15*k];

            wait_for_confirmLable.textColor = kColor2;
            wait_for_confirmLable.text = @"等待医师确认";
            wait_for_confirmLable.textAlignment = NSTextAlignmentCenter;
        }
        else
            wait_for_confirmLable.text = nil;
       
        

}
    else if ([order.status isEqualToString:@"order_serving"]){//待完成状态的订单
        payLable.text = @"待完成";
        payLable.textColor = kColor3;
        commentButton.layer.cornerRadius = 5;
        commentButton.layer.borderWidth = 1.0;
        [commentButton setTitle:nil forState:UIControlStateNormal];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0 });
        [commentButton.layer setBorderColor:colorref];

        if (IS_IPHONE_4S_SCREEN) {
            numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blueCircle-4s.png"]];

        }
        else{
        numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blueCircle.png"]];}
          _lable6.text = @"￥";
        _lable6.textColor = kColor1;
        NSString* s = [NSString stringWithFormat:@"%g", self.singleOrder.price];
        priceLable.text = s;
        priceLable.textAlignment = NSTextAlignmentRight;
        priceLable.textColor = kColor1;
        numberLable.textColor = kColor3;
        endTimeLable.textColor = kColor3;
        minLable.textColor =kColor3;
        sLable.textColor = kColor3;
        minTextLable.textColor = kColor3;
        sTextLable.textColor = kColor3;
        numLable.textColor = kColor3;
        wait_for_confirmLable.text = @"2015-02-04";
        wait_for_confirmLable.textColor = kColor3;

        if (IS_IPHONE_4S_SCREEN) {
            detailPic = [UIImage imageNamed:@"checkBlue-4s.png"];

        }
        else{
            detailPic = [UIImage imageNamed:@"checkBlue.png"];
        }
        
}
    else if ([order.status isEqualToString:@"order_finished"] || [order.status isEqualToString:@"order_comment"]){//完成交易状态的订单
        payLable.text = @"已完成";
        payLable.textColor = kColor4;
        _lable6.text = @"￥";
        _lable6.textColor = kColor1;
        NSString *s = [NSString stringWithFormat:@"%g", self.singleOrder.price];
        priceLable.text = s;
        priceLable.textAlignment = NSTextAlignmentRight;
        priceLable.textColor = kColor1;
        numberLable.textColor = kColor4;
        endTimeLable.textColor = kColor4;
        minLable.textColor =kColor4;
        sLable.textColor = kColor4;
        minTextLable.textColor = kColor4;
        sTextLable.textColor = kColor4;
        numLable.textColor = kColor4;
        wait_for_confirmLable.text = @"2015-02-04";
        wait_for_confirmLable.textColor = kColor4;
        if ([order.status isEqualToString:@"order_comment"]) {
            commentButton.layer.cornerRadius = 5;
            commentButton.layer.borderWidth = 1.0;
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 232.0/255,128.0/255, 33.0/255, 1 });
            commentButton.titleLabel.font = [UIFont  systemFontOfSize: 14*k];
            [commentButton setTitle:@"去评价" forState:UIControlStateNormal];
            [commentButton setTitleColor:kColor2 forState:UIControlStateNormal];
            [commentButton.layer setBorderColor:colorref];
            [commentButton addTarget:self action:@selector(toComment) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            commentButton.layer.cornerRadius = 5;
            commentButton.layer.borderWidth = 1.0;
            [commentButton setTitle:nil forState:UIControlStateNormal];
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0 });
            [commentButton.layer setBorderColor:colorref];
        }
        if (IS_IPHONE_4S_SCREEN) {
            detailPic = [UIImage imageNamed:@"checkGreen-4s.png"];
            numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greenCircle-4s.png"]];
        }
        else{
            detailPic = [UIImage imageNamed:@"checkGreen.png"];
            numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"greenCircle.png"]];
        }
    }
    
    else if([order.status isEqualToString:@"overtime_closed"] || [order.status isEqualToString:@"doctor_closed"]){
        commentButton.layer.cornerRadius = 5;
        commentButton.layer.borderWidth = 1.0;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0 });
        [commentButton setTitle:nil forState:UIControlStateNormal];
        [commentButton.layer setBorderColor:colorref];
        numberLable.textColor = [UIColor clearColor];
        
        if([order.status isEqualToString:@"doctor_closed"]){
            wait_for_confirmLable.text = @"医生取消订单";}
        else if ([order.status isEqualToString:@"overtime_closed"]){
            wait_for_confirmLable.text = @"订单已关闭";
        }
        
        wait_for_confirmLable.font = [UIFont systemFontOfSize:16*k];
        wait_for_confirmLable.textColor = kColor_cancle;
        wait_for_confirmLable.textAlignment = NSTextAlignmentCenter;
        _lable6.text = @"￥";
        _lable6.textColor = kColor_cancle ;
        NSString* s = [NSString stringWithFormat:@"%g",self.singleOrder.price];
        priceLable.text = s;
        priceLable.textColor = kColor_cancle;
        priceLable.textAlignment = NSTextAlignmentRight;
        endTimeLable.textColor = kColor_cancle;
        minLable.textColor =kColor_cancle;
        sLable.textColor = kColor_cancle;
        minTextLable.textColor = kColor_cancle;
        sTextLable.textColor = kColor_cancle;
        numLable.textColor = kColor_cancle;
        payLable.text = @"已取消";
        payLable.textColor = kColor_cancle;
        if (IS_IPHONE_4S_SCREEN) {
            detailPic = [UIImage imageNamed:@"order_checkGrey-4s.png"];
        }
        else{
            detailPic = [UIImage imageNamed:@"order_checkGrey.png"];
        }

        if (IS_IPHONE_4S_SCREEN) {
            numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"order_cancel-4s"]];
        }
        else{
            numberImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"order_cancel"]];
        }
    }
    [detailButton addGestureRecognizer:tap1];
    [detailButton setUserInteractionEnabled:YES];
    picView1.image = pic1;
    picView2.image = pic2;
    picView3.image = pic3;
    picView4.image = pic4;
    detailButton.image = detailPic;
}

-(void)into:(UITapGestureRecognizer *)recognizer{
    MyOrderViewController *rootViewController = (MyOrderViewController *)[[self superview]superview];
    NSIndexPath *indexPath = [rootViewController indexPathForCell:self];
    [rootViewController cellTapedBackToHomeWithRow:indexPath.row];
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


-(void)toComment{
    NSLog(@"进入评论界面");
}




@end
