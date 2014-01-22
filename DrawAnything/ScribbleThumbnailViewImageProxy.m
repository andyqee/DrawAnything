//
//  ScribbleThumbnailViewImageProxy.m
//  DrawAnything
//
//  Created by andy on 16/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "ScribbleThumbnailViewImageProxy.h"

@interface ScribbleThumbnailViewImageProxy()

@property (nonatomic) Scribble *scribble;
//@property Command *touchCommand_;
@property (nonatomic) UIImage *realImage;
@property  BOOL loadingThreadHasLaunched;

@end
@implementation ScribbleThumbnailViewImageProxy

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
}


@end
