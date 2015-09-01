//
//  TestViewController.m
//  UIScrollView
//
//  Created by Tom on 15/2/6.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property(nonatomic) int number;

@end

@implementation TestViewController
@synthesize number;

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor greenColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 350, 200)];
    label.text = [NSString stringWithFormat:@"第%d张图片", number+1];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popViewController)];
    [self.view addGestureRecognizer:tap];
}
- (void)setIndex:(int)index
{
    number = index;
}

-(id)initWithIndex:(int)index{
    self = [super init];
    if (self) {
        number = index;
    }
    return self;
}

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
