//
//  DiagnosisViewController.m
//  心理助手
//
//  Created by tiny on 15/1/25.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import "DiagnosisViewController.h"
#import "CoreDataManager.h"
#import "Question.h"
#import "TestCell.h"
#import "testAnalysisViewController.h"
#import "FunnyTestViewController.h"
#import <CoreText/CoreText.h>

#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define FrameH [[UIScreen mainScreen]bounds].size.height
#define ratio6 375/414
#define ratio5 320/414
#define TextFont (((FrameH > 567) && (FrameH < 569))? 13 :(((FrameH > 666) && (FrameH < 668))? 15 : (((FrameH > 735) && (FrameH < 737))? 17 : 13)))
#define cellHeight (((FrameH > 567) && (FrameH < 569))? 160 * ratio5:(((FrameH > 666) && (FrameH < 668))? 160 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 160 : 160 * ratio5)))
#define offset (((FrameH > 567) && (FrameH < 569))? 157:(((FrameH > 666) && (FrameH < 668))? 163 : (((FrameH > 735) && (FrameH < 737))? 169 : 153)))

@interface DiagnosisViewController ()

@property (strong , nonatomic) CoreDataManager *manager;

@property (strong , nonatomic) UITableView *table;

@property (strong , nonatomic) UIView *viewLeft;
@property (strong , nonatomic) UIView *viewRight;
@property (strong , nonatomic) UITextView *testTitle;

@property (strong , nonatomic) UIImageView *bt1;
@property (strong , nonatomic) UIImageView *bt2;
@property (strong , nonatomic) UIImageView *bt3;

@property (strong, nonatomic)UIButton *buttonLeft;
@property (strong, nonatomic)UIButton *buttonRight;

@property (strong , nonatomic) NSString *choosedKind;
@property (strong , nonatomic) NSMutableArray *temp;
@property (strong , nonatomic) NSString *choosedSubKind;

@property(strong, nonatomic) testAnalysisViewController *result;

@property (strong , nonatomic) YiYuTestViewController *test;
@property (strong , nonatomic) FunnyTestViewController *funnyTest;

@property CGRect viewFrame;
@property CGRect rightViewFrame;
@property CGRect leftViewFrame;

@property (nonatomic) BOOL isTableViewExisted;

@end

