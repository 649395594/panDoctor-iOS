//
//  TestCell.m
//  Pan大夫
//
//  Created by Juvia Xin on 15/5/3.
//  Copyright (c) 2015年 Neil. All rights reserved.
//
#define ratio6 375/414
#define ratio5 320/414
#define FrameH [[UIScreen mainScreen]bounds].size.height
#define ImageWidth (((FrameH > 567) && (FrameH < 569))? 394 * ratio5:(((FrameH > 666) && (FrameH < 668))? 394 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 394 : 394 * ratio5)))
#define ImageHeight (((FrameH > 567) && (FrameH < 569))? 150 * ratio5:(((FrameH > 666) && (FrameH < 668))? 150 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 150 : 150 * ratio5)))
#define TopGap (((FrameH > 567) && (FrameH < 569))? 5 * ratio5:(((FrameH > 666) && (FrameH < 668))? 5 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 5 : 5 * ratio5)))
#define TextTopGap (((FrameH > 567) && (FrameH < 569))? 30 * ratio5:(((FrameH > 666) && (FrameH < 668))? 30 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 30 : 30 * ratio5)))
#define TextLeftGap (((FrameH > 567) && (FrameH < 569))? 280 * ratio5:(((FrameH > 666) && (FrameH < 668))? 280 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 280 : 280 * ratio5)))
#define TextWidth (((FrameH > 567) && (FrameH < 569))? 114 * ratio5:(((FrameH > 666) && (FrameH < 668))? 114 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 114 : 114 * ratio5)))
#define TextHeight (((FrameH > 567) && (FrameH < 569))? 110 * ratio5:(((FrameH > 666) && (FrameH < 668))? 110 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 110 : 110 * ratio5)))
#define HeartTopGap (((FrameH > 567) && (FrameH < 569))? 120 * ratio5:(((FrameH > 666) && (FrameH < 668))? 120 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 120 : 120 * ratio5)))
#define HeartLeftGap (((FrameH > 567) && (FrameH < 569))? 368 * ratio5:(((FrameH > 666) && (FrameH < 668))? 368 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 368 : 368 * ratio5)))
#define HeartHeight (((FrameH > 567) && (FrameH < 569))? 20 * ratio5:(((FrameH > 666) && (FrameH < 668))? 20 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 20 : 20 * ratio5)))
#define HeartWidth (((FrameH > 567) && (FrameH < 569))? 20 * ratio5:(((FrameH > 666) && (FrameH < 668))? 20 * ratio6 : (((FrameH > 735) && (FrameH < 737))? 20 : 20 * ratio5)))


#import "TestCell.h"

@implementation TestCell

@synthesize title, picture, heart;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        picture = [[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width - ImageWidth)/2, TopGap, ImageWidth, ImageHeight)];
        picture.layer.cornerRadius = 4;
        picture.layer.masksToBounds = YES;
        title = [[UITextView alloc]initWithFrame:CGRectMake(TextLeftGap, TextTopGap, TextWidth, TextHeight)];
        title.editable = NO;
        title.userInteractionEnabled = NO;
        heart = [[UIButton alloc]initWithFrame:CGRectMake(HeartLeftGap, HeartTopGap, HeartWidth, HeartHeight)];
        self.Id = [[NSString alloc]init];
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1.0];
        [self addSubview:picture];
        [self addSubview:title];
        [self addSubview:heart];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
