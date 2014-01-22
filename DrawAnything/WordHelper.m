//
//  WordDelegate.m
//  DrawAnything
//
//  Created by andy on 28/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import "WordHelper.h"
@interface WordHelper()

@property (readwrite)Word* word;
@property (readwrite)WordLib* wordLib;
@property (readwrite)UIManagedDocument* document;
@property (readwrite)NSManagedObjectContext* contex;

@end

@implementation WordHelper

- (id)init
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory
                                                    inDomains:NSUserDomainMask]firstObject];
    NSString *documentName = @"MyDocument";
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    self.document = [[UIManagedDocument alloc]initWithFileURL:url];
    
    if ([fileManager fileExistsAtPath:url]) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) {
           //     [self documentIsReady];
                
            }
            if (!success) {
                NSLog(@"couldn't open document at %@",url);
            }
            
        }];
    }
    else{
        [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
         //   if (success) //     [self documentIsReady]};
            if (!success) NSLog(@"couldn't create document at %@",url);
        }];
        
    }
        
    
    return self;

}

//- (Word*)selectSingleWordBaseOnState: (WordStateType)state
//{
//    
//
//}
//
//- (Word*)selectAllWordsBaseOnState: (WordStateType)state
//{
//
//}

- (void)setWordState: (WordStateType)state
{
    
}

- (void)updateWordState: (WordStateType)state
{
    
    
}

-(void)documentIsReady
{
    if (self.document.documentState == UIDocumentStateNormal) {
        self.contex = self.document.managedObjectContext;

    }

}

@end
