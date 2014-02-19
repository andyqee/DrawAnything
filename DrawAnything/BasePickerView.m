//
//  BasePickerView.m
//  DrawAnything
//
//  Created by andy on 13/2/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "BasePickerView.h"

CGFloat const ColorPickerRadius = 30;

int const whiteHEX = 0xffffff;
int const blackHEX = 0;
int const facebookblueHEX = 0x3c5a9a;
int const twitterblueHEX = 0x3083be;
int const redHEX = 0xce3025;
int const greenHEX = 0x00FF00;

int const BubbleButtonNumber = 6;


@interface BasePickerView()

@property (nonatomic,strong) UIView *backgroudView;
@property (nonatomic,strong) NSMutableArray *bubbles;
@property (nonatomic,strong) NSMutableDictionary *bubblesIndex;
@property (nonatomic,strong) NSMutableDictionary *bubblesColorIndex;
@property (nonatomic,strong) NSMutableDictionary *bubblesSizeIndex;

@end

@implementation BasePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView
{
    self = [super initWithFrame:CGRectMake(point.x - radiusValue, point.y - radiusValue, radiusValue * 2, radiusValue * 2)];
//    self = [super initWithFrame:CGRectMake(0,0, inView.bounds.size.width, inView.bounds.size.height)];
    if (self) {
//        self.backgroundColor = [UIColor lightGrayColor];
//        self.alpha = 0.3;
        _radius = radiusValue;
        _parentView = inView;
    }
    
    return self;
}

#pragma mark -
#pragma mark Actions

- (void)buttonTabbed:(UIButton*)button
{
    int tag = button.tag;
    UIColor* bubbleColor = [_bubblesColorIndex objectForKey:[NSNumber numberWithInt:tag]];
    [self hide];
    if ([self.delegate respondsToSelector:@selector(strokeColorPickerBubble:tappedBubbleColor:)]) {
        [self.delegate strokeColorPickerBubble:self tappedBubbleColor:bubbleColor];
    }
}

- (void)sizeButtonTabbed:(UIButton*)button
{
    int tag = button.tag;
    NSNumber* bubbleSize = [_bubblesSizeIndex objectForKey:[NSNumber numberWithInt:tag]];
    [self hide];
    if ([self.delegate respondsToSelector:@selector(strokeSizePickerBubble:tappedBubbleSize:)]) {
        [self.delegate strokeSizePickerBubble:self tappedBubbleSize:bubbleSize];
    }
}

#pragma mark -
#pragma mark show and hide method


- (void)hide
{
    if(_isAnimating == NO)
    {
        _isAnimating = YES;
        int inetratorI = 0;
        for (UIButton *bubble in _bubbles)
        {
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(hideBubbleWithAnimation:) withObject:bubble afterDelay:delayTime];
            ++inetratorI;
        }
    }
}

- (void)showSizePickerBubble:(UIColor *)strokeColor
{
    if (_isAnimating == NO){
        
        _isAnimating = YES;
        [_parentView addSubview:self];
        _backgroudView = [[UIView alloc] initWithFrame:_parentView.bounds];
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped:)];
        [_backgroudView addGestureRecognizer:tapges];
        [_parentView insertSubview:_backgroudView belowSubview:self];
        
        if (_bubbles) {
            _bubbles = nil;
        }
        _bubbles = [[NSMutableArray alloc]init];
        _bubblesSizeIndex = [[NSMutableDictionary alloc] init];
        
        int size[] = {3,6,12,16,20,25};
        for (int i = 0;i < BubbleButtonNumber;i++) {
            [self createSizeButton:size[i] withBackgroudColor: strokeColor];
            [_bubblesSizeIndex setObject:[NSNumber numberWithInt:size[i] ] forKey:[NSNumber numberWithInt:i]];
        }
        
        if (_bubbles.count == 0) {return;}
        
        float bubbleDistanceFromPivot = _radius - _bubbleRadius;
        float bubblesBetweenAngel = 360 / _bubbles.count;
        float startAngel = (180 - bubblesBetweenAngel) * 0.5;
        NSMutableArray *coordinates = [NSMutableArray array];
        
        for (int i = 0; i < _bubbles.count; i++) {
            UIButton *bubble = [_bubbles objectAtIndex:i];
            bubble.tag = i;
            
            float angle = startAngel + i * bubblesBetweenAngel;
            float x = cos(angle * M_PI / 180) * bubbleDistanceFromPivot + _radius;
            float y = sin(angle * M_PI / 180) * bubbleDistanceFromPivot + _radius;
            
            [coordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:x], @"x", [NSNumber numberWithFloat:y], @"y", nil]];
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.center = CGPointMake(_radius, _radius);
        }
        
        int inetratorI = 0;
        for (NSDictionary *coordinate in coordinates)
        {
            UIButton *bubble = [_bubbles objectAtIndex:inetratorI];
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(showBubbleWithAnimation:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:bubble, @"button", coordinate, @"coordinate", nil] afterDelay:delayTime];
            ++inetratorI;
        }
    }

}

