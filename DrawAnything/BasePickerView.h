//
//  BasePickerView.h
//  DrawAnything
//
//  Created by andy on 13/2/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BasePickerViewDelegate;


@interface BasePickerView : UIView

@property (nonatomic, assign) id<BasePickerViewDelegate> delegate;
@property (nonatomic, assign) int radius;
@property (nonatomic, assign) int bubbleRadius;
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, weak) UIView *parentView;

//- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView buttonType:(BOOL)Type;
- (id)initWithPoint:(CGPoint)point radius:(int)radiusValue inView:(UIView *)inView;
-(void)show:(BOOL)type;
-(void)hide;

@end

@protocol BasePickerViewDelegate<NSObject>

@required
- (void)strokeColorPickerBubble:(BasePickerView *)pickerView tappedBubbleColor:(UIColor*)color;

@optional
- (void)BubblesDidHide;

@end
