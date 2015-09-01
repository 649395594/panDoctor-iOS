//
//  AboutUSViewController.m
//  Pan大夫
//
//  Created by tiny on 15/3/15.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "AboutUSViewController.h"
#define KDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define KDeviceHeight [[UIScreen mainScreen]bounds].size.height
#define kCellHeight 0.0869565
#define kCellImageLeftInterval 0.031401
#define kCellImageTopInterval 0.0135869
#define kCellImageRightInterval 0.024154
#define kImageWidth 0.106280
#define kLabelTopInterVal 0.029891
#define kLabelWidth 0.806763
#define kHeaderHeight 0.1453804
#define kFooterHeight 0.103261
#define kTopImageViewHeight 0.3165761
#define kNameLabelLeftInterval 0.253623
#define kNameLabelTopInterval 0.0095108
#define kNameLabelWidth 0.483091
#define kNameLabelHeight 0.054347
#define kDetailLabelTopInterval 0.0679347
#define kDetailLabelHeight 0.040761
#define kWebLabelLeftInterval 0.2415458
#define kWebLabelTopInterval 0.054347
#define kWebLabelHeight 0.048913
#define kAlertViewWidth 0.927536
#define kAlertViewHeight 0.233695
@interface AboutUSViewController ()
@property (strong, nonatomic) UITableView *aboutUsTable;
@property (strong, nonatomic) NSArray *aboutUSDataList;
@property (strong, nonatomic) NSArray *aboutUsImageList;
@property (strong, nonatomic) UILabel *cellLabel;
@end

