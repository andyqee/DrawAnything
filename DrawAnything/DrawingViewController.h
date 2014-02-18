//
//  DATDrawingViewController.h
//  DrawAnything
//
//  Created by andy on 24/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordManager.h"
#import "WordHelper.h"

#import "PlayerViewController.h"
#import "CoreDataManager.h"
#import "BasePickerView.h"

//#import "DetailViewController.h"

@protocol DrawingViewControllerDelegate;

@interface DrawingViewController : PlayerViewController<UIGestureRecognizerDelegate,BasePickerViewDelegate>

@property (nonatomic, weak) id <DrawingViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (NSInvocation *) drawScribbleInvocation;
- (NSInvocation *) undrawScribbleInvocation;
- (void) executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation;
- (void) unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation;

- (IBAction)showSizePicker:(id)sender;

- (IBAction)showColorPicker:(id)sender;

- (IBAction)undo:(id)sender;

- (IBAction)redo:(id)sender;

@end

@protocol DrawingViewControllerDelegate
- (void)drawingViewController:(DrawingViewController *)controller didFinishWithSave:(BOOL)save;
@end

