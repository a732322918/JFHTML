//
//  JFHTMLElement.h
//  JFHTML
//
//  Created by 付书炯 on 16/4/29.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "JFHTMLNode.h"

@interface JFHTMLElement : JFHTMLNode

+ (instancetype)elementWithName:(NSString *)name attributes:(NSDictionary *)attributes;

@property (nonatomic, assign) NSUInteger headerLevel;

@property (nonatomic, assign) CGFloat fontSize;

- (NSDictionary *)attributesForAttributedStringRepresentation;

- (void)inheritAttributesFromElement:(JFHTMLElement *)element;

- (void)applyStyleDictionary:(NSDictionary *)styles;

- (NSAttributedString *)attributedString;

@end
