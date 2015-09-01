//
//  DashLineView.m
//  DashLine
//
//  Created by tiny on 15/3/6.
//  Copyright (c) 2015年 tiny. All rights reserved.
//

#import "DashLineView.h"

@implementation DashLineView
@synthesize dashLineColor;
- (void)drawRect:(CGRect)rect {
    if (dashLineWidth < self.frame.size.height) {
        //获得处理的上下文
        CGContextRef context =UIGraphicsGetCurrentContext();
        //开始一个起始路径
        CGContextBeginPath(context);
        //设置线条粗细宽度
        CGContextSetLineWidth(context, dashLineWidth);
        //设置线条的颜色
        CGContextSetStrokeColorWithColor(context, dashLineColor.CGColor);
        //lengths说明虚线如何交替绘制,lengths的值{4，4}表示先绘制4个点，再跳过4个点，如此反复
        CGFloat lengths[] = {4,4};
        //画虚线
        CGContextSetLineDash(context, 0, lengths,2);
        //设置开始点的位置
        CGContextMoveToPoint(context, 0.0, self.frame.size.height/2);
        //设置终点的位置
        CGContextAddLineToPoint(context,self.frame.size.width,self.frame.size.height/2);
        //开始绘制虚线
        CGContextStrokePath(context);
    }
}

-(void)setLineColor:(UIColor *)lineColor LineWidth:(CGFloat)lineWidth{
    dashLineColor = lineColor;
    dashLineWidth = lineWidth;
}

@end
