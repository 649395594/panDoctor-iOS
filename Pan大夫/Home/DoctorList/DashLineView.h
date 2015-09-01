//
//  DashLineView.h
//  DashLine
//
//  Created by tiny on 15/3/6.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashLineView : UIView{
    CGFloat dashLineWidth;//虚线粗细宽度
}
//虚线颜色
@property (strong, nonatomic)UIColor *dashLineColor;

-(void)setLineColor:(UIColor *)lineColor LineWidth:(CGFloat)lineWidth;
@end
