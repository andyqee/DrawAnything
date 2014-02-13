//
//  Stroke.m
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "Stroke.h"

@implementation Stroke

- (id)init
{
    self = [super init];
    if (self) {
        _marks = [NSMutableArray arrayWithCapacity:8];
    }
    return self;
}

- (void)addMark:(id<Mark>)mark
{
    [_marks addObject:mark];
}

- (void)removeMark:(id<Mark>)mark
{
    if ([_marks containsObject:mark]) {
        [_marks removeObject:mark];
    }
    else{
        [_marks makeObjectsPerformSelector:@selector(removeMark:)withObject:mark];
    }
}

#pragma mark -
#pragma mark frequently used useful method

- (id<Mark>)lastChild
{
    return [_marks lastObject];
}

- (NSUInteger)count
{
    return [_marks count];
}

- (id<Mark>)childMarkAtIndex:(NSUInteger) index
{
    if (index >= [_marks count]) return nil;
    
    return [_marks objectAtIndex:index];
}

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor
{
    for (id <Mark> mark in _marks)
    {
        [mark acceptMarkVisitor:visitor];
    }
    [visitor visitStroke:self];
}

#pragma mark -
#pragma mark implement archives and serializations

static NSString *ColorKey = @"StrokeColor";
static NSString *SizeKey = @"StrokeSize";
static NSString *TimeIntervalKey = @"StrokeTimeStamp";
static NSString *MarksKey = @"StrokeMarks";


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _color = [aDecoder decodeObjectForKey:ColorKey];
        _size = [aDecoder decodeFloatForKey:SizeKey];
        _timeInterval = [aDecoder decodeDoubleForKey:TimeIntervalKey];
        _marks = [aDecoder decodeObjectForKey:MarksKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_color forKey:ColorKey];
    [aCoder encodeFloat:_size forKey:SizeKey];
    [aCoder encodeDouble:_timeInterval forKey:TimeIntervalKey];
    [aCoder encodeObject:_marks forKey:MarksKey];
}

#pragma mark - draw context

- (void)drawWithContext:(CGContextRef)context
{
    CGContextMoveToPoint(context, self.location.x, self.location.y);
    
    for (id <Mark> mark in _marks)
    {
        [mark drawWithContext:context];
    }
    
    CGContextSetLineWidth(context, self.size);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context,[self.color CGColor]);
    CGContextStrokePath(context);
}

@end
