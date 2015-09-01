//
//  CommandViewController.m
//  Pan大夫
//
//  Created by tiny on 15/3/7.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "CommentViewController.h"
#import "Comment.h"
#import "CommentTableView.h"
#import "AppDelegate.h"
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height

@interface CommentViewController (){
    int comments;
}


@property (strong, nonatomic) MKNetworkOperation *netOp;
@property (strong, nonatomic) UIActivityIndicatorView *NetIndicator;
@property (strong, nonatomic) UILabel *loadingLabel;
@property (strong, nonatomic) UILabel *netFailLabel;

@property (strong, nonatomic) NSMutableArray *commentsArray;
@property (strong, nonatomic) CommentTableView *commentTable;

@property (strong, nonatomic) Doctor *localDoctor;

@property (strong, nonatomic) NSString *docID;

@end

@implementation CommentViewController
@synthesize netOp,NetIndicator,loadingLabel,netFailLabel;
@synthesize commentsArray;
@synthesize commentTable;
@synthesize localDoctor;
@synthesize docID;
- (void)viewDidLoad {
    [super viewDidLoad];
    comments = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    commentsArray = [[NSMutableArray alloc]init];
    [self getCommentsFromNetWork];
    
}

- (id)initWithDoctor:(Doctor *)doctor{
    self = [super init];
    if (self) {
        localDoctor = doctor;
        docID = doctor.docID;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCommentsFromNetWork{
    NetIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    NetIndicator.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width - 10)/2, (self.view.frame.size.height - 100)/2-20, 10, 10);
    
    loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width - 120)/2, (self.view.frame.size.height - 40)/2-20, 150, 40)];
    loadingLabel.text = @"拼命加载中。。。";
    [self commentsWillLoad];//活动指示器开启

    
    __block NSMutableArray *localCommentsArray = commentsArray;
    __block CommentViewController *localSelf = self;
    __block CommentTableView *localCommentTable = commentTable;
    __block Doctor *newDoctor = localDoctor;

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *path = [NSString stringWithFormat:@"/commentdb.php?action=get&nextPage=1&doctorId=%@",docID];
    netOp = [appDelegate.netEngine operationWithPath:path];
    
    [netOp addCompletionHandler:^(MKNetworkOperation *operation){
        id json = [operation responseJSON];
        NSDictionary *dic = (NSDictionary *)json;
        int commentNumber = [[dic objectForKey:@"commentNumber"]intValue];
        NSMutableArray *allCommentsArray = [dic objectForKey:@"comments"];
        
        if (commentNumber == 0) {
            
            if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
                UILabel *noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 100, 200, 20)];
                noticeLabel.text = @"暂无对医生的评论哦！";
                noticeLabel.font = [UIFont systemFontOfSize:14];
                noticeLabel.textColor = [UIColor grayColor];
                [localSelf.view addSubview:noticeLabel];
            }
            else if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
                UILabel *noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 110, 200, 20)];
                noticeLabel.text = @"暂无对医生的评论哦！";
                noticeLabel.font = [UIFont systemFontOfSize:15];
                noticeLabel.textColor = [UIColor grayColor];
                [localSelf.view addSubview:noticeLabel];
            }
            else{
                UILabel *noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 130, 200, 20)];
                noticeLabel.text = @"暂无对医生的评论哦！";
                noticeLabel.font = [UIFont systemFontOfSize:16];
                noticeLabel.textColor = [UIColor grayColor];
                [localSelf.view addSubview:noticeLabel];
            }
        }else{
            [localCommentsArray removeAllObjects];
            NSString *totalComments = [[NSString alloc]init];
            NSString *rateOfFullMark = [[NSString alloc]init];
            NSString *averageMark = [[NSString alloc]init];
            
            for (int i=0; i<[allCommentsArray count]; i++) {
                NSDictionary *comment = [allCommentsArray objectAtIndex:i];
                NSString *patientName = [localSelf encryptName:[comment objectForKey:@"patientName"]];
                NSString *patientTel = [localSelf encryptTel:[comment objectForKey:@"patientTel"]];
                
                NSString *mark = [comment objectForKey:@"mark"];
                NSString *commentDate = [comment objectForKey:@"commentDate"];

                NSString *information = [comment objectForKey:@"information"];
                NSString *doctorId = [comment objectForKey:@"doctorId"];
                NSString *commentId = [comment objectForKey:@"commentId"];
                
                
                //以下信息对整个表格使用，不属于某个单独评论
                totalComments = [comment objectForKey:@"totalComments"];
                rateOfFullMark = [comment objectForKey:@"rateOfFullMark"];
                averageMark = [comment objectForKey:@"averageMark"];
                
                Comment *newComment = [[Comment alloc]initWithPatientName:patientName PatientTel:patientTel Mark:mark CommentDate:commentDate Information:information DoctorId:doctorId CommentId:commentId];
                [localCommentsArray addObject:newComment];
                
                
            }
            localCommentTable = [[CommentTableView alloc]initWithComments:localCommentsArray PushDelegate:localSelf Frame:CGRectMake(0, 0, localSelf.view.frame.size.width, localSelf.view.frame.size.height) Doctor:newDoctor];
            //处理字符串
            if (averageMark.length > 3) {
                averageMark = [averageMark substringToIndex:3];//如果小数点后不止一位，精确到小数点后一位
            }
            
            float floatRate = [rateOfFullMark floatValue];
            int rate = floatRate * 100 + 0.5;
            [localCommentTable setTotalComment:totalComments AverageMark:averageMark FullMarkRate:rate];
            [localSelf.view addSubview:localCommentTable];
        }
        [localSelf commentsDidLoad];
        
    } errorHandler:^(MKNetworkOperation *operation,NSError *error){
        NSLog(@"网络加载失败！");
        [localSelf commentsDidLoad];
        [localSelf noticeNetWorkFail];//创建网络加载失败界面
    }
     ];
    [appDelegate.netEngine enqueueOperation:netOp];
}

