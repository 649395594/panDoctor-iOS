//
//  FunnyTestViewController.m
//  Pan大夫
//
//  Created by Juvia Xin on 15/5/3.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "FunnyTestViewController.h"

#define ratio6 375/414
#define ratio5 320/414
#define FrameH [[UIScreen mainScreen]bounds].size.height
#define headGap (((FrameH > 567) && (FrameH < 569))? 15 * ratio5:(((FrameH > 666) && (FrameH < 668))? 15 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 15 : 15 * ratio5)))
#define headHeight (((FrameH > 567) && (FrameH < 569))? 42 * ratio5:(((FrameH > 666) && (FrameH < 668))? 42 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 42 : 42 * ratio5)))
#define numWidth (((FrameH > 567) && (FrameH < 569))? 40 * ratio5:(((FrameH > 666) && (FrameH < 668))? 40 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 40 : 40 * ratio5)))
#define headWidth (((FrameH > 567) && (FrameH < 569))? 350 * ratio5:(((FrameH > 666) && (FrameH < 668))? 350 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 350 : 350 * ratio5)))
#define picGap (((FrameH > 567) && (FrameH < 569))? 65 * ratio5:(((FrameH > 666) && (FrameH < 668))? 65 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 65 : 65 * ratio5)))
#define picWidth (((FrameH > 567) && (FrameH < 569))? 360 * ratio5:(((FrameH > 666) && (FrameH < 668))? 360 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 360 : 360 * ratio5)))
#define explainGap (((FrameH > 567) && (FrameH < 569))? 23 * ratio5:(((FrameH > 666) && (FrameH < 668))? 23 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 23 : 23 * ratio5)))
#define explainHeight (((FrameH > 567) && (FrameH < 569))? 67 * ratio5:(((FrameH > 666) && (FrameH < 668))? 67 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 67 : 67 * ratio5)))
#define explainWidth (((FrameH > 567) && (FrameH < 569))? 390 * ratio5:(((FrameH > 666) && (FrameH < 668))? 390 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 390 : 390 * ratio5)))
#define principleGap (((FrameH > 567) && (FrameH < 569))? 23 * ratio5:(((FrameH > 666) && (FrameH < 668))? 23 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 23 : 23 * ratio5)))
#define labelGap (((FrameH > 567) && (FrameH < 569))? 15 * ratio5:(((FrameH > 666) && (FrameH < 668))? 15 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 15 : 15 * ratio5)))
#define labelLeft (((FrameH > 567) && (FrameH < 569))? 85 * ratio5:(((FrameH > 666) && (FrameH < 668))? 85 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 85 : 85 * ratio5)))
#define labelHeight (((FrameH > 567) && (FrameH < 569))? 40 * ratio5:(((FrameH > 666) && (FrameH < 668))? 40 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 40 : 40 * ratio5)))
#define labelWidth (((FrameH > 567) && (FrameH < 569))? 122 * ratio5:(((FrameH > 666) && (FrameH < 668))? 122 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 122 : 122 * ratio5)))
#define ansHeight (((FrameH > 567) && (FrameH < 569))? 36 * ratio5:(((FrameH > 666) && (FrameH < 668))? 36 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 36 : 36 * ratio5)))
#define leftLike (((FrameH > 567) && (FrameH < 569))? 63 * ratio5:(((FrameH > 666) && (FrameH < 668))? 63 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 63 : 63 * ratio5)))
#define titleFont (((FrameH > 567) && (FrameH < 569))? 13:(((FrameH > 666) && (FrameH < 668))? 15 : (((FrameH > 735) && (FrameH < 737))? 17 : 13)))

@interface FunnyTestViewController ()

@property (strong , nonatomic) UILabel *numLabel;
@property (strong , nonatomic) UIScrollView *scrollView;
@property (strong , nonatomic) UITextView *headView;
@property (strong , nonatomic) UIView *headBackground;
@property (strong , nonatomic) UIImageView *pictureView;
@property (strong , nonatomic) UITextView *explainView;

@property (strong , nonatomic) UILabel *LabelA;
@property (strong , nonatomic) UILabel *LabelB;
@property (strong , nonatomic) UILabel *LabelC;
@property (strong , nonatomic) UILabel *LabelD;
@property (strong , nonatomic) UILabel *LabelE;
@property (strong , nonatomic) UILabel *LabelF;
@property (strong , nonatomic) UIButton *choiceAButton;
@property (strong , nonatomic) UIButton *choiceBButton;
@property (strong , nonatomic) UIButton *choiceCButton;
@property (strong , nonatomic) UIButton *choiceDButton;
@property (strong , nonatomic) UIButton *choiceEButton;
@property (strong , nonatomic) UIButton *choiceFButton;
@property (strong , nonatomic) UIButton *ansButton;
@property (strong , nonatomic) NSString *ansA;
@property (strong , nonatomic) NSString *ansB;
@property (strong , nonatomic) NSString *ansC;
@property (strong , nonatomic) NSString *ansD;
@property (strong , nonatomic) NSMutableAttributedString *prin;
@property int choice;
@property float picHeight;
@property (strong , nonatomic) FunnyTestViewController *funnyTestans;
@property (strong , nonatomic) UIButton *likeButton;
@property (strong , nonatomic) UIButton *shareButton;
@property (strong , nonatomic) UIView *view1;
@property (strong , nonatomic) UIView *view2;
@property (strong , nonatomic) UIImageView *heart;
@property (strong , nonatomic) UIImageView *share;
@property int Index;

@end


@implementation FunnyTestViewController

@synthesize scrollView, numLabel, headView, pictureView, explainView, LabelA, LabelB, LabelC, LabelD, choiceAButton, choiceBButton, choiceCButton, choiceDButton, ansButton, choice, funnyTestans, ansA, ansB, ansC, ansD, prin, picHeight, likeButton, shareButton, view1, view2, heart, share, Index, headBackground, LabelE, LabelF, choiceEButton, choiceFButton, delegate;

-(id)initWithHead:(NSString *)head picture:(UIImage *)picture explain:(NSString *)explain index:(int)index{
    Index = index;
    picHeight = picWidth * picture.size.height / picture.size.width;
    self = [super init];
    self.view.frame = CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.view.backgroundColor = [UIColor whiteColor];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64)];
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, picGap + picHeight + explainHeight + explainGap + headGap);
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, headGap * 1.7, numWidth, headHeight- numWidth * 0.4)];
    numLabel.text =  [[NSString alloc] initWithFormat:@"%d%@", index + 1,@":"];
    numLabel.textAlignment = NSTextAlignmentRight;
    
    numLabel.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    numLabel.font = [UIFont boldSystemFontOfSize:titleFont + 7];
    numLabel.textColor = [UIColor colorWithRed:31/255.0 green:174/255.0 blue:169/255.0 alpha:1.0];
    headView = [[UITextView alloc] initWithFrame:CGRectMake(numWidth, headGap * 1.4, headWidth, headHeight - headGap * 0.4)];
    [headView.layer setMasksToBounds:YES];
    [headView.layer setCornerRadius:4.0];
    headBackground = [[UIView alloc] initWithFrame:CGRectMake(-4, headGap, headWidth + numWidth + 4, headHeight)];
    headBackground.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [headBackground.layer setMasksToBounds:YES];
    [headBackground.layer setCornerRadius:4.0];
    headView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    headView.font = [UIFont boldSystemFontOfSize:titleFont];
    pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - picWidth) / 2, picGap, picWidth, picHeight)];
    explainView = [[UITextView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - explainWidth, picGap + picHeight + explainGap, explainWidth + 4, explainHeight)];
    explainView.backgroundColor = [UIColor colorWithRed:31/255.0 green:174/255.0 blue:169/255.0 alpha:1.0];
    explainView.textColor = [UIColor whiteColor];
    [explainView.layer setMasksToBounds:YES];
    [explainView.layer setCornerRadius:4.0];
    headView.text = head;
    pictureView.image = picture;
    explainView.text = explain;
    explainView.font = [UIFont boldSystemFontOfSize:titleFont - 1];
    headView.editable = NO;
    headView.userInteractionEnabled = NO;
    explainView.editable = NO;
    explainView.userInteractionEnabled = NO;
    [scrollView addSubview:headBackground];
    [scrollView addSubview:headView];
    [scrollView addSubview:numLabel];
    [scrollView addSubview:headView];
    [scrollView addSubview:pictureView];
    [scrollView addSubview:explainView];
    
    likeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64, [[UIScreen mainScreen] bounds].size.width / 2, 64)];
    shareButton = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height - 64, [[UIScreen mainScreen] bounds].size.width / 2, 64)];
    likeButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    shareButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [likeButton setTitle:@"  喜欢" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]forState:UIControlStateNormal];
    [shareButton setTitle:@"  分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]forState:UIControlStateNormal];
    heart = [[UIImageView alloc]initWithFrame:CGRectMake(leftLike, [[UIScreen mainScreen] bounds].size.height - 42, 20, 20)];
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];//plist文件位置
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
    NSDictionary *testItem;
    NSString *string = [[NSString alloc] initWithFormat:@"%@%d",@"item", index];
    testItem = [plistDictionary objectForKey:string];
    heart.image = [UIImage imageNamed:[testItem objectForKey:@"heart"]];
    [likeButton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    
    
    share = [[UIImageView alloc]initWithFrame:CGRectMake(leftLike + [[UIScreen mainScreen] bounds].size.width / 2 - 3, [[UIScreen mainScreen] bounds].size.height - 42, 26, 20)];
    share.image = [UIImage imageNamed:@"share"];
    
    [self.view addSubview:likeButton];
    [self.view addSubview:heart];
    [self.view addSubview:shareButton];
    [self.view addSubview:share];
    
    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64.5, [[UIScreen mainScreen] bounds].size.width, 0.5)];
    view1.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    view2 = [[UIView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 0.5) / 2, [[UIScreen mainScreen] bounds].size.height - 46, 0.5, 28)];
    view2.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    return self;
}
-(void)backToRootView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)DoLike
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];//plist文件位置
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
    NSDictionary *testItem;
    NSString *string = [[NSString alloc] initWithFormat:@"%@%d",@"item", Index];
    testItem = [plistDictionary objectForKey:string];
    NSLog(@"Dolike");
    heart.image = [UIImage imageNamed:[testItem objectForKey:@"heart"]];
    [delegate DoLike];
}

