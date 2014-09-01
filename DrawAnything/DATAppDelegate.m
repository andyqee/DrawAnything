//
//  DATAppDelegate.m
//  DrawAnything
//
//  Created by andy on 23/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import "DATAppDelegate.h"
#import "XMLParser.h"
#import "CoreDataManager.h"
#import "WordHelper.h"

@interface DATAppDelegate()

@property (strong,readwrite) UIDocument *document;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation DATAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self setUpWordLib] ;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setUpWordLib
{    
    self.managedObjectContext = [CoreDataManager defaultContext];
    NSArray* words = [self fetchDataFromDBWithEntityName:@"Word"];
    if (words.count == 0) {
        words = [self fetchDataFromPlist];
        [self insertDataToDB:words];
    }
}
- (NSArray*)fetchDataFromDBWithEntityName: (NSString*)entityName
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName
                                   inManagedObjectContext:self.managedObjectContext]];

    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request
                                                                error:&error];
    return results;
}

- (NSArray*)fetchDataFromPlist
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"WordsLib.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"WordsLib" ofType:@"plist"];
    }
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    return [NSMutableArray arrayWithArray:[temp objectForKey:@"WordList"]];
}

- (void)insertDataToDB:(NSArray*)words
{
    NSInteger i = 0;
    for (id wordCell in words) {
        Word *newWord = [NSEntityDescription insertNewObjectForEntityForName:@"Word"
                                                      inManagedObjectContext:self.managedObjectContext];
        newWord.name = (NSString*)wordCell;
        newWord.state = [NSNumber numberWithInteger:Fresh];
        newWord.grade = [NSNumber numberWithInteger:i++];
    }
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

}

- (NSString*)getPlistFilePath
{
    NSString* wordLibPath = [[NSBundle mainBundle] pathForResource:@"WordsLib"
                                                            ofType:@"plist"];
    return wordLibPath;
}
         
@end
