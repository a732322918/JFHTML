//
//  JFHTMLAttributedStringBuilder.m
//  JFHTML
//
//  Created by 付书炯 on 16/5/3.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "JFHTMLAttributedStringBuilder.h"
#import "JFHTMLParser.h"
#import "JFHTMLElement.h"
#import "JFHTMLTextElement.h"
#import "JFHTMLBreakElement.h"

@interface JFHTMLAttributedStringBuilder () <JFHTMLParserDelegate>
{
    NSData *_data;
    
    NSMutableAttributedString *_builtString;
    

    JFHTMLElement *_rootElement;
    JFHTMLElement *_currentElement;
    JFHTMLElement *_previousElement;
    
    dispatch_group_t _group;
}

@end

@implementation JFHTMLAttributedStringBuilder

- (instancetype)initWithHTML:(NSData *)data {
    self = [super init];
    if (self) {
        _data = data;
        _group = dispatch_group_create();
    }
    return self;
}

- (NSAttributedString *)build {
    if (!_builtString) {
        [self _buildString];
    }
    
    return _builtString;
}

- (void)_buildString {
    JFHTMLParser *parser = [[JFHTMLParser alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    parser.delegate = self;
    
    dispatch_group_async(_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [parser parse];
        
    });
    
    dispatch_group_wait(_group, DISPATCH_TIME_FOREVER);
}

- (void)parserDidStartDocument:(JFHTMLParser *)parser {
    _builtString = [[NSMutableAttributedString alloc] init];
    _rootElement = [JFHTMLElement new];
    _rootElement.fontSize = 14;
    _currentElement = _rootElement;
}

- (void)parser:(JFHTMLParser *)parser didStartElement:(NSString *)elementName attributes:(NSDictionary *)attributeDict {
    JFHTMLElement *newElement = [JFHTMLElement elementWithName:elementName attributes:attributeDict];
    
    
    [newElement inheritAttributesFromElement:_currentElement];
    if ([elementName isEqualToString:@"h3"]) {
        newElement.headerLevel = 3;
    }
    [_currentElement addChildNode:newElement];
    
    _currentElement = newElement;
}

- (void)parser:(JFHTMLParser *)parser didEndElement:(NSString *)elementName {
    while (![_currentElement.name isEqualToString:elementName] && _currentElement)
    {
        // missing end of element, attempt to recover
        _currentElement = (JFHTMLElement*)[_currentElement parentNode];
    }
    _currentElement = (JFHTMLElement*)_currentElement.parentNode;
}

- (void)parser:(JFHTMLParser *)parser foundCharacters:(NSString *)string {
    
    JFHTMLTextElement *textElement = [[JFHTMLTextElement alloc] init];
    textElement.text = string;
    [textElement inheritAttributesFromElement:_currentElement];
    [_currentElement addChildNode:textElement];
}

- (void)parserDidEndDocument:(JFHTMLParser *)parser {
    _builtString = (NSMutableAttributedString *)_rootElement.attributedString;
}

@end