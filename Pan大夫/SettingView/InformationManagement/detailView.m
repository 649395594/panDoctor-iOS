//
//  detailView.m
//  New-part
//
//  Created by xuyaowen on 15/3/14.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import "detailView.h"
#import "SearcherViewController.h"

//设置frame 的宏的情况
#define heightBetween 0
#define LengthBefore 10
#define lengthBetween 5
#define lengthOftabel 90
#define HeighToTop [[UIScreen mainScreen]bounds].size.height/7.5
#define HeightBig 10
#define widthOfLabel [[UIScreen mainScreen]bounds].size.height/15
#define lengthOfTextField kScreenWidth - lengthOftabel - LengthBefore
#define lineColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:1
#define wordColor colorWithRed:0.416 green:0.416 blue:0.416 alpha:1
@interface detailView (){
    NSString* areaValue;
    HZAreaPickerView* locatePicker;
    UIScrollView* scrollView;
    Patient * p3;
    NSString* strStr;
    UIButton* buttonOfSex;
    UIImage* tmpImage;
    UIImage* imageOfRight;
}


@end

@implementation detailView

@synthesize fieldOfdate,fieldOfDoorNum,fieldOfNeighborhood,fieldOfPhone,fieldOfProvince,fieldOfUser;
@synthesize data;
@synthesize province,city,district;

