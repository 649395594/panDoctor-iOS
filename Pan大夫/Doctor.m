//
//  Doctor.m
//  Pan大夫
//
//  Created by tiny on 15/3/8.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import "Doctor.h"
@interface Doctor ()
@end
@implementation Doctor
- (id)initWithDocID:(NSString *)ID DocName:(NSString *)name DocSex:(NSString *)sex DocAge:(NSString *)age DocMark:(NSString *)mark DocPrice:(NSString *)price DocSpecial:(NSString *)special DocConTimes:(NSString *)conTimes DocIntroduction:(NSString *)Introduction DocMore:(NSString *)more  DocMoreSpe:(NSString *)docMoreSpe DoccareerTimes:(NSString *)careerTimes DocGPS:(NSString *)docGPS PicUrl:(NSString *)picURL DocCertificate:(NSString *)docCertificate DocLocation:(NSString *)docLocation DocDepartment:(NSString *)docDepartment DocTitle:(NSString *)docTitle{
    self = [super init];
    if (self) {
        self.docID = ID;
        self.docName = name;
        self.docSex = sex;
        self.docAge = age;
        self.docMark = mark;
        self.docPrice = price;
        self.docSpecial = special;
        self.docConTimes = conTimes;
        self.docIntroduction = Introduction;
        self.docMore = more;
        self.docMoreSpecial = docMoreSpe;
        self.careerTimes = careerTimes;
        self.docGPS = docGPS;
        self.imageURL = picURL;
        self.docCertificate = docCertificate;
        self.docLocation = docLocation;
        self.docDepartment = docDepartment;
        self.docTitle = docTitle;
    }
    return self;
}

@end
