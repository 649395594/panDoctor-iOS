//
//  ViewController.m
//  New-part
//
//  Created by xuyaowen on 15/3/13.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import "MyTableView.h"

#import "InformationViewController.h"
#import "HomeViewController.h"
#define ButtonHeight 40
#define wordColor colorWithRed:0.004 green:0.639 blue:0.620 alpha:1

@interface MyTableView ()



@end

@implementation MyTableView
@synthesize action;
@synthesize patientsInformation;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style DefaultUser:(Patient *)defaulPatient BackUpUsers:(NSMutableArray *)backupPatients{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.defaultInformationArray = [[NSMutableArray alloc]init];
        self.backupInformationArray = [[NSMutableArray alloc]init];
        if (defaulPatient) {
            self.defaultInformationArray = [[NSMutableArray alloc]initWithObjects:defaulPatient, nil];
        }
        if (backupPatients) {
             self.backupInformationArray = backupPatients;
        }
       
        patientsInformation = [[NSMutableArray alloc]initWithObjects:self.defaultInformationArray,self.backupInformationArray, nil];
        self.backgroundColor = [UIColor colorWithRed:0.941 green:0.937 blue:0.957 alpha:1];
        
        
        self.backgroundColor =[UIColor whiteColor];
        
        self.delegate  = self;
        self.dataSource =self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.backgroundColor = [UIColor colorWithRed:0.941 green:0.937 blue:0.957 alpha:1];
    }
    return self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellForUserTableViewCell *cell =  (CellForUserTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    float height = cell.fieldOfAddress.frame.size.height + cell.fieldOfAddress.frame.origin.y + 29;
    return (height > 275 ? height : 275);
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return [self.defaultInformationArray count];
            break;
            
        case 1:
            return [self.backupInformationArray count];
            break;
        default:
            return 0;
            break;
    }
}

-(NSString* ) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"默认信息";
            break;
        case 1:
            return @"备选信息";
            break;
        default:
            return @"Unknow";
            break;
    }
}

- (UITableViewCell* ) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIndentifier = @"Cell";
    
    CellForUserTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    int row = (int)[indexPath row];
    int sectionNumber = (int)indexPath.section;
    NSMutableArray *patients = [patientsInformation objectAtIndex:sectionNumber];
    Patient *patient = [patients objectAtIndex:row];
    if(cell == nil){
        cell = [[ CellForUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier index:indexPath ID:indexPath.section];

    }
    
    cell.labelOfName.text = patient.name;
    
    cell.fieldOfAge.text = patient.age;
    
    cell.fieldOfPhone.text = patient.tel;
    
    cell.fieldOfLocation.text = patient.location;
    
    cell.fieldOfAddress.text = patient.address;

    [cell.leftBtn setTitle:patient.defaultInfo forState:UIControlStateNormal];

    if(indexPath.section == 0){
        //cell.leftBtn.titleLabel.text = @"已为默认";
        [cell.leftBtn setTitle:@"设为默认" forState:UIControlStateNormal];
    }
    if(indexPath.section == 1){
        //cell.leftBtn.titleLabel.text = @"已为默认";
        [cell.leftBtn setTitle:@"设为默认" forState:UIControlStateNormal];
    }
    cell.myIndexPath = indexPath;
    cell.layer.cornerRadius = 5;
    
    [self adjustCell:cell];
    
    cell.layer.masksToBounds = YES;
    [cell setsexImage:patient.sex];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"你选择了一行");
}


- (NSString* ) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(action == 1){
        return  NO;
    }
    return YES;
    
}



