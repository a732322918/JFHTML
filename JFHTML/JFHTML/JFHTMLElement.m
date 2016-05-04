//
//  JFHTMLElement.m
//  JFHTML
//
//  Created by 付书炯 on 16/4/29.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "JFHTMLElement.h"
#import "JFHTMLBreakElement.h"
#import <UIKit/UIKit.h>

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
    
    NSMutableDictionary *myAttributes = self.attributes.mutableCopy;
    NSMutableArray *diffKeys = element.attributes.allKeys.mutableCopy;
    [diffKeys removeObjectsInArray:self.attributes.allKeys];
 
    for (NSString *key in diffKeys) {
        [myAttributes setObject:element.attributes[key] forKey:key];
    }
    
    self.attributes = myAttributes;
}

- (NSDictionary *)attributesForAttributedStringRepresentation {
    UIFont *font;
    if (self.headerLevel) {
        font = [UIFont boldSystemFontOfSize:self.fontSize];
    }
    else {
        font = [UIFont systemFontOfSize:self.fontSize];
    }
    return @{NSFontAttributeName: font,
             NSForegroundColorAttributeName: [UIColor blackColor]};
}

- (void)applyStyleDictionary:(NSDictionary *)styles {
    
}

- (NSAttributedString *)attributedString {
    NSMutableAttributedString *builtString = [[NSMutableAttributedString alloc] init];
    for (JFHTMLElement *element in self.childNodes) {
        NSAttributedString *attributedString = [element attributedString];
    
        [builtString appendAttributedString:attributedString];
        if ([element isKindOfClass:[JFHTMLBreakElement class]]) {
            [builtString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
        
        if (element.headerLevel > 0) {
            [builtString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
        
        if ([element.name isEqualToString:@"p"]) {
            [builtString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
    }
    
    return builtString;
}

@end
