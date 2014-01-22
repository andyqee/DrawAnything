//
//  StationeryToolbar.m
//  DrawAnything
//
//  Created by andy on 8/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "StationeryToolbar.h"
#import "StaioneryToolbarButton.h"


@interface StationeryToolbar ()

@property (nonatomic,strong)NSArray *stationeryButtons;
@property (nonatomic,strong)UIView *toolbarView;
@property (nonatomic,strong)CALayer *topBorder;

@end

@implementation StationeryToolbar

@synthesize stationeryButtons;

+ (instancetype)initToolbarWithButtons: (NSArray *)buttons
{
    return [[StationeryToolbar alloc] initWithButtons: buttons];
    
}

- (id)initWithButtons: (NSArray *)buttons
{
    CGRect frame = CGRectMake(0,0,self.window.rootViewController.view.bounds.size.width,50) ;
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        stationeryButtons = buttons;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:[self loadButtonView]];
        
    }
    return self;
}

- (UIView*)loadButtonView
{
    _toolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    _toolbarView.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.0];
    _toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    
    _topBorder = [CALayer layer];
    _topBorder.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, 0.5f);
    _topBorder.backgroundColor = [UIColor colorWithWhite:0.678 alpha:1.0].CGColor;
    
    [_toolbarView.layer addSublayer:_topBorder];
 //   [_toolbarView addSubview:[self fackToolbar]];
    
    
    return _toolbarView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
