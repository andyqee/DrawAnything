//
//  XmlParser.m
//  DrawAnything
//
//  Created by andy on 19/2/14.
//  Copyright (c) 2014 andy. All rights reserved.
//

#import "XMLParser.h"

@interface XMLParser () <NSXMLParserDelegate>

@property (nonatomic) NSMutableArray *words;
@property NSUInteger currentIndex;
@property (nonatomic,strong)NSXMLParser *addressParser;
@property (nonatomic,strong)NSMutableString *currentParsedCharacterData;

@end

@implementation XMLParser

- (NSArray*)parseXMLFile
{
    if([_addressParser parse]){
        NSLog(@"XML file has been parsed successfully");
        return self.words;
    }
    return Nil;
}

- (id)initWithFilePath:(NSString*)pathToFile
{
    if (self = [super init]) {
        
        NSURL *xmlURL = [NSURL fileURLWithPath:pathToFile];
        _addressParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
        _addressParser.delegate = self;
        
    }
    return  self;
}

#pragma mark - NSXMLParser delegate methods
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"start parse");
}
// sent when the parser begins parsing of the document.
- (void)parserDidEndDocument:(NSXMLParser *)parser;
{
    NSLog(@"end parse");
}

- (void)parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
       namespaceURI:(NSString *)namespaceURI
      qualifiedName:(NSString *)qName
         attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"array"]) {
        self.words = [[NSMutableArray alloc] init];
        self.currentIndex = 0;
        return;
    }
    if ([elementName isEqualToString:@"string"]) {
        return;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!self.currentParsedCharacterData) {
        self.currentParsedCharacterData = [[NSMutableString alloc]initWithString:string];
    }
    else
        [self.currentParsedCharacterData appendString:string];
    NSLog(@"found Chracters: %@",[NSString stringWithString: self.currentParsedCharacterData]);
    
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"string"]) {
        [self.words insertObject:self.currentParsedCharacterData atIndex:self.currentIndex];
        self.currentParsedCharacterData = nil;
    }
    
    return;
}

@end
