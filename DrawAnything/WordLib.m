//
//  Word.m
//  DrawAnything
//
//  Created by andy on 25/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import "WordLib.h"

@interface WordLib()

@property (readwrite) NSUInteger numbersOfTotalWord;
@property (readwrite) NSUInteger numbersOfUsedWord;

// array of Word object
@property (strong) NSArray *words;

@end

@implementation WordLib

- (id)initWithWordLibPlistAtURL:(NSURL*) wordLibURL
{
    self = [super init];
    
    if (self) {
        NSData* wordLibPlistData;
        NSDictionary* wordLibPlistDict;
        
        wordLibPlistData = [NSData dataWithContentsOfURL:wordLibURL];
        wordLibPlistDict = [NSPropertyListSerialization propertyListWithData:wordLibPlistData
                                                                       options:NSPropertyListImmutable
                                                                        format:nil
                                                                         error:NULL];
        
    }

    return self;
}



//- (NSString*)pickUnusedWord
//{
//    //first check if there exit unused word
//    
//    
//}

- (void)setStatusOfTargetWord:(NSString *)targetWord
{
    
}

- (void)resetStatusOfAllWord
{
    
}




@end
