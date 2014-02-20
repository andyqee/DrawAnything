//
//  XmlParser.h
//  DrawAnything
//
//  Created by andy on 19/2/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"

@interface XMLParser : NSOperation

- (NSArray*)parseXMLFile;

- (id)initWithFilePath:(NSString*)pathToFile;

@end
