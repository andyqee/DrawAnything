//
//  DATCanvas.h
//  DrawAnything
//
//  Created by andy on 14/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mark.h"

@interface DrawingCanvas : UIView

@property (nonatomic,strong) id<Mark> mark;

@end
