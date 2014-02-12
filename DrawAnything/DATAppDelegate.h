//
//  DATAppDelegate.h
//  DrawAnything
//
//  Created by andy on 23/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DATAppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UIWindow *window;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
