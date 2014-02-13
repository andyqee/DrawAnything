//
//  Vertex.m
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

- (id)initWithLocation:(CGPoint)location TimeStamp:(NSTimeInterval)timeInterval;
{
    if (self = [super init])
    {
        self.location = location;
        self.timeInterval = timeInterval;
    }
    
    return self;
}

- (void)acceptMarkVisitor:(id<MarkVisitor>)visitor
{
    [visitor visitVertex:self];
}

#pragma mark -
#pragma mark NSCopying method

// it needs to be implemented for memento
- (id)copyWithZone:(NSZone *)zone
{
    Vertex *vertexCopy = [[[self class] allocWithZone:zone] initWithLocation:self.location TimeStamp:self.timeInterval];
    
    return vertexCopy;
}

#pragma mark -
#pragma mark NSCoder methods

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        self.location = [(NSValue *)[coder decodeObjectForKey:@"VertexLocation"] CGPointValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:[NSValue valueWithCGPoint:self.location] forKey:@"VertexLocation"];
}

#pragma mark -
#pragma mark MarkIterator methods

- (void)enumerateMarksUsingBlock:(void (^)(id <Mark> item, BOOL *stop)) block {}

#pragma mark -
#pragma mark An Extended Direct-draw

- (void)drawWithContext:(CGContextRef)context
{
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    
    CGContextAddLineToPoint(context, x, y);
}

@end