//
//  ResourcesViewController.m
//  IOS
//
//  Created by Kt on 14-8-20.
//  Copyright (c) 2014年 neu. All rights reserved.
//

#import "ResourcesViewController.h"
#import "MyScollViewController.h"
#import "SVTopScrollView.h"
#import "scrollableTable.h"
#import "NewsDetailViewController.h"

#define kCellCount 10
@interface ResourcesViewController (){
    NSInteger count;
    
}
@property (strong, nonatomic) NSMutableArray *tables;


@property (strong, nonatomic) NSMutableArray *cellTitles;//存储文章标题的数组
@property (weak, nonatomic) UITableView *table;

@end

@implementation ResourcesViewController

@synthesize table,tables,cellTitles;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSArray *nameArray = [[NSArray alloc]initWithObjects:@"抑郁症",@"焦虑症",@"疑病症",@"强迫症",@"妄想症",@"恐惧症",@"健忘症",@"多动症",nil];
    cellTitles = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    NSArray *diseaseArray = [[NSArray alloc]initWithObjects:@"depression",@"anxiety",@"hypochondria",@"obsession",@"paranoid",@"phobia",@"amnesia",@"ADHD",nil];
    
    scrollableTable *table1 = [[scrollableTable alloc]initWithNavPushController:self];
    scrollableTable *table2 = [[scrollableTable alloc]initWithNavPushController:self];
    scrollableTable *table3 = [[scrollableTable alloc]initWithNavPushController:self];
    scrollableTable *table4 = [[scrollableTable alloc]initWithNavPushController:self];
    scrollableTable *table5 = [[scrollableTable alloc]initWithNavPushController:self];
    scrollableTable *table6 = [[scrollableTable alloc]initWithNavPushController:self];
    scrollableTable *table7 = [[scrollableTable alloc]initWithNavPushController:self];
    scrollableTable *table8 = [[scrollableTable alloc]initWithNavPushController:self];
    
    tables = [NSMutableArray arrayWithObjects:table1,table2,table3,table4,table5,table6,table7,table8,nil];
    MyScollViewController *myScrollViewController = [[MyScollViewController alloc]initWithNameArray:nameArray diseaseArray:diseaseArray AndTables:tables];
    [self.view addSubview:myScrollViewController.view];
    [table1 refreshTable];
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cellTapedWithId:(NSString*)Id{
    NewsDetailViewController *detailViewController = [[NewsDetailViewController alloc]initWithId:Id];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end