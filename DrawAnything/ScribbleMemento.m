//
//  ScribbleMemento.m
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "ScribbleMemento.h"
//#import "ScribbleMemento+Friend.h"

@interface ScribbleMemento()

@property id <Mark> mark;
@property BOOL hasCompleteSnapshot;

@end

@implementation ScribbleMemento

- (NSData *) data
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_mark];
    return data;
}

+ (ScribbleMemento *) mementoWithData:(NSData *)data
{
    // It raises an NSInvalidArchiveOperationException if data is not a valid archive
    id <Mark> retoredMark = (id <Mark>)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    ScribbleMemento *memento = [[ScribbleMemento alloc] initWithMark:retoredMark];
    
    return memento;
}

#pragma mark -
#pragma mark Private methods

- (id) initWithMark:(id <Mark>)aMark
{
    if (self = [super init])
    {
        [self setMark:aMark];
    }
    return self;
}

@end
