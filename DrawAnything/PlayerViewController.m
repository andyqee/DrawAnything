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
    CGFloat imageViewWidth = self.view.bounds.size.height - self.buttomToolbar.bounds.size.height;
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, imageViewWidth);
    [self.uiView addSubview:imageView];
    self.imageView = imageView;
    [self.view bringSubviewToFront:self.buttomToolbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

- (IBAction)share:(id)sender
{
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Share"
                                                contentText:@"Share with your sina weibo"
                                            leftButtonTitle:@"cancel"
                                           rightButtonTitle:@"OK"];
    [alert show];
    alert.leftBlock = ^() {
        NSLog(@"left button clicked");
    };
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        NSLog(@"Do something interesting after dismiss block");
    };
  
}

- (IBAction)removeToTrash:(id)sender
{
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Attention!"
                                                contentText:@"Do you want to delete the masterpiece"
                                            leftButtonTitle:@"cancel"
                                           rightButtonTitle:@"delete"];
    [alert show];
    alert.leftBlock = ^() {
        NSLog(@"left button clicked");
    };
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        NSLog(@"Do something interesting after dismiss block");
    };

}

@end