//活动指示器开启
- (void)commentsWillLoad{
    [self.view addSubview:NetIndicator];
    [self.view addSubview:loadingLabel];
    [NetIndicator startAnimating];
}

//活动指示器关闭
- (void)commentsDidLoad{
    [NetIndicator stopAnimating];
    [loadingLabel removeFromSuperview];
    [NetIndicator removeFromSuperview];
}

//创建网络加载失败界面
- (void)noticeNetWorkFail{
    netFailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,KDeviceWidth , KDeviceHeight-49-64)];
    netFailLabel.backgroundColor = [UIColor lightGrayColor];
    netFailLabel.textAlignment = NSTextAlignmentCenter;
    netFailLabel.font = [UIFont systemFontOfSize:12];
    netFailLabel.text = @"网络连接失败,请点击屏幕重新加载";
    
    UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singalTap];
    [self.view addSubview:netFailLabel];
}

//轻触手势调用函数
- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [self.view removeGestureRecognizer:sender];
    [netFailLabel removeFromSuperview];
    [self getCommentsFromNetWork];
}

//姓名加密
- (NSString *)encryptName:(NSString *)originalName{
    NSMutableString *replace = [[NSMutableString alloc]init];
    for (int i=0; i < [originalName length]-1; i ++) {
        [replace appendFormat:@"%@",@"*" ];
    }
    NSMutableString *result = [[NSMutableString alloc]initWithString:originalName];
    [result replaceCharactersInRange:NSMakeRange(1, [originalName length]-1) withString:replace];
    return result;
}

//电话号码加密
- (NSString *)encryptTel:(NSString *)originalTel{
    NSMutableString *replace = [[NSMutableString alloc]initWithString:@"****"];
    NSMutableString *result = [[NSMutableString alloc]initWithString:originalTel];
    [result replaceCharactersInRange:NSMakeRange(7, 4) withString:replace];
    NSString *answer = [[NSString alloc]initWithFormat:@"(%@)",result];
    return answer;
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