@implementation AboutUSViewController
@synthesize aboutUSDataList,aboutUsImageList;
@synthesize aboutUsTable;
@synthesize cellLabel;
- (id)initWithTable{
    self = [super init];
    if (self) {
        UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, KDeviceWidth, kTopImageViewHeight*KDeviceHeight)];
        NSLog(@"headerImage is %f",headerImage.frame.size.height);
        //适配顶部图片
        
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
           headerImage.image = [UIImage imageNamed:@"aboutUs_4s"];
        }
        else{
           headerImage.image = [UIImage imageNamed:@"aboutUs"]; 
        }
        
        [self.view addSubview:headerImage];
        
        aboutUsTable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerImage.frame),KDeviceWidth,KDeviceHeight-CGRectGetHeight(headerImage.frame)) style:UITableViewStylePlain];
        aboutUsTable.delegate = self;
        aboutUsTable.dataSource = self;
        aboutUsTable.scrollEnabled = NO;
        aboutUsTable.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
        aboutUSDataList = [[NSArray alloc]initWithObjects:@"当前版本：",@"客服电话：",@"评价打分：",@"免责声明：", nil];
        aboutUsTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        aboutUsTable.showsVerticalScrollIndicator = NO;
        [self.view addSubview:aboutUsTable];
        
        if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
            aboutUsImageList = [[NSArray alloc]initWithObjects:@"arrow-4s",@"phone-4s",@"star-4s",@"page-4s", nil];
        }
        else{
            aboutUsImageList = [[NSArray alloc]initWithObjects:@"arrow",@"phone",@"star",@"page", nil];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"reuseIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
     cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    //newImage的适配
    UIImageView *newImage = [[UIImageView alloc]init];
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481){
      newImage.frame = CGRectMake(10,3, kImageWidth*KDeviceWidth, kImageWidth*KDeviceWidth);
    }
    else{
      newImage.frame = CGRectMake(kCellImageLeftInterval*KDeviceWidth, kCellImageTopInterval*KDeviceHeight, kImageWidth*KDeviceWidth, kImageWidth*KDeviceWidth);
    }
    newImage.layer.cornerRadius = kImageWidth*KDeviceWidth/2;
    newImage.image = [UIImage imageNamed:[aboutUsImageList objectAtIndex:indexPath.row]];
    [cell.contentView addSubview:newImage];
    [cell.contentView bringSubviewToFront:newImage];
    
    //label的大小以及字体适配
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
        cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newImage.frame)+kCellImageRightInterval*KDeviceWidth, kLabelTopInterVal*KDeviceHeight, kLabelWidth*KDeviceWidth, 16)];
        cellLabel.font = [UIFont systemFontOfSize:16];
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
        cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newImage.frame)+kCellImageRightInterval*KDeviceWidth, kLabelTopInterVal*KDeviceHeight, kLabelWidth*KDeviceWidth, 15)];
        cellLabel.font = [UIFont systemFontOfSize:14];
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
        cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newImage.frame)+kCellImageRightInterval*KDeviceWidth, kLabelTopInterVal*KDeviceHeight, kLabelWidth*KDeviceWidth, 18)];
        cellLabel.font = [UIFont systemFontOfSize:18];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415) {
        cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newImage.frame)+kCellImageRightInterval*KDeviceWidth, kLabelTopInterVal*KDeviceHeight, kLabelWidth*KDeviceWidth, 20)];
        cellLabel.font = [UIFont systemFontOfSize:20];
    }
    //Label信息添加
    if ((long)indexPath.row == 0) {
        NSMutableString *version = [[NSMutableString alloc]init];
        [version appendString:[aboutUSDataList objectAtIndex:indexPath.row]];
        [version appendFormat:@"V2.1"];
        cellLabel.text = version;
    }
    else if ((long)indexPath.row == 1){
        NSMutableString *telNumber = [[NSMutableString alloc]init];
        [telNumber appendString:[aboutUSDataList objectAtIndex:indexPath.row]];
        [telNumber appendFormat:@"400-820-8820"];
        cellLabel.text = telNumber;
    }
    else{
       cellLabel.text = [aboutUSDataList objectAtIndex:indexPath.row];
    }
    [cell.contentView addSubview:cellLabel];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight*KDeviceHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, kHeaderHeight*KDeviceHeight)];
    header.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kNameLabelLeftInterval*KDeviceWidth, kNameLabelTopInterval*KDeviceHeight, kNameLabelWidth*KDeviceWidth, kNameLabelHeight*KDeviceHeight)];
    nameLabel.text = @"潘大夫";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *detailInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(kNameLabelLeftInterval*KDeviceWidth, kDetailLabelTopInterval*KDeviceHeight, kNameLabelWidth*KDeviceWidth, kDetailLabelHeight*KDeviceHeight)];
    detailInfoLabel.textColor = [UIColor grayColor];
    detailInfoLabel.text = @"您身边的心理咨询师";
    detailInfoLabel.textAlignment = NSTextAlignmentCenter;
    
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
        nameLabel.font = [UIFont systemFontOfSize:32];
        detailInfoLabel.font = [UIFont systemFontOfSize:16];
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
        nameLabel.font = [UIFont systemFontOfSize:30];
        detailInfoLabel.font = [UIFont systemFontOfSize:14];
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
        nameLabel.font = [UIFont systemFontOfSize:34];
        detailInfoLabel.font = [UIFont systemFontOfSize:18];
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415) {
        nameLabel.font = [UIFont systemFontOfSize:40];
        detailInfoLabel.font = [UIFont systemFontOfSize:20];
    }
    [header addSubview:nameLabel];
    [header addSubview:detailInfoLabel];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
        return 75;
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
        return 60;
    }
    if ((KDeviceWidth>=374&&KDeviceWidth<=376)||(KDeviceWidth>=413&&KDeviceWidth<=415)) {
        return kHeaderHeight*KDeviceHeight;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFooterHeight*KDeviceHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KDeviceWidth, KDeviceHeight*kFooterHeight)];
    footer.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1];
    
    UILabel *webLabel = [[UILabel alloc]init];
    webLabel.text = @"dr.pan@hotmail.com";
    webLabel.textAlignment = NSTextAlignmentCenter;
    
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=567&&KDeviceHeight<=569) {
       webLabel.font = [UIFont systemFontOfSize:15];
       webLabel.frame = CGRectMake(kWebLabelLeftInterval*KDeviceWidth, 25, kNameLabelWidth*KDeviceWidth, kWebLabelHeight*KDeviceHeight);
    }
    if (KDeviceWidth>=319&&KDeviceWidth<=321&&KDeviceHeight>=479&&KDeviceHeight<=481) {
       webLabel.font = [UIFont systemFontOfSize:12];
       webLabel.frame = CGRectMake(kWebLabelLeftInterval*KDeviceWidth, 17, kNameLabelWidth*KDeviceWidth, kWebLabelHeight*KDeviceHeight);
    }
    if (KDeviceWidth>=374&&KDeviceWidth<=376) {
       webLabel.font = [UIFont systemFontOfSize:17];
       webLabel.frame = CGRectMake(kWebLabelLeftInterval*KDeviceWidth, kWebLabelTopInterval*KDeviceHeight, kNameLabelWidth*KDeviceWidth, kWebLabelHeight*KDeviceHeight);
    }
    if (KDeviceWidth>=413&&KDeviceWidth<=415) {
       webLabel.font = [UIFont systemFontOfSize:19];
       webLabel.frame = CGRectMake(kWebLabelLeftInterval*KDeviceWidth, kWebLabelTopInterval*KDeviceHeight, kNameLabelWidth*KDeviceWidth, kWebLabelHeight*KDeviceHeight);
    }

    [footer addSubview:webLabel];
    return footer;
}
//选择Cell，触发UIAlertView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *alertTitle = @"";
    NSString *alertMessage = @"";
    NSString *leftButtonTitle = @"";
    NSString *rightButtonTitle = @"";
    switch (indexPath.row) {
        case 0:
            alertTitle = @"版本检测";
            alertMessage = @"检测到新版本V2.3,更省流量,推荐您升级";
            leftButtonTitle = @"升级";
            rightButtonTitle = @"取消";
            break;
        case 1:
            alertTitle = @"拨打电话";
            alertMessage = @"是否继续拨打客服电话：400-820-8820 ？";
            leftButtonTitle = @"继续";
            rightButtonTitle = @"取消";
            break;
        case 2:
            alertTitle = @"跳转提示";
            alertMessage = @"将跳转到App Store为我们打分。";
            leftButtonTitle = @"继续";
            rightButtonTitle = @"返回";
            break;
        case 3:
            alertTitle = @"查看声明";
            alertMessage = @"您将查看《潘大夫使用条款和隐私政策》";
            leftButtonTitle = @"继续";
            rightButtonTitle = @"返回";
            break;
        default:
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:alertMessage delegate:self cancelButtonTitle:leftButtonTitle otherButtonTitles:rightButtonTitle,nil];
    [alert show];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
