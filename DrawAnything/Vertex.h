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
@property NSTimeInterval timeInterval;

- (id)initWithLocation:(CGPoint)location TimeStamp:(NSTimeInterval)timeInterval;

- (void)addMark:(id <Mark>) mark;
- (void)removeMark:(id <Mark>) mark;
- (id <Mark>)childMarkAtIndex:(NSUInteger) index;

- (void)acceptMarkVisitor:(id <MarkVisitor>) visitor;

- (id)copyWithZone:(NSZone *)zone;

- (NSEnumerator *)enumerator;

- (void)enumerateMarksUsingBlock:(void (^)(id <Mark> item, BOOL *stop)) block;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

@end

