//
//  Doctor.h
//  Pan大夫
//
//  Created by tiny on 15/3/8.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor : NSObject
@property (strong, nonatomic) NSString *docID;
@property (strong, nonatomic) NSString *docName;
@property (strong, nonatomic) NSString *docSex;
@property (strong, nonatomic) NSString *docAge;
@property (strong, nonatomic) NSString *docMark;
@property (strong, nonatomic) NSString *docPrice;
@property (strong, nonatomic) NSString *docGPS;
@property (strong, nonatomic) NSString *docSpecial;
@property (strong, nonatomic) NSString *docConTimes;
@property (strong, nonatomic) NSString *docIntroduction;
@property (strong, nonatomic) NSString *docMore;
@property (strong, nonatomic) NSString *careerTimes;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *docCertificate;
@property (strong, nonatomic) NSString *docLocation;
@property (strong, nonatomic) NSString *docDepartment;
@property (strong, nonatomic) NSString *docTitle;
@property (strong, nonatomic) NSString *docMoreSpecial;

- (id)initWithDocID:(NSString *)ID DocName:(NSString *)name DocSex:(NSString *)sex DocAge:(NSString *)age DocMark:(NSString *)mark DocPrice:(NSString *)price DocSpecial:(NSString *)special DocConTimes:(NSString *)conTimes DocIntroduction:(NSString *)Introduction DocMore:(NSString *)more  DocMoreSpe:(NSString *)docMoreSpe DoccareerTimes:(NSString *)careerTimes DocGPS:(NSString *)docGPS PicUrl:(NSString *)picURL DocCertificate:(NSString *)docCertificate DocLocation:(NSString *)docLocation DocDepartment:(NSString *)docDepartment DocTitle:(NSString *)docTitle;
@end