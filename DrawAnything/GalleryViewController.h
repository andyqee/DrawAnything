//
//  DATGalleryViewController.h
//  DrawAnything
//
//  Created by andy on 24/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawingViewController.h"


@interface GalleryViewController : UITableViewController <NSFetchedResultsControllerDelegate, DrawingViewControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
