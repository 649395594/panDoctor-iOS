//
//  GifView.m
//  Pan大夫
//
//  Created by Juvia Xin on 15/5/8.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "GifView.h"

@implementation GifView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)loadData:(NSData *)_data{
    
    //kCGImagePropertyGIFLoopCount loopCount（播放次数）：有些gif播放到一定次数就停止了，如果为0就代表gif一直循环播放。
    gifProperties = [[NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount] forKey:(NSString *)kCGImagePropertyGIFDictionary] retain];
    
    
    gif = CGImageSourceCreateWithData((CFDataRef)_data, (CFDictionaryRef)gifProperties);
    
    count =CGImageSourceGetCount(gif);
    
    //获取图像的属性信息
    NSDictionary* frame1Properties = ( NSDictionary*)CGImageSourceCopyPropertiesAtIndex(gif, 0, NULL);
    
    //kCGImagePropertyGIFDelayTime 每一帧播放的时间，也就是说这帧显示到delayTime就转到下一帧。
    float duration = [[[frame1Properties objectForKey:(NSString*)kCGImagePropertyGIFDictionary] objectForKey:(NSString*)kCGImagePropertyGIFDelayTime] floatValue];
    
    //解决重复调用timer的问题
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(play) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)play
{
    index ++;
    index = index%count;
    
    //获取图像
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
    
    self.layer.contents = (id)ref;
    CFRelease(ref);
}

-(void)removeFromSuperview
{
    NSLog(@"removeFromSuperview");
    [timer invalidate];
    timer = nil;
    [super removeFromSuperview];
}

- (void)dealloc {
    NSLog(@"dealloc");
    CFRelease(gif);
}







@end

