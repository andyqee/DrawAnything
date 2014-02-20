//
//  CoreDataManager.h
//  DrawAnything
//
//  Created by andy on 8/2/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

//@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (copy, nonatomic) NSString *databaseName;
@property (copy, nonatomic) NSString *modelName;

+ (instancetype)sharedManager;
+ (NSManagedObjectContext *)defaultContext;
+ (BOOL)insertDataToDB:(NSArray*)dataSource withEntityName:(NSString*)entityName;
+ (NSArray*)fetchDataFromDBWithEntityName:(NSString*)entityName;

//- (BOOL)saveContext;
//- (void)useInMemoryStore;

#pragma mark - Helpers

- (NSURL *)applicationDocumentsDirectory;
//- (NSURL *)applicationSupportDirectory;
@end
