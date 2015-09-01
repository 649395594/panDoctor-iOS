//
//  CommentTableView.m
//  Pan大夫
//
//  Created by zxy on 3/12/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentTableViewCell.h"
#import "Comment.h"
#import "Doctor.h"
#import "AppDelegate.h"

#define kCommandTopViewHeight 0.0704225
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define kCellHeight 0.163043
#define kCommentSRWidth 0.193236
#define kCommentSRHeight 0.028533
#define kTotalMarkLeftInterval 0.043478
#define kTotalMarkTopInterval 0.02038
#define kTotalMarkWidth 0.157004
#define kTotalMarkHeight 0.0217391
#define kCommentLabelWidth 0.140096
#define kCommentStarRateWidth 0.241545
#define kCommentStarRateHeight 0.033967
#define kAverageWidth 0.062802
#define kAverageHeight 0.024456
#define kRateLabelWidth 0.128019
#define kSecRateWidth 0.144927
@interface CommentTableView ()
{
    int localRate;
    int commentPage;
}
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) CommentViewController *pushDelegate;
@property (nonatomic, strong) NSString *totalCommentNumber;
@property (nonatomic, strong) NSString *shortAverageMark;
@property (nonatomic, strong) StarRateView *userCommentRate;
@property (nonatomic, strong) UIImageView *LineImage;
@property (strong, nonatomic) MKNetworkOperation *netOp;
@property (strong, nonatomic) Doctor *locDoc;
@end

@implementation CommentTableView
@synthesize shortAverageMark,userCommentRate,LineImage;
@synthesize netOp;
@synthesize locDoc;
- (id)initWithComments:(NSMutableArray *)comments PushDelegate:(CommentViewController *)delegate Frame:(CGRect)frame Doctor:(Doctor *)doctor{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.commentArray = comments;
        self.dataSource = self;
        self.delegate = self;
        self.pushDelegate = delegate;
        self.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        self.pullDelegate = self;
        self.canPullUp = YES;
        self.canPullDown = NO;
        
        locDoc = doctor;
        
        commentPage = 1;
    }
    return self;
}

//根据手势的上拉和下拉判断加载或者刷新
- (void)scrollView:(UIScrollView *)scrollView loadWithState:(LoadState)state{
    if (state == PullUpLoadState) {
        commentPage = commentPage+1;
        [self requestNetWork];
        [self performSelector:@selector(PullUpLoadEnd) withObject:nil afterDelay:0];
    }
}
//上拉加载结束调用的函数
- (void)PullUpLoadEnd {
    [self reloadData];
    [self stopLoadWithState:PullUpLoadState];
}

