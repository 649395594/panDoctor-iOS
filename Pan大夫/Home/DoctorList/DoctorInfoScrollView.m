//
//  DoctorInfoScrollView.m
//  Pan大夫
//
//  Created by tiny on 15/3/9.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "DoctorInfoScrollView.h"
#import "AppDelegate.h"

#define kInterval 4
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define kButtonWidth (KDeviceWidth-2*kInterval)/2
@interface DoctorInfoScrollView ()

@property (strong, nonatomic)Doctor *doctor;
@property (strong, nonatomic) MKNetworkOperation *netOp;

@property (strong, nonatomic) NSString *timetable;
@property (strong, nonatomic) NSString *currentDate;

@end
@implementation DoctorInfoScrollView

@synthesize timeTableViewController,docInfoViewController;
@synthesize doctor;
@synthesize netOp;
@synthesize timetable,currentDate;
- (id)initWithFrame:(CGRect)frame AndDoctor:(Doctor *)doc{
    self = [super initWithFrame:frame];
    if (self) {
        self.doctor = doc;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.layer.cornerRadius = 5;
        self.contentSize = CGSizeMake(16*kButtonWidth, self.frame.size.height);
        [self initWithViewControllers];
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:0.5];
        self.scrollEnabled = NO;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 150.0/255.0,150.0/255.0, 150.0/255.0, 1 });
        [self.layer setBorderColor:colorref];
        userConOffsetX = 0;
    }
    return self;
}
//初始化医生时间表，医生信息，认证信息，评论信息控制器的View
- (void)initWithViewControllers{
    [self showTimeTable];
    
    UIView *docInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2*kButtonWidth, self.frame.size.height)];
    docInfoViewController = [[DoctorInformationViewController alloc]initWithDocInfo:doctor AndView:docInfoView];
    [self addSubview:docInfoView];
    
}
//得到点击按钮的tag值
- (void)getButtonID:(long)tag{
    [self setContentOffset:CGPointMake(tag*2*kButtonWidth, 0) animated:NO];
    if (!timeTableViewController) {
    }
}

- (void)showTimeTable{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *path = [NSString stringWithFormat:@"/timetable.php?action=get&doctorId=%@",self.doctor.docID];
    NSLog(@"doctor id = %@",self.doctor.docID);
    netOp = [appDelegate.netEngine operationWithPath:path];
    
    __block NSString *localTimeTable = timetable;
    __block NSString *localCurrentDate = currentDate;
    __block DoctorInfoScrollView *localSelf = self;
    
    [netOp addCompletionHandler:^(MKNetworkOperation *operation){
        id json = [operation responseJSON];
        NSDictionary *dic = (NSDictionary *)json;
        NSString *code = [dic objectForKey:@"code"];
        if ([code isEqualToString:@"101"]) {
            NSLog(@"读取失败");
        }
        else{
            localTimeTable = [dic objectForKey:@"table"];
            localCurrentDate = [dic objectForKey:@"date"];
            timeTableViewController = [[TimeTableViewController alloc]initWithTimeTable:localTimeTable Frame:CGRectMake(0, 0, 2*kButtonWidth, localSelf.frame.size.height)];
            timeTableViewController.view.frame  = CGRectMake(2*kButtonWidth, 0, 2*kButtonWidth, localSelf.frame.size.height);
            [timeTableViewController setCurrentDate:localCurrentDate];
            
            [localSelf addSubview:timeTableViewController.view];
        }
        
        
    } errorHandler:^(MKNetworkOperation *operation,NSError *error){
        NSLog(@"网络加载失败");
    }
     ];
    [appDelegate.netEngine enqueueOperation:netOp];
}

@end
