//
//  Dot.m
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "Dot.h"

@implementation Dot

#pragma mark -
#pragma mark An Extended Direct-draw

- (void)drawWithContext:(CGContextRef) context
{
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    CGFloat framesize = self.size;
    CGRect frame = CGRectMake(x-framesize/2, y-framesize/2, framesize, framesize);
    CGContextSetFillColorWithColor(context, [self.color CGColor]);
    CGContextFillEllipseInRect(context, frame);
}

- (id)copyWithZone:(NSZone *)zone
{
    Dot *cloneDot = [[[self class] allocWithZone:zone] initWithLocation:self.location
                                                              TimeStamp:self.timeInterval];
    cloneDot.Color = [UIColor colorWithCGColor:[self.color CGColor]];
    cloneDot.Size = self.size;
    
    return cloneDot;
}


@end