- (id) initWithUser:(NSString* )name Age:(NSString* ) age Del:(NSString* ) tel Provience:(NSString* ) province Neighborhood:(NSString* ) neighborhood DoorNum:(NSString* )doornum SexNum:(NSInteger) sexnum{
    self = [self init];
    if(self){
            self.sexNum = sexnum;
            scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
            scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+200);
            [self.view addSubview:scrollView];
            scrollView.backgroundColor =  [UIColor colorWithRed:0.941 green:0.937 blue:0.961 alpha:1];
        
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.scrollEnabled = NO;
        
            [scrollView setContentOffset:CGPointMake(0, 70) animated:YES];
        
        
        
             if (data) {
                p3 = [[Patient alloc] initWithPatient:data];
            }
                   
            UILabel* titleLabel = [[UILabel alloc]  initWithFrame:CGRectMake(0, 0, 40, 30)];
            titleLabel.text = @"信息管理";
            titleLabel.textColor  = [UIColor colorWithRed:0.004 green:0.631 blue:0.608 alpha:1];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:17];
            self.navigationItem.titleView = titleLabel;
            UIBarButtonItem* rightBtn = [[ UIBarButtonItem alloc] initWithTitle:@"· · ·" style:UIBarButtonItemStyleDone target:self action:@selector(edit)];
            rightBtn.tintColor = [UIColor colorWithRed:0.004 green:0.631 blue:0.608 alpha:1];
            self.navigationItem.rightBarButtonItem = rightBtn;
        
        
            self.view.backgroundColor = [UIColor colorWithRed:0.941 green:0.937 blue:0.961 alpha:1];
            UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(LengthBefore, HeighToTop, lengthOftabel, widthOfLabel)];
            UILabel* labelOfUser= [[UILabel alloc] initWithFrame:CGRectMake(LengthBefore, HeighToTop+heightBetween+widthOfLabel, lengthOftabel, widthOfLabel)];
            UILabel* labelOfDate= [[UILabel alloc] initWithFrame:CGRectMake(LengthBefore, HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOftabel, widthOfLabel)];
            UILabel* labelOfPhone= [[UILabel alloc] initWithFrame:CGRectMake(LengthBefore, HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOftabel, widthOfLabel)];
        
        
        
            UILabel* label2     = [[UILabel alloc] initWithFrame:CGRectMake(LengthBefore, HeightBig+HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOftabel, widthOfLabel)];
            UILabel* labelOfProvince= [[UILabel alloc] initWithFrame:CGRectMake(LengthBefore, HeightBig+HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOftabel, widthOfLabel)];
            UILabel* labelOfNeighborhood= [[UILabel alloc] initWithFrame:CGRectMake(LengthBefore,HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOftabel, widthOfLabel)];
            UILabel* labelOfDoorNum= [[UILabel alloc] initWithFrame:CGRectMake(LengthBefore,HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOftabel, widthOfLabel)];
        
        
            fieldOfUser = [[UITextField alloc] initWithFrame:CGRectMake(LengthBefore+lengthOftabel+lengthBetween, HeighToTop+heightBetween+widthOfLabel, lengthOfTextField/2, widthOfLabel)];
            fieldOfdate = [[UITextField alloc] initWithFrame:CGRectMake(LengthBefore+lengthOftabel+lengthBetween, HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOfTextField, widthOfLabel)];
            fieldOfPhone= [[UITextField alloc] initWithFrame:CGRectMake(LengthBefore+lengthOftabel+lengthBetween,  HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOfTextField, widthOfLabel)];
            fieldOfProvince = [[UITextField alloc] initWithFrame:CGRectMake(LengthBefore+lengthOftabel+lengthBetween, HeightBig+HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOfTextField, widthOfLabel)];
            fieldOfNeighborhood = [[UITextField alloc] initWithFrame:CGRectMake(LengthBefore+lengthOftabel+lengthBetween, HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOfTextField, widthOfLabel)];
            fieldOfDoorNum = [[UITextField alloc] initWithFrame:CGRectMake(LengthBefore+lengthOftabel+lengthBetween, HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, lengthOfTextField, widthOfLabel)];
        
        
            UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0, HeighToTop+heightBetween/2+widthOfLabel, self.view.frame.size.width, 2*heightBetween+3*widthOfLabel)];
            view1.backgroundColor = [UIColor whiteColor];
            [scrollView addSubview:view1];
        
            UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(0, HeightBig+HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width,2*heightBetween+3*widthOfLabel)];
            view2.backgroundColor = [UIColor whiteColor];
            [scrollView addSubview:view2];
        
        
        
        
        
        
        
            [ scrollView addSubview:fieldOfdate];
            [ scrollView addSubview:fieldOfDoorNum];
            [ scrollView addSubview:fieldOfNeighborhood];
            [ scrollView addSubview:fieldOfPhone];
            [ scrollView addSubview:fieldOfProvince];
            [ scrollView addSubview:fieldOfUser];
            [ scrollView addSubview:label1];
            [ scrollView addSubview:labelOfUser];
            [ scrollView addSubview:labelOfDate];
            [ scrollView addSubview:labelOfPhone];
            [ scrollView addSubview:label2];
            [ scrollView addSubview:labelOfProvince];
            [ scrollView addSubview:labelOfNeighborhood];
            [ scrollView addSubview:labelOfDoorNum];
        
            fieldOfdate.placeholder =@"请输入你的年龄";
            fieldOfDoorNum.placeholder =@"具体的门牌号，如3栋101室";
            fieldOfNeighborhood.placeholder =@"请输入您的小区/大厦名";
            fieldOfPhone.placeholder =@"请输入联系人手机号";
            fieldOfProvince.placeholder =@"选择你在的省市区";
            fieldOfUser.placeholder =@"请输入联系人姓名";
        
            label1.text =@"基本信息";
            labelOfUser.text =@" 联系人：";
            labelOfDate.text =@"    年龄：";
            labelOfPhone.text =@"联系方式：";
            label2.text =@"咨询地址";
            labelOfProvince.text =@"省市区：";
            labelOfNeighborhood.text =@"小区名：";
            labelOfDoorNum.text =@"门牌号：";
        
            self.fieldOfUser.text = name;
            self.fieldOfdate.text = age;
            self.fieldOfProvince.text = province;
            self.fieldOfNeighborhood.text = neighborhood;
            self.fieldOfDoorNum.text = doornum;
            self.fieldOfPhone.text =tel;

        
            fieldOfdate.font = [UIFont boldSystemFontOfSize:17];
            fieldOfDoorNum.font = [UIFont boldSystemFontOfSize:17];
            fieldOfNeighborhood.font = [UIFont boldSystemFontOfSize:17];
            fieldOfPhone.font = [UIFont boldSystemFontOfSize:17];
            fieldOfProvince.font = [UIFont boldSystemFontOfSize:17];
            fieldOfUser.font = [UIFont boldSystemFontOfSize:17];
        
            label1.font = [UIFont boldSystemFontOfSize:17];
            labelOfUser.font = [UIFont boldSystemFontOfSize:17];
            labelOfDate.font = [UIFont boldSystemFontOfSize:17];
            labelOfPhone.font = [UIFont boldSystemFontOfSize:17];
            label2.font = [UIFont boldSystemFontOfSize:17];
            labelOfProvince.font = [UIFont boldSystemFontOfSize:17];
            labelOfNeighborhood.font = [UIFont boldSystemFontOfSize:17];
            labelOfDoorNum.font = [UIFont boldSystemFontOfSize:17];
        //
            fieldOfdate.textColor = [UIColor wordColor];
            fieldOfDoorNum.textColor = [UIColor wordColor];
            fieldOfNeighborhood.textColor = [UIColor wordColor];
            fieldOfPhone.textColor = [UIColor wordColor];
            fieldOfProvince.textColor = [UIColor wordColor];
            fieldOfUser.textColor = [UIColor wordColor];
        
            label1.textColor = [UIColor wordColor];
            labelOfUser.textColor = [UIColor wordColor];
            labelOfDate.textColor = [UIColor wordColor];
            labelOfPhone.textColor = [UIColor wordColor];
            label2.textColor = [UIColor wordColor];
            labelOfProvince.textColor = [UIColor wordColor];
            labelOfNeighborhood.textColor = [UIColor wordColor];
            labelOfDoorNum.textColor = [UIColor wordColor];
        
            UIButton* footerButton = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
            [footerButton setTitle:@"保存并返回" forState:UIControlStateNormal];
            footerButton.frame = CGRectMake(10, self.view.frame.size.height-50, self.view.frame.size.width-20, 40);
            //footerButton.tintColor = [UIColor blackColor];
            footerButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
            footerButton.backgroundColor = [UIColor colorWithRed:0.004 green:0.639 blue:0.620 alpha:1];
            footerButton.tintColor = [UIColor whiteColor];
            footerButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            footerButton.layer.cornerRadius = 5;
            footerButton.layer.masksToBounds = NO;
            [footerButton addTarget:self action:@selector(addNewer) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:footerButton];
            UIView * lineFoot = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 1)];
            lineFoot.backgroundColor = [UIColor lightGrayColor];
            [scrollView addSubview:lineFoot];
        
        
        //用于画出表格之中的线
            UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, HeighToTop+heightBetween/2+widthOfLabel, self.view.frame.size.width, 1)];
            line1.backgroundColor = [UIColor lineColor];
            [scrollView addSubview:line1];
            UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(LengthBefore, HeighToTop+heightBetween/2+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, 1)];
            line2.backgroundColor = [UIColor lineColor];
            [scrollView addSubview:line2];
            UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(LengthBefore, HeighToTop+heightBetween/2+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, 1)];
            line3.backgroundColor = [UIColor lineColor];
            [scrollView addSubview:line3];
            UIView * line5 = [[UIView alloc] initWithFrame:CGRectMake(0, HeightBig+HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, 1)];
            line5.backgroundColor = [UIColor lineColor];
            [scrollView addSubview:line5];
            UIView * line6 = [[UIView alloc] initWithFrame:CGRectMake(LengthBefore,HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, 1)];
            line6.backgroundColor = [UIColor lineColor];
            [scrollView addSubview:line6];
            UIView * line7 = [[UIView alloc] initWithFrame:CGRectMake(LengthBefore,HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, 1)];
            line7.backgroundColor = [UIColor lineColor];
            [scrollView addSubview:line7];
            UIView * line8 = [[UIView alloc] initWithFrame:CGRectMake(0, widthOfLabel+HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, 1)];
            line8.backgroundColor = [UIColor lineColor];
            [scrollView addSubview:line8];
            UIView * line9 = [[UIView alloc] initWithFrame:CGRectMake(0,HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+widthOfLabel, self.view.frame.size.width, 1)];
            line9.backgroundColor = [UIColor lineColor];
            [scrollView addSubview:line9];
        
            UIButton* buttonOfProvince = [[UIButton alloc] initWithFrame:CGRectMake(0, HeightBig+HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, widthOfLabel)];
            [buttonOfProvince setTitle:@"" forState:UIControlStateNormal];
            [buttonOfProvince addTarget:self action:@selector(chooseProvince) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:buttonOfProvince];
            UIButton* buttonOfNeighorhood = [[UIButton alloc] initWithFrame:CGRectMake(0,HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, widthOfLabel)];
            [buttonOfNeighorhood setTitle:@"" forState:UIControlStateNormal];
            [buttonOfNeighorhood addTarget:self action:@selector(chooseNeighborhood) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:buttonOfNeighorhood];
        
            UIButton* buttonDefault = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            buttonDefault.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        buttonDefault.tintColor = [UIColor wordColor];
            buttonDefault.frame = CGRectMake(0, 60+HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, widthOfLabel);
            //UIButton* buttonDefault = [[UIButton alloc] initWithFrame:CGRectMake(0, 100+HeightBig+ HeighToTop+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel+heightBetween+widthOfLabel, self.view.frame.size.width, widthOfLabel)];
            [buttonDefault addTarget:self action:@selector(setDefault) forControlEvents:UIControlEventTouchUpInside];
            [buttonDefault setTitle:@"将该信息设为默认" forState:UIControlStateNormal];
           [buttonDefault setTitle:@"已设为默认" forState:UIControlStateHighlighted];
            [buttonDefault setBackgroundColor:[UIColor whiteColor]];

            [scrollView addSubview:buttonDefault];
            [buttonDefault setHighlighted:NO];
        

            
            
            fieldOfDoorNum.delegate = self;
            fieldOfPhone.delegate =self;
            fieldOfUser.delegate =self;
            fieldOfdate.delegate =self;
            fieldOfNeighborhood.delegate =self;
            
            
