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

            [self appendEndOfParagraphTo:builtString];
        
    }
    
    if ([self.name isEqualToString:@"p"]) {
        
            [self appendEndOfParagraphTo:builtString];
        
    }
    
    return builtString;
}

- (NSMutableParagraphStyle *)paragraphStyle {
    if (!_paragraphStyle) {
        _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    }
    return _paragraphStyle;
}

- (void)appendEndOfParagraphTo:(NSMutableAttributedString *)attributedString
{
    NSUInteger length = [attributedString length];
    if (length <= 0) {
        NSAttributedString *newlineString = [[NSAttributedString alloc] initWithString:@"\n" attributes:[self attributesForAttributedStringRepresentation]];
        [attributedString appendAttributedString:newlineString];
        return;
    }
    
    NSRange effectiveRange;
    NSDictionary *attributes = [attributedString attributesAtIndex:length-1 effectiveRange:&effectiveRange];
    
    NSMutableDictionary *appendAttributes = [NSMutableDictionary dictionary];
    
    id font = [attributes objectForKey:NSFontAttributeName];
    
    if (font)
    {
        [appendAttributes setObject:font forKey:NSFontAttributeName];
    }
    
    id paragraphStyle = [attributes objectForKey:NSParagraphStyleAttributeName];
    
    if (paragraphStyle)
    {
        [appendAttributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    
    
    
    id foregroundColor = [attributes objectForKey:NSForegroundColorAttributeName];
    
    if (foregroundColor)
    {
        [appendAttributes setObject:foregroundColor forKey:NSForegroundColorAttributeName];
    }
    
    
    NSAttributedString *newlineString = [[NSAttributedString alloc] initWithString:@"\n" attributes:appendAttributes];
    [attributedString appendAttributedString:newlineString];
}

@end
