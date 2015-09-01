//
//  InformationViewController.m
//  New-part
//
//  Created by xuyaowen on 15/3/14.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import "InformationViewController.h"
#import "MyTableView.h"

#define wordColor colorWithRed:0.004 green:0.639 blue:0.620 alpha:1

@interface InformationViewController ()

@property (nonatomic, strong) NSIndexPath* myMyIndex;
@property (nonatomic, strong) MyTableView *table;
@property (nonatomic, strong) NSMutableArray *defaultPatient;
@property (nonatomic, strong) NSMutableArray *backupPatients;
@property (nonatomic, strong) detailView *detail;
@end

@implementation InformationViewController
@synthesize table, tmpOfPatient,tmpOfPatient1;
@synthesize defaultPatient,backupPatients;
@synthesize detail;

- (id) initWithPath:(NSString* ) path{
    self = [self init];
    if(self){
        
        self.callPath = path;
        tmpOfPatient1 = [[Patient alloc] init];
        
        self.view.backgroundColor = [UIColor colorWithRed:0.941 green:0.937 blue:0.957 alpha:1];
        
        //界面底部的 新增信息 的button的设置style；
        UIButton* footerButton = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
        [footerButton setTitle:@"新增信息" forState:UIControlStateNormal];
        footerButton.frame = CGRectMake(10, self.view.frame.size.height-50, self.view.frame.size.width-20, 40);
        
        footerButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        footerButton.backgroundColor = [UIColor colorWithRed:0.004 green:0.639 blue:0.620 alpha:1];
        footerButton.tintColor = [UIColor whiteColor];
        footerButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        footerButton.layer.cornerRadius = 5;
        footerButton.layer.masksToBounds = NO;
        [footerButton addTarget:self action:@selector(addNewer) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:footerButton];
        
        defaultPatient = [[NSMutableArray alloc]init];
        backupPatients = [[NSMutableArray alloc]init];
        [self readPatientsFromDatabase];
        
        [self.view addSubview:table];
        // Do any additional setup after loading the view.
        
        table.rootVC = self;
        table.path = path;
    }
    
    return self;
    
    
}


-(void) cancel{
    NSLog(@"取消情况！");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//用于以后来测试 delegate 来传参用于测试传参的状态！
-(void) printf{
    NSLog(@"你执行了 printf 函数！");
    NSLog(@"%@", tmpOfPatient1);
    [self.table reloadData];
}

//用于界面跳转；跳转到用户信息登记的界面
-(void) jump:(NSIndexPath *) cellIndex{
    NSMutableArray* tmpArray = [[NSMutableArray alloc] initWithArray:[self.table.patientsInformation objectAtIndex:cellIndex.section]];
    Patient *p2 = [[Patient alloc] initWithPatient:[tmpArray objectAtIndex:cellIndex.row]];
    tmpOfPatient = [[Patient alloc] initWithPatient:p2];
    NSLog(@"%@",p2.age);
    NSInteger num = 1;
    if([tmpOfPatient.sex  isEqual: @"male.jpg"]){
        num = 1;
    }else{
        num = 0;
    }
    
    
    detail = [[detailView alloc] initWithUser:tmpOfPatient.name Age:tmpOfPatient.age Del:tmpOfPatient.tel Provience:tmpOfPatient.province Neighborhood:tmpOfPatient.neighborhood DoorNum:tmpOfPatient.doorNum SexNum:num];

    
    self.myMyIndex = cellIndex;
    detail.path = self.callPath;
    detail.action =0;
    detail.dele = self.table;
    detail.Lat = p2.lat;
    detail.Lng = p2.lng;
    NSLog(@"初始化的时候lat = %lf",p2.lat);
    NSLog(@"初始化的时候lng = %lf",p2.lng);
    detail.myMyIndexPath = self.myMyIndex;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

// 响应的事件为 新增信息的button的响应！
-(void) addNewer{
    NSLog(@"你选择了新增信息！");
    detail = [[detailView alloc] initWithUser:@"" Age:@"" Del:@"" Provience:@"" Neighborhood:@"" DoorNum:@"" SexNum:1];
    detail.data = tmpOfPatient;
    detail.dele = self.table;
    detail.action = 1;
    [self.navigationController pushViewController:detail animated:YES];
    [table reloadData];
    
}

- (void)readPatientsFromDatabase{
    [defaultPatient removeAllObjects];
    [backupPatients removeAllObjects];
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];//读取数据库字典
    NSMutableArray *array = [plistDictionary objectForKey:@"patients"];
    NSLog(@"have %d patients",[array count]);
    if (!array) {
        //设置中间的设置表
        table = [[MyTableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-74-60) style:UITableViewStylePlain DefaultUser:nil BackUpUsers:nil];
    }
    else{
        for (NSDictionary *patient in array) {
            NSString *isDefault = [patient objectForKey:@"isDefault"];
            double lng = [[patient objectForKey:@"lng"]doubleValue];
            double lat = [[patient objectForKey:@"lat"]doubleValue];
            Patient *p = [[Patient alloc]initWithName:[patient objectForKey:@"patientName"] Tel:[patient objectForKey:@"patientTel"] Age:[patient objectForKey:@"patientAge"] Address:[patient objectForKey:@"patientAddress"] Location:[patient objectForKey:@"patientLocation"] Sex:[patient objectForKey:@"patientSex"] DoorNum:[patient objectForKey:@"patientDoorNum"] Province:[patient objectForKey:@"patientProvince"] Neigh:[patient objectForKey:@"patientNeighbourhood"] Default:[patient objectForKey:@"isDefault"] Lng:lng Lat:lat];
            if ([isDefault isEqualToString:@"yes"]) {
                [defaultPatient addObject:p];
            }
            else{
                [backupPatients addObject:p];
            }
        }
        if ([defaultPatient count] > 0) {
            //设置中间的设置表
            table = [[MyTableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-74-60) style:UITableViewStylePlain DefaultUser:[defaultPatient objectAtIndex:0] BackUpUsers:backupPatients];
        }
        else{
            //设置中间的设置表
            table = [[MyTableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-74-60) style:UITableViewStylePlain DefaultUser:nil BackUpUsers:backupPatients];
        }
    }
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