@implementation DiagnosisViewController
@synthesize manager,result;
@synthesize viewFrame,rightViewFrame,leftViewFrame,testTitle;
@synthesize bt1,bt2,bt3;
@synthesize table;
@synthesize buttonLeft,buttonRight,test,choosedKind,temp,choosedSubKind,funnyTest;
@synthesize bottomSquare;
- (void)viewDidLoad {
    [super viewDidLoad];

    manager = [[CoreDataManager alloc]init];
    if ([[UIScreen mainScreen]bounds].size.height>479&&[[UIScreen mainScreen]bounds].size.height<481) {
        buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width/2, 40)];
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"icon_4s_press_left"] forState:UIControlStateNormal];
        [buttonLeft addTarget:self action:@selector(buttonLeftTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLeft];
        
        buttonRight = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2, 64, [[UIScreen mainScreen]bounds].size.width/2, 40)];
        [buttonRight setBackgroundImage:[UIImage imageNamed:@"icon_4s_unpress_right"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(buttonRightTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.buttonRight];
    }
    else if([[UIScreen mainScreen]bounds].size.height>567&&[[UIScreen mainScreen]bounds].size.height<570){
        buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width/2, 44)];
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"icon_5s_press_left"] forState:UIControlStateNormal];
        [buttonLeft addTarget:self action:@selector(buttonLeftTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLeft];
        
        buttonRight = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2, 64, [[UIScreen mainScreen]bounds].size.width/2, 44)];
        [buttonRight setBackgroundImage:[UIImage imageNamed:@"icon_5s_unpress_right"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(buttonRightTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.buttonRight];
    }
    else if ([[UIScreen mainScreen]bounds].size.height>666&&[[UIScreen mainScreen]bounds].size.height<670){
        buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width/2, 50)];
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"icon_6_press_left"] forState:UIControlStateNormal];
        [buttonLeft addTarget:self action:@selector(buttonLeftTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLeft];
        
        buttonRight = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2, 64, [[UIScreen mainScreen]bounds].size.width/2, 50)];
        [buttonRight setBackgroundImage:[UIImage imageNamed:@"icon_6_unpress_right"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(buttonRightTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.buttonRight];
    }
    else{
        buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width/2, 56)];
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"icon_6_press_left"] forState:UIControlStateNormal];
        [buttonLeft addTarget:self action:@selector(buttonLeftTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonLeft];
        
        buttonRight = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2, 64, [[UIScreen mainScreen]bounds].size.width/2, 56)];
        [buttonRight setBackgroundImage:[UIImage imageNamed:@"icon_6_unpress_right"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(buttonRightTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.buttonRight];
    }

    viewFrame =  CGRectMake(0, 64+buttonLeft.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64-49-buttonLeft.frame.size.height);
    rightViewFrame = CGRectMake([[UIScreen mainScreen] bounds].size.width,64+buttonRight.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-(64+buttonRight.frame.size.height+49));
    leftViewFrame = CGRectMake(-[[UIScreen mainScreen] bounds].size.width,64+buttonRight.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-(64+buttonRight.frame.size.height+49));
    
    self.viewLeft = [[UIView alloc]initWithFrame:viewFrame];//创建左侧视图
    self.viewRight = [[UIView alloc] initWithFrame:rightViewFrame];//创建右侧视图
    [self.view addSubview:self.viewLeft];
    [self.view addSubview:self.viewRight];//将左右视图加入到view中
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bt1Clicked:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bt2Clicked:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bt3Clicked:)];

    if ([[UIScreen mainScreen]bounds].size.height>479&&[[UIScreen mainScreen]bounds].size.height<481) {
        CGRect pt1Frame = CGRectMake(0, 0, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt2Frame = CGRectMake(0, self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt3Frame = CGRectMake(0, 2*self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);

        bt1 = [[UIImageView alloc]initWithFrame:pt1Frame];
        bt1.image = [UIImage imageNamed:@"4s-抑郁"];
        bt1.tag = 1;
        [bt1 addGestureRecognizer:tap1];
        [bt1 setUserInteractionEnabled:YES];
        [self.view addSubview:bt1];
        
        bt2 = [[UIImageView alloc]initWithFrame:pt2Frame];
        bt2.image = [UIImage imageNamed:@"4s-焦虑"];
        bt2.tag = 2;
        [bt2 addGestureRecognizer:tap2];
        [bt2 setUserInteractionEnabled:YES];
        [self.view addSubview:bt2];
        
        bt3 = [[UIImageView alloc]initWithFrame:pt3Frame];
        bt3.image = [UIImage imageNamed:@"4s-SQL"];
        bt3.tag = 3;
        [bt3 addGestureRecognizer:tap3];
        [bt3 setUserInteractionEnabled:YES];
        [self.view addSubview:bt3];
    }
    else if([[UIScreen mainScreen]bounds].size.height>567&&[[UIScreen mainScreen]bounds].size.height<570){
        CGRect pt1Frame = CGRectMake(0, 0, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt2Frame = CGRectMake(0, self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt3Frame = CGRectMake(0, 2*self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        bt1 = [[UIImageView alloc]initWithFrame:pt1Frame];
        bt1.image = [UIImage imageNamed:@"5s-抑郁"];
        bt1.tag = 1;
        [bt1 addGestureRecognizer:tap1];
        [bt1 setUserInteractionEnabled:YES];
        [self.view addSubview:bt1];

        bt2 = [[UIImageView alloc]initWithFrame:pt2Frame];
        bt2.image = [UIImage imageNamed:@"5s-焦虑"];
        bt2.tag = 2;
        [bt2 addGestureRecognizer:tap2];
        [bt2 setUserInteractionEnabled:YES];
        [self.view addSubview:bt2];

        bt3 = [[UIImageView alloc]initWithFrame:pt3Frame];
        bt3.image = [UIImage imageNamed:@"5s-SQL"];
        bt3.tag = 3;
        [bt3 addGestureRecognizer:tap3];
        [bt3 setUserInteractionEnabled:YES];
        [self.view addSubview:bt3];


    }
    else if ([[UIScreen mainScreen]bounds].size.height>666&&[[UIScreen mainScreen]bounds].size.height<670){
        CGRect pt1Frame = CGRectMake(0, 0, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt2Frame = CGRectMake(0, self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt3Frame = CGRectMake(0, 2*self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
      
        
        bt1 = [[UIImageView alloc]initWithFrame:pt1Frame];
        bt1.image = [UIImage imageNamed:@"6s-抑郁"];
        bt1.tag = 1;
        [bt1 addGestureRecognizer:tap1];
        [bt1 setUserInteractionEnabled:YES];
        [self.view addSubview:bt1];
        
        bt2 = [[UIImageView alloc]initWithFrame:pt2Frame];
        bt2.image = [UIImage imageNamed:@"6s-焦虑"];
        bt2.tag = 2;
        [bt2 addGestureRecognizer:tap2];
        [bt2 setUserInteractionEnabled:YES];
        [self.view addSubview:bt2];
        
        bt3 = [[UIImageView alloc]initWithFrame:pt3Frame];
        bt3.image = [UIImage imageNamed:@"6s-SQL"];
        bt3.tag = 3;
        [bt3 addGestureRecognizer:tap3];
        [bt3 setUserInteractionEnabled:YES];
        [self.view addSubview:bt3];
    }
    else{
        CGRect pt1Frame = CGRectMake(0, 0, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt2Frame = CGRectMake(0, self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        CGRect pt3Frame = CGRectMake(0, 2*self.viewLeft.frame.size.height/3, KDeviceWidth, self.viewLeft.frame.size.height/3);
        bt1 = [[UIImageView alloc]initWithFrame:pt1Frame];
        bt1.image = [UIImage imageNamed:@"6+-抑郁"];
        bt1.tag = 1;
        [bt1 addGestureRecognizer:tap1];
        [bt1 setUserInteractionEnabled:YES];
        [self.view addSubview:bt1];
        
        bt2 = [[UIImageView alloc]initWithFrame:pt2Frame];
        bt2.image = [UIImage imageNamed:@"6+-焦虑"];
        bt2.tag = 2;
        [bt2 addGestureRecognizer:tap2];
        [bt2 setUserInteractionEnabled:YES];
        [self.view addSubview:bt2];
        
        bt3 = [[UIImageView alloc]initWithFrame:pt3Frame];
        bt3.image = [UIImage imageNamed:@"6+-SQL"];
        bt3.tag = 3;
        [bt3 addGestureRecognizer:tap3];
        [bt3 setUserInteractionEnabled:YES];
        [self.view addSubview:bt3];
    }

    [self.viewLeft addSubview:bt1];
    [self.viewLeft addSubview:bt2];
    [self.viewLeft addSubview:bt3];
    
    bottomSquare = [[UIImageView alloc]initWithFrame:CGRectMake(0, buttonLeft.frame.origin.y+buttonLeft.frame.size.height-3, [[UIScreen mainScreen] bounds].size.width/2,3)];
    bottomSquare.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bottomSquare];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *databaseFilePath = [documentDirectory stringByAppendingPathComponent:@"CoreDataQuestions"];
    NSLog(@"databse--->%@",databaseFilePath);

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)bt1Clicked:(UITapGestureRecognizer *)recognizer{
    UIAlertView *willBeginSASTest = [[UIAlertView alloc]initWithTitle:@"您即将进行抑郁症自我测试" message:@"请根据近期情况准确回答，您的答案将被加密保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开始测试", nil];
    willBeginSASTest.tag = 1;
    [willBeginSASTest show];
}

-(void)bt2Clicked:(UITapGestureRecognizer *)recognizer{
    UIAlertView *willBeginSDSTest = [[UIAlertView alloc]initWithTitle:@"您即将进行焦虑症自我测试" message:@"请根据近期情况准确回答，您的答案将被加密保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开始测试", nil];
    willBeginSDSTest.tag = 2;
    [willBeginSDSTest show];
}

-(void)bt3Clicked:(UITapGestureRecognizer *)recognizer{
    UIAlertView *willBeginSCLTest = [[UIAlertView alloc]initWithTitle:@"您即将进行SCL90综合测试" message:@"请根据近期情况准确回答，您的答案将被加密保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"开始测试", nil];
    willBeginSCLTest.tag = 3;
    [willBeginSCLTest show];
}




-(void)change1Color:(UITapGestureRecognizer *)recognizer{
    bt1.backgroundColor = [UIColor grayColor];
}
-(void)change2Color:(UITapGestureRecognizer *)recognizer{
    bt2.backgroundColor = [UIColor grayColor];
}
-(void)change3Color:(UITapGestureRecognizer *)recognizer{
    bt3.backgroundColor = [UIColor grayColor];
}

-(void)DoLike
{
    [table reloadData];
}

-(void)buttonRightTouched{
    UIImage *imageLeft = [[UIImage alloc]init];
    UIImage *imageRight = [[UIImage alloc]init];
    if ([[UIScreen mainScreen]bounds].size.height>479&&[[UIScreen mainScreen]bounds].size.height<481) {
        imageLeft = [UIImage imageNamed:@"icon_4s_unpress_left"];
        imageRight = [UIImage imageNamed:@"icon_4s_press_right"];
    }
    else if([[UIScreen mainScreen]bounds].size.height>567&&[[UIScreen mainScreen]bounds].size.height<570){
        imageLeft = [UIImage imageNamed:@"icon_5s_unpress_left"];
        imageRight = [UIImage imageNamed:@"icon_5s_press_right"];
    }
    else{
        imageLeft = [UIImage imageNamed:@"icon_6_unpress_left"];
        imageRight = [UIImage imageNamed:@"icon_6_press_right"];
    }
    [self.buttonLeft setBackgroundImage:imageLeft forState:UIControlStateNormal];
    [self.buttonRight setBackgroundImage:imageRight forState:UIControlStateNormal];
    if (!self.isTableViewExisted) {
        table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - offset)];
        table.contentSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width, cellHeight * 19);
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.scrollEnabled = YES;
        table.bounces = NO;
        [self.viewRight addSubview:table];
        self.isTableViewExisted = YES;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    bottomSquare.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2,buttonLeft.frame.origin.y+buttonLeft.frame.size.height-3, [[UIScreen mainScreen] bounds].size.width/2,3);
    self.viewRight.frame = viewFrame;
    [UIImageView commitAnimations];
    
    self.viewLeft.frame = leftViewFrame;
    


    
}

-(void)buttonLeftTouched{
    UIImage *imageLeft = [[UIImage alloc]init];
    UIImage *imageRight = [[UIImage alloc]init];
    if ([[UIScreen mainScreen]bounds].size.height>479&&[[UIScreen mainScreen]bounds].size.height<481) {
        imageLeft = [UIImage imageNamed:@"icon_4s_press_left"];
        imageRight = [UIImage imageNamed:@"icon_4s_unpress_right"];
    }
    else if([[UIScreen mainScreen]bounds].size.height>567&&[[UIScreen mainScreen]bounds].size.height<570){
        imageLeft = [UIImage imageNamed:@"icon_5s_press_left"];
        imageRight = [UIImage imageNamed:@"icon_5s_unpress_right"];
    }
    else{
        imageLeft = [UIImage imageNamed:@"icon_6_press_left"];
        imageRight = [UIImage imageNamed:@"icon_6_unpress_right"];
    }
    [self.buttonLeft setBackgroundImage:imageLeft forState:UIControlStateNormal];
    [self.buttonRight setBackgroundImage:imageRight forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    bottomSquare.frame = CGRectMake(0,buttonLeft.frame.origin.y+buttonLeft.frame.size.height-3, [[UIScreen mainScreen] bounds].size.width/2,3);
    self.viewLeft.frame = viewFrame;
    [UIView commitAnimations];
    self.viewRight.frame = rightViewFrame;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex    //设置每个section的cell个数
{
    return 19;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    TestCell *cell = (TestCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];//plist文件位置
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
    NSDictionary *testItem;
    
    cell.heart.tag = indexPath.row;
    NSString *string = [[NSString alloc] initWithFormat:@"%@%d",@"item", cell.heart.tag];
    testItem = [plistDictionary objectForKey:string];
    cell.title.text = [testItem objectForKey:@"title"];
    cell.title.font = [UIFont boldSystemFontOfSize:TextFont];
    cell.picture.image = [UIImage imageNamed:[testItem objectForKey:@"image"]];
    [cell.heart setImage:[UIImage imageNamed:[testItem objectForKey:@"heart"]] forState:UIControlStateNormal];
    [cell.heart addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)like:(id)sender{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];//plist文件位置
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
    NSDictionary *testItem;
    UIButton* button = (UIButton*)sender;
    int btnTag = [button tag];
    NSString *string = [[NSString alloc] initWithFormat:@"%@%d",@"item", btnTag];
    testItem = [plistDictionary objectForKey:string];
    if ([[testItem objectForKey:@"heart"] isEqual: @"heart1"]) {
        [testItem setValue:@"heart2" forKey:@"heart"];
    } else {
        [testItem setValue:@"heart1" forKey:@"heart"];
    }
    [plistDictionary writeToFile:documentPlistPath atomically:YES];
    [button setImage:[UIImage imageNamed:[testItem objectForKey:@"heart"]] forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1 && buttonIndex == 1) {
        bt1.backgroundColor = [UIColor whiteColor];
        test = [[YiYuTestViewController alloc]initWithKind:@"SAS"];//创建测试界面视图
        test.view.backgroundColor = [UIColor whiteColor];//设置背景颜色为白色
        test.title = @"抑郁自测";
        test.kind = @"SAS";
        choosedKind = @"SAS";
        [self.navigationController pushViewController:test animated:YES];
        test.delegate = self;
        
        temp = [[NSMutableArray alloc]init];
        NSInteger i =1;
        for (i = 1; i <= 20; i++) {
            NSString *tempString = [NSString stringWithFormat:@"%ld",(long)i];
            [temp addObject:tempString];
        }
        test.tags = temp;
        test.tag = [temp objectAtIndex:0];
    }
    if(alertView.tag == 2 && buttonIndex == 1){
        bt2.backgroundColor = [UIColor whiteColor];
        test = [[YiYuTestViewController alloc]initWithKind:@"SDS"];//创建测试界面视图
        test.view.backgroundColor = [UIColor whiteColor];//设置背景颜色为白色
        test.title = @"焦虑自测";
        test.kind = @"SDS";
        choosedKind = @"SDS";
        test.tag = [[NSMutableString alloc]initWithFormat:@"1"];
        [self.navigationController pushViewController:test animated:YES];
        test.delegate = self;
        
        temp = [[NSMutableArray alloc]init];
        NSInteger i =1;
        for (i = 1; i <= 20; i++) {
            NSString *tempString = [NSString stringWithFormat:@"%ld",(long)i];
            [temp addObject:tempString];
        }
        test.tags = temp;
        test.tag = [temp objectAtIndex:0];
    }
    if(alertView.tag == 3 && buttonIndex == 1){
        bt3.backgroundColor = [UIColor whiteColor];
        test = [[YiYuTestViewController alloc]initWithKind:@"SCL"];//创建测试界面视图
        test.view.backgroundColor = [UIColor whiteColor];//设置背景颜色为白色
        test.title = @"SCL自测";
        test.kind = @"SCL";
        choosedKind = @"SCL";
        choosedSubKind = @"general";
        test.tag = [[NSMutableString alloc]initWithFormat:@"1"];
        [self.navigationController pushViewController:test animated:YES];
        test.delegate = self;
        
        temp = [[NSMutableArray alloc]init];
        NSInteger i =1;
        for (i = 1; i <= 90; i++) {
            NSString *tempString = [NSString stringWithFormat:@"%ld",(long)i];
            [temp addObject:tempString];
        }
        test.tags = temp;
        test.tag = [temp objectAtIndex:0];
    }
}

-(void)submit{
    NSMutableArray *answers = [manager findAnswersbyKind:choosedKind andTags:temp];
    result = [[testAnalysisViewController alloc]initWithAnswers:answers];
    result.tags = temp;
    result.kind = choosedKind;
    result.subKind = choosedSubKind;
    result.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:result animated:YES];
}



//222222222
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *head;
    UIImage *picture;
    NSString *explain;
    NSString *choiceA;
    NSString *choiceB;
    NSString *choiceC;
    NSString *choiceD;
    NSString *choiceAans;
    NSString *choiceBans;
    NSString *choiceCans;
    NSString *choiceDans;
    
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"];
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plist];
    NSDictionary *testItem;
    NSString *string = [[NSString alloc] initWithFormat:@"%@%d",@"item", indexPath.row];
    testItem = [plistDictionary objectForKey:string];
    explain = [testItem objectForKey:@"explain"];
    
    if (![explain isEqualToString: @""]) {
        head = [testItem objectForKey:@"head"];
        picture = [UIImage imageNamed:[testItem objectForKey:@"picture"]];
        funnyTest = [[FunnyTestViewController alloc]initWithHead:head picture:picture explain:explain index:indexPath.row];
    } else {
        head = [testItem objectForKey:@"head"];
        picture = [UIImage imageNamed:[testItem objectForKey:@"picture"]];
        choiceA = [testItem objectForKey:@"A"];
        choiceB = [testItem objectForKey:@"B"];
        choiceC = [testItem objectForKey:@"C"];
        choiceD = [testItem objectForKey:@"D"];
        choiceAans = [testItem objectForKey:@"Aans"];
        choiceBans = [testItem objectForKey:@"Bans"];
        choiceCans = [testItem objectForKey:@"Cans"];
        choiceDans = [testItem objectForKey:@"Dans"];
        funnyTest = [[FunnyTestViewController alloc]initWithHead:head picture:picture choiceA:choiceA choiceB:choiceB choiceC:choiceC choiceD:choiceD choiceAans:choiceAans choiceBans:choiceBans choiceCans:choiceCans choiceD:choiceDans index:indexPath.row];
    }
    funnyTest.delegate = self;
    funnyTest.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:funnyTest animated:YES];
    
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
