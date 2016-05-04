//
//  JFHTMLTests.m
//  JFHTMLTests
//
//  Created by 付书炯 on 16/4/29.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JFHTMLElement.h"
#import "JFHTMLTextElement.h"

@interface JFHTMLTests : XCTestCase

@end

@implementation JFHTMLTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    JFHTMLElement *p = [JFHTMLElement elementWithName:@"p" attributes:@{@"font-size": @"14px",
                                                                        @"color": @"#333333"}];
    XCTAssert(p);
    NSLog(@"%@", p.attributes);
    
    JFHTMLElement *p2 = [JFHTMLElement elementWithName:@"p2" attributes:@{@"font-size": @"12px"}];
    [p2 inheritAttributesFromElement:p];
    XCTAssert(p2.attributes[@"color"]);
}

- (void)testGenerateAttributedString {
    JFHTMLElement *p = [JFHTMLElement elementWithName:@"p" attributes:@{@"font-size": @"14px",
                                                                        @"color": @"#333333"}];
    XCTAssert(p.attributedString.length == 0);
    
    JFHTMLTextElement *text = [[JFHTMLTextElement alloc] init];
    text.text = @"Hello";
    
    [text inheritAttributesFromElement:p];
    
    [p addChildNode:text];
    
    NSLog(@"%@", p.attributedString);
    
}

- (void)testHtmlTag {
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
