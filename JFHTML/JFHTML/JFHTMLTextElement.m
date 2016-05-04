//
//  JFHTMLTextElement.m
//  JFHTML
//
//  Created by 付书炯 on 16/5/3.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "JFHTMLTextElement.h"

@implementation JFHTMLTextElement

- (NSString *)text {
    if (!_text) {
        _text = @"";
    }
    return _text;
}

- (NSAttributedString *)attributedString {
    return [[NSAttributedString alloc] initWithString:self.text
                                           attributes:[self attributesForAttributedStringRepresentation]];
}

@end
