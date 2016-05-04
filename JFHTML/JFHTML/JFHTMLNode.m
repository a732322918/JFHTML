//
//  JFHTMLNode.m
//  JFHTML
//
//  Created by 付书炯 on 16/4/29.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "JFHTMLNode.h"

#define NodeLock() dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER)
#define NodeUnlock() dispatch_semaphore_signal(_lock)

@interface JFHTMLNode () {
    NSMutableArray *_childNodes;
    dispatch_semaphore_t _lock;
}

@end
@implementation JFHTMLNode

- (instancetype)initWithName:(NSString *)name attributes:(NSDictionary *)attributes {
    if (self = [super init]) {
        _name = name;
        self.attributes = attributes;
        _lock = dispatch_semaphore_create(1);
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _lock = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)addChildNode:(JFHTMLNode *)childNode {
    NodeLock();
    if (!_childNodes) {
        _childNodes = [[NSMutableArray alloc] init];
    }
    
    [_childNodes addObject:childNode];
    childNode.parentNode = self;
    NodeUnlock();
}

- (void)removeChildNode:(JFHTMLNode *)childNode {
    NodeLock();
    [_childNodes removeObject:childNode];
    NodeUnlock();
}

- (void)removeAllChildNodes {
    NodeLock();
    [_childNodes removeAllObjects];
    NodeUnlock();
}

@end