//完善删除功能，注意要同时删掉相对应的本地存储！！！lf改动

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.backupInformationArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)setDefaultInformationAtIndex:(NSIndexPath *)index{

    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForRow:index.row inSection:1];

    Patient *p1 = [self.backupInformationArray objectAtIndex:index.row];
    Patient *move = [[Patient alloc]initWithPatient:p1];
    [self.backupInformationArray removeObjectAtIndex:index.row];
    [self.defaultInformationArray insertObject:move atIndex:0];
    [self moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    move.defaultInfo = @"设为默认";
    
    if ([self.defaultInformationArray count] > 1) {
        Patient *p2 = [self.defaultInformationArray objectAtIndex:1];
        
        p2.defaultInfo = @"设为默认";
        
        destinationIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        sourceIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.backupInformationArray insertObject:p2 atIndex:0];
        [self.defaultInformationArray removeObjectAtIndex:1];
        [self moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
    [self writeDataIntoDatabase];
    if ([self.path isEqualToString:@"in"]) {
        NSMutableDictionary *location = [[NSMutableDictionary alloc]init];
        NSString *lng = [NSString stringWithFormat:@"%lf",p1.lng];
        NSString *lat = [NSString stringWithFormat:@"%lf",p1.lat];
        [location setObject:lng forKey:@"lng"];
        [location setObject:lat forKey:@"lat"];
        [location setObject:p1.neighborhood forKey:@"patientNeighbourhood"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseDefaultAddress"object:location];
        NSLog(@"in neighborhood sent = %@",p1.neighborhood);
    }
    if ([self.path isEqualToString:@"out"]) {
        NSMutableDictionary *location = [[NSMutableDictionary alloc]init];
        NSString *lng = [NSString stringWithFormat:@"%lf",p1.lng];
        NSString *lat = [NSString stringWithFormat:@"%lf",p1.lat];
        [location setObject:lng forKey:@"lng"];
        [location setObject:lat forKey:@"lat"];
        [location setObject:p1.neighborhood forKey:@"patientNeighbourhood"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseDefaultAddress"object:location];
        NSLog(@"neighborhood sent = %@",p1.neighborhood);
        [self.rootVC.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    //允许移动
    return YES;
}

-(void) setCell:(NSIndexPath *) selectedIndexPath{
    
    [self.rootVC jump:selectedIndexPath];
    
}

- (void)setRootDelegate:(InformationViewController *)delegate{
    self.rootVC = delegate;
}

- (void)adjustCell:(CellForUserTableViewCell *)cell{
    [cell.fieldOfAddress flashScrollIndicators];   // 闪动滚动条
    
    static CGFloat maxHeight = 130.0f;
    CGRect frame = cell.fieldOfAddress.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [cell.fieldOfAddress sizeThatFits:constraintSize];
    if (size.height >= maxHeight)
    {
        size.height = maxHeight;
        cell.fieldOfAddress.scrollEnabled = YES;   // 允许滚动
    }
    else
    {
        cell.fieldOfAddress.scrollEnabled = NO;    // 不允许滚动，当textview的大小足以容纳它的text的时候，需要设置scrollEnabed为NO，否则会出现光标乱滚动的情况
    }
    cell.fieldOfAddress.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    
    //文字内容垂直居中
    CGFloat topCorrect = ([cell.fieldOfAddress bounds].size.height - [cell.fieldOfAddress contentSize].height);
    topCorrect = (topCorrect <0.0 ?0.0 : topCorrect);
    cell.fieldOfAddress.contentOffset = (CGPoint){.x =0, .y = -topCorrect/2};
    
    [cell.footerView setFrame:CGRectMake(0, cell.fieldOfAddress.frame.size.height + cell.fieldOfAddress.frame.origin.y + 9, [[UIScreen mainScreen]bounds].size.width, 25)];
}

- (void)writeDataIntoDatabase{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"login.plist"];//plist文件位置
    
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];//读取数据库字典
    NSMutableArray *array = [plistDictionary objectForKey:@"patients"];
    if (!array) {
        array = [[NSMutableArray alloc]init];
    }
    else{
        [array removeAllObjects];
    }

    if ([self.defaultInformationArray count] > 0) {
        Patient *p = [self.defaultInformationArray objectAtIndex:0];
        NSLog(@"last p = %@",p);
        NSLog(@"last lng = %lf",p.lng);
        NSLog(@"last lat = %lf",p.lat);
        NSString *stringLng = [NSString stringWithFormat:@"%lf",p.lng];
        NSString *stringLat = [NSString stringWithFormat:@"%lf",p.lat];
        NSMutableDictionary *newPatient = [[NSMutableDictionary alloc]initWithObjectsAndKeys:p.name,@"patientName",p.age,@"patientAge",p.tel,@"patientTel",p.province,@"patientProvince",p.neighborhood, @"patientNeighbourhood",p.doorNum,@"patientDoorNum",@"yes",@"isDefault",p.sex,@"patientSex",p.address,@"patientAddress",p.location,@"patientLocation",stringLng,@"lng",stringLat,@"lat", nil];
        [array addObject:newPatient];
    }
    for (Patient *p in self.backupInformationArray) {
        NSLog(@"备用地址写入数据库");
        NSLog(@"写入备用数据时 lng = %lf",p.lng);
        NSLog(@"写入备用数据时 lat = %lf",p.lat);
        NSString *stringLng = [NSString stringWithFormat:@"%lf",p.lng];
        NSString *stringLat = [NSString stringWithFormat:@"%lf",p.lat];
        NSMutableDictionary *newPatient = [[NSMutableDictionary alloc]initWithObjectsAndKeys:p.name,@"patientName",p.age,@"patientAge",p.tel,@"patientTel",p.province,@"patientProvince",p.neighborhood, @"patientNeighbourhood",p.doorNum,@"patientDoorNum",@"no",@"isDefault",p.sex,@"patientSex",p.address,@"patientAddress",p.location,@"patientLocation",stringLng,@"lng",stringLat,@"lat", nil];
        [array addObject:newPatient];
    }
    [plistDictionary setObject:array forKey:@"patients"];
    [plistDictionary writeToFile:documentPlistPath atomically:YES];
}

@end
