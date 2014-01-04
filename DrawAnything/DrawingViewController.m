//
//  DATDrawingViewController.m
//  DrawAnything
//
//  Created by andy on 24/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import "DrawingViewController.h"
#import "DrawingRecord.h"
#import "Word.h"
#import "Pen.h"
#import "Eraser.h"


@interface DrawingViewController()

@property (weak, nonatomic) IBOutlet UIToolbar *finish;
@property (strong, nonatomic) NSArray * wordList;
@property (strong,readwrite) NSUInteger cur;                 // store the current index of wordList

- (IBAction)skipAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@property (readwrite) NSString* navigationTitle;

@end


@implementation DrawingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadWordList];
    NSString *title = [self pickOneFromWordList];
    self.navigationController.title = title;
    
    [self loadButtomToolbar];
    
}


- (void)viewDidUnload {
    
    // Release any properties that are loaded in viewDidLoad or can be recreated lazily.
    self.fetchedResultsController = nil;
    
}


- (IBAction)skipAction:(id)sender {
    
    
    [self deleteCachedDrawing];
    [self updateWordState];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)doneAction:(id)sender
{

    if([self saveDrawing] == YES){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        // fail to save the drawing record,maybe out of the storage
  //      doSomethingelse()// ask user to empty some files;
    
    }
}


#pragma mark - Fetched results controller

- (void)loadNavigationItem (NSString*)title
{
    
}

- (void)loadWordList
{
    // Create and configure a fetch request with the DrawingRecord entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *gradeDescriptor = [[NSSortDescriptor alloc] initWithKey:@"grade" ascending:YES];
    NSArray *sortDescriptors = @[gradeDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"word.state == %@",Fresh];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (array != nil) {
        self.wordList = array;
    }
    else{
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);

    }
}


- (NSString*)pickOneFromWordList
{
    NSString *title;
    
    
    return title;
}

- (void)loadButtomToolbar
{
    


}

- (void)deleteCachedDrawing
{


}

- (void)updateWordState
 
- (BOOL)saveDrawing{
    
    BOOL status = NO;
    
    return status;
}


@end
