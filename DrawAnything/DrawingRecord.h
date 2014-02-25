//
//  DrawingRecord.h
//  DrawAnything
//
//  Created by andy on 25/2/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface DrawingRecord : NSManagedObject

@property (nonatomic, retain) NSDate * creationTime;
@property (nonatomic, retain) NSDate * finishedTime;
@property (nonatomic, retain) NSString * recordFilePath;
@property (nonatomic, retain) NSString * snapShotFilePath;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) Word *associate;

@end
