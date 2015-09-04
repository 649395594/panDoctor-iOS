//
//  TimeTableViewController.m
//  timeTableView_1
//
//  Created by Tom on 15/3/7.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#define kDateButtonWidth (60 * deviceWidthRate)
#define kTimeButtonWidth (68 * deviceWidthRate)
#define kDateButtonHeiht (60 * deviceWidthRate)
#define kTimeButtonHeight (35 * deviceWidthRate)
#define kstartTimeLabelHeight (20 * deviceWidthRate)
#define ktimeLongLabelWidth (60*deviceWidthRate)
#define kleftInterval (15 * deviceWidthRate)
#define kdateInterval (15 * deviceWidthRate)
#define ktimeInterval (3 * deviceWidthRate)
#define ktimeVerticalInterval (2 * deviceWidthRate)
#define ktopInterval (7 * deviceWidthRate)
#define kverticalInterval (20 * deviceWidthRate)

#define kdisplayDate 7
#define kdisplayTime 24
#define kstartTimeSeconds (60*60*9 + 24*60*60)
#define kdateButtonTag 300
#define ktimeButtonTag 100

#import "TimeTableViewController.h"

@interface TimeTableViewController ()

@property(nonatomic, strong)UIScrollView *backgroundView;
@property(nonatomic, strong)UIScrollView *dateScrollerView;
@property(nonatomic, strong)UIView *timeScrollerView;
@property(nonatomic, strong)NSString *timeTableString;
@property(nonatomic, strong)UIButton *previousDateButton;
@property(nonatomic, strong)UIButton *previousTimeButton;
@property(nonatomic, strong)UILabel *startTimeLabel;
@property(nonatomic, strong)NSString *timeTableDividedString;
@property(nonatomic, strong)NSString *outputStartTime;
@property(nonatomic, strong)NSIndexPath *previousIndexPath;
@property(nonatomic, strong)NSDate *today;
@property(nonatomic, strong)UIImage *themeColorImage;
@property(nonatomic, strong)UIImage *whiteColorImage;
@property(nonatomic, strong)UIImage *lightGrayImage;
@property(nonatomic)NSInteger maxTimeLongAvailable;
@property(nonatomic)NSInteger selectedDateNo;
@property(nonatomic)NSInteger selectedTimeNo;
@property(nonatomic)float deviceWidthRate;
@property(nonatomic)BOOL isTimeListHide;
@property(nonatomic)BOOL isStartTimeSelected;
@property(nonatomic)BOOL isTimeLongSelectd;
@property(nonatomic, strong)UIColor *themeColor;


@end

@implementation TimeTableViewController

@synthesize backgroundView, dateScrollerView, timeScrollerView, previousDateButton, previousTimeButton, startTimeLabel, isTimeListHide, selectedDateNo, selectedTimeNo, selectedTimeLong, maxTimeLongAvailable, timeTableString, timeTableDividedString, outputStartPosition, outputStartTime, today, isStartTimeSelected, isTimeLongSelectd, previousIndexPath, themeColor, outputTimeInterval, deviceWidthRate, themeColorImage, whiteColorImage, lightGrayImage;