//            UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHide:)];
//            singleTap.cancelsTouchesInView = NO;
//            [self.view addGestureRecognizer:singleTap];
        
             buttonOfSex = [[UIButton alloc] initWithFrame:CGRectMake(lengthOfTextField-130, 0, self.view.frame.size.width/3.8, widthOfLabel)];
            [buttonOfSex setTitle:@"" forState:UIControlStateNormal];
            //[buttonOfSex setBackgroundColor:[UIColor redColor]];
        
            [buttonOfSex addTarget:self action:@selector(sexSet) forControlEvents:UIControlEventTouchUpInside];
            [fieldOfUser addSubview:buttonOfSex];
        
        if(sexnum == 1){
            switch (DEVICE_ID) {
                case 1:{
                    tmpImage = [UIImage imageNamed:@"genderMale-4s"];
                    break;
                }
                case 2:{
                    tmpImage = [UIImage imageNamed:@"genderMale"];
                    break;
                }
                case 3:{
                    tmpImage = [UIImage imageNamed:@"genderMale"];
                    break;
                }
                case 4:{
                    tmpImage = [UIImage imageNamed:@"genderMale"];
                    break;
                }
                    
                default:
                    break;
            }

            
        }else{
            switch (DEVICE_ID) {
                case 1:{
                    tmpImage = [UIImage imageNamed:@"genderFemale-4s"];
                    break;
                }
                case 2:{
                    tmpImage = [UIImage imageNamed:@"genderFemale"];
                    break;
                }
                case 3:{
                    tmpImage = [UIImage imageNamed:@"genderFemale"];
                    break;
                }
                case 4:{
                    tmpImage = [UIImage imageNamed:@"genderFemale"];
                    break;
                }
                    
                default:
                    break;
            }

        }
        
            [buttonOfSex setBackgroundImage:tmpImage forState:UIControlStateNormal];
            [buttonOfSex setBackgroundImage:tmpImage forState:UIControlStateHighlighted];
            [buttonOfSex setHighlighted:NO];
        switch (DEVICE_ID) {
            case 1:{
                imageOfRight = [UIImage imageNamed:@"circle-4s"];
                break;
            }
            case 2:{
                imageOfRight = [UIImage imageNamed:@"circle"];
                break;
            }
            case 3:{
                imageOfRight = [UIImage imageNamed:@"circle"];
                break;
            }
            case 4:{
                imageOfRight = [UIImage imageNamed:@"circle"];
                break;
            }
                
            default:
                break;
        }

        UIImageView* imageOfRightView = [[UIImageView alloc] init];
        imageOfRightView.image = imageOfRight;
        imageOfRightView.frame = CGRectMake(0+(self.view.frame.size.width/3.5/3)*2,0, self.view.frame.size.width/3.5/2.5, widthOfLabel);
        NSLog(@"rightFrame == %f",self.view.frame.size.width/3.5/3);
        //[imageOfRightView setBackgroundColor:[UIColor blueColor]];
        [buttonDefault addSubview:imageOfRightView];

        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHide:)];
        singleTap.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:singleTap];
        

        self.fieldOfUser.text = name;
        self.fieldOfdate.text = age;
        self.fieldOfProvince.text = province;
        self.fieldOfNeighborhood.text = neighborhood;
        self.fieldOfDoorNum.text = doornum;
        self.fieldOfPhone.text =tel;
        NSLog(@"111%@",self.fieldOfPhone.text);
        NSLog(@"调用初始化函数");
    }
    return self;
}

