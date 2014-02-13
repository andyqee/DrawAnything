//
//  DATCanvas.m
//  DrawAnything
//
//  Created by andy on 14/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "DrawingCanvas.h"
#import "MarkRenderer.h"

@implementation DrawingCanvas

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    MarkRenderer *markRenderer = [[MarkRenderer alloc] initWithCGContext:context];

    [_mark acceptMarkVisitor:markRenderer];
}

@end
