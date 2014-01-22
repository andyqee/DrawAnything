//
//  ScribbleMemento.h
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"


@interface ScribbleMemento : NSObject

+ (ScribbleMemento *) mementoWithData:(NSData *)data;
- (NSData *) data;

@end
