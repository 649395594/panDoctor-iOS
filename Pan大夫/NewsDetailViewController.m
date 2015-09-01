//
//  NewsDetailViewController.m
//  1.0.5
//
//  Created by tiny on 15/1/30.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@property (strong,nonatomic) NSString *Id;

@property (nonatomic ,strong) UIActivityIndicatorView *indicator;
@property (nonatomic ,strong) UIView *coverView;
@property (nonatomic ,strong) UILabel *loadingLabel;
@end

@implementation NewsDetailViewController
@synthesize indicator,coverView,loadingLabel;
- (id)initWithId:(NSString *)Id{
    self = [super init];
    if (self) {
        self.Id  =Id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置分享按钮，添加动作函数
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //加载灰色遮蔽视图
    coverView = [[UIView alloc]initWithFrame:self.view.frame];
    [coverView setBackgroundColor:[UIColor grayColor]];
    
    
    //加载网络活动指示器
    [self.view setBackgroundColor: [UIColor grayColor]];
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width - 10)/2, (self.view.frame.size.height - 100)/2, 10, 10);
    
    //加载说明文字
    loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width - 120)/2, (self.view.frame.size.height - 40)/2, 150, 40)];
    loadingLabel.text = @"拼命加载中。。。";
    // Dispose of any resources that can be recreated.
    
    NSString *stringURL = [[NSString alloc]initWithFormat:@"http://1.pandoctor.sinaapp.com/newsWebview.php?id=%@",self.Id];
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.delegate = self;
    
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view addSubview:coverView];
    [coverView addSubview:loadingLabel];
    [coverView addSubview:indicator];
    [indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [indicator stopAnimating];
    [indicator removeFromSuperview];
    [loadingLabel removeFromSuperview];
    [coverView removeFromSuperview];
}

- (void)share:(id)sender{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
