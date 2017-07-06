//
//  NSAttributedString+DMHTML.h
//  DamaiIphone
//
//  Created by fushujiong on 2017/7/6.
//  Copyright © 2017年 damai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText.h>
#import "DMHTMLImageView.h"

@interface NSAttributedString (DMHTML)

/**
 *  Generates an attributed string from HTML.
 *
 *  @param htmlString HTML String
 *
 *  @return Attributed string
 */
+ (NSAttributedString *)dm_attributedStringFromHTML:(NSString *)htmlString;

/**
 *  Generates an attributed string from HTML.
 *
 *  @param htmlString HTML String
 *  @param boldFont   Font to use for <b> and <strong> tags
 *  @param italicFont Font to use for <i> and <em> tags
 *
 *  @return Attributed string
 */
+ (NSAttributedString *)dm_attributedStringFromHTML:(NSString *)htmlString boldFont:(UIFont *)boldFont italicFont:(UIFont *)italicFont;

/**
 *  Generates an attributed string from HTML.
 *
 *  @param htmlString HTML String
 *  @param normalFont Font to use for general text
 *  @param boldFont   Font to use for <b> and <strong> tags
 *  @param italicFont Font to use for <i> and <em> tags
 *
 *  @return Attributed string
 */
+ (NSAttributedString *)dm_attributedStringFromHTML:(NSString *)htmlString normalFont:(UIFont *)normalFont boldFont:(UIFont *)boldFont italicFont:(UIFont *)italicFont;

/**
 *  Generates an attributed string from HTML.
 *
 *  @param htmlString   HTML String
 *  @param normalFont   Font to use for general text
 *  @param boldFont     Font to use for <b> and <strong> tags
 *  @param italicFont   Font to use for <i> and <em> tags
 *  @param imageMap     Images to use in place of standard bundle images.
 *
 *  @return Attributed string
 */
+ (NSAttributedString *)dm_attributedStringFromHTML:(NSString *)htmlString normalFont:(UIFont *)normalFont boldFont:(UIFont *)boldFont italicFont:(UIFont *)italicFont imageMap:(NSDictionary<NSString *, UIImage *> *)imageMap;

@end
