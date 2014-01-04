//
//  Word.h
//  DrawAnything
//
//  Created by andy on 4/1/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Word : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSNumber * grade;

@end
