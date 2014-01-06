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

//#import "DetailViewController.h"

@protocol DrawingViewControllerDelegate;


@interface DrawingViewController : PlayerViewController


@property (nonatomic, weak) id <DrawingViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end


@protocol DrawingViewControllerDelegate
- (void)drawingViewController:(DrawingViewController *)controller didFinishWithSave:(BOOL)save;
@end

