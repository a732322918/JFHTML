//
//  JFHTMLNode.h
//  JFHTML
//
//  Created by 付书炯 on 16/4/29.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface JFHTMLNode : NSObject

- (instancetype)initWithName:(NSString *)name attributes:(NSDictionary *)attributes;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDictionary *attributes;
@property (nonatomic, weak) JFHTMLNode *parentNode;
@property (nonatomic, readonly) NSArray *childNodes;

- (void)addChildNode:(JFHTMLNode *)childNode;
- (void)removeChildNode:(JFHTMLNode *)childNode;
- (void)removeAllChildNodes;

@end
