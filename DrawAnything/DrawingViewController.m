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
//#import "Pen.h"
//#import "Eraser.h"
#import "StationeryToolbar.h"

#import "Dot.h"
#import "Stroke.h"
#import "DrawingCanvas.h"
#import "Scribble.h"
#import "Vertex.h"

//CONSTANTS:
CGFloat const defaultStrokeSize = 10.0;
CGFloat const defaultStrokeRed = 0;
CGFloat const defaultStrokeGreen = 0;
CGFloat const defaultStrokeBlue = 0;


@interface DrawingViewController()

@property (strong, nonatomic) IBOutlet UIView *canvasViewContainer;
@property (strong, nonatomic) StationeryToolbar *stationaryToolbar;
@property (strong, nonatomic) NSArray *wordList;
@property (readwrite) NSUInteger cur;                 // store the current index of wordList
@property (readwrite) NSString *navigationTitle;

@property (strong) Dot *dot;
@property (strong) Stroke *stroke;
@property (readwrite) CGFloat strokeSize;
@property (strong, nonatomic) UIColor *strokeColor;
@property (strong, nonatomic) Scribble *scribble;

@property (strong, nonatomic) DrawingCanvas *canvas;
@property (readwrite) CGPoint startPoint;

- (IBAction)skipAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end

@implementation DrawingViewController
@synthesize wordList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //@TODO
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadWordList];
    _cur = self.wordList.count - 1;
 //   NSString *title = [self pickNextFromWordList];
    NSString *title = @"testTitle";
  //  self.navigationController.title = title;
 //   self.title = title;
    self.navigationItem.title = title;

    [self loadButtomToolbar];
    [self createCanvas];
    [self setUpScribble];
    [self setUpDefaultStroke];
}

- (void)createCanvas
{
    [self.canvas removeFromSuperview];
    
    CGFloat width = self.canvasViewContainer.bounds.size.width;
    CGFloat height = self.canvasViewContainer.bounds.size.height;

    CGRect frame = CGRectMake(0, 0,width,height);
    self.canvas = [[DrawingCanvas alloc] initWithFrame:frame];
 //   [self.canvas setBackgroundColor:[UIColor grayColor]];  //
    [self.canvasViewContainer addSubview:self.canvas];
}

