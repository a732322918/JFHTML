//
//  DMHTMLImageView.m
//  DamaiIphone
//
//  Created by fushujiong on 2017/7/6.
//  Copyright © 2017年 damai. All rights reserved.
//

#import "DMHTMLImageView.h"
#import "UIImageView+WebCache.h"

@implementation DMHTMLImageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)didMoveToWindow {
    if ([self window]) {
//        [_imageView sd_setImageWithURL:[NSURL URLWithString:_src]];
    }
}

@end