-(id)initWithTimeTable:(NSString *)_timeTable Frame:(CGRect)frame{
    timeTableString = _timeTable;
    while (timeTableString.length< kdisplayDate*kdisplayTime) {
        timeTableString = [timeTableString stringByAppendingString:@"000000000000000000000000"];
    }
    timeTableString = [timeTableString substringWithRange:NSMakeRange(0, kdisplayDate*kdisplayTime)];
    themeColor = [UIColor colorWithRed:0/255.0 green:175.0/255.0 blue:170.0/255.0 alpha:1.0];
    themeColorImage = [self createImageWithColor:themeColor];
    whiteColorImage = [self createImageWithColor:[UIColor whiteColor]];
    lightGrayImage = [self createImageWithColor:[UIColor colorWithRed:235.0/255.0 green:235.0/255 blue:235.0/255.0 alpha:1.0]];
    
    //适配机型
    if (kScreenWidth == 320) {
        deviceWidthRate = 1.0;
    }else if (kScreenWidth == 375){
        deviceWidthRate = 1.172;
    }else if (kScreenWidth == 414){
        deviceWidthRate = 1.294;
    }else{
        deviceWidthRate = kScreenWidth/320.0;
    }
    
    
    self = [super init];
    if (self) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        backgroundView = [[UIScrollView alloc]initWithFrame:frame];
        backgroundView.contentSize = CGSizeMake(frame.size.width, ktopInterval + kDateButtonHeiht + kstartTimeLabelHeight + kTimeButtonHeight*kdisplayTime/4 + kverticalInterval*2);
        backgroundView.showsVerticalScrollIndicator = YES;
        //日期背景
        dateScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ktopInterval, frame.size.width, kDateButtonHeiht)];
        dateScrollerView.contentSize = CGSizeMake((kDateButtonWidth + kdateInterval) * kdisplayDate + kleftInterval, kDateButtonHeiht);
        //时间label
        startTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ktopInterval + kDateButtonHeiht, frame.size.width, kstartTimeLabelHeight)];
        startTimeLabel.text = @"出诊时间";
        startTimeLabel.textAlignment = NSTextAlignmentCenter;
        startTimeLabel.font = [UIFont systemFontOfSize:12];
        [backgroundView addSubview:startTimeLabel];
        //时间背景
        timeScrollerView = [[UIView alloc]initWithFrame:CGRectMake(0, ktopInterval + kDateButtonHeiht + kstartTimeLabelHeight, frame.size.width, (kTimeButtonHeight + ktimeVerticalInterval)*kdisplayTime/4)];
        [self showTimeButton];
        
        [backgroundView addSubview:dateScrollerView];
        [self.view addSubview:backgroundView];
        
        
    }
    return self;
}

