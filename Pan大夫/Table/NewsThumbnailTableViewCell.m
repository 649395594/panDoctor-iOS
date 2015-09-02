//
//  NewsThumbnailTableViewCell.m
//  心理助手
//
//  Created by tiny on 15/1/28.
//  Copyright (c) 2015年 tiny. All rights reserved.
//
#define kImageWidth 80
#define kImageHeight 60
#define kImageRightGap 10
#define kTextImageGap 15
#define kTextLeftGap 20
#define kTopGap 10
#import "NewsThumbnailTableViewCell.h"
#import "ScrollableTable.h"
@implementation NewsThumbnailTableViewCell

@synthesize title,image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        image = [[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width - kImageRightGap - kImageWidth, kTopGap, kImageWidth, kImageHeight)];
        title = [[UITextView alloc]initWithFrame:CGRectMake(kTextLeftGap, kTopGap * 1.5, image.frame.origin.x - kTextLeftGap - kTextImageGap, 50)];
        title.editable = NO;
        title.userInteractionEnabled = NO;
        self.Id = [[NSString alloc]init];
        [self addSubview:image];
        [self addSubview:title];
        
        UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:singalTap];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    UITableViewCell *cell = (UITableViewCell *)sender.view;
    ScrollableTable *rootView = (ScrollableTable *)[[cell superview]superview];
    NSLog(@"tablecell superView is %@",[[cell superview]superview]);
    NSString *Id = [rootView.articles objectAtIndex:self.row];
    [rootView cellClickedWithID:Id];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
