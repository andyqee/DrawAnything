//
//  DATGalleryViewController.m
//  DrawAnything
//
//  Created by andy on 24/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import "GalleryViewController.h"
#import "WordManager.h"
#import "WordHelper.h"
#import "DrawingRecord.h"

#import "PlayerViewController.h"
#import "DrawingViewController.h"
#import "CoreDataManager.h"

@interface GalleryViewController()
    
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSString* rootPath;

//@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@end

#pragma mark -
#pragma mark - implementation
@implementation GalleryViewController 

#pragma mark -
#pragma mark - View lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    self.navigationController.navigationBar.translucent = NO;
    self.rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(startNewDrawing:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.tableView.rowHeight = 100;
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)viewWillAppear
{
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    self.fetchedResultsController = nil;
}

- (void)viewDidAppear:(BOOL)animated
{

}

#pragma mark - Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return  numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];

    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - private method used to configure cell of table view

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
//    NSLog([NSString stringWithFormat:@"%d", indexPath.section]);
    if (indexPath.section %2 == 1)
		cell.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
	else
		cell.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:0.5];

    DrawingRecord *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = record.title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    NSString *creationTime = [dateFormatter stringFromDate: record.creationTime];

//    NSTimeInterval duration = [record.finishedTime timeIntervalSinceDate:record.creationTime];
//    NSString *sDuration = ;
    
    NSString *detail = @"Created at :";
    NSString *detail2 = @"It takes you ";
//    [detail appendString:creationTime];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@\n%@",detail,creationTime,detail2];

    NSString *imagePath =  record.snapShotFilePath;
    cell.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    
}

#pragma mark - Table view editing

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    if (editing) {
        self.rightBarButtonItem = self.navigationItem.rightBarButtonItem;
        self.navigationItem.rightBarButtonItem = nil;
    }
    else {
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
        self.rightBarButtonItem = nil;
    }
}

#pragma mark - Fetched results controller
/*
 Returns the fetched results controller. Creates and configures the controller if necessary.
 */
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DrawingRecord"
                                              inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *creationTimeDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationTime" ascending:NO];
 //   NSSortDescriptor *titleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = @[creationTimeDescriptor];
  //  NSArray *sortDescriptors = @[creationTimeDescriptor,titleDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:managedObjectContext
                                                                      sectionNameKeyPath:@"creationTime"
                                                                               cacheName:@"Root"];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

/*
 NSFetchedResultsController delegate methods to respond to additions, removals and so on.
 */
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark - core Date stack

- (NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = [CoreDataManager defaultContext];
    return _managedObjectContext;
}

#pragma mark - Segue management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"drawingSegue"])
    {        
        DrawingViewController *drawingViewController = (DrawingViewController *)[segue destinationViewController];
        drawingViewController.delegate = self;
        NSManagedObjectContext *addingContext = [CoreDataManager defaultContext];
//        DrawingRecord *newDrawingRecord = (DrawingRecord *)[NSEntityDescription insertNewObjectForEntityForName:@"DrawingRecord" inManagedObjectContext:addingContext];
//        drawingViewController.drawingRecord = newDrawingRecord;
        drawingViewController.managedObjectContext = addingContext;
    }
    else if ([[segue identifier] isEqualToString:@"playerSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DrawingRecord *selectedRecord = (DrawingRecord *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        PlayerViewController *playerViewController = (PlayerViewController *)[segue destinationViewController];
        playerViewController.drawingRecord = selectedRecord;
    }
}

#pragma mark - Add controller delegate
/*
 Add controller's delegate method; informs the delegate that the add operation has completed, and indicates whether the user saved the new Drawing record.
 */
- (void)drawingViewController:(DrawingViewController *)controller didFinishWithSave:(BOOL)save {
    
    if (save) {
        NSError *error;
        NSManagedObjectContext *addingManagedObjectContext = [controller managedObjectContext];
        if (![addingManagedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        if (![[self.fetchedResultsController managedObjectContext] save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    // Dismiss the modal view to return to the main list
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createScribble:(id)sender
{
    
}

@end