- (void)requestNetWork{
    __block NSMutableArray *localCommentsArray = self.commentArray;
    __block CommentTableView *localSelf = self;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *path = [NSString stringWithFormat:@"/commentdb.php?action=get&nextPage=%d&doctorId=%@",commentPage,locDoc.docID];
    netOp = [appDelegate.netEngine operationWithPath:path];
    
    [netOp addCompletionHandler:^(MKNetworkOperation *operation){
        id json = [operation responseJSON];
        NSDictionary *dic = (NSDictionary *)json;
        NSLog(@"pullUpnumber = %@",[dic objectForKey:@"commentNumber"]);
        int commentNumber = [[dic objectForKey:@"commentNumber"]intValue];
        NSMutableArray *allCommentsArray = [dic objectForKey:@"comments"];
        
        if (commentNumber == 0) {
            NSLog(@"commentNumber = 0");
        }else{
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
            //处理字符串
            if (averageMark.length > 3) {
                averageMark = [averageMark substringToIndex:3];//如果小数点后不止一位，精确到小数点后一位
            }
            
            int rate = (int)([rateOfFullMark floatValue] * 100 + 0.5);
            [localSelf setTotalComment:totalComments AverageMark:averageMark FullMarkRate:rate];
        }
        
    } errorHandler:^(MKNetworkOperation *operation,NSError *error){
        NSLog(@"网络加载失败！");
    }
     ];
    [appDelegate.netEngine enqueueOperation:netOp];
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


- (void)setTotalComment:(NSString *)totalCommentNumber AverageMark:(NSString *)averageMark FullMarkRate:(int) rate{
    self.totalCommentNumber = totalCommentNumber;
    shortAverageMark = [[NSString alloc]init];
    if (averageMark.length > 3) {
        shortAverageMark = [averageMark substringToIndex:3];
    }
    else{
        shortAverageMark = averageMark;
    }
    localRate = rate;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.commentArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight*KDeviceHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = (int)[indexPath row];
    static NSString *indentifier = @"cell";
    CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CommentTableViewCell" owner:self options:nil]firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Comment *comment = [self.commentArray objectAtIndex:row];
    cell.nameLabel.text = comment.patientName;
    cell.nameLabel.font = [UIFont systemFontOfSize:14];
    
    cell.telLabel.text = comment.patientTel;
    cell.telLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *date = comment.commentDate;
    NSString *newDate = [date substringToIndex:10];
    cell.dateLabel.text = newDate;
    cell.dateLabel.font = [UIFont systemFontOfSize:12];
    
    cell.informationView.text = comment.information;
    
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
   userCommentRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.telLabel.frame)+10, CGRectGetMinY(cell.nameLabel.frame)+2, kCommentSRWidth*KDeviceWidth, kCommentSRHeight*KDeviceHeight) numberOfStars:5];
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
    userCommentRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.telLabel.frame)+18, CGRectGetMinY(cell.nameLabel.frame)+1, kCommentSRWidth*KDeviceWidth, kCommentSRHeight*KDeviceHeight) numberOfStars:5];
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
    userCommentRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.telLabel.frame)+60, CGRectGetMinY(cell.nameLabel.frame), kCommentSRWidth*KDeviceWidth, kCommentSRHeight*KDeviceHeight) numberOfStars:5];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415) {
    userCommentRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.telLabel.frame)+85, CGRectGetMinY(cell.nameLabel.frame), kCommentSRWidth*KDeviceWidth, kCommentSRHeight*KDeviceHeight) numberOfStars:5];
    }
    userCommentRate.allowIncompleteStar = YES;
    userCommentRate.hasAnimation = NO;
    userCommentRate.scorePercent = [comment.mark floatValue]/5.0;
    [cell addSubview:userCommentRate];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect titleRect = CGRectMake(0.0, 0.0, self.frame.size.width, kCommandTopViewHeight*KDeviceHeight);
    UIView *titView = [[UIView alloc] initWithFrame:titleRect];
    titView.backgroundColor = [UIColor whiteColor];
    
    UILabel *totalMarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(kTotalMarkLeftInterval*KDeviceWidth, kTotalMarkTopInterval*KDeviceHeight, KDeviceWidth*kTotalMarkWidth, KDeviceHeight*kTotalMarkHeight)];
    totalMarkLabel.text = @"整体评分";
    totalMarkLabel.textColor = [UIColor grayColor];
    [titView addSubview:totalMarkLabel];
    
    UILabel *commentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totalMarkLabel.frame),CGRectGetMinY(totalMarkLabel.frame), KDeviceWidth*kCommentLabelWidth, KDeviceHeight*kTotalMarkHeight)];
    NSMutableString *allComments = [[NSMutableString alloc]init];
    [allComments appendString:@"("];
    [allComments appendFormat:@"%@条):",self.totalCommentNumber];
    commentsLabel.text = allComments;
    commentsLabel.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];
    [titView addSubview:commentsLabel];
    
    //评分星控件
    StarRateView *comStarRate = [[StarRateView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(commentsLabel.frame), CGRectGetMinY(totalMarkLabel.frame)-4, kCommentStarRateWidth*KDeviceWidth, kCommentStarRateHeight*KDeviceHeight) numberOfStars:5];
    comStarRate.delegate = self;
    comStarRate.allowIncompleteStar = YES;
    comStarRate.hasAnimation = NO;
    comStarRate.scorePercent = [shortAverageMark floatValue]/5.0;
    [titView addSubview:comStarRate];
    
    UILabel *comAverageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(comStarRate.frame), CGRectGetMinY(totalMarkLabel.frame)-1.5, kAverageWidth*KDeviceWidth, kAverageHeight*KDeviceHeight)];
    comAverageLabel.text = shortAverageMark;
    comAverageLabel.textAlignment = NSTextAlignmentRight;
    comAverageLabel.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];
    [titView addSubview:comAverageLabel];
    
    UILabel *secAverageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(comAverageLabel.frame)+1, CGRectGetMinY(comAverageLabel.frame), kAverageWidth*KDeviceWidth, kAverageHeight*KDeviceHeight)];
    secAverageLabel.textColor = [UIColor grayColor];
    secAverageLabel.text = @"/5";
    [titView addSubview:secAverageLabel];
    
    //好评率Label
    UILabel *rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(secAverageLabel.frame), CGRectGetMinY(totalMarkLabel.frame), KDeviceWidth*kRateLabelWidth, kTotalMarkHeight*KDeviceHeight)];
    rateLabel.text = @"好评率:";
    rateLabel.textColor = [UIColor grayColor];
    [titView addSubview:rateLabel];
    
    UILabel *secRateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rateLabel.frame), CGRectGetMinY(totalMarkLabel.frame)-1, kSecRateWidth*KDeviceWidth, kAverageHeight*KDeviceHeight)];
    NSMutableString *allRate = [[NSMutableString alloc]init];
    [allRate appendString:@""];
    [allRate appendFormat:@"%d%%",localRate];
    secRateLabel.textColor = [UIColor colorWithRed:3/255.0 green:133/255.0 blue:125/255.0 alpha:1.0];
    secRateLabel.text = allRate;
    [titView addSubview:secRateLabel];
    
    //适配各种机型的字体
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
        totalMarkLabel.font = [UIFont systemFontOfSize:12];
        commentsLabel.font = [UIFont systemFontOfSize:12];
        comAverageLabel.font = [UIFont systemFontOfSize:14];
        secAverageLabel.font = [UIFont systemFontOfSize:13];
        rateLabel.font = [UIFont systemFontOfSize:12];
        secRateLabel.font = [UIFont systemFontOfSize:14];
        NSLog(@"titView is %f",titView.frame.size.height);
        LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 33.5, KDeviceWidth, 0.3)];
        
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
        totalMarkLabel.font = [UIFont systemFontOfSize:12];
        commentsLabel.font = [UIFont systemFontOfSize:12];
        comAverageLabel.font = [UIFont systemFontOfSize:14];
        secAverageLabel.font = [UIFont systemFontOfSize:13];
        rateLabel.font = [UIFont systemFontOfSize:12];
        secRateLabel.font = [UIFont systemFontOfSize:14];
        LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titView.frame), KDeviceWidth, 0.3)];
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
        totalMarkLabel.font = [UIFont systemFontOfSize:14];
        commentsLabel.font = [UIFont systemFontOfSize:14];
        comAverageLabel.font = [UIFont systemFontOfSize:16];
        secAverageLabel.font = [UIFont systemFontOfSize:15];
        rateLabel.font = [UIFont systemFontOfSize:14];
        secRateLabel.font = [UIFont systemFontOfSize:16];
        LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titView.frame), KDeviceWidth, 0.3)];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415) {
       totalMarkLabel.font = [UIFont systemFontOfSize:16];
       commentsLabel.font = [UIFont systemFontOfSize:16];
       comAverageLabel.font = [UIFont systemFontOfSize:18];
       secAverageLabel.font = [UIFont systemFontOfSize:17];
       rateLabel.font = [UIFont systemFontOfSize:16];
       secRateLabel.font = [UIFont systemFontOfSize:18];
       LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titView.frame), KDeviceWidth, 0.3)];
    }
    LineImage.backgroundColor = [UIColor lightGrayColor];
    [titView addSubview:LineImage];
    return titView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCommandTopViewHeight*KDeviceHeight;
}
@end
