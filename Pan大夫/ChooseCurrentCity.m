//
//  ChooseCurrentCity.m
//  Pan大夫
//
//  Created by tiny on 15/3/24.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "ChooseCurrentCity.h"
#import "AppDelegate.h"
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
@interface ChooseCurrentCity()
@property (strong, nonatomic) UITableView *cityTable;
@property (strong, nonatomic) NSMutableArray *cityList;
@property (strong, nonatomic) NSString *currentCity;
@end
@implementation ChooseCurrentCity
@synthesize cityTable;
@synthesize cityList;
@synthesize currentCity;
@synthesize homeDelegate;

- (id)initWithCurrentCity:(NSString *)city HomeDelegate:(HomeViewController *)delegate{
    self = [super init];
    if (self) {
        currentCity = city;
        homeDelegate = delegate;
        cityTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 84, KDeviceWidth, KDeviceHeight)];
        cityTable.dataSource = self;
        cityTable.delegate = self;
        cityTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        cityList = [[NSMutableArray alloc]initWithObjects:@"北京",@"沈阳",@"大连", nil];
        [self.view addSubview:cityTable];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, 64+20)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 20, 200, 50)];
        titleLabel.font = [UIFont systemFontOfSize:24];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"选择城市";
        [headerView addSubview:titleLabel];
        
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 35, 40, 30)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [cancelButton addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:cancelButton];
        
        [self.view addSubview:headerView];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return [cityList count];
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = currentCity;
            break;
        case 1:
            cell.textLabel.text = [cityList objectAtIndex:indexPath.row];
        default:
            break;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"定位城市";
            break;
        case 1:
            return @"目前开通城市";
            break;
        default:
            return @"Unknown";
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *choosedCity = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    //将所选择城市写入plist文件
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
    [currentPosition setObject:choosedCity forKey:@"defaultCity"];
    [plistDictionary writeToFile:[self getFilePath] atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getCurrentCity"object:nil];
    [homeDelegate.leftButton setTitle:choosedCity forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelEvent{
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
    NSMutableDictionary *currentPosition = [plistDictionary objectForKey:@"currentPosition"];
    [homeDelegate.leftButton setTitle:[currentPosition objectForKey:@"defaultCity"] forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)getFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    return documentPlistPath;
}

@end
