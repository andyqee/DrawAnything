//
//  Mark.h
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkVisitor.h"


@protocol Mark <NSObject, NSCopying, NSCoding>

@property (nonatomic, strong) UIColor *color;
@property (nonatomic) CGFloat size;
@property (nonatomic) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id <Mark> lastChild;
@property NSTimeInterval timeInterval;

//deep copy 
- (id)copy;
- (void)addMark:(id <Mark>) mark;
- (void)removeMark:(id <Mark>) mark;
- (id <Mark>)childMarkAtIndex:(NSUInteger) index;

- (void)acceptMarkVisitor:(id <MarkVisitor>) visitor;

// for the Iterator pattern
- (NSEnumerator *)enumerator;

// for internal iterator implementation
- (void)enumerateMarksUsingBlock:(void (^)(id <Mark> item, BOOL *stop)) block;

// for a bad example
- (void)drawWithContext:(CGContextRef) context;

@end