//
//  DATPlayerViewController.m
//  DrawAnything
//
//  Created by andy on 24/12/13.
//  Copyright (c) 2013 andy. All rights reserved.
//

#import "PlayerViewController.h"
#import "DrawingRecord.h"


@interface PlayerViewController()

@property (weak, nonatomic) IBOutlet UIToolbar *buttomToolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *middlePlayButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightPlayButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftActionButton;

@property (strong, nonatomic) IBOutlet UIView *uiView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.drawingRecord.title;
    NSData *imageData = [[NSData alloc]initWithContentsOfFile:self.drawingRecord.snapShotFilePath];
    UIImage *snapShotImage = [[UIImage alloc]initWithData:imageData];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:snapShotImage];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.buttomToolbar.bounds.size.height);
   // imageView.frame = self.view.frame;
    [self.uiView addSubview:imageView];
    
    self.imageView = imageView;
    
    [self.view bringSubviewToFront:self.buttomToolbar];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //Register for when the save window appears so the keyboard won't conflict with it.
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{

    
}



- (IBAction)share:(id)sender {
    
}

- (IBAction)removeToTrash:(id)sender {
}

@end