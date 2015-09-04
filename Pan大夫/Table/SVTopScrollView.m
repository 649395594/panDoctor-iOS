//
//  SVTopScrollView.m
//  SlideView
//
//  Created by Chen Yaoqiang on 13-12-27.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import "SVTopScrollView.h"
#import "SVRootScrollView.h"
#import "ScrollableTable.h"

//按钮空隙
#define BUTTONGAP 20
//滑条宽度
#define CONTENTSIZEX 320
//按钮id
#define BUTTONID (sender.tag-100)
#define kBarWidth 2
#define kButtonWidth 42
#define kButtonWidth_6plus 48
//滑动id
#define BUTTONSELECTEDID (scrollViewSelectedChannelID - 100)

@implementation SVTopScrollView

@synthesize nameArray,diseaseArray,tables,buttons;
@synthesize scrollViewSelectedChannelID;
@synthesize buttomBar,button;

+ (SVTopScrollView *)shareInstance {
    static SVTopScrollView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (IS_IPHONE_4S_SCREEN) {
            _instance=[[self alloc] initWithFrame:CGRectMake(0, IOS7_STATUS_BAR_HEGHT+44, 320, 32)];
        }
        else if (IS_IPHONE_5S_SCREEN) {
            _instance=[[self alloc] initWithFrame:CGRectMake(0, IOS7_STATUS_BAR_HEGHT+44,320, 32)];
            
        }
        else if (IS_IPHONE_6_SCREEN) {
            _instance=[[self alloc] initWithFrame:CGRectMake(0, IOS7_STATUS_BAR_HEGHT+44, 375, 40)];
            
        }
        else{
            _instance=[[self alloc] initWithFrame:CGRectMake(0, IOS7_STATUS_BAR_HEGHT+44, [[UIScreen mainScreen]bounds].size.width, 48)];
            
        }

    });
    return _instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        
        userSelectedChannelID = 100;
        scrollViewSelectedChannelID = 100;
        
        self.buttonOriginXArray = [NSMutableArray array];//creates and returns an empty
        self.buttonWithArray = [NSMutableArray array];
        
        buttomBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - kBarWidth-0.5, kButtonWidth + BUTTONGAP, kBarWidth)];
        buttomBar.backgroundColor = [UIColor orangeColor];
        [self addSubview:buttomBar];
    }
    return self;
}

- (void)initWithNameButtons
{
    buttons = [[NSMutableArray alloc]init];
    float xPos = BUTTONGAP/2;
    for (int i = 0; i < [self.nameArray count]; i++) {
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [self.nameArray objectAtIndex:i];
        
        [button setTag:i+100];
        if (i == 0) {
            button.selected = YES;
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        
        int buttonWidth = kButtonWidth;
        if ([[UIScreen mainScreen]bounds].size.width<=320) {
             button.frame = CGRectMake(xPos, 3, buttonWidth, 30);
             button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        }
        else if (IS_IPHONE_6_SCREEN){
             button.frame = CGRectMake(xPos, 6, buttonWidth, 30);
             button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        }
        else{
             button.frame = CGRectMake(xPos, 11, kButtonWidth_6plus, 30);
             button.titleLabel.font = [UIFont systemFontOfSize:16.0];
        }
        
        [_buttonOriginXArray addObject:@(xPos)];
        
        xPos += buttonWidth+BUTTONGAP;
        
        [_buttonWithArray addObject:@(button.frame.size.width)];
        
        [buttons addObject:button];
        [self addSubview:button];
    }

    self.contentSize = CGSizeMake(xPos-10.0, 32);
}

//点击顶部条滚动标签
- (void)selectNameButton:(UIButton *)sender
{
    int previousButtonTag = (int)userSelectedChannelID - 100;
    int nextButtonTag = (int)BUTTONID;
    
    
    [self adjustScrollViewContentX:sender];
    [self moveSquare:sender.frame.origin.x - BUTTONGAP/2];
    //如果更换按钮
    if (sender.tag != userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self viewWithTag:userSelectedChannelID];//强制转换
        lastButton.selected = NO;
        //赋值按钮ID
        userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        [UIView animateWithDuration:0.1 animations:^{
            
            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, [[_buttonWithArray objectAtIndex:BUTTONID] floatValue], 44)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新闻页出现
                if (previousButtonTag < nextButtonTag - 1) {
                    [[SVRootScrollView shareInstance] duplicateTableFromIndex:previousButtonTag ToIndex:nextButtonTag - 1];
                    [[SVRootScrollView shareInstance] setContentOffset:CGPointMake([[UIScreen mainScreen]bounds].size.width * (BUTTONID - 1), 0) animated:NO];
                    
                }
                else if(previousButtonTag > nextButtonTag + 1){
                    [[SVRootScrollView shareInstance] duplicateTableFromIndex:previousButtonTag ToIndex:nextButtonTag + 1];
                    [[SVRootScrollView shareInstance] setContentOffset:CGPointMake([[UIScreen mainScreen]bounds].size.width * (BUTTONID + 1), 0) animated:NO];
                }
                [[SVRootScrollView shareInstance] setContentOffset:CGPointMake(BUTTONID * [[UIScreen mainScreen]bounds].size.width, 0) animated:YES];
                if ([[[SVRootScrollView shareInstance].tables objectAtIndex:sender.tag-100] returnRefreshCount]>0) {
                   
                }else{
                    [[[SVRootScrollView shareInstance].tables objectAtIndex:sender.tag-100] refreshTable];
                }
                //赋值滑动列表选择频道ID
                scrollViewSelectedChannelID = sender.tag;
            }
        }];
    }
    //重复点击选中按钮
    else {
    }