- (void)setUpScribble
{
   // self.scribble = [[Scribble alloc]init];
    self.scribble = [Scribble new];
    [self.scribble addObserver:self forKeyPath:@"mark" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

- (void)setUpDefaultStroke
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat size = [userDefaults floatForKey:@"size"];
    if (size == 0) {
        [userDefaults setFloat:defaultStrokeSize forKey:@"size"];
        [userDefaults setFloat:defaultStrokeRed forKey:@"red"];
        [userDefaults setFloat:defaultStrokeGreen forKey:@"green"];
        [userDefaults setFloat:defaultStrokeBlue forKey:@"blue"];
    }
    CGFloat red = [userDefaults floatForKey:@"red"];
    CGFloat green = [userDefaults floatForKey:@"green"];
    CGFloat blue = [userDefaults floatForKey:@"blue"];
    size = [userDefaults floatForKey:@"size"];

    self.strokeSize = size;
    self.strokeColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (void)loadWordList
{
    self.managedObjectContext = [CoreDataManager defaultContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *gradeDescriptor = [[NSSortDescriptor alloc] initWithKey:@"grade" ascending:YES];
    NSArray *sortDescriptors = @[gradeDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"state == %d",Fresh];
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

#pragma mark -
#pragma mark Touch Event Handlers

- (void)touchesBegan:(NSSet *)inTouches withEvent:(UIEvent *)event
{
    _startPoint = [[inTouches anyObject] locationInView:_canvas];
}

- (void)touchesMoved:(NSSet *)inTouches withEvent:(UIEvent *)event
{
    CGPoint lastPoint = [[inTouches anyObject] previousLocationInView:_canvas];
    if (CGPointEqualToPoint(lastPoint, _startPoint))
    {
        id <Mark> newStroke = [[Stroke alloc] init];
        newStroke.color = _strokeColor;
        newStroke.size = _strokeSize;
        newStroke.timeInterval = event.timestamp;
        
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&newStroke atIndex:2];
        
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&newStroke atIndex:2];
        
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
    }
    CGPoint currentPoint = [[inTouches anyObject] locationInView:_canvas];
    NSTimeInterval timeInterval = event.timestamp;
    
    Vertex *vertex = [[Vertex alloc]initWithLocation:currentPoint TimeStamp:timeInterval];
    [self.scribble addMark:vertex shouldAddToPreviousMark:YES];
}

- (void)touchesEnded:(NSSet *)inTouches withEvent:(UIEvent *)event
{
    CGPoint previousPoint = [[inTouches anyObject] previousLocationInView:_canvas];
    CGPoint currentPoint = [[inTouches anyObject] locationInView:_canvas];
    if (CGPointEqualToPoint(previousPoint, currentPoint)) {
        NSTimeInterval timeInterval = event.timestamp;
       
        Dot *dot = [[Dot alloc]initWithLocation:currentPoint TimeStamp:timeInterval];
        dot.color = _strokeColor;
        dot.size = _strokeSize;
        
        NSInvocation *drawInvocation = [self drawScribbleInvocation];
        [drawInvocation setArgument:&dot atIndex:2];
        
        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
        [undrawInvocation setArgument:&dot atIndex:2];
        
        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
    }
    _startPoint = CGPointZero;
}

- (void)touchesCancelled:(NSSet *)inTouches withEvent:(UIEvent *)event
{
    _startPoint = CGPointZero;
}

#pragma mark - Scribble observer method

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.scribble && [keyPath isEqualToString:@"mark"]) {
        id <Mark> mark = [change objectForKey:NSKeyValueChangeNewKey];
        _canvas.mark = mark;
       [_canvas setNeedsDisplay];
    }
}

#pragma mark - Scribble invocation

- (NSInvocation *)drawScribbleInvocation
{
    NSMethodSignature *executeMethodSignature = [_scribble methodSignatureForSelector:@selector(addMark:shouldAddToPreviousMark:)];
    NSInvocation *drawInvocation = [NSInvocation invocationWithMethodSignature:executeMethodSignature];
    [drawInvocation setTarget:_scribble];
    [drawInvocation setSelector:@selector(addMark:shouldAddToPreviousMark:)];
    BOOL attachToPreviousMark = NO;
    [drawInvocation setArgument:&attachToPreviousMark atIndex:3];
    
    return drawInvocation;
}

- (NSInvocation *)undrawScribbleInvocation
{
    NSMethodSignature *unEcuteMethodSignature = [_scribble methodSignatureForSelector:@selector(removeMark:)];
    NSInvocation *unDrawInvocation = [NSInvocation invocationWithMethodSignature:unEcuteMethodSignature];
    [unDrawInvocation setTarget:_scribble];
    [unDrawInvocation setSelector:@selector(removeMark:)];
    
    return unDrawInvocation;
}

#pragma mark - Invocation

- (void)executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation
{
    [invocation retainArguments];
    [[self.undoManager prepareWithInvocationTarget:self]unexecuteInvocation:undoInvocation withRedoInvocation:invocation];
    [invocation invoke];
}

- (void)unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation;
{
    [invocation retainArguments];
    [[self.undoManager prepareWithInvocationTarget:self]executeInvocation:redoInvocation withUndoInvocation:invocation];
    [invocation invoke];
}

#pragma mark -

- (void)loadButtomToolbar
{
    
}

- (void)adjustToolbarSize
{
    
}

- (void)createToolbarItems
{
    
}

- (void)deleteCachedDrawing
{
    
}

- (void)updateWordState
{
    
}

- (void)saveDrawing
{
    
}

#pragma mark -
- (IBAction)skipAction:(id)sender {
    [self deleteCachedDrawing];
    [self updateWordState];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneAction:(id)sender
{
    [self saveDrawing];
}

// We do not support auto-rotation
- (BOOL)shouldAutorotate
{
    return NO;
}
@end
