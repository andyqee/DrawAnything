//
//  Scribble.h
//  DrawAnything
//
//  Created by andy on 15/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import "Mark.h"
#import "ScribbleMemento.h"

@interface Scribble : NSObject

// methods for Mark management
- (void)addMark:(id <Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark;
- (void)removeMark:(id <Mark>)aMark;

// methods for memento
- (id)initWithMemento:(ScribbleMemento *)aMemento;
+ (Scribble *)scribbleWithMemento:(ScribbleMemento *)aMemento;
- (ScribbleMemento *)scribbleMemento;
- (ScribbleMemento *)scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot;
- (void)attachStateFromMemento:(ScribbleMemento *)memento;

@end
