//
//  Scribble.m
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

//#import "ScribbleMemento+Friend.h"
#import "Scribble.h"
#import "Stroke.h"

@interface Scribble ()

@property (nonatomic, strong) id <Mark> mark;
//@property (nonatomic, strong) id <Mark> rootMark;
@property (nonatomic, strong) id <Mark> incrementalMark;

@end


@implementation Scribble

- (id)init
{
    if (self = [super init]){
//        _mark = [[Stroke alloc] init];
        _mark = [[Stroke alloc] init];

    }
    return self;
}

#pragma mark -
#pragma mark Methods for Mark management

- (void)addMark:(id <Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark
{
    [self willChangeValueForKey:@"mark"];
    
    if (shouldAddToPreviousMark){
        [[_mark lastChild] addMark:aMark];
    }
    else{
        [_mark addMark:aMark];
        _incrementalMark = aMark;
    }
    
    [self didChangeValueForKey:@"mark"];
}

- (void)removeMark:(id <Mark>)aMark
{
    if (aMark == _mark) return;
    [self willChangeValueForKey:@"mark"];
    [_mark removeMark:aMark];
    
    if (aMark == _incrementalMark){
        _incrementalMark = nil;
    }    
    [self didChangeValueForKey:@"mark"];
}

#pragma mark -
#pragma mark Methods for archive

//- (id)initWithMemento:(ScribbleMemento *)aMemento
//{
//    
//}
//
//+ (Scribble *)scribbleWithMemento:(ScribbleMemento *)aMemento
//{
//    
//}
//- (ScribbleMemento *)scribbleMemento
//{
//}
//- (ScribbleMemento *)scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot
//{
//}
//- (void)attachStateFromMemento:(ScribbleMemento *)memento
//{
//    
//}



@end