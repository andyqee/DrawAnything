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

@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) NSArray * wordList;
@property (readwrite) NSUInteger cur;                 // store the current index of wordList
@property (readwrite) NSString* navigationTitle;

- (IBAction)skipAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end


@implementation DrawingViewController

@synthesize wordList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //@TODO:
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self loadWordList];
    _cur = self.wordList.count - 1;
    
    NSString *title = [self pickNextFromWordList];
    self.navigationController.title = title;
    
    [self loadButtomToolbar];
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
        wordList = array;
    } else {
        NSLog(@"Unresolved error : fail to load word from core data %@, %@", error, [error userInfo]);
    }
}


- (NSString *)pickNextFromWordList
{
    _cur = (_cur >= wordList.count - 1) ? 0 : _cur++;
    return ((Word*)[wordList objectAtIndex:_cur]).name;
}

- (void)loadButtomToolbar
{
	_toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
	self.toolbar.barStyle = UIBarStyleDefault;
	
    [self adjustToolbarSize];
    [self.toolbar setFrame:CGRectMake(CGRectGetMinX(self.view.bounds),
                                      CGRectGetMinY(self.view.bounds) + CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.toolbar.frame),
                                      CGRectGetWidth(self.view.bounds),
                                      CGRectGetHeight(self.toolbar.frame))];
    
    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	[self.view addSubview:self.toolbar];
    
    [self createToolbarItems];
    // @TODO
}

- (void)adjustToolbarSize
{
	[self.toolbar sizeToFit];
    
	CGRect mainViewBounds = self.view.bounds;
	[self.toolbar setFrame:CGRectMake(CGRectGetMinX(mainViewBounds),
                                      CGRectGetMinY(mainViewBounds) + CGRectGetHeight(mainViewBounds) - CGRectGetHeight(self.toolbar.frame),
                                      CGRectGetWidth(mainViewBounds),
                                      CGRectGetHeight(self.toolbar.frame))];
}

- (void)createToolbarItems
{
    // match each of the toolbar item's style match the selection in the "UIBarButtonItemStyle" segmented control
//	UIBarButtonItemStyle style = [self.buttonItemStyleSegControl selectedSegmentIndex];
    
	// create the system-defined "OK or Done" button
//    UIBarButtonItem *systemItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:self.currentSystemItem
//                                                                                target:self
//                                                                                action:@selector(action:)];
//	systemItem.style = style;
//	
//	// flex item used to separate the left groups items and right grouped items
//	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                                              target:nil
//                                                                              action:nil];
//    
	
    // create a special tab bar item with a pen image and title
	UIBarButtonItem *infoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"segment_tools"]
                                                                 style:style
                                                                target:self
                                                                action:@selector(action:)];
    
	// Set the accessibility label for an image bar item.
	[infoItem setAccessibilityLabel:NSLocalizedString(@"ToolsIcon", @"")];
	
    // create a custom button with a background image with black text for its title:
    UIBarButtonItem *customItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Item1"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(action:)];
    UIImage *baseImage = [UIImage imageNamed:@"whiteButton"];
    UIImage *backroundImage = [baseImage stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    [customItem1 setBackgroundImage:backroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    NSDictionary *textAttributes = @{ UITextAttributeTextColor:[UIColor blackColor] };
    [customItem1 setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    // create a bordered style button with custom title
	UIBarButtonItem *customItem2 = [[UIBarButtonItem alloc] initWithTitle:@"Item2"
																	style:style	// note you can use "UIBarButtonItemStyleDone" to make it blue
																   target:self
																   action:@selector(action:)];
    
	// apply the bar button items to the toolbar
    [self.toolbar setItems:@[ systemItem, flexItem, customItem1, customItem2, infoItem ] animated:NO];
    
    
}

- (void)deleteCachedDrawing
{


}

- (void)updateWordState
{



}
 
- (BOOL)saveDrawing{
    
}


@end
