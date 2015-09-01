//
//  CoreDataManager.h
//  test
//
//  Created by 张星宇 on 14-9-20.
//  Copyright (c) 2014年 张星宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Question.h"
@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//插入数据
- (int)create:(Question *)qs;
//查询
- (Question *)findById:(NSString *)tag;
- (Question *)findById:(NSString *)tag kind:(NSString *)kind;
- (NSMutableArray *)findAnswersbyKind:(NSString *)kind;
- (NSMutableArray *)findQuestionLabelsByKind:(NSString *)kind andTags:(NSArray *)tags;
- (NSMutableArray *)findAnswersbyKind:(NSString *)kind andTags:(NSMutableArray *)tags;
- (NSMutableArray *)findAll;
//删除
-(int)remove:(NSString *) tag;
-(int)remove:(NSString *)tag kind:(NSString *)kind;
//更新
-(int)modify:(NSString *)tag label:(NSString *)newLabel;
-(int)modify:(NSString *)tag kind:(NSString *)kind answer:(NSString *)answer;
@end
