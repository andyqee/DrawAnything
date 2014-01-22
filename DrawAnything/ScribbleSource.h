//
//  ScribbleSource.h
//  DrawAnything
//
//  Created by andy on 16/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scribble.h"

@protocol ScribbleSource <NSObject>

- (Scribble *) scribble;

@end
