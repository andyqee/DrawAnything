//
//  Stroke.h
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
//#import "MarkEnumerator.h"

@interface Stroke : NSObject<Mark>

@property (nonatomic,strong) NSMutableArray *marks;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,readwrite) CGFloat size;
@property (readwrite) NSTimeInterval timeInterval;
@property (nonatomic) CGPoint location;

- (void) addMark:(id <Mark>) mark;
- (void) removeMark:(id <Mark>) mark;
- (id <Mark>) childMarkAtIndex:(NSUInteger) index;

- (void) acceptMarkVisitor:(id <MarkVisitor>)visitor;

- (id) copyWithZone:(NSZone *)zone;

- (NSEnumerator *) enumerator;

- (void) enumerateMarksUsingBlock:(void (^)(id <Mark> item, BOOL *stop)) block;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;


@end
