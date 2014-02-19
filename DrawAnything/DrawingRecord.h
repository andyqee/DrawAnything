//
//  DrawingRecord.h
//  DrawAnything
//
//  Created by andy on 2/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface DrawingRecord : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * snapShotFilePath;
@property (nonatomic, retain) NSDate * creationTime;
@property (nonatomic, retain) NSDate * finishedTime;
@property (nonatomic, retain) NSString * recordFilePath;
@property (nonatomic, retain) Word *associate;

@end
