//
//  ServieceItemSTableViewCell.m
//  Pan大夫
//
//  Created by nineteen. on 8/25/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import "ServiceItemSTableViewCell.h"

@interface ServiceItemSTableViewCell()
@property (nonatomic , strong)UIImageView *myImageView;
@end

@implementation ServiceItemSTableViewCell
@synthesize myImageView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    ServiceItemSTableViewCell *cell = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (cell) {
        myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width-10, 150)];
        // 使得layer将layer之下的都遮住（为了产生圆角）
        myImageView.layer.masksToBounds = YES;
        myImageView.layer.cornerRadius = 10;
        [cell.contentView addSubview:myImageView];
    }
    return cell;
}

- (void)setMyImage: (UIImage *)image
{
    myImageView.image = image;
}

@end