-(id)initWithHead:(NSString *)head picture:(UIImage *)picture choiceA:(NSString *)choiceA choiceB:(NSString *)choiceB choiceC:(NSString *)choiceC choiceD:(NSString *)choiceD choiceAans:(NSString *)choiceAans choiceBans:(NSString *)choiceBans choiceCans:(NSString *)choiceCans choiceD:(NSString *)choiceDans index:(int)index{
    int choices;
    NSRange _range = [choiceA rangeOfString:@" "];
    NSRange _range2 = [choiceB rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        if (_range2.location != NSNotFound) {
            choices = 6;
        } else {
            choices = 5;
        }
    } else {
        choices = 4;
    }
    Index = index;
    picHeight = picWidth * picture.size.height / picture.size.width;
    self = [super init];
    self.view.frame = CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.view.backgroundColor = [UIColor whiteColor];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64)];
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, picGap + picHeight + labelGap * 2 + labelHeight * 2 + ansHeight + headGap);
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, headGap * 1.7, numWidth, headHeight- numWidth * 0.4)];
    numLabel.text = @"A:";
    numLabel.textAlignment = NSTextAlignmentRight;
    
    numLabel.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    numLabel.font = [UIFont boldSystemFontOfSize:titleFont + 7];
    numLabel.textColor = [UIColor colorWithRed:31/255.0 green:174/255.0 blue:169/255.0 alpha:1.0];
    headView = [[UITextView alloc] initWithFrame:CGRectMake(numWidth, headGap * 1.4, headWidth, headHeight - headGap * 0.4)];
    headBackground = [[UIView alloc] initWithFrame:CGRectMake(-4, headGap, headWidth + numWidth + 4, headHeight)];
    headBackground.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    headView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    headView.font = [UIFont boldSystemFontOfSize:titleFont];
    [headView.layer setMasksToBounds:YES];
    [headView.layer setCornerRadius:4.0];
    [headBackground.layer setMasksToBounds:YES];
    [headBackground.layer setCornerRadius:4.0];
    pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - picWidth) / 2, picGap, picWidth, picHeight)];
    headView.text = head;
    pictureView.image = picture;
    headView.editable = NO;
    headView.userInteractionEnabled = NO;
    LabelA = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, picGap + picHeight + labelGap, labelWidth, labelHeight)];
    LabelB = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft * 2 + labelWidth, picGap + picHeight + labelGap, labelWidth, labelHeight)];
    LabelC = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, picGap + picHeight + labelGap + labelHeight, labelWidth, labelHeight)];
    LabelD = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft * 2 + labelWidth, picGap + picHeight + labelGap + labelHeight, labelWidth, labelHeight)];
    if (choices >= 5) {
        LabelA.text = [choiceA substringToIndex:_range.location];
        LabelE = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, picGap + picHeight + labelGap + labelHeight * 2, labelWidth, labelHeight)];
        LabelE.text = [choiceA substringFromIndex:_range.location + 1];
        LabelB.text = choiceB;
        choiceEButton = [[UIButton alloc] initWithFrame:CGRectMake(0, picGap + picHeight + labelGap + labelHeight * 2, labelLeft, labelHeight)];
        [choiceEButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
        [choiceEButton addTarget:self action:@selector(Echose) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:choiceEButton];
        [scrollView addSubview:LabelE];
        ansButton = [[UIButton alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - picWidth) / 2, picGap + picHeight + labelGap * 2 + labelHeight * 3, picWidth, ansHeight)];
        scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, picGap + picHeight + labelGap * 2 + labelHeight * 3 + ansHeight + headGap);
        if (choices == 6) {
            LabelB.text = [choiceB substringToIndex:_range2.location];
            LabelF = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft * 2 + labelWidth, picGap + picHeight + labelGap + labelHeight * 2, labelWidth, labelHeight)];
            LabelF.text = [choiceB substringFromIndex:_range2.location + 1];
            choiceFButton = [[UIButton alloc] initWithFrame:CGRectMake(labelLeft + labelWidth, picGap + picHeight + labelGap + labelHeight * 2, labelLeft, labelHeight)];
            [choiceFButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
            [choiceFButton addTarget:self action:@selector(Fchose) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:choiceFButton];
            [scrollView addSubview:LabelF];
        }
    } else {
        LabelA.text = choiceA;
        LabelB.text = choiceB;
        ansButton = [[UIButton alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - picWidth) / 2, picGap + picHeight + labelGap * 2 + labelHeight * 2, picWidth, ansHeight)];
    }
    
    LabelC.text = choiceC;
    LabelD.text = choiceD;
    choiceAButton = [[UIButton alloc] initWithFrame:CGRectMake(0, picGap + picHeight + labelGap, labelLeft, labelHeight)];
    choiceBButton = [[UIButton alloc] initWithFrame:CGRectMake(labelLeft + labelWidth, picGap + picHeight + labelGap, labelLeft, labelHeight)];
    choiceCButton = [[UIButton alloc] initWithFrame:CGRectMake(0, picGap + picHeight + labelGap  + labelHeight, labelLeft, labelHeight)];
    choiceDButton = [[UIButton alloc] initWithFrame:CGRectMake(labelLeft + labelWidth, picGap + picHeight + labelGap + labelHeight, labelLeft, labelHeight)];
    
    
    [choiceAButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceBButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceCButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceDButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];

    [choiceAButton addTarget:self action:@selector(Achose) forControlEvents:UIControlEventTouchUpInside];
    [choiceBButton addTarget:self action:@selector(Bchose) forControlEvents:UIControlEventTouchUpInside];
    [choiceCButton addTarget:self action:@selector(Cchose) forControlEvents:UIControlEventTouchUpInside];
    [choiceDButton addTarget:self action:@selector(Dchose) forControlEvents:UIControlEventTouchUpInside];
    
    ansA = choiceAans;
    ansB = choiceBans;
    ansC = choiceCans;
    ansD = choiceDans;
    
    [ansButton setTitle:@"查看答案" forState:UIControlStateNormal];
    ansButton.titleLabel.font = [UIFont boldSystemFontOfSize:titleFont];
    ansButton.backgroundColor = [UIColor colorWithRed:28/255.0 green:174/255.0 blue:169/255.0 alpha:1.0];
    [ansButton.layer setMasksToBounds:YES];
    [ansButton.layer setCornerRadius:4.0];
    
    [scrollView addSubview:headBackground];
    [scrollView addSubview:numLabel];
    [scrollView addSubview:headView];
    [scrollView addSubview:pictureView];
    [scrollView addSubview:LabelA];
    [scrollView addSubview:LabelB];
    [scrollView addSubview:LabelC];
    [scrollView addSubview:LabelD];
    [scrollView addSubview:choiceAButton];
    [scrollView addSubview:choiceBButton];
    [scrollView addSubview:choiceCButton];
    [scrollView addSubview:choiceDButton];
    [scrollView addSubview:ansButton];
    
    [ansButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    likeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64, [[UIScreen mainScreen] bounds].size.width / 2, 64)];
    shareButton = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height - 64, [[UIScreen mainScreen] bounds].size.width / 2, 64)];
    likeButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    shareButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [likeButton setTitle:@"  喜欢" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]forState:UIControlStateNormal];
    [shareButton setTitle:@"  分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]forState:UIControlStateNormal];
    heart = [[UIImageView alloc]initWithFrame:CGRectMake(leftLike, [[UIScreen mainScreen] bounds].size.height - 42, 20, 20)];
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];//plist文件位置
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
    NSDictionary *testItem;
    NSString *string = [[NSString alloc] initWithFormat:@"%@%d",@"item", Index];
    testItem = [plistDictionary objectForKey:string];
    heart.image = [UIImage imageNamed:[testItem objectForKey:@"heart"]];
    [likeButton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    
    
    share = [[UIImageView alloc]initWithFrame:CGRectMake(leftLike + [[UIScreen mainScreen] bounds].size.width / 2 - 3, [[UIScreen mainScreen] bounds].size.height - 42, 26, 20)];
    share.image = [UIImage imageNamed:@"share"];
    
    [self.view addSubview:likeButton];
    [self.view addSubview:heart];
    [self.view addSubview:shareButton];
    [self.view addSubview:share];
    
    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64.5, [[UIScreen mainScreen] bounds].size.width, 0.5)];
    view1.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    view2 = [[UIView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 0.5) / 2, [[UIScreen mainScreen] bounds].size.height - 46, 0.5, 28)];
    view2.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    return self;
    
}