//选择性别的方法！
- (void) sexSet{
    NSLog(@"Hello!");
    if(self.sexNum == 1){
        self.sexNum = 0;
        switch (DEVICE_ID) {
            case 1:{
                tmpImage = [UIImage imageNamed:@"genderFemale-4s"];
                break;
            }
            case 2:{
                tmpImage = [UIImage imageNamed:@"genderFemale"];
                break;
            }
            case 3:{
                tmpImage = [UIImage imageNamed:@"genderFemale"];
                break;
            }
            case 4:{
                tmpImage = [UIImage imageNamed:@"genderFemale"];
                break;
            }
                
            default:
                break;
        }
        [buttonOfSex setBackgroundImage:tmpImage forState:UIControlStateNormal];
        [buttonOfSex setBackgroundImage:tmpImage forState:UIControlStateHighlighted];
    }else{
        self.sexNum =1;
        switch (DEVICE_ID) {
            case 1:{
                tmpImage = [UIImage imageNamed:@"genderMale-4s"];
                break;
            }
            case 2:{
                tmpImage = [UIImage imageNamed:@"genderMale"];
                break;
            }
            case 3:{
                tmpImage = [UIImage imageNamed:@"genderMale"];
                break;
            }
            case 4:{
                tmpImage = [UIImage imageNamed:@"genderMale"];
                break;
            }
                
            default:
                break;
        }
        [buttonOfSex setBackgroundImage:tmpImage forState:UIControlStateNormal];
        [buttonOfSex setBackgroundImage:tmpImage forState:UIControlStateHighlighted];
    }
    
}

