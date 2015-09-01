//
//  SettingsViewController.h
//  Pan大夫
//
//  Created by zxy on 2/24/15.
//  Copyright (c) 2015 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

#define   FrameH  [[UIScreen mainScreen]bounds].size.height
#define   ratio6 375/320
#define   ratio6plus 414/320
#define   topH  0
#define   userImageW  [[UIScreen mainScreen]bounds].size.width
#define   userImageH  (((FrameH > 567) && (FrameH < 569))?170:(((FrameH > 666) && (FrameH < 668))? 170*ratio6 : (((FrameH > 735) && (FrameH < 737))? 170*ratio6plus : 170)))
#define   labelH  (((FrameH > 567) && (FrameH < 569))?15:(((FrameH > 666) && (FrameH < 668))? 15*ratio6 : (((FrameH > 735) && (FrameH < 737))? 15*ratio6plus : 15)))
#define   labelW  (((FrameH > 567) && (FrameH < 569))?48:(((FrameH > 666) && (FrameH < 668))? 50*ratio6 : (((FrameH > 735) && (FrameH < 737))? 49*ratio6plus : 48)))
#define   labelWL  (((FrameH > 567) && (FrameH < 569))?105:(((FrameH > 666) && (FrameH < 668))? 104*ratio6 : (((FrameH > 735) && (FrameH < 737))? 103*ratio6plus : 105)))
#define   tableUp (((FrameH > 567) && (FrameH < 569))?42:(((FrameH > 666) && (FrameH < 668))? 50*ratio6 : (((FrameH > 735) && (FrameH < 737))? 50*ratio6plus : 8)))
#define   bgH (FrameH - 113 - userImageH)
#define   localLabelH  (((FrameH > 567) && (FrameH < 569))?14:(((FrameH > 666) && (FrameH < 668))? 14*ratio6 : (((FrameH > 735) && (FrameH < 737))? 14*ratio6plus : 14)))
#define   localLabelW  (((FrameH > 567) && (FrameH < 569))?226:(((FrameH > 666) && (FrameH < 668))? 218*ratio6 : (((FrameH > 735) && (FrameH < 737))? 221*ratio6plus : 226)))
#define   upLabel  (((FrameH > 567) && (FrameH < 569))?44:(((FrameH > 666) && (FrameH < 668))? 44*ratio6 : (((FrameH > 735) && (FrameH < 737))? 44*ratio6plus : 8)))
#define   telH  (((FrameH > 567) && (FrameH < 569))?38:(((FrameH > 666) && (FrameH < 668))? 38*ratio6 : (((FrameH > 735) && (FrameH < 737))? 38*ratio6plus : 38)))
#define   telW  (((FrameH > 567) && (FrameH < 569))?288:(((FrameH > 666) && (FrameH < 668))? 288*ratio6 : (((FrameH > 735) && (FrameH < 737))? 288*ratio6plus : 288)))
#define   telIconW  (((FrameH > 567) && (FrameH < 569))?45:(((FrameH > 666) && (FrameH < 668))? 45*ratio6 : (((FrameH > 735) && (FrameH < 737))? 45*ratio6plus : 45)))
#define   uptel  (((FrameH > 567) && (FrameH < 569))?84:(((FrameH > 666) && (FrameH < 668))? 84*ratio6 : (((FrameH > 735) && (FrameH < 737))? 84*ratio6plus : 30)))
#define   CAPTCHAW  (((FrameH > 567) && (FrameH < 569))?216:(((FrameH > 666) && (FrameH < 668))? 216*ratio6 : (((FrameH > 735) && (FrameH < 737))? 216*ratio6plus : 216)))
#define   CAPTCHAButtonW  (((FrameH > 567) && (FrameH < 569))?67:(((FrameH > 666) && (FrameH < 668))? 67*ratio6 : (((FrameH > 735) && (FrameH < 737))? 67*ratio6plus : 67)))
#define   upCAPTCHA  (((FrameH > 567) && (FrameH < 569))?130:(((FrameH > 666) && (FrameH < 668))? 130*ratio6 : (((FrameH > 735) && (FrameH < 737))? 130*ratio6plus : 77)))
#define   upLogin  (((FrameH > 567) && (FrameH < 569))?178:(((FrameH > 666) && (FrameH < 668))? 178*ratio6 : (((FrameH > 735) && (FrameH < 737))? 178*ratio6plus: 125)))
#define   Offset  100
#define   OffsetBack  0
#define   cellH  (((FrameH > 567) && (FrameH < 569))?180:(((FrameH > 666) && (FrameH < 668))? 180*ratio6 : (((FrameH > 735) && (FrameH < 737))? 180*ratio6plus : 180)))
#define   tableFont  (((FrameH > 567) && (FrameH < 569))?17:(((FrameH > 666) && (FrameH < 668))? 19 : (((FrameH > 735) && (FrameH < 737))? 20 : 17)))
#define   telFont  (((FrameH > 567) && (FrameH < 569))?17:(((FrameH > 666) && (FrameH < 668))? 20 : (((FrameH > 735) && (FrameH < 737))? 22 : 17)))
#define   loginFont  (((FrameH > 567) && (FrameH < 569))?16:(((FrameH > 666) && (FrameH < 668))? 19 : (((FrameH > 735) && (FrameH < 737))? 21 : 16)))
#define   hitFont  (((FrameH > 567) && (FrameH < 569))?13:(((FrameH > 666) && (FrameH < 668))? 15 : (((FrameH > 735) && (FrameH < 737))? 17 : 13)))
#define k_scale_up 220.0/736.0
#define   scrollY  (((FrameH > 567) && (FrameH < 569))?-12:(((FrameH > 666) && (FrameH < 668))? 35 : (((FrameH > 735) && (FrameH < 737))? 60 : -12)))
#define   scrollW  ((FrameH > 735) && (FrameH < 737))? 623/455 * userImageW : userImageW
#define   scrollH  (((FrameH > 567) && (FrameH < 569))?340:(((FrameH > 666) && (FrameH < 668))? 310 : (((FrameH > 735) && (FrameH < 737))? 300 : 340)))

@interface SettingsViewController : UIViewController

@property(strong, nonatomic)NSString *IDNum;

- (void)userDidLogin:(NSString*)IDNum;


@end
