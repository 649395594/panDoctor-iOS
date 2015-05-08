//
//  FunnyTestViewController.h
//  Pan大夫
//
//  Created by Juvia Xin on 15/5/3.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDelegate <NSObject>

- (void)DoLike;

@end


@interface FunnyTestViewController : UIViewController
{
    id <MyDelegate> delegate;
}
-(id)initWithHead:(NSString *)head picture:(UIImage *)picture explain:(NSString *)explain index:(int)index;
-(id)initWithHead:(NSString *)head picture:(UIImage *)picture choiceA:(NSString *)choiceA choiceB:(NSString *)choiceB choiceC:(NSString *)choiceC choiceD:(NSString *)choiceD choiceAans:(NSString *)choiceAans choiceBans:(NSString *)choiceBans choiceCans:(NSString *)choiceCans choiceD:(NSString *)choiceDans index:(int)index;
-(id)initWithHead:(NSString *)head choiceAans:(NSString *)choiceAans choiceBans:(NSString *)choiceBans choiceCans:(NSString *)choiceCans choiceDans:(NSString *)choiceDans chioce:(int)Choice index:(int)index;

@property (nonatomic, retain) id <MyDelegate> delegate;

@end







