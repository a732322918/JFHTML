//
//  JFHTMLBreakElement.m
//  JFHTML
//
//  Created by 付书炯 on 16/5/4.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "JFHTMLBreakElement.h"

@implementation JFHTMLBreakElement

- (NSAttributedString *)attributedString {
    NSDictionary *attributes = [self attributesForAttributedStringRepresentation];
    return [[NSAttributedString alloc] initWithString:@"\u2028" attributes:attributes];
}

@end
