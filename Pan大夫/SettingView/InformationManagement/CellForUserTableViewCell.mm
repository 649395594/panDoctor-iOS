//
//  CellForUserTableViewCell.m
//  New-part
//
//  Created by xuyaowen on 15/3/13.
//  Copyright (c) 2015年 xuyaowen. All rights reserved.
//

#import "CellForUserTableViewCell.h"
#import "MyTableView.h"

//空间style的设置宏的情况！
#define rowHeight  40
#define topAdd 6
#define heightBetweenRow 10
#define lengthOfStart 10
#define lengthBetweenInTheRow 5
#define KWidth [UIScreen mainScreen].bounds.size.width
#define imageWidth 40
#define labelWidth 40
#define fieldWidth KWidth-imageWidth-labelWidth-lengthBetweenInTheRow*3
#define leftButtonWidth [UIScreen mainScreen].bounds.size.width/4
#define rightButtonWidth [UIScreen mainScreen].bounds.size.width/4
#define nameLableLength KWidth-(leftButtonWidth+50)*2
#define lineToTop 8
#define sexViewWidth topAdd+labelWidth

//topAdd+rowHeight-10
//style

#define labelColor colorWithRed:0.922 green:0.922  blue:0.922  alpha:1
#define labelColor1 lightGrayColor
#define headerViewColor  colorWithRed:0.961 green:0.961 blue:0.961 alpha:1
#define fontSize 17
#define wordColor colorWithRed:0.004 green:0.639 blue:0.620 alpha:1


@implementation CellForUserTableViewCell{
    UIButton* editBtn;
    UIImageView* sexView;
    UIImage*  ageImage;
    UIImage* phoneImage;
    UIImage* locationImage;
    UIImage* addressImage;
}
@synthesize fieldOfAge,fieldOfAddress,fieldOfLocation,fieldOfPhone,footerView;
@synthesize labelOfName,labelOfSet,leftBtn, myIndexPath,sexes;

