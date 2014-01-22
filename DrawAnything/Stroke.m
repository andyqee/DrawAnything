//
//  Stroke.m
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "Stroke.h"
@interface Stroke()

@property (nonatomic,strong) NSMutableArray *marks;
@property (nonatomic,strong) UIColor *strokeColor;
@property (readwrite) CGFloat strokeSize;
@property (readwrite) NSTimeInterval strokeTimeInterval;

@end

@implementation Stroke

- (id)init
{
    self = [super init];
    if (self) {
        self.marks = [NSMutableArray arrayWithCapacity:8];
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

- (id <Mark>)childMarkAtIndex:(NSUInteger) index
{
    if (index >= [_marks count]) return nil;
    
    return [_marks objectAtIndex:index];
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
        _strokeColor = [aDecoder decodeObjectForKey:ColorKey];
        _strokeSize = [aDecoder decodeFloatForKey:SizeKey];
        _strokeTimeInterval = [aDecoder decodeDoubleForKey:TimeIntervalKey];
        _marks = [aDecoder decodeObjectForKey:MarksKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_strokeColor forKey:ColorKey];
    [aCoder encodeFloat:_strokeSize forKey:SizeKey];
    [aCoder encodeDouble:_strokeTimeInterval forKey:TimeIntervalKey];
    [aCoder encodeObject:_marks forKey:MarksKey];
}

#pragma mark -
#pragma mark draw context

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