-(void)like{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];//plist文件位置
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
    NSDictionary *testItem;
    NSString *string = [[NSString alloc] initWithFormat:@"%@%d",@"item", Index];
    testItem = [plistDictionary objectForKey:string];
    if ([[testItem objectForKey:@"heart"] isEqual: @"heart1"]) {
        [testItem setValue:@"heart2" forKey:@"heart"];
    } else {
        [testItem setValue:@"heart1" forKey:@"heart"];
    }
    [plistDictionary writeToFile:documentPlistPath atomically:YES];
    heart.image = [UIImage imageNamed:[testItem objectForKey:@"heart"]];
    [delegate DoLike];
}

-(id)initWithHead:(NSString *)head choiceAans:(NSString *)choiceAans choiceBans:(NSString *)choiceBans choiceCans:(NSString *)choiceCans choiceDans:(NSString *)choiceDans chioce:(int)Choice index:(int)index{
    int choices;
    NSRange _range = [choiceAans rangeOfString:@" "];
    NSRange _range2 = [choiceBans rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        if (_range2.location != NSNotFound) {
            choices = 6;
        } else {
            choices = 5;
        }
    } else {
        choices = 4;
    }
    Index = index;
    self = [super init];
    self.view.frame = CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.view.backgroundColor = [UIColor whiteColor];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64)];
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, picGap * 1.2 + labelHeight * 4.5 + ansHeight + headGap);
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, headGap * 1.7, numWidth, headHeight- numWidth * 0.4)];
    numLabel.text = @"Q:";
    numLabel.textAlignment = NSTextAlignmentRight;
    
    numLabel.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    numLabel.font = [UIFont boldSystemFontOfSize:titleFont + 7];
    numLabel.textColor = [UIColor colorWithRed:31/255.0 green:174/255.0 blue:169/255.0 alpha:1.0];
    headView = [[UITextView alloc] initWithFrame:CGRectMake(numWidth, headGap * 1.4, headWidth, headHeight - headGap * 0.4)];
    headBackground = [[UIView alloc] initWithFrame:CGRectMake(-4, headGap, headWidth + numWidth + 4, headHeight)];
    headBackground.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    headView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    headView.font = [UIFont boldSystemFontOfSize:titleFont];
    [headView.layer setMasksToBounds:YES];
    [headView.layer setCornerRadius:4.0];
    [headBackground.layer setMasksToBounds:YES];
    [headBackground.layer setCornerRadius:4.0];
    headView.text = head;
    headView.editable = NO;
    headView.userInteractionEnabled = NO;
    LabelA = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, picGap * 1.2, [[UIScreen mainScreen] bounds].size.width - labelLeft, labelHeight)];
    LabelB = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, picGap * 1.2 + labelHeight, [[UIScreen mainScreen] bounds].size.width - labelLeft, labelHeight)];
    LabelC = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, picGap * 1.2 + labelHeight * 2, [[UIScreen mainScreen] bounds].size.width - labelLeft, labelHeight)];
    LabelD = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, picGap * 1.2 + labelHeight * 3, [[UIScreen mainScreen] bounds].size.width - labelLeft, labelHeight)];
    if (choices >= 5) {
        LabelA.text = [choiceAans substringToIndex:_range.location];
        LabelE = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, picGap * 1.2 + labelHeight * 4, [[UIScreen mainScreen] bounds].size.width - labelLeft, labelHeight)];
        LabelE.text = [choiceAans substringFromIndex:_range.location + 1];
        LabelB.text = choiceBans;
        choiceEButton = [[UIButton alloc] initWithFrame:CGRectMake(0, picGap * 1.2 + labelHeight * 4, labelLeft, labelHeight)];
        [choiceEButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
        [scrollView addSubview:choiceEButton];
        [scrollView addSubview:LabelE];
        ansButton = [[UIButton alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - picWidth) / 2, picGap * 1.2 + labelHeight * 5.5, picWidth, ansHeight)];
        scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, picGap * 1.2 + labelHeight * 5.5 + ansHeight + headGap);
        if (choices == 6) {
            LabelB.text = [choiceBans substringToIndex:_range2.location];
            LabelF = [[UILabel alloc] initWithFrame:CGRectMake(labelLeft, picGap * 1.2 + labelHeight * 5, [[UIScreen mainScreen] bounds].size.width - labelLeft, labelHeight)];
            LabelF.text = [choiceBans substringFromIndex:_range2.location + 1];
            choiceFButton = [[UIButton alloc] initWithFrame:CGRectMake(0, picGap * 1.2 + labelHeight * 5, labelLeft, labelHeight)];
            [choiceFButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
            ansButton = [[UIButton alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - picWidth) / 2, picGap * 1.2 + labelHeight * 6.5, picWidth, ansHeight)];
            scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, picGap * 1.2 + labelHeight * 6.5 + ansHeight + headGap);
            [scrollView addSubview:choiceFButton];
            [scrollView addSubview:LabelF];
        }
    } else {
        LabelA.text = choiceAans;
        LabelB.text = choiceBans;
        ansButton = [[UIButton alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - picWidth) / 2, picGap * 1.2 + labelHeight * 4.5, picWidth, ansHeight)];
    }
    LabelC.text = choiceCans;
    LabelD.text = choiceDans;
    choiceAButton = [[UIButton alloc] initWithFrame:CGRectMake(0, picGap * 1.2, labelLeft, labelHeight)];
    choiceBButton = [[UIButton alloc] initWithFrame:CGRectMake(0, picGap * 1.2 + labelHeight, labelLeft, labelHeight)];
    choiceCButton = [[UIButton alloc] initWithFrame:CGRectMake(0, picGap * 1.2 + labelHeight * 2, labelLeft, labelHeight)];
    choiceDButton = [[UIButton alloc] initWithFrame:CGRectMake(0, picGap * 1.2 + labelHeight * 3, labelLeft, labelHeight)];
    
    
    [choiceAButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceBButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceCButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceDButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    switch (Choice) {
        case 1:
            [choiceAButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
            break;
        case 2:
            [choiceBButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
            break;
        case 3:
            [choiceCButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
            break;
        case 4:
            [choiceDButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
            break;
        case 5:
            [choiceEButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
            break;
        case 6:
            [choiceFButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    choiceAButton.userInteractionEnabled = NO;
    choiceBButton.userInteractionEnabled = NO;
    choiceCButton.userInteractionEnabled = NO;
    choiceDButton.userInteractionEnabled = NO;
    
    
    [ansButton setTitle:@"返回重测" forState:UIControlStateNormal];
    ansButton.titleLabel.font = [UIFont boldSystemFontOfSize:titleFont];
    ansButton.backgroundColor = [UIColor colorWithRed:28/255.0 green:174/255.0 blue:169/255.0 alpha:1.0];
    [ansButton.layer setMasksToBounds:YES];
    [ansButton.layer setCornerRadius:4.0];
    
    [scrollView addSubview:headBackground];
    [scrollView addSubview:numLabel];
    [scrollView addSubview:headView];
    [scrollView addSubview:LabelA];
    [scrollView addSubview:LabelB];
    [scrollView addSubview:LabelC];
    [scrollView addSubview:LabelD];
    [scrollView addSubview:choiceAButton];
    [scrollView addSubview:choiceBButton];
    [scrollView addSubview:choiceCButton];
    [scrollView addSubview:choiceDButton];
    [scrollView addSubview:ansButton];
    
    [ansButton addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    
    
    likeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64, [[UIScreen mainScreen] bounds].size.width / 2, 64)];
    shareButton = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.height - 64, [[UIScreen mainScreen] bounds].size.width / 2, 64)];
    likeButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    shareButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [likeButton setTitle:@"  喜欢" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]forState:UIControlStateNormal];
    [shareButton setTitle:@"  分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:1.0]forState:UIControlStateNormal];
    heart = [[UIImageView alloc]initWithFrame:CGRectMake(leftLike, [[UIScreen mainScreen] bounds].size.height - 42, 20, 20)];
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *documentPlistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];//plist文件位置
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:documentPlistPath];
    NSDictionary *testItem;
    NSString *string = [[NSString alloc] initWithFormat:@"%@%d",@"item", Index];
    testItem = [plistDictionary objectForKey:string];
    heart.image = [UIImage imageNamed:[testItem objectForKey:@"heart"]];
    [likeButton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    
    
    share = [[UIImageView alloc]initWithFrame:CGRectMake(leftLike + [[UIScreen mainScreen] bounds].size.width / 2 - 3, [[UIScreen mainScreen] bounds].size.height - 42, 26, 20)];
    share.image = [UIImage imageNamed:@"share"];
    
    [self.view addSubview:likeButton];
    [self.view addSubview:heart];
    [self.view addSubview:shareButton];
    [self.view addSubview:share];
    
    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 64.5, [[UIScreen mainScreen] bounds].size.width, 0.5)];
    view1.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    view2 = [[UIView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 0.5) / 2, [[UIScreen mainScreen] bounds].size.height - 46, 0.5, 28)];
    view2.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
//    backItem.title = @"返回";
//    self.navigationItem.backBarButtonItem = backItem;
    
    
    
    return self;
}