//接收时间，并且设置dateButton
-(void)setCurrentDate:(NSString *)currentDate{
    //处理接受的时间
    NSDateFormatter *receivedFormatter = [[NSDateFormatter alloc]init];
    [receivedFormatter setDateFormat:@"yyyy-MM-dd"];
    receivedFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    today = [receivedFormatter dateFromString:currentDate];
    
    //设置dateButton的格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"eee"];
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    NSString *dateString = [dateFormatter stringFromDate:today];
    NSTimeInterval secondsPerDay = 24*60*60;
    
    //设置dateButton
    for (int i = 0 ; i<kdisplayDate; i++){
        UIButton *dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dateButton.frame = CGRectMake((kDateButtonWidth + kdateInterval)*i +kleftInterval , 0, kDateButtonWidth, kDateButtonHeiht);
        dateButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        NSDate *buttonDate = [NSDate dateWithTimeInterval:secondsPerDay*(i+1) sinceDate:today];
        dateString = [dateFormatter stringFromDate:buttonDate];
        
        [dateButton setTitle:dateString forState:UIControlStateNormal];
        [dateButton setTitle:dateString forState:UIControlStateSelected];
        [dateButton setTitleColor:themeColor forState:UIControlStateNormal];
        [dateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [dateButton setBackgroundImage:[UIImage imageNamed:@"date01"] forState:UIControlStateSelected];
        [dateButton setBackgroundImage:[UIImage imageNamed:@"date02"] forState:UIControlStateNormal];
        
        dateButton.tag = kdateButtonTag + i;
        [dateButton addTarget:self action:@selector(dateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //第一次显示默认为第一天
        if (i == 0) {
            dateButton.selected = YES;
            previousDateButton = dateButton;
        }
        [dateScrollerView addSubview:dateButton];
        
    }
    //默认截取第一的字符串
    timeTableDividedString = [timeTableString substringWithRange:NSMakeRange(0, kdisplayTime)];
}

//显示timeButton
-(void)showTimeButton{
    //   若timeButton 已经存在，则更改enabled
    if ([timeScrollerView  subviews].count >= kdisplayTime){
        for (UIButton *button in [timeScrollerView subviews]) {
            if (button.tag >= ktimeButtonTag) {
                //从timeTableDividedString 中截取第i个字符，决定第i个button是否可选
                long i = button.tag - ktimeButtonTag;
                NSInteger testInteger = [[timeTableDividedString substringWithRange:NSMakeRange(i, 1)] intValue];
                if (testInteger == 1) {
                    button.enabled = YES;
                    [button.layer setBorderWidth:1.0];
                    //                    [button addTarget:self action:@selector(timeButtonClicked:)forControlEvents:UIControlEventTouchUpInside];
                }else{
                    button.enabled = NO;
                    [button.layer setBorderWidth:0];
                }
            }
        }
    }else{
        //创建timeButton
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        [timeFormatter setDateFormat:@"HH:mm"];
        timeFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        for (int i = 0 ; i<kdisplayTime; i++) {
            //设置每个timeButton的标题
            UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            timeButton.frame = CGRectMake(i%4 * (kTimeButtonWidth + ktimeInterval) + kleftInterval, i/4*(kTimeButtonHeight+ktimeVerticalInterval), kTimeButtonWidth, kTimeButtonHeight);
            NSDate *time = [[NSDate alloc]initWithTimeIntervalSince1970:kstartTimeSeconds-60*60*8+60*30*i];
            NSString *buttonTime = [timeFormatter stringFromDate: time];
            timeButton.tag = ktimeButtonTag + i;
            
            [timeButton setTitle:buttonTime forState:UIControlStateNormal];
            [timeButton setTitle:buttonTime forState:UIControlStateSelected];
            [timeButton setTitle:buttonTime forState:UIControlStateDisabled];
            [timeButton setBackgroundImage:whiteColorImage forState:UIControlStateNormal];
            [timeButton setBackgroundImage:themeColorImage forState:UIControlStateSelected];
            [timeButton setBackgroundImage:lightGrayImage forState:UIControlStateDisabled];
            [timeButton setTitleColor:themeColor forState:UIControlStateNormal];
            [timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [timeButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            
            //自定义timeButton
            [timeButton.layer setMasksToBounds:YES];
            [timeButton.layer setCornerRadius:10.0];
            [timeButton.layer setBorderWidth:1.0];
            [timeButton.layer setBorderColor:themeColor.CGColor];
            
            //从timeTableDividedString 中截取第i个字符，决定第i个button是否可选
            NSInteger testInteger = [[timeTableString substringWithRange:NSMakeRange(i, 1)] intValue];
            if (testInteger == 1) {
                timeButton.enabled = YES;
                [timeButton.layer setBorderWidth:1.0];
                //                [timeButton addTarget:self action:@selector(timeButtonClicked:)forControlEvents:UIControlEventTouchUpInside];
            }else{
                timeButton.enabled = NO;
                [timeButton.layer setBorderWidth:0];
            }
            [timeScrollerView addSubview:timeButton];
        }
        [backgroundView addSubview:timeScrollerView];
        timeScrollerView.userInteractionEnabled = NO;
    }
    previousTimeButton = nil;
}

//当dateButton被点击时触发事件
-(void)dateButtonClicked:(UIButton *)_dateButton{
    previousDateButton.selected = NO;
    _dateButton.selected = YES;
    selectedDateNo = _dateButton.tag - kdateButtonTag;
    timeTableDividedString = [timeTableString substringWithRange:NSMakeRange(selectedDateNo*kdisplayTime, kdisplayTime)];
    
    if (_dateButton != previousDateButton) {
        previousTimeButton.selected = NO;
        [previousTimeButton.layer setBorderWidth:1.0];
        previousTimeButton = nil;
        //        [timeLongButton setTitle:@"请选择咨询时长" forState:UIControlStateNormal];
        //        [timeLongTableView deselectRowAtIndexPath:previousIndexPath animated:NO];
        [self showTimeButton];
    }
    previousDateButton = _dateButton;
}

////当timeButton被点击时触发事件
//-(void)timeButtonClicked:(UIButton *)_timeButton{
//    if (_timeButton == previousTimeButton) {
//        return;
//    }
//    if (previousTimeButton) {
//        previousTimeButton.selected = NO;
//        [previousTimeButton.layer setBorderWidth:1.0];
////        [timeLongButton setTitle:@"请选择咨询时长" forState:UIControlStateNormal];
//    }
//    _timeButton.selected = YES;
//
//    selectedTimeNo = _timeButton.tag - ktimeButtonTag;
//
//    //设置最大的可选择时长
//    maxTimeLongAvailable = 0;
//    for (long i = selectedTimeNo; i<kdisplayTime ; i++) {
//        NSInteger testInteger = [[timeTableDividedString substringWithRange:NSMakeRange(i, 1)] intValue];
//        if (testInteger == 1) {
//            maxTimeLongAvailable++;
//        }else{
//            break;
//        }
//    }
//
//    previousTimeButton = _timeButton;
//    isStartTimeSelected = YES;
//    isTimeLongSelectd = NO;
//    [timeLongTableView deselectRowAtIndexPath:previousIndexPath animated:NO];
//    NSLog(@"button: %ld maxTimeLongAvailable: %ld", selectedTimeNo, maxTimeLongAvailable);
//}
//
//#pragma mark - TableView datasource
////设置cell高度
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return  maxTimeLongAvailable;
//}
//
////设置cell
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellIndentifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
//    if(cell==nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        cell.textLabel.textColor = themeColor;
//        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
//        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//        cell.selectedBackgroundView.backgroundColor = themeColor;
//    }
//    cell.textLabel.text = timeLongArray[indexPath.row];
//    return  cell;
//}
//
////选择时长触发
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self performSelector:@selector(hideTimeLongList) withObject:self afterDelay: 0.3];
//    [timeLongButton setTitle:timeLongArray[indexPath.row] forState:UIControlStateNormal];
//
//    isTimeLongSelectd = YES;
//    selectedTimeLong = indexPath.row + 1;
//    previousIndexPath = indexPath;
//}
//
////选择预约时长button点击时触发
//-(void)timeLongButtonClicked:(UIButton *)_timeLongButton{
//    if (isTimeListHide) {
//        [self showTimeLongList];
//    }else{
//        [self hideTimeLongList];
//    }
//}
//
////显示下拉菜单
//-(void)showTimeLongList{
//    [backgroundView addSubview:timeLongTableView];
//    [backgroundView setContentOffset:CGPointMake(0, ktopInterval + kDateButtonHeiht + kstartTimeLabelHeight + (kTimeButtonHeight + ktimeVerticalInterval)*kdisplayTime/4 - ktimeVerticalInterval) animated:YES];
//    backgroundView.scrollEnabled = NO;
//    isTimeListHide = NO;
//}
//
////隐藏下拉菜单
//-(void)hideTimeLongList{
//    [backgroundView setContentOffset:CGPointMake(0, 0) animated:YES];
//    [timeLongTableView performSelector:@selector(removeFromSuperview) withObject:self afterDelay: 0.3];
//    backgroundView.scrollEnabled = YES;
//    isTimeListHide = YES;
//}
//
////预约button点击时触发
//-(BOOL)appointmentButtonClicked{
//    //未完成相关信息时候提示
//    if (isStartTimeSelected == NO || isTimeLongSelectd == NO) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还未完成相关信息" delegate:self cancelButtonTitle:@"返回继续编辑" otherButtonTitles:nil];
//        [alert show];
//        return NO;
//    }
//    outputStartPosition = selectedDateNo*kdisplayTime + selectedTimeNo;
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
//    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    outputFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
//    NSDate *selectedStartTime = [[NSDate alloc]initWithTimeInterval:(kstartTimeSeconds + 24*60*60*selectedDateNo + 30*60*selectedTimeNo) sinceDate:today];
//    outputTimeInterval = [selectedStartTime timeIntervalSince1970];
//    return YES;
//}

//UIColor 转UIImage
- (UIImage *)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
