//
//  Vertex.h
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

@protocol MarkVisitor;

@interface Vertex : NSObject <Mark, NSCopying>

@property (nonatomic, strong) UIColor *color;
@property (nonatomic) CGFloat size;
@property (nonatomic) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id <Mark> lastChild;

- (id)initWithLocation:(CGPoint)location TimeStamp:(NSTimeInterval)timeInterval;

- (void)addMark:(id <Mark>) mark;
- (void)removeMark:(id <Mark>) mark;
- (id <Mark>)childMarkAtIndex:(NSUInteger) index;

- (void)acceptMarkVisitor:(id <MarkVisitor>) visitor;

// for the Prototype pattern
- (id)copyWithZone:(NSZone *)zone;

// for the Iterator pattern
- (NSEnumerator *)enumerator;

// for internal iterator implementation
- (void)enumerateMarksUsingBlock:(void (^)(id <Mark> item, BOOL *stop)) block;

// for the Memento pattern
- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

@end

