//
//  JFHTMLAttributedStringBuilder.h
//  JFHTML
//
//  Created by 付书炯 on 16/5/3.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFHTMLAttributedStringBuilder : NSObject

- (instancetype)initWithHTML:(NSData *)data;

- (NSAttributedString *)build;

@end