//初始化cell表格的方法！
-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier index:(NSIndexPath*) myIndex ID:(NSInteger ) buttonId{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        //field的情况的定义设计的方法！
        
        fieldOfAge = [[UITextField alloc] init];
        fieldOfPhone = [[UITextField alloc] init];
        fieldOfAddress = [[UITextView alloc] init];
        labelOfName = [[UILabel alloc] init];
        editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        
        leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [leftBtn addTarget:self action:@selector(setAsDefault) forControlEvents:UIControlEventTouchUpInside];
        
        fieldOfLocation = [[UITextField alloc] init];

        
        
        //声明了Label;声明所有的lable;
        UILabel* labelOfAge = [[UILabel alloc] init];
        UILabel* labelOfPhone = [[UILabel alloc] init];
        UILabel* labelOfLocation = [[UILabel alloc] init];
        UILabel* labelOfAddress = [[UILabel alloc] init];
        
        labelOfAge.text= @"年龄:";
        labelOfPhone.text = @"电话:";
        labelOfLocation.text =@"位置:";
        labelOfAddress.text =@"地址:";
        
        switch (DEVICE_ID) {
            case 1:{
                ageImage = [UIImage imageNamed:@"age-4s"];
                phoneImage = [UIImage imageNamed:@"phone"];
                locationImage = [UIImage imageNamed:@"location"];
                addressImage = [UIImage imageNamed:@"address"];
                break;
            }
            case 2:{
                ageImage = [UIImage imageNamed:@"age-4s"];
                phoneImage = [UIImage imageNamed:@"phone"];
                locationImage = [UIImage imageNamed:@"location"];
                addressImage = [UIImage imageNamed:@"address"];
                break;
            }
            case 3:{
                ageImage = [UIImage imageNamed:@"age-4s"];
                phoneImage = [UIImage imageNamed:@"phone"];
                locationImage = [UIImage imageNamed:@"location"];
                addressImage = [UIImage imageNamed:@"address"];
                break;
            }
            case 4:{
                ageImage = [UIImage imageNamed:@"age-4s"];
                phoneImage = [UIImage imageNamed:@"phone"];
                locationImage = [UIImage imageNamed:@"location"];
                addressImage = [UIImage imageNamed:@"address"];
                break;
            }
                
            default:
                break;
        }

        
        
        UIImageView* imageOfAge = [[UIImageView alloc] init];
        UIImageView* imageOfPhone = [[UIImageView alloc] init];
        UIImageView* imageOfLocation = [[UIImageView alloc] init];
        UIImageView* imageOfAddress = [[UIImageView alloc] init];
        
        imageOfAge.image = ageImage;
        imageOfPhone.image = phoneImage;
        imageOfLocation.image = locationImage;
        imageOfAddress.image = addressImage;
        
        
        
        //设置空间的style的请情况！
        [self addSubview:fieldOfAge];
        [self addSubview:fieldOfPhone];
        [self addSubview:fieldOfLocation];
        [self addSubview:fieldOfAddress];
        [self addSubview:labelOfAge];
        [self addSubview:labelOfPhone];
        [self addSubview:labelOfLocation];
        [self addSubview:labelOfAddress];
        [self addSubview:imageOfAge];
        [self addSubview:imageOfPhone];
        [self addSubview:imageOfLocation];
        [self addSubview:imageOfAddress];
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, topAdd+ 0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, KWidth, 20)];
        footerView.backgroundColor = [UIColor colorWithRed:0.941 green:0.937 blue:0.957 alpha:1];
        [self addSubview:footerView];
        
        
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, topAdd+rowHeight)];
        headerView.backgroundColor = [UIColor headerViewColor];
        
        //边界的线的画的情况！
        UIView* line1 = [[UIView alloc] initWithFrame:CGRectMake(imageWidth+lengthOfStart, topAdd+0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow/2, KWidth-imageWidth-lengthOfStart, 1)];
        line1.backgroundColor = [UIColor labelColor];
        UIView* line2 = [[UIView alloc] initWithFrame:CGRectMake(imageWidth+lengthOfStart, topAdd+0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow/2, KWidth-imageWidth-lengthOfStart, 1)];
        line2.backgroundColor = [UIColor labelColor];
        UIView* line3 = [[UIView alloc] initWithFrame:CGRectMake(imageWidth+lengthOfStart, topAdd+0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow/2, KWidth-imageWidth-lengthOfStart, 1)];
        line3.backgroundColor = [UIColor labelColor];
        UIView* line01 = [[UIView alloc] initWithFrame:CGRectMake(leftButtonWidth+6, lineToTop, 1, topAdd+rowHeight-2*lineToTop)];
        line01.backgroundColor = [UIColor labelColor];
        UIView* line02 = [[UIView alloc] initWithFrame:CGRectMake(KWidth-rightButtonWidth-2, lineToTop, 1, topAdd+rowHeight-2*lineToTop)];
        line02.backgroundColor = [UIColor labelColor];
        UIView* line03 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 1)];
        line03.backgroundColor = [UIColor labelColor];
        UIView* line04 = [[UIView alloc] initWithFrame:CGRectMake(0, topAdd+rowHeight, KWidth, 1)];
        line04.backgroundColor = [UIColor labelColor];
        //UIView* line05 = [[UIView alloc] initWithFrame:CGRectMake(0, topAdd+ 0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, KWidth, 1)];
        //line05.backgroundColor = [UIColor labelColor];
        
        [headerView addSubview:line03];
        [headerView addSubview:line04];
        //[headerView addSubview:line05];
        
        NSString* tmpStr = [[NSString alloc] init];
        tmpStr = sexes;
        
        
        UIImage* sex =[UIImage imageNamed:tmpStr];
        sexView = [[UIImageView alloc] initWithFrame:CGRectMake(lengthOfStart+leftButtonWidth+20, 5, topAdd+rowHeight-10, topAdd+rowHeight-10)];
        sexView.image = sex;
        [headerView addSubview:sexView];
        
        
        
        
        
        
        [self addSubview:headerView];
        [headerView addSubview:labelOfName];
        [headerView addSubview:editBtn];
        [headerView addSubview:leftBtn];
        [self addSubview:line1];
        [self addSubview:line2];
        [self addSubview:line3];
        [self addSubview:line01];
        [self addSubview:line02];
        
        
        //设置空间的style的1你情况！
        fieldOfAge.text = @"24";
        fieldOfAge.frame =CGRectMake(lengthOfStart+lengthBetweenInTheRow+lengthBetweenInTheRow+imageWidth+labelWidth, topAdd+0+rowHeight+heightBetweenRow, fieldWidth, rowHeight);
        fieldOfPhone.frame =CGRectMake(lengthOfStart+lengthBetweenInTheRow+lengthBetweenInTheRow+imageWidth+labelWidth, topAdd+0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, fieldWidth, rowHeight);
        fieldOfLocation.frame =CGRectMake(lengthOfStart+lengthBetweenInTheRow+lengthBetweenInTheRow+imageWidth+labelWidth,topAdd+ 0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, fieldWidth, rowHeight);
        fieldOfAddress.frame =CGRectMake(lengthOfStart+lengthBetweenInTheRow+lengthBetweenInTheRow+imageWidth+labelWidth - 5, topAdd+0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow + 2, fieldWidth, rowHeight);
        labelOfAge.frame =CGRectMake(lengthOfStart+imageWidth, topAdd+0+rowHeight+heightBetweenRow, labelWidth, rowHeight);
        labelOfPhone.frame =CGRectMake(lengthOfStart+imageWidth, topAdd+0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, labelWidth, rowHeight);
        labelOfLocation.frame =CGRectMake(lengthOfStart+imageWidth, topAdd+0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, labelWidth, rowHeight);
        labelOfAddress.frame =CGRectMake(lengthOfStart+imageWidth, topAdd+0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, labelWidth, rowHeight);
        imageOfAge.frame =CGRectMake(lengthOfStart, topAdd+0+rowHeight+heightBetweenRow, imageWidth, rowHeight);
        imageOfPhone.frame =CGRectMake(lengthOfStart,topAdd+ 0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, imageWidth, rowHeight);
        imageOfLocation.frame =CGRectMake(lengthOfStart, topAdd+0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, imageWidth, rowHeight);
        imageOfAddress.frame =CGRectMake(lengthOfStart,topAdd+ 0+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow+rowHeight+heightBetweenRow, imageWidth, rowHeight);
        
        labelOfName.frame =CGRectMake(lengthBetweenInTheRow+lengthOfStart+leftButtonWidth+sexViewWidth+lengthBetweenInTheRow+5, 0, nameLableLength, topAdd+rowHeight);
        labelOfName.text = @"1";
        editBtn.frame =CGRectMake(KWidth-rightButtonWidth, 0, rightButtonWidth, topAdd+rowHeight);
        leftBtn.frame =CGRectMake(lengthOfStart, 0, leftButtonWidth, topAdd+rowHeight);
        
        
        labelOfAge.font = [UIFont boldSystemFontOfSize:fontSize];
        labelOfPhone.font = [UIFont boldSystemFontOfSize:fontSize];
        labelOfLocation.font = [UIFont boldSystemFontOfSize:fontSize];
        labelOfAddress.font = [UIFont boldSystemFontOfSize:fontSize];
        labelOfAge.textColor =[UIColor labelColor1];
        labelOfPhone.textColor =[UIColor labelColor1];
        labelOfLocation.textColor =[UIColor labelColor1];
        labelOfAddress.textColor =[UIColor labelColor1];
        
        fieldOfAge.font = [UIFont boldSystemFontOfSize:fontSize];
        fieldOfPhone.font = [UIFont boldSystemFontOfSize:fontSize];
        fieldOfLocation.font = [UIFont boldSystemFontOfSize:fontSize];
        fieldOfAddress.font = [UIFont boldSystemFontOfSize:fontSize];
        
        
        fieldOfAge.textColor =[UIColor wordColor];
        fieldOfPhone.textColor =[UIColor wordColor];
        fieldOfLocation.textColor =[UIColor wordColor];
        fieldOfAddress.textColor =[UIColor wordColor];
        
        labelOfName.textColor = [UIColor wordColor];
        leftBtn.tintColor = [UIColor wordColor];
        editBtn.tintColor = [UIColor wordColor];
        leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        editBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        
        [fieldOfAge setEnabled:NO];
        [fieldOfPhone setEnabled:NO];
        [fieldOfLocation setEnabled:NO];
        [fieldOfAddress setUserInteractionEnabled:NO];
    }
    
    return self;
}


