//
//  JFHTMLParser.h
//  JFHTML
//
//  Created by 付书炯 on 16/4/29.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JFHTMLParserDelegate;

@interface JFHTMLParser : NSObject

- (instancetype)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding;

@property (nonatomic, weak) id <JFHTMLParserDelegate> delegate;

- (BOOL)parse;
- (void)abortParsing;

@property (readonly, copy) NSError *parserError;

@end

@protocol JFHTMLParserDelegate <NSObject>

@optional

- (void)parserDidStartDocument:(JFHTMLParser *)parser;

- (void)parserDidEndDocument:(JFHTMLParser *)parser;

- (void)parser:(JFHTMLParser *)parser didStartElement:(NSString *)elementName attributes:(NSDictionary *)attributeDict;

- (void)parser:(JFHTMLParser *)parser didEndElement:(NSString *)elementName;

- (void)parser:(JFHTMLParser *)parser foundCharacters:(NSString *)string;

- (void)parser:(JFHTMLParser *)parser foundComment:(NSString *)comment;

- (void)parser:(JFHTMLParser *)parser foundCDATA:(NSData *)CDATABlock;

- (void)parser:(JFHTMLParser *)parser parseErrorOccurred:(NSError *)parseError;

@end