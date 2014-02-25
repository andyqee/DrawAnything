//
//  ScribbleManager.h
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scribble.h"
//#import "ScribbleThumbnailViewImageProxy.h"

@interface ScribbleManager : NSObject

- (void) saveScribble:(Scribble *)scribble thumbnail:(UIImage *)image;
- (NSInteger) numberOfScribbles;
- (Scribble *) scribbleAtIndex:(NSInteger)index;
- (UIView *) scribbleThumbnailViewAtIndex:(NSInteger)index;

@end