// 加上手势来惊醒取消键盘的第一相应的情况！
- (void) keyBoardHide:(UITapGestureRecognizer* ) tap{
    NSLog(@"你发出了手势的的情况！");
    [self resignFirstResponder];
    [fieldOfdate resignFirstResponder];
    [fieldOfdate resignFirstResponder];
    [fieldOfDoorNum resignFirstResponder];
    [fieldOfNeighborhood resignFirstResponder];
    [fieldOfPhone resignFirstResponder];
    [fieldOfUser resignFirstResponder];
    [self cancelLocatePicker];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"你好啊！");
    [fieldOfdate resignFirstResponder];
    [fieldOfdate resignFirstResponder];
    [fieldOfDoorNum resignFirstResponder];
    [fieldOfNeighborhood resignFirstResponder];
    [fieldOfPhone resignFirstResponder];
    [fieldOfUser resignFirstResponder];

}
    
    
-(void) chooseProvince{
    NSLog(@"请选择该省份的情况！");
    [fieldOfdate resignFirstResponder];
    [fieldOfDoorNum resignFirstResponder];
    [fieldOfNeighborhood resignFirstResponder];
    [fieldOfPhone resignFirstResponder];
    [fieldOfUser resignFirstResponder];
    [self cancelLocatePicker];
    locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    [locatePicker showInView:self.view];
}

- (void) chooseNeighborhood{
    
    NSLog(@"请选择该小区的情况！");
    [fieldOfdate resignFirstResponder];
    [fieldOfDoorNum resignFirstResponder];
    [fieldOfProvince resignFirstResponder];
    [fieldOfPhone resignFirstResponder];
    [fieldOfUser resignFirstResponder];
    
    if ([province isEqualToString:@"北京"] || [province isEqualToString:@"上海"] || [province isEqualToString:@"天津"] || [province isEqualToString:@"重庆"]) {
        city = province;
    }
    SearcherViewController* searchView = [[SearcherViewController alloc] initWithCity:city Longitude:39.915 Latitude:116.404];
    searchView.delegate = self;
    [self.navigationController pushViewController:searchView animated:YES];
}

