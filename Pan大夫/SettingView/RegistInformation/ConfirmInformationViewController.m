//
//  ComfirmInformationViewController.m
//  Pan大夫
//
//  Created by Tom on 15/9/2.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "ConfirmInformationViewController.h"
#import "ConfirmInformationView.h"

@interface ConfirmInformationViewController ()<ConfirmInformationViewDelegate>

@property(nonatomic)ConfirmInformationView *confirmInformationView;
@property(strong, nonatomic) NSArray *keyArray;
@property(strong, nonatomic)NSDictionary *infoDictionay;

@end

@implementation ConfirmInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.view.backgroundColor = [UIColor whiteColor];
    _confirmInformationView = [[ConfirmInformationView alloc]initWithFrame:self.view.frame InformationDictionary:_infoDictionay];
    _confirmInformationView.delegate = self;
    [self.view addSubview:_confirmInformationView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self refleshData];
}

//初始化试图控制器，通过字典传值
-(id)initWithInformationDictionary:(NSDictionary *)informationDictionary{
    self = [super init];
    if (self) {
        _infoDictionay = [[NSDictionary alloc]initWithDictionary:informationDictionary];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitButtonClicked{
    NSLog(@"commitButtonClicked");
    
}

-(void)refleshData{
    if ([@"男" isEqualToString: [_infoDictionay objectForKey:@"性别"] ]) {
        _confirmInformationView.headImageView.image = [UIImage imageNamed:@"picOfBoyHead"];
    }else{
        _confirmInformationView.headImageView.image = [UIImage imageNamed:@"picOfGirlHead"];
    }
    _keyArray = [[NSArray alloc]initWithObjects:@"姓名", @"性别", @"学号", @"学院", @"专业", nil];
    _confirmInformationView.nameLabel.text = [_infoDictionay objectForKey:@"姓名"];
    _confirmInformationView.sexLabel.text = [_infoDictionay objectForKey:@"性别"];
    _confirmInformationView.IDLabel.text = [_infoDictionay objectForKey:@"学号"];
    _confirmInformationView.collogeLabel.text = [_infoDictionay objectForKey:@"学院"];
    _confirmInformationView.majorLabel.text = [_infoDictionay objectForKey:@"专业"];
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