- (void)Achose {
    [choiceAButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
    [choiceBButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceCButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceDButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    if (choiceEButton != nil) {
        [choiceEButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    }
    if (choiceFButton != nil) {
        [choiceFButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    }
    choice = 1;
}
- (void)Bchose {
    [choiceAButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceBButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
    [choiceCButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceDButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    if (choiceEButton != nil) {
        [choiceEButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    }
    if (choiceFButton != nil) {
        [choiceFButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    }
    choice = 2;
}
- (void)Cchose {
    [choiceAButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceBButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceCButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
    [choiceDButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    if (choiceEButton != nil) {
        [choiceEButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    }
    if (choiceFButton != nil) {
        [choiceFButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    }
    choice = 3;
}
- (void)Dchose {
    [choiceAButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceBButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceCButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceDButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
    if (choiceEButton != nil) {
        [choiceEButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    }
    if (choiceFButton != nil) {
        [choiceFButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    }
    choice = 4;
}
- (void)Echose {
    [choiceAButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceBButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceCButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceDButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceEButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
    if (choiceFButton != nil) {
        [choiceFButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    }
    choice = 5;
}
- (void)Fchose {
    [choiceAButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceBButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceCButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceDButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceEButton setImage:[UIImage imageNamed:@"circle1.png"] forState:UIControlStateNormal];
    [choiceFButton setImage:[UIImage imageNamed:@"circle2.png"] forState:UIControlStateNormal];
    choice = 6;
}

- (void)submit{
    funnyTestans = [[FunnyTestViewController alloc]initWithHead:@"测试结果仅供娱乐，不为专业指导"choiceAans:ansA choiceBans:ansB choiceCans:ansC choiceDans:ansD chioce:choice  index: Index];
    funnyTestans.delegate = self;
    [self.navigationController pushViewController:funnyTestans animated:YES];
}

- (void)returnBack {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"趣味测试";

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

@end
