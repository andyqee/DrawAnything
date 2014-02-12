//
//  WordDelegate.h
//  DrawAnything
//
//  Created by andy on 28/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"
#import "WordLib.h"

typedef NS_ENUM(NSInteger, WordStateType){
    Fresh,
    Inuse,
    Pending,

};


@interface WordHelper : NSObject

- (id)init;

- (Word*)selectSingleWordBaseOnState: (WordStateType)state;
- (Word*)selectAllWordsBaseOnState: (WordStateType)state;

- (void)setWordState: (WordStateType)state;

- (void)updateWordState: (WordStateType)state;


@end
