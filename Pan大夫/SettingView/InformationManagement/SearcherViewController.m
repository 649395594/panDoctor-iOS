//
//  SearcherViewController.m
//  json
//
//  Created by xuyaowen on 15/3/8.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import "SearcherViewController.h"

@interface SearcherViewController (){
    NSMutableArray* dataSource;

    NSMutableArray* dataLng;
    NSMutableArray* dataLat;

    UISearchBar* _searchBar;
    double longitude;
    double latitude;
    NSMutableArray* dataOfDistrict;
    
    //下面的变量来储存所有的地址，用于 - 地址解析的作用；
    
    NSMutableDictionary* iAddress;
    UITableView * tableOfSearch;
    int count;
    NSNumber* lngTmp;
    NSNumber* latTmp;
}

@property (nonatomic, strong) NSData *totalData;

@end

@implementation SearcherViewController
@synthesize city;
@synthesize totalData;

//Sever:(NSDictionary* ) services
- (id) initWithCity:(NSString *)pCity Longitude:(double)pLongitude Latitude:(double)pLatitude{
    self = [self init];
    if(self){
        dataLng =[[NSMutableArray alloc] init];
        dataLat = [[NSMutableArray alloc] init];
        lngTmp = [[NSNumber alloc] init];
        latTmp = [[NSNumber alloc] init];
        longitude = 0;
        latitude = 0;
        city =[[ NSString alloc] init];
        city = pCity;
        longitude = pLongitude;
        latitude = pLongitude;
        self.navigationItem.title =@"选择地址";
        count=0;
        // Do any additional setup after loading the view.
        dataSource = [[NSMutableArray alloc] init];
        dataOfDistrict = [[NSMutableArray alloc] init];
        
        tableOfSearch = [[UITableView alloc] init];
        tableOfSearch.frame = CGRectMake(0,108, self.view.frame.size.width, self.view.frame.size.height-64);
        tableOfSearch.delegate=self;
        tableOfSearch.dataSource =self;
        tableOfSearch.rowHeight = 60;
        tableOfSearch.bounces=NO;
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
        _searchBar.placeholder = @"搜索";
        _searchBar.delegate=self;
        _searchBar.keyboardType = UIKeyboardTypeAlphabet;
        _searchBar.showsCancelButton =YES;
        _searchBar.keyboardType = UIKeyboardTypeAlphabet;
        [self.view addSubview:_searchBar];
        self.view.backgroundColor= [UIColor whiteColor];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - SeacherBar 的代理函数-实时显示

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(count == 0){
        //创建tableview，并加以覆盖界面；
        [self.view addSubview:tableOfSearch];
        
        //即将在这里加上一个小视图；
    }
    count++;
    NSString* str1 = searchBar.text;
    //str1=[str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* str2 = city;
    NSString* str = [NSString stringWithFormat:@"http://api.map.baidu.com/place/v2/search?query=%@&region=%@&output=json&ak=iX2vhvv808qj9Ngf1E69BcQF",str1,str2];
    NSLog(@"str = %@",str);
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"str = %@",str);
    totalData = [[NSMutableData alloc] init];
    NSURL* url=[NSURL URLWithString:str];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    
    NSURLConnection* conn = [NSURLConnection connectionWithRequest:request delegate:self];
    if(conn != nil){
        return;
    }
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

#pragma mark -- connection 的代理方法！
// 设置代理-connection的代理！

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //    NSLog(@"响应的数据类型： %@",response.MIMEType);
    //    NSLog(@"响应的数据长度是：%lld",response.expectedContentLength);
    //    NSLog(@"响应数据使用的字符集：%@",response.textEncodingName);
    //    NSLog(@"响应的文件名：%@",response.suggestedFilename);
    
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    totalData = data;
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"--error-- %@",error);
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    id jsonObj = [NSJSONSerialization JSONObjectWithData:totalData options:NSJSONReadingMutableLeaves error:nil];
    [dataSource removeAllObjects];
    [dataOfDistrict removeAllObjects];
    if (jsonObj) {
        NSMutableDictionary *total = (NSMutableDictionary *)jsonObj;
        NSMutableArray* result = [total objectForKey:@"results"];
        for (int i=0; i< [result count]; i++) {
            NSDictionary* place =[result objectAtIndex:i];
            NSString *placeName = [place objectForKey:@"name"];
            NSDictionary *location = [place objectForKey:@"location"];
            NSString *address = [place objectForKey:@"address"];

            [dataSource addObject:placeName];
            NSString *lng = [location objectForKey:@"lng"];
            NSString *lat = [location objectForKey:@"lat"];
            if (lng) {
                NSLog(@"新加入的lng 为 %@",lng);
                [dataLng addObject:lng];
            }
            if (lat) {
                NSLog(@"新加入的lat 为 %@",lat);
                [dataLat addObject:lat];
            }
            if (address) {
                [dataOfDistrict addObject:address];
            }
            else{
                [dataOfDistrict addObject:@""];
            }
        }

    }
    [tableOfSearch reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[dataSource objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [dataOfDistrict objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    //cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *neighbourHood = [dataSource objectAtIndex:indexPath.row];
    self.delegate.fieldOfNeighborhood.text = neighbourHood;
    
    self.delegate.Lng = [[dataLng objectAtIndex:indexPath.row]doubleValue];
    self.delegate.Lat = [[dataLat objectAtIndex:indexPath.row]doubleValue];
//    NSLog(@"real Lng = %lf", self.delegate.Lng);
//    NSLog(@"real Lat = %lf", self.delegate.Lat);
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y > 0.003f || velocity.y < -0.003f) {
        [_searchBar resignFirstResponder];
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