//用于设置性别头像的图片！
- (void) setsexImage:(NSString*) sexess{
    UIImage* sex =[[UIImage alloc] init];
    if([sexess  isEqual: @"male.jpg"]){
        switch (DEVICE_ID) {
            case 1:{
                sex = [UIImage imageNamed:@"male-4s"];
                break;
            }
            case 2:{
               sex = [UIImage imageNamed:@"male"];
                break;
            }
            case 3:{
                sex = [UIImage imageNamed:@"male"];
                break;
            }
            case 4:{
               sex = [UIImage imageNamed:@"male"];
                break;
            }
                
            default:
                break;
        }
    }else{
        switch (DEVICE_ID) {
            case 1:{
                sex = [UIImage imageNamed:@"female-4s"];
                break;
            }
            case 2:{
                sex = [UIImage imageNamed:@"female"];
                break;
            }
            case 3:{
                sex = [UIImage imageNamed:@"female"];
                break;
            }
            case 4:{
                sex = [UIImage imageNamed:@"female"];
                break;
            }
                
            default:
                break;
        }

        
    }
    sexView.image = sex;

}


//响应Cell右上角的编辑的事件！
- (void) edit{
    MyTableView *table = (MyTableView *)[[self superview]superview];
    NSIndexPath *index=  [table indexPathForCell:self];
    [table setCell:index];
    
}


//响应Cell左上角的设为默认的事件！
- (void) setAsDefault{
    MyTableView *table = (MyTableView *)[[self superview]superview];
    NSIndexPath *index=  [table indexPathForCell:self];
        NSLog(@"section = %ld row = %ld",(long)index.section,(long)index.row);
    if (index.section != 0) {
        [table setDefaultInformationAtIndex:index];
    }
}


@end
