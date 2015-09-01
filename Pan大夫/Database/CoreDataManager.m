//
//  CoreDataManager.m
//  test
//
//  Created by 张星宇 on 14-9-20.
//  Copyright (c) 2014年 张星宇. All rights reserved.
//

#import "CoreDataManager.h"
#import "questionManagedObject.h"
#import "Question.h"
@implementation CoreDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataQuestions" withExtension:@"mom"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataQuestions.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.获取Documents路径
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//插入数据
- (int)create:(Question *)qs
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    Question *qusetion = [NSEntityDescription insertNewObjectForEntityForName:@"Questions" inManagedObjectContext:cxt];

    qusetion.answer = qs.answer;
    qusetion.kind = qs.kind;
    qusetion.questionLabel = qs.questionLabel;
    qusetion.tag = qs.tag;
    
    NSError *error = nil;
    if ([self.managedObjectContext save:&error]) {
        NSLog(@"插入数据成功");
    }
    else{
        NSLog(@"插入数据失败");
        return -1;
    }
    return 0;
}

//有条件查询
- (Question *)findById:(NSString *)tag
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];//创建实体关联的描述类，并通过实体的名字获得实例对象
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag = %@",tag];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    if ([listData count] > 0) {
        questionManagedObject *mo = [listData lastObject];
        Question *question = [[Question alloc]init];
        question.tag = mo.tag;
        question.answer = (NSMutableString *)mo.answer;
        question.questionLabel = mo.questionLabel;
        question.kind = mo.kind;
        return question;
    }
    return nil;
}

- (Question *)findById:(NSString *)tag kind:(NSString *)kind
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];//创建实体关联的描述类，并通过实体的名字获得实例对象
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag = %@ and kind = %@",tag,kind];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    if ([listData count] > 0) {
        questionManagedObject *mo = [listData lastObject];
        Question *question = [[Question alloc]init];
        question.tag = mo.tag;
        question.answer = (NSMutableString *)mo.answer;
        question.questionLabel = mo.questionLabel;
        question.kind = mo.kind;
        return question;
    }
    return nil;
}

- (NSMutableArray *)findAnswersbyKind:(NSString *)kind{
    NSMutableArray *answers = [[NSMutableArray alloc]init];
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];//创建实体关联的描述类，并通过实体的名字获得实例对象
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    Question *temp = [[Question alloc]init];
    if (![kind isEqualToString:@"SCL"]) {
        NSInteger intTag = 1;
        NSMutableString *tag;
        for (intTag = 1; intTag < 21; intTag++) {
            tag = [NSMutableString stringWithFormat:@"%ld",(long)intTag];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag = %@ and kind = %@",tag,kind];
            [request setPredicate:predicate];
            
            NSError *error = nil;
            NSArray *listData = [cxt executeFetchRequest:request error:&error];
            temp = [listData lastObject];
            [answers addObject:temp.answer];
        }
    }
    return answers;
}

- (NSMutableArray *)findAnswersbyKind:(NSString *)kind andTags:(NSMutableArray *)tags{
    NSMutableArray *answers = [[NSMutableArray alloc]init];
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];//创建实体关联的描述类，并通过实体的名字获得实例对象
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    Question *temp = [[Question alloc]init];
    for (NSString *tag in tags) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag = %@ and kind = %@",tag,kind];
        [request setPredicate:predicate];
        NSError *error = nil;
        NSArray *listData = [cxt executeFetchRequest:request error:&error];
        temp = [listData lastObject];
        [answers addObject:temp.answer];
    }
    
    return answers;
}

- (NSMutableArray *)findQuestionLabelsByKind:(NSString *)kind andTags:(NSArray *)tags{
    NSMutableArray *questionLabels = [[NSMutableArray alloc]init];
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];//创建实体关联的描述类，并通过实体的名字获得实例对象
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    Question *temp = [[Question alloc]init];
    for (NSString *tag in tags) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag = %@ and kind = %@",tag,kind];
        [request setPredicate:predicate];
        NSError *error = nil;
        NSArray *listData = [cxt executeFetchRequest:request error:&error];
        temp = [listData lastObject];
        [questionLabels addObject:temp.questionLabel];
    }
    
    return questionLabels;
}

//无条件查询
- (NSMutableArray *)findAll{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];
    NSFetchRequest *request= [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"tag" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    NSMutableArray *reListData= [[NSMutableArray alloc]init];
    for(questionManagedObject *mo in listData){
        Question *question = [[Question alloc]init];
        question.tag = mo.tag;
        question.answer = (NSMutableString *)mo.answer;
        question.questionLabel = mo.questionLabel;
        question.kind = mo.kind;
        [reListData addObject:question];
    }
    return reListData;
}

//删除
-(int)remove:(NSString *)tag
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription= [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag = %@",tag];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0)
    {
        questionManagedObject *question = [listData lastObject];
        [self.managedObjectContext deleteObject:question];
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]) {
            NSLog(@"删除成功");
        }
        else{
            NSLog(@"删除失败");
            return  -1;
        }
    }
    return 0;
}

-(int)remove:(NSString *)tag kind:(NSString *)kind
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription= [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag = %@ and kind = %@",tag,kind];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0)
    {
        questionManagedObject *question = [listData lastObject];
        [self.managedObjectContext deleteObject:question];
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]) {
            NSLog(@"删除成功");
        }
        else{
            NSLog(@"删除失败");
            return  -1;
        }
    }
    return 0;
}

//更新
-(int)modify:(NSString *)tag label:(NSString *)newLabel
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription= [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag = %@",tag];
    [request setPredicate:predicate];
    
    //保存
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        questionManagedObject *question = [listData lastObject];
        question.questionLabel = newLabel;
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]) {
            NSLog(@"更新成功");
        }
        else{
            NSLog(@"更新失败");
            return -1;
        }
    }
    return 0;
}
-(int)modify:(NSString *)tag kind:(NSString *)kind answer:(NSString *)answer
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    NSEntityDescription *entityDescription= [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:cxt];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag = %@ and kind = %@",tag,kind];
    [request setPredicate:predicate];
    
    //保存
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        questionManagedObject *question = [listData lastObject];
        question.answer = answer;
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]) {
            NSLog(@"更新成功");
        }
        else{
            NSLog(@"更新失败");
            return -1;
        }
    }
    return 0;
//    NSArray *array = [[NSArray alloc]initWithObjects:@"1",1,123.1,true, nil];
}
@end
