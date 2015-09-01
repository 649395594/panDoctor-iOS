//
//  scrollableTable.m
//  REFrostedViewControllerExample
//
//  Created by zxy on 14/12/20.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "scrollableTable.h"
#import "SVTopScrollView.h"
#import "UIImageView+WebCache.h"
#import "NewsThumbnailTableViewCell.h"
#import "AppDelegate.h"

#define kCellHeight 80
#define kCellCount 10
#define k4S_RefreshLabel_Height 16
#define k6_RefreshLabel_Height 20
#define k6plus_RefreshLabel_Height 24

@interface scrollableTable (){
    int nextPage;
    BOOL isEmpty;
    BOOL isSameArticle;
}

@property (strong, nonatomic) MKNetworkOperation *op;
@property (strong, nonatomic) NSMutableArray *cellTitles;//存储文章标题的数组
@property (strong, nonatomic) NSMutableArray *imageURLs;//存储文章图片URL的数组

@property (strong, nonatomic) UIImageView *refreshView;
@property (strong, nonatomic)  UIImageView *loadView;

@end
@implementation scrollableTable
@synthesize op,cellTitles,imageURLs;
@synthesize refreshCount;
@synthesize articles,type,refreshView,loadView;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)init{
    
    //cellTitles = [[NSMutableArray alloc]initWithObjects:@"测试文章标题第一个",@"测试文章标题第二个",@"测试文章标题第三个",@"测试文章标题第四个",@"测试文章标题第五个",@"测试文章标题第六个",@"测试文章标题第六个",@"测试文章标题第六个",@"测试文章标题第六个",@"测试文章标题第六个", nil];
    cellTitles = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    imageURLs = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    articles = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    scrollableTable *table = [super init];
    table.delegate = self;
    table.dataSource = self;
    
    table.pullDelegate = self;
    table.canPullUp = YES;
    table.canPullDown = YES;
    refreshCount = 0;
    nextPage = 1;
    isSameArticle = NO;
    isEmpty = NO;
    return table;
}

- (id)initWithNavPushController:(ResourcesViewController *)delegate{
    self = [self init];
    self.navPushDelegate = delegate;
    return self;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cellTitles count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (void)scrollView:(UIScrollView*)scrollView loadWithState:(LoadState)state {
    if (state == PullDownLoadState) {
        [self refreshTable];
    }
    else {
        nextPage = (int)nextPage+1;
        SVTopScrollView *topView = [SVTopScrollView shareInstance];
        type = [topView.diseaseArray objectAtIndex:(int)[topView  getButtonId]];
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSString *path = [NSString stringWithFormat:@"/newsInfo.php?type=%@&nextPage=%d",type,nextPage];
        
        op = [appDelegate.netEngine operationWithPath:path];
        
        __block NSMutableArray *localTitles = self.cellTitles;
        __block NSMutableArray *localURLs = imageURLs;
        __block NSMutableArray *localIDs = articles;
        __block scrollableTable *localSelf = self;
        //__block BOOL localIsEmpty = isEmpty;

        [op addCompletionHandler:^(MKNetworkOperation *operaton){
            id json = [operaton responseJSON];
            NSDictionary *dic = (NSDictionary *)json;
            int rowNumber = [[dic objectForKey:@"rowNumber"]intValue];
            NSMutableArray * dataArray = [dic objectForKey:@"data"];
            if (rowNumber == 0) {
                isEmpty = YES;
            }
            else{
                for (int i=0; i<dataArray.count; i++) {
                    NSDictionary *articleDic = [dataArray objectAtIndex:i];
                    NSString *articleId = [articleDic objectForKey:@"id"];
                    NSString *title = [articleDic objectForKey:@"title"];
                    NSString *picUrl = [articleDic objectForKey:@"picturl"];
                    
                    [localIDs addObject:articleId];
                    [localTitles addObject:title];
                    [localURLs addObject:picUrl];
                }
            }
            [localSelf performSelector:@selector(PullUpLoadEnd) withObject:nil afterDelay:0];
        }
                    errorHandler:^(MKNetworkOperation *operation,NSError *error){
                    }
         ];
        [appDelegate.netEngine enqueueOperation:op];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    
    static NSString *indentifier = @"cell";
    NewsThumbnailTableViewCell *cell = (NewsThumbnailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[NewsThumbnailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *url = [imageURLs objectAtIndex:row];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:url]
                  placeholderImage:[UIImage imageNamed:@"ImageLoadError"]];
    cell.title.text = [cellTitles objectAtIndex:row];
    cell.row = row;
    cell.Id = [articles objectAtIndex:row];
    cell.title.editable = NO;
    [cell.title setFont:[UIFont systemFontOfSize:17]];

    return cell;
}

- (void)PullDownLoadEnd {
    self.canPullUp = YES;
    [self reloadData];
    [self stopLoadWithState:PullDownLoadState];
}

- (void)PullUpLoadEnd {
    [self reloadData];
    [self stopLoadWithState:PullUpLoadState];
}

- (void)refreshTable{
    nextPage = 1;
    isEmpty = NO;
    SVTopScrollView *topView = [SVTopScrollView shareInstance];
    type = [topView.diseaseArray objectAtIndex:(int)[topView  getButtonId]];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *path = [NSString stringWithFormat:@"/newsInfo.php?type=%@&nextPage=%d",type,1];
    op = [appDelegate.netEngine operationWithPath:path];
    
    
    __block NSMutableArray *localTitles = self.cellTitles;
    __block NSMutableArray *localURLs = imageURLs;
    __block NSMutableArray *localIDs = articles;
    __block scrollableTable *localSelf = self;
    
  
    [op addCompletionHandler:^(MKNetworkOperation *operaton){
        id json = [operaton responseJSON];
        NSDictionary *dic = (NSDictionary *)json;
        int rowNumber = [[dic objectForKey:@"rowNumber"]intValue];
        NSMutableArray * dataArray = [dic objectForKey:@"data"];
        
        if (rowNumber == 0) {
            
        }
        else{
            [localTitles removeAllObjects];
            [localURLs removeAllObjects];
            [localIDs removeAllObjects];
            for (int i=0; i<dataArray.count; i++) {
                NSDictionary *articleDic = [dataArray objectAtIndex:i];
                NSString *articleId = [articleDic objectForKey:@"id"];
                NSString *title = [articleDic objectForKey:@"title"];
                NSString *picUrl = [articleDic objectForKey:@"picturl"];
                
                [localTitles addObject:title];
                [localURLs addObject:picUrl];
                [localIDs addObject:articleId];
            }
            if (rowNumber > 0&&[[localTitles objectAtIndex:0] isEqualToString:[localTitles objectAtIndex:0]]) {
                isSameArticle = YES;
            }
        }
        [localSelf performSelector:@selector(PullDownLoadEnd) withObject:nil afterDelay:0];
    }
                errorHandler:^(MKNetworkOperation *operation,NSError *error){
                }
     ];
    [appDelegate.netEngine enqueueOperation:op];
    
    refreshCount += 1;
}

- (void)scrollrefreshTable{
    SVTopScrollView *topView = [SVTopScrollView shareInstance];
    type = [topView.diseaseArray objectAtIndex:(int)[topView  getTableId]];
    NSLog(@"[topView  getTableId] = %d",(int)[topView  getTableId]);
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *path = [NSString stringWithFormat:@"/newsInfo.php?type=%@&nextPage=%d",type,1];
    op = [appDelegate.netEngine operationWithPath:path];
    
    
    __block NSMutableArray *localTitles = self.cellTitles;
    __block NSMutableArray *localURLs = imageURLs;
    __block NSMutableArray *localIDs = articles;
    __block scrollableTable *localSelf = self;
    
    
    [op addCompletionHandler:^(MKNetworkOperation *operaton){
        id json = [operaton responseJSON];
        NSDictionary *dic = (NSDictionary *)json;
        int rowNumber = [[dic objectForKey:@"rowNumber"]intValue];
        NSMutableArray * dataArray = [dic objectForKey:@"data"];
        
        if (rowNumber == 0) {
            
        }
        else{
            [localTitles removeAllObjects];
            [localURLs removeAllObjects];
            [localIDs removeAllObjects];
            for (int i=0; i<dataArray.count; i++) {
                NSDictionary *articleDic = [dataArray objectAtIndex:i];
                NSString *articleId = [articleDic objectForKey:@"id"];
                NSString *title = [articleDic objectForKey:@"title"];
                NSString *picUrl = [articleDic objectForKey:@"picturl"];
                
                [localTitles addObject:title];
                [localURLs addObject:picUrl];
                [localIDs addObject:articleId];
            }
    }
        [localSelf performSelector:@selector(PullDownLoadEnd) withObject:nil afterDelay:0];
    }
                errorHandler:^(MKNetworkOperation *operation,NSError *error){
                }
     ];
    [appDelegate.netEngine enqueueOperation:op];
    
    refreshCount += 1;
}



- (NSInteger *)returnRefreshCount{
    return refreshCount;
}

- (void)showMessage:(NSString *)actionKind{
    if ([actionKind isEqualToString:@"refresh"]&&isSameArticle) {
        if ([[UIScreen mainScreen]bounds].size.width <=321){
            refreshView =[[UIImageView alloc]initWithFrame:CGRectMake(0, -k4S_RefreshLabel_Height, 0, 0)];
            [self startTopAnimation];
            UILabel *refreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, k4S_RefreshLabel_Height)];
            refreshLabel.text = @"暂无文章更新";
            refreshLabel.textAlignment = NSTextAlignmentCenter;
            refreshLabel.textColor = [UIColor grayColor];
            [refreshLabel setFont:[UIFont systemFontOfSize:10.0]];
            [refreshLabel setBackgroundColor:[UIColor colorWithRed:244/255.0 green:252/255.0 blue:154/255.0 alpha:1.0]];
            [refreshView addSubview:refreshLabel];
            [self initNSTimer];
            [self addSubview:refreshView];
        }
        else if ([[UIScreen mainScreen]bounds].size.width <=376&&[[UIScreen mainScreen]bounds].size.width>321){
            refreshView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -k6_RefreshLabel_Height, 0, 0)];
            [self startTopAnimation];
            UILabel *refreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, k6_RefreshLabel_Height)];
            refreshLabel.text = @"暂无文章更新";
            refreshLabel.textAlignment = NSTextAlignmentCenter;
            refreshLabel.textColor = [UIColor grayColor];
            [refreshLabel setFont:[UIFont systemFontOfSize:10.0]];
            [refreshLabel setBackgroundColor:[UIColor colorWithRed:244/255.0 green:252/255.0 blue:154/255.0 alpha:1.0]];
            [refreshView addSubview:refreshLabel];
            [self initNSTimer];
            [self addSubview:refreshView];
        }
        else{
            refreshView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -k6plus_RefreshLabel_Height, 0, 0)];
            [self startTopAnimation];
            UILabel *refreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, k6plus_RefreshLabel_Height)];
            refreshLabel.text = @"暂无文章更新";
            refreshLabel.textAlignment = NSTextAlignmentCenter;
            refreshLabel.textColor = [UIColor grayColor];
            [refreshLabel setFont:[UIFont systemFontOfSize:10.0]];
            [refreshLabel setBackgroundColor:[UIColor colorWithRed:244/255.0 green:252/255.0 blue:154/255.0 alpha:1.0]];
            [refreshView addSubview:refreshLabel];
            [self initNSTimer];
            [self addSubview:refreshView];
        }
        
    }
    else if ([actionKind isEqualToString:@"load"]&&isEmpty) {
        if ([[UIScreen mainScreen]bounds].size.width <=320){
            loadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, [self contentOffset].y-k4S_RefreshLabel_Height, [[UIScreen mainScreen]bounds].size.width, k4S_RefreshLabel_Height)];
            [self startDownAnimation];
            UILabel *loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(49+k4S_RefreshLabel_Height), [[UIScreen mainScreen]bounds].size.width, k4S_RefreshLabel_Height)];
            loadLabel.text = @"已经是最后一篇文章了";
            loadLabel.textAlignment = NSTextAlignmentCenter;
            loadLabel.textColor = [UIColor grayColor];
            [loadLabel setFont:[UIFont systemFontOfSize:10.0]];
            [loadLabel setBackgroundColor:[UIColor colorWithRed:244/255.0 green:252/255.0 blue:154/255.0 alpha:1.0]];
            [loadView addSubview:loadLabel];
            [self initNSTimer];
            [self addSubview:loadView];
        }
        else if ([[UIScreen mainScreen]bounds].size.width <=375&&[[UIScreen mainScreen]bounds].size.width>320){
            loadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, [self contentOffset].y-k6_RefreshLabel_Height, [[UIScreen mainScreen]bounds].size.width, k6_RefreshLabel_Height)];
            [self startDownAnimation];
            UILabel *loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(49+k6_RefreshLabel_Height), [[UIScreen mainScreen]bounds].size.width, k6_RefreshLabel_Height)];
            loadLabel.text = @"已经是最后一篇文章了";
            loadLabel.textAlignment = NSTextAlignmentCenter;
            loadLabel.textColor = [UIColor grayColor];
            [loadLabel setFont:[UIFont systemFontOfSize:10.0]];
            [loadLabel setBackgroundColor:[UIColor colorWithRed:244/255.0 green:252/255.0 blue:154/255.0 alpha:1.0]];
            [loadView addSubview:loadLabel];
            [self initNSTimer];
            [self addSubview:loadView];
        }
        else{
            loadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, [self contentOffset].y-k6plus_RefreshLabel_Height, [[UIScreen mainScreen]bounds].size.width, k6plus_RefreshLabel_Height)];
            [self startDownAnimation];
            UILabel *loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen]bounds].size.height-(49+k6plus_RefreshLabel_Height), [[UIScreen mainScreen]bounds].size.width, k6plus_RefreshLabel_Height)];
            loadLabel.text = @"已经是最后一篇文章了";
            loadLabel.textAlignment = NSTextAlignmentCenter;
            loadLabel.textColor = [UIColor grayColor];
            [loadLabel setFont:[UIFont systemFontOfSize:10.0]];
            [loadLabel setBackgroundColor:[UIColor colorWithRed:244/255.0 green:252/255.0 blue:154/255.0 alpha:1.0]];
            [loadView addSubview:loadLabel];
            [self initNSTimer];
            [self addSubview:loadView];
        }
    }
}
- (void)initNSTimer{
    NSTimer *showTime = showTime = [NSTimer scheduledTimerWithTimeInterval:1.8 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
}

- (void)timerFireMethod:(NSTimer*)theTimer{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    refreshView.alpha = 0.0;
    loadView.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)cellClickedWithID:(NSString *)Id{
    [self.navPushDelegate cellTapedWithId:Id];
}

- (void)startTopAnimation{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.4];
    
    if ([[UIScreen mainScreen]bounds].size.width<=320) {
        refreshView.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, k4S_RefreshLabel_Height);
    }
    else if ([[UIScreen mainScreen]bounds].size.width>320&&[[UIScreen mainScreen]bounds].size.width<=375){
        refreshView.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width,k6_RefreshLabel_Height);
    }
    else{
        refreshView.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width,k6plus_RefreshLabel_Height);
    }
    
    [UIImageView commitAnimations];
}

-(void)startDownAnimation{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.4];
    
    
    if ([[UIScreen mainScreen]bounds].size.width<=320) {
        loadView.frame = CGRectMake(0, [self contentOffset].y-97, [[UIScreen mainScreen]bounds].size.width, k4S_RefreshLabel_Height);
    }
    else if ([[UIScreen mainScreen]bounds].size.width>320&&[[UIScreen mainScreen]bounds].size.width<=375){
        loadView.frame = CGRectMake(0, [self contentOffset].y-106, [[UIScreen mainScreen]bounds].size.width, k6_RefreshLabel_Height);
    }
    else{
        loadView.frame = CGRectMake(0, [self contentOffset].y-114, [[UIScreen mainScreen]bounds].size.width,k6plus_RefreshLabel_Height);
    }
    
    [UIView commitAnimations];
}

@end
