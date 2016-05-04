//
//  JFHTMLElement.m
//  JFHTML
//
//  Created by 付书炯 on 16/4/29.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "JFHTMLElement.h"
#import "JFHTMLBreakElement.h"

@implementation JFHTMLElement

+ (instancetype)elementWithName:(NSString *)name attributes:(NSDictionary *)attributes {
    Class class;
    if ([name isEqualToString:@"br"]) {
        class = [JFHTMLBreakElement class];
    }
    else {
        class = [JFHTMLElement class];
    }
    
    return [[class alloc] initWithName:name attributes:attributes];
}

- (instancetype)initWithName:(NSString *)name attributes:(NSDictionary *)attributes {
    self = [super initWithName:name attributes:attributes];
    if (self) {
        _fontSize = 12;
    }
    return self;
}

- (void)inheritAttributesFromElement:(JFHTMLElement *)element {
    
    self.headerLevel = element.headerLevel;
    self.fontSize = element.fontSize;
    self.paragraphStyle = element.paragraphStyle.mutableCopy;
    
    NSMutableDictionary *myAttributes = self.attributes.mutableCopy;
    NSMutableArray *diffKeys = element.attributes.allKeys.mutableCopy;
    [diffKeys removeObjectsInArray:self.attributes.allKeys];
 
    for (NSString *key in diffKeys) {
        [myAttributes setObject:element.attributes[key] forKey:key];
    }
    
    self.attributes = myAttributes;
}

- (CGFloat)headerFontSize {
    return ceil(self.fontSize * (2 / sqrt(self.headerLevel)));
}

- (NSDictionary *)attributesForAttributedStringRepresentation {
    UIFont *font;
    if (self.headerLevel) {
        font = [UIFont boldSystemFontOfSize:[self headerFontSize]];
    }
    else {
        font = [UIFont systemFontOfSize:self.fontSize];
    }
    return @{NSFontAttributeName: font,
             NSForegroundColorAttributeName: [UIColor blackColor],
             NSParagraphStyleAttributeName: self.paragraphStyle};
}

- (void)applyStyleDictionary:(NSDictionary *)styles {
    
}

- (NSAttributedString *)attributedString {
    NSMutableAttributedString *builtString = [[NSMutableAttributedString alloc] init];
    for (JFHTMLElement *element in self.childNodes) {
        NSAttributedString *attributedString = [element attributedString];
    
        [builtString appendAttributedString:attributedString];
    }
    
    if ([self.name isEqualToString:@"h1"] || [self.name isEqualToString:@"h2"] || [self.name isEqualToString:@"h3"] || [self.name isEqualToString:@"h4"] || [self.name isEqualToString:@"h5"] || [self.name isEqualToString:@"h6"]) {
        [builtString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:[self attributesForAttributedStringRepresentation]]];
    }
    
    if ([self.name isEqualToString:@"p"]) {
        [builtString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:[self attributesForAttributedStringRepresentation]]];
    }
    
    return builtString;
}

- (NSString *)description {
    NSString *result = @"";
    NSUInteger indentLevel = 0;
    for (JFHTMLElement *element in self.childNodes) {
        
        NSString *placeholder = @"";
        for (int i = 0; i < indentLevel; i++) {
            placeholder = [placeholder stringByAppendingString:@"   "];
        }
        
        result = [result stringByAppendingString:placeholder];
        result = [result stringByAppendingString:element.name];
        result = [result stringByAppendingString:element.description];
        indentLevel++;
    }
    
    return result;
}

- (NSMutableParagraphStyle *)paragraphStyle {
    if (!_paragraphStyle) {
        _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    }
    return _paragraphStyle;
}
@end
