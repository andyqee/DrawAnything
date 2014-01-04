//
//  Word.h
//  DrawAnything
//
//  Created by andy on 25/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"

@interface WordLib : NSObject

- (id)initWithWordLibPlistAtURL:(NSURL*) wordLibURL;

- (NSString*)pickUnusedWord;

- (void)setStatusOfTargetWord:(NSString*) targetWord;
- (void)resetStatusOfAllWord;


@property (readonly) NSUInteger numbersOfTotalWord;
@property (readonly) NSUInteger numbersOfUsedWord;



@end