-(void) setDefault{
//    //检查当前控件内容完整性
//    if (![self checkCompleteness]) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有填完您的信息" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        [alert show];
//        return ;
//    }
    
   // NSLog(@"设置所有信息为默认信息! ");
    [fieldOfdate resignFirstResponder];
    [fieldOfDoorNum resignFirstResponder];
    [fieldOfProvince resignFirstResponder];
    [fieldOfPhone resignFirstResponder];
    [fieldOfUser resignFirstResponder];
    strStr = [NSString stringWithFormat:@"%@%@%@", fieldOfProvince.text , fieldOfNeighborhood.text, fieldOfDoorNum.text];

    
    NSString* str1 = [[NSString alloc] init];
    if (self.sexNum == 1) {
        str1 = [NSString stringWithFormat:@"male.jpg"];
    }
    else{
        str1 = [NSString stringWithFormat:@"female.jpg"];
    }
    NSLog(@"self indexpath = %@",self.myMyIndexPath);
    Patient *p1 = [[Patient alloc]initWithName:fieldOfUser.text Tel:fieldOfPhone.text Age:fieldOfdate.text Address:strStr Location:fieldOfNeighborhood.text Sex:str1 DoorNum:fieldOfDoorNum.text Province:fieldOfProvince.text Neigh:fieldOfNeighborhood.text Default: @"设为默认" Lng:self.Lng Lat:self.Lat];
    NSLog(@"保存数据时lng = %lf",self.Lng);
    NSLog(@"保存数据时lat = %lf",self.Lat);
    if (self.action == 1) {
        //需要新增数据
        if ([self.dele.defaultInformationArray count] == 0) {
            //默认数组为空
            [self.dele.defaultInformationArray addObject:p1];
            //
        }
        else{
            //默认数组不为空
            Patient *p2 = [self.dele.defaultInformationArray objectAtIndex:0];
            [self.dele.backupInformationArray insertObject:p2 atIndex:0];
            
            [self.dele.defaultInformationArray insertObject:p1 atIndex:0];
            [self.dele.defaultInformationArray removeObjectAtIndex:1];

        }
        [self.dele reloadData];
    }
    else{
        //只是编辑数据
        if ([self.dele.defaultInformationArray count] == 0) {
            //默认数组为空
            [self.dele.defaultInformationArray addObject:p1];
            [self.dele.backupInformationArray removeObjectAtIndex:self.myMyIndexPath.row];
        }
        else{
            //默认数组不为空
            if (self.myMyIndexPath.section == 1) {
                Patient *p2 = [[Patient alloc] initWithPatient:[self.dele.defaultInformationArray objectAtIndex:0]];
                [self.dele.defaultInformationArray removeObjectAtIndex:0];
                [self.dele.backupInformationArray removeObjectAtIndex:self.myMyIndexPath.row];
                [self.dele.backupInformationArray insertObject:p2 atIndex:0];
                [self.dele.defaultInformationArray insertObject:p1 atIndex:0];
            }
            else{
                [self.dele.defaultInformationArray removeObjectAtIndex:0];
                [self.dele.defaultInformationArray insertObject:p1 atIndex:0];
            }
        }
        [self.dele reloadData];
    }
    [self.dele writeDataIntoDatabase];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseDefaultAddress"object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}



-(void) addNewer{
//    //检查当前控件内容完整性
//    if (![self checkCompleteness]) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有填完您的信息" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        [alert show];
//        return ;
//    }
    NSString* str1 = [[NSString alloc] init];
    if(self.sexNum == 1) {
        str1 = [NSString stringWithFormat:@"male.jpg"];
    }
    else{
        str1 = [NSString stringWithFormat:@"female.jpg"];
    }
    strStr = [NSString stringWithFormat:@"%@%@%@", fieldOfProvince.text , fieldOfNeighborhood.text, fieldOfDoorNum.text];
    NSLog(@"保存数据时lng = %lf",self.Lng);
    NSLog(@"保存数据时lat = %lf",self.Lat);
    Patient *p1 = [[Patient alloc]initWithName:fieldOfUser.text Tel:fieldOfPhone.text Age:fieldOfdate.text Address:strStr Location:fieldOfNeighborhood.text Sex:str1 DoorNum:fieldOfDoorNum.text Province:fieldOfProvince.text Neigh:fieldOfNeighborhood.text Default: @"设为默认" Lng:self.Lng Lat:self.Lat];
    if (self.action == 1){
        
        //需要新增数据
        [self.dele.backupInformationArray addObject:p1];
        [self.dele reloadData];
    }
    else{
        //只是编辑数据
        if (self.myMyIndexPath.section == 1) {
            //修改备选数组
            [self.dele.backupInformationArray removeObjectAtIndex:self.myMyIndexPath.row];
            [self.dele.backupInformationArray insertObject:p1 atIndex:self.myMyIndexPath.row];
        }
        else{
            //修改默认数组
            [self.dele.defaultInformationArray removeObjectAtIndex:self.myMyIndexPath.row];
            [self.dele.defaultInformationArray insertObject:p1 atIndex:self.myMyIndexPath.row];
        }
        [self.dele reloadData];
    }
    [self.dele writeDataIntoDatabase];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseDefaultAddress"object:nil];
    [self.navigationController popViewControllerAnimated:YES];
 }

-(void) edit{
    NSLog(@" 我么恩即将要编辑它! ");
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    province = picker.locate.state;
    city = picker.locate.city;
    district = picker.locate.district;
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        areaValue = [NSString stringWithFormat:@"%@省%@市%@", picker.locate.state, picker.locate.city, picker.locate.district];
        fieldOfProvince.text = areaValue;
        NSLog(@"更换区域名！");
    } else{
    }
}

