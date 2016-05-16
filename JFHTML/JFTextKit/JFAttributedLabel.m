//
//  JFAttributedLabel.m
//  JFHTML
//
//  Created by 付书炯 on 16/5/6.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "JFAttributedLabel.h"
#import "JFLayoutManager.h"
#import "JFTextAttachment.h"
#import <CoreText/CoreText.h>

@implementation JFAttributedLabel {
    JFLayoutManager *_layoutManager;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

//    [super drawRect:rect];
    
    [self.backgroundColor setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
    
    if (!self.attributedText.length) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, rect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    CFArrayRef lines = CTFrameGetLines(textFrame);
    CFIndex lineCount = CFArrayGetCount(lines);
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), lineOrigins);
    
    NSInteger numberOfLines = lineCount;
    for (int i = 0; i < numberOfLines; i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        CFIndex runCount = CFArrayGetCount(runs);
        CGPoint lineOrigin = lineOrigins[i];
        
        CGFloat lineAscent;
        CGFloat lineDescent;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, NULL);
        
        CGFloat lineHeight = lineAscent + lineDescent;
        CGFloat lineBottomY = lineOrigin.y - lineDescent;
        
        for (int j = 0; j < runCount; ++j) {
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            
            
            CTRunDelegateRef runDelegate = (__bridge CTRunDelegateRef)(runAttributes[(NSString *)kCTRunDelegateAttributeName]);
            if (!runDelegate) {
                continue;
            }
//            
//            JFTextAttachment *attachment = CTRunDelegateGetRefCon(runDelegate);
//            CGFloat ascent = 0.0f;
//            CGFloat descent = 0.0f;
//            CGFloat width = (CGFloat)CTRunGetTypographicBounds(run,
//                                                               CFRangeMake(0, 0),
//                                                               &ascent,
//                                                               &descent,
//                                                               NULL);
//            
//            CGFloat height = attachment.attachmentSize.height;
//            
//            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, nil);
//            
//            CGFloat imageBoxOriginY = lineBottomY;
//            
//            imageBoxOriginY = lineBottomY + (lineHeight - height);
//            
//            CGFloat originX = lineOrigin.x + xOffset;
//            if (attachment.attachmentType == JFTextAttachmentTypeAttachmentInLine && attachment.horizonalAlignment == JFTextAttachmentHorizonalAlignmentCenter) {
//                originX = CGRectGetWidth(rect) - attachment.attachmentSize.width;
//                originX /= 2.0;
//            }
//            
//            if (width > CGRectGetWidth(rect)) {
//                width = CGRectGetWidth(rect);
//            }
//            
//            if (height > CGRectGetHeight(rect)) {
//                height = CGRectGetHeight(rect);
//            }
//            
//            CGRect rect = CGRectMake(originX, imageBoxOriginY, width, height);
//            
//            CGRect attatchmentRect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsZero);
//            
//            //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSData *imageData = [NSData dataWithContentsOfURL:attachment.URLOfImage];
//            UIImage *image = [UIImage imageWithData:imageData];
//            //                dispatch_sync(dispatch_get_main_queue(), ^{
//            
//            CGContextDrawImage(context, attatchmentRect, image.CGImage);
        }
    }
    
    CTFrameDraw(textFrame, context);
    CFRelease(textFrame);
}

@end
