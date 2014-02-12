//
//  DATPlayerViewController.h
//  DrawAnything
//
//  Created by andy on 24/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DrawingRecord;

@interface PlayerViewController : UIViewController

@property (nonatomic, strong) DrawingRecord *drawingRecord;

@end


// These methods are used by the DrawingViewController, so are declared here, but they are private to these classes.

@interface PlayerViewController (Private)



- (void)setUpUndoManager;
- (void)cleanUpUndoManager;

@end