//    scrollableTable *table = (scrollableTable*)[tables objectAtIndex:previousButtonTag];
//    [table refreshTable];
//    [table reloadData];
    
}

- (void)adjustScrollViewContentX:(UIButton *)sender
{
    float screen_width ;
    if ((IS_IPHONE_4S_SCREEN)||(IS_IPHONE_5S_SCREEN)) {
        screen_width =320;
    }
    else if (IS_IPHONE_6_SCREEN){
        screen_width  = 375;
    }
    else {
        screen_width =414;
    }
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONID] floatValue];
    
    float XTry = originX+width/2-screen_width/2;
    if (XTry < 0) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (XTry + screen_width > self.contentSize.width){
        [self setContentOffset:CGPointMake(self.contentSize.width - screen_width, 0) animated:YES];
    }
    else{
        [self setContentOffset:CGPointMake(XTry, 0) animated:YES];
    }
}

- (void)moveSquare:(float)beginX{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    buttomBar.frame = CGRectMake(beginX, self.frame.size.height - kBarWidth, kButtonWidth + BUTTONGAP, kBarWidth);
    
    [UIImageView commitAnimations];
}

//滚动内容页顶部滚动
- (void)setButtonUnSelect
{
    //滑动撤销选中按钮
    UIButton *lastButton = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    lastButton.selected = NO;
}

- (void)setButtonSelect
{
    //滑动选中按钮
    UIButton *localButton = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    [self moveSquare:localButton.frame.origin.x - BUTTONGAP/2];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [shadowImageView setFrame:CGRectMake(localButton.frame.origin.x, 0, [[_buttonWithArray objectAtIndex:localButton.tag-100] floatValue], 44)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (!localButton.selected) {
                localButton.selected = YES;
                userSelectedChannelID = localButton.tag;
            }
        }
    }];
    
}

-(void)setScrollViewContentOffset
{
    UIButton *localButton = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    [self adjustScrollViewContentX:localButton];
}

-(NSInteger)getButtonId{
    NSString *stringInt = [NSString stringWithFormat:@"%d",userSelectedChannelID-100];
    NSInteger returnValue = [stringInt integerValue];
    return returnValue;
}

-(NSInteger)getTableId{
    NSString *stringInt = [NSString stringWithFormat:@"%d",scrollViewSelectedChannelID - 100];
    NSInteger returnValue = [stringInt integerValue];
    return returnValue;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