-(void)cancelLocatePicker
{
    [locatePicker cancelPicker];
    locatePicker.delegate = nil;
    locatePicker = nil;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == fieldOfDoorNum){
        [fieldOfDoorNum setEnabled:YES];
        [self cancelLocatePicker];
        [scrollView setContentOffset:CGPointMake(0, 225) animated:YES];
        return  YES;
    }else if(textField == fieldOfNeighborhood){
        [scrollView setContentOffset:CGPointMake(0, 25) animated:YES];
        [self cancelLocatePicker];
        return YES;
    }else if(textField == fieldOfdate){
        [scrollView setContentOffset:CGPointMake(0, 25) animated:YES];
        [self cancelLocatePicker];
        return YES;
    }else if(textField == fieldOfUser){
        [scrollView setContentOffset:CGPointMake(0, 25) animated:YES];
        [self cancelLocatePicker];
        return YES;
    }else if(textField == fieldOfPhone){
        [scrollView setContentOffset:CGPointMake(0, 25) animated:YES];
        [self cancelLocatePicker];
        return YES;
    }else {
        [scrollView setContentOffset:CGPointMake(0, 25) animated:YES];
        [self cancelLocatePicker];
        return YES;
    }
}

- (bool) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField{
    
    if(textField == fieldOfDoorNum){
        [fieldOfDoorNum setEnabled:YES];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [fieldOfDoorNum resignFirstResponder];
        return  YES;
    }else if(textField == fieldOfNeighborhood){
        [fieldOfNeighborhood setEnabled:YES];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [fieldOfNeighborhood resignFirstResponder];
        return YES;
    }else if(textField == fieldOfdate){
        [fieldOfdate setEnabled:YES];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return YES;
    }else if(textField == fieldOfUser){
        [fieldOfUser setEnabled:YES];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return YES;
    }else if(textField == fieldOfPhone){
        [fieldOfPhone setEnabled:YES];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [fieldOfPhone resignFirstResponder];
        return YES;
    }else {
        [textField  setEnabled:YES];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [textField resignFirstResponder];
        return YES;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//完整性分析，检查所有输入控件的内容是否为空
- (BOOL)checkCompleteness{
    BOOL flag = true;
    if([fieldOfdate.text isEqualToString:@""]){
        flag = false;
    }
    if([fieldOfDoorNum.text isEqualToString:@""]){
        flag = false;
    }
    if([fieldOfDoorNum.text isEqualToString:@""]){
        flag = false;
    }
    if([fieldOfNeighborhood.text isEqualToString:@""]){
        flag = false;
    }
    if([fieldOfPhone.text isEqualToString:@""]){
        flag = false;
    }
    if([fieldOfProvince.text isEqualToString:@""]){
        flag = false;
    }
    if([fieldOfUser.text isEqualToString:@""]){
        flag = false;
    }
    return flag;
}

@end