- (void) showColorPickerBubble
{
    if (_isAnimating == NO){
        
        _isAnimating = YES;
        [_parentView addSubview:self];
        _backgroudView = [[UIView alloc] initWithFrame:_parentView.bounds];
        _backgroudView.backgroundColor = [UIColor lightGrayColor];
        _backgroudView.alpha = 0.3;
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped:)];
        [_backgroudView addGestureRecognizer:tapges];
        [_parentView insertSubview:_backgroudView belowSubview:self];
        
        if (_bubbles) {
            _bubbles = nil;
        }
        _bubbles = [[NSMutableArray alloc]init];
        _bubblesColorIndex = [[NSMutableDictionary alloc] init];
        
        int colorHEXs[] = {whiteHEX,blackHEX,facebookblueHEX,twitterblueHEX,redHEX,greenHEX};
        for (int i = 0;i < BubbleButtonNumber;i++) {
            [self createButton:ColorPickerRadius withBackgroudColor: colorHEXs[i]];
            [_bubblesColorIndex setObject:[self colorFromHEX:colorHEXs[i]] forKey:[NSNumber numberWithInt:i]];
        }
        
        if (_bubbles.count == 0) {return;}
        
        float bubbleDistanceFromPivot = _radius - _bubbleRadius;
        float bubblesBetweenAngel = 360 / _bubbles.count;
        float startAngel = (180 - bubblesBetweenAngel) * 0.5;
        NSMutableArray *coordinates = [NSMutableArray array];
        
        for (int i = 0; i < _bubbles.count; i++) {
            UIButton *bubble = [_bubbles objectAtIndex:i];
            bubble.tag = i;
            
            float angle = startAngel + i * bubblesBetweenAngel;
            float x = cos(angle * M_PI / 180) * bubbleDistanceFromPivot + _radius;
            float y = sin(angle * M_PI / 180) * bubbleDistanceFromPivot + _radius;
            
            [coordinates addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:x], @"x", [NSNumber numberWithFloat:y], @"y", nil]];
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.center = CGPointMake(_radius, _radius);
        }
        
        int inetratorI = 0;
        for (NSDictionary *coordinate in coordinates)
        {
            UIButton *bubble = [_bubbles objectAtIndex:inetratorI];
            float delayTime = inetratorI * 0.1;
            [self performSelector:@selector(showBubbleWithAnimation:) withObject:[NSDictionary dictionaryWithObjectsAndKeys:bubble, @"button", coordinate, @"coordinate", nil] afterDelay:delayTime];
            ++inetratorI;
        }
    }
}

- (void) createButton:(CGFloat)size withBackgroudColor:(int)hex
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonTabbed:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 2 * size, 2 * size);
    
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * size, 2 * size)];
    circle.backgroundColor = [self colorFromHEX:hex];
    circle.layer.cornerRadius = size;
    circle.layer.masksToBounds = YES;
    circle.opaque = NO;
    circle.alpha = 0.97;
    
    [button setBackgroundImage:[self imageWithView:circle] forState:UIControlStateNormal];
    [_bubbles addObject:button];
    [self addSubview:button];
}

- (void) createSizeButton:(int)size withBackgroudColor:(UIColor *)color
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(sizeButtonTabbed:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 2 * size, 2 * size);
    
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * size, 2 * size)];
    circle.backgroundColor = color;
    circle.layer.cornerRadius = size;
    circle.layer.masksToBounds = YES;
    circle.opaque = NO;
    circle.alpha = 0.97;
    
    [button setBackgroundImage:[self imageWithView:circle] forState:UIControlStateNormal];
    [_bubbles addObject:button];
    [self addSubview:button];
}

- (void)backgroundViewTapped:(UITapGestureRecognizer*)tapGesture
{
    [tapGesture.view removeFromSuperview];
    [self hide];
}

- (void)showBubbleWithAnimation:(NSDictionary *)info
{
    UIButton *button = (UIButton *)[info objectForKey:@"button"];
    NSDictionary *coordinate = (NSDictionary *)[info objectForKey:@"coordinate"];
    
    [UIView animateWithDuration:0.25 animations:^{
        button.center = CGPointMake([[coordinate objectForKey:@"x"] floatValue], [[coordinate objectForKey:@"y"] floatValue]);
        button.alpha = 1;
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            button.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                button.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                if(button.tag == _bubbles.count - 1) _isAnimating = NO;
                button.layer.shadowColor = [UIColor blackColor].CGColor;
                button.layer.shadowOpacity = 0.2;
                button.layer.shadowOffset = CGSizeMake(0, 1);
                button.layer.shadowRadius = 2;
            }];
        }];
    }];
}

- (void)hideBubbleWithAnimation:(UIButton *)bubble
{
    [UIView animateWithDuration:0.2 animations:^{
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            bubble.center = CGPointMake(self.radius, self.radius);
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.alpha = 0;
        } completion:^(BOOL finished) {
            if(bubble.tag == _bubbles.count - 1) {
                self.isAnimating = NO;
                self.hidden = YES;
                [_backgroudView removeFromSuperview];
                _backgroudView = nil;
                
                if([self.delegate respondsToSelector:@selector(BubblesDidHide)]) {
                    [self.delegate BubblesDidHide];
                }
                
                [self removeFromSuperview];
            }
            [bubble removeFromSuperview];
        }];
    }];
}

- (UIColor *)colorFromHEX:(int)rgb
{
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0];
}

-(UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end