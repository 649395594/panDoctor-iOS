//
//  MyScollViewController.m
//  SlideView
//
//  Created by zxy on 14/12/6.
//  Copyright (c) 2014年 Chen Yaoqiang. All rights reserved.
//

#import "MyScollViewController.h"
#import "ScrollableTable.h"
@interface MyScollViewController ()

@end

@implementation MyScollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNameArray:(NSArray *)nameArray diseaseArray:(NSArray*)diseaseArray AndTables:(NSMutableArray *)tables{
    
    UIImageView *topShadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 5)];
    [topShadowImageView setImage:[UIImage imageNamed:@"top_background_shadow.png"]];
    [self.view addSubview:topShadowImageView];
    
    SVTopScrollView *topScrollView = [SVTopScrollView shareInstance];
    SVRootScrollView *rootScrollView = [SVRootScrollView shareInstance];
    
    topScrollView.nameArray = nameArray;
    rootScrollView.viewNameArray = nameArray;
    
    topScrollView.diseaseArray = diseaseArray;
    
    rootScrollView.tables = tables;
    topScrollView.tables = tables;
    
    if ([rootScrollView.viewNameArray count] == [rootScrollView.tables count]) {
        [rootScrollView initWithTables];
    }
    
    if ([[UIScreen mainScreen]bounds].size.width<=320) {
        UIImageView *topCutOff = [[UIImageView alloc]initWithFrame:CGRectMake(0, 31.5, 570, 0.5)];
        topCutOff.backgroundColor = [UIColor grayColor];
        [topScrollView addSubview:topCutOff];
    }
    else if ([[UIScreen mainScreen]bounds].size.width >320&&[[UIScreen mainScreen]bounds].size.width<=375) {
        UIImageView *topCutOff = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, 570, 0.5)];
        topCutOff.backgroundColor = [UIColor grayColor];
        [topScrollView addSubview:topCutOff];
    }
    else{
        UIImageView *topCutOff = [[UIImageView alloc]initWithFrame:CGRectMake(0, 47.5, 570, 0.5)];
        topCutOff.backgroundColor = [UIColor grayColor];
        [topScrollView addSubview:topCutOff];
    }
    
    [self.view addSubview:topScrollView];
    [self.view addSubview:rootScrollView];
    [topScrollView initWithNameButtons];
    return self;
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
