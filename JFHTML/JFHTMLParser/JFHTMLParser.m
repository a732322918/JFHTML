//
//  JFHTMLParser.m
//  JFHTML
//
//  Created by 付书炯 on 16/4/29.
//  Copyright © 2016年 shujiong. All rights reserved.
//

#import "JFHTMLParser.h"
#import <libxml/HTMLparser.h>

@interface JFHTMLParser () {
    htmlSAXHandler _handler;
    htmlParserCtxtPtr _parserContext;
    
    NSData *_data;
    NSStringEncoding _encoding;
    
    NSMutableString *_charactersBuffer;
}

@property (readwrite, copy) NSError *parserError;

- (void)_bufferCharacters:(const xmlChar *)characters length:(int)length;
- (void)_flushBuffer;

@end
@implementation JFHTMLParser

- (void)dealloc {
    if (_parserContext) {
        htmlFreeParserCtxt(_parserContext);
    }
}

- (instancetype)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding {
    self = [super init];
    if (self) {
        _data = data;
        _encoding = encoding;
        
        if (!data) {
            NSLog(@"Warning: data is nil.");
        }
        
        xmlSAX2InitHtmlDefaultSAXHandler(&(_handler));
        
        self.delegate = nil;
    }
    return self;
}

- (BOOL)parse {
    xmlCharEncoding charEnc = XML_CHAR_ENCODING_NONE;
    CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
    
    if (cfenc != kCFStringEncodingInvalidId) {
        CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
        
        if (cfencstr) {
            NSString *NS_VALID_UNTIL_END_OF_SCOPE encstr = [NSString stringWithString:(__bridge NSString*)cfencstr];
            const char *enc = [encstr UTF8String];
            
            charEnc = xmlParseCharEncoding(enc);
        }
    }
    
    char *chunk = (char *)[_data bytes];
    
    _parserContext = htmlCreatePushParserCtxt(&(_handler),
                                              (__bridge void *)(self),
                                              chunk,
                                              (int)[_data length],
                                              NULL,
                                              charEnc);
    
    htmlCtxtUseOptions(_parserContext, HTML_PARSE_RECOVER | HTML_PARSE_NONET | HTML_PARSE_COMPACT | HTML_PARSE_NOBLANKS);
    
    int result = htmlParseDocument(_parserContext);
    
    return result == 0;
}

- (void)abortParsing {
    if (_parserContext) {
        xmlStopParser(_parserContext);
        _parserContext = NULL;
    }
}

- (void)setDelegate:(id<JFHTMLParserDelegate>)delegate {
    _delegate = delegate;
    
    if ([_delegate respondsToSelector:@selector(parserDidStartDocument:)]) {
        _handler.startDocument = ___startDocument;
    }
    else {
        _handler.startDocument = NULL;
    }
    
    if ([_delegate respondsToSelector:@selector(parserDidEndDocument:)]) {
        _handler.endDocument = ___endDocument;
    }
    else {
        _handler.endDocument = NULL;
    }
    
    if ([delegate respondsToSelector:@selector(parser:foundCharacters:)]) {
        _handler.characters = ___characters;
    }
    else {
        _handler.characters = NULL;
    }
    
    if ([_delegate respondsToSelector:@selector(parser:didStartElement:attributes:)]) {
        _handler.startElement = ___startElement;
    }
    else {
        if (_handler.characters) {
            _handler.startElement = ___startElement_no_delegate;
        }
        else {
            _handler.startElement = NULL;
        }
    }
    
    if ([_delegate respondsToSelector:@selector(parser:didEndElement:)]) {
        _handler.endElement = ___endElement;
    }
    else {
        if (_handler.characters) {
            _handler.endElement = ___endElement_no_delegate;
        }
        else {
            _handler.endElement = NULL;
        }
    }
    
    if ([_delegate respondsToSelector:@selector(parser:foundComment:)]) {
        _handler.comment = ___comment;
    }
    else {
        _handler.comment = NULL;
    }
    
    if ([_delegate respondsToSelector:@selector(parser:parseErrorOccurred:)]) {
        _handler.error = ___dterror;
    }
    else {
        _handler.error = NULL;
    }
    
    if ([_delegate respondsToSelector:@selector(parser:foundCDATA:)]) {
        _handler.cdataBlock = ___cdataBlock;
    }
    else {
        _handler.cdataBlock = NULL;
    }
}

- (void)_bufferCharacters:(const xmlChar *)characters length:(int)length {
    if (!_charactersBuffer) {
        _charactersBuffer = [[NSMutableString alloc] initWithBytes:characters length:length encoding:NSUTF8StringEncoding];
    }
    else {
        [_charactersBuffer appendString:[[NSString alloc] initWithBytes:characters length:length encoding:NSUTF8StringEncoding]];
    }
}

- (void)_flushBuffer {
    if (!_charactersBuffer.length) {
        return;
    }
    
    [self.delegate parser:self foundCharacters:_charactersBuffer];
    _charactersBuffer = nil;
}

void ___startDocument(void *ctx) {
    JFHTMLParser *parser = (__bridge JFHTMLParser *)ctx;
    [parser.delegate parserDidStartDocument:parser];
}

void ___endDocument(void *ctx) {
    JFHTMLParser *parser = (__bridge JFHTMLParser *)ctx;
    [parser.delegate parserDidEndDocument:parser];
}

void ___startElement(void *ctx,
                  const xmlChar *name,
                  const xmlChar **atts) {
    
    NSMutableDictionary *attributes = nil;
    if (atts) {
        NSString *key = nil;
        NSString *value = nil;
        
        attributes = [[NSMutableDictionary alloc] init];
        
        int i = 0;
        while (1) {
            char *att = (char *)atts[i++];
            if (!key) {
                if (!att) {
                    break;
                }
                
                key = [NSString stringWithUTF8String:att];
            }
            else {
                if (att) {
                    value = [NSString stringWithUTF8String:att];
                    [attributes setObject:value forKey:key];
                }
                else {
                    //                    value = key;
                    NSLog(@"Ignored: Only have key: %@, but no value", key);
                }
                
                value = nil;
                key = nil;
            }
        }
    }
    
    JFHTMLParser *parser = (__bridge JFHTMLParser *)ctx;
    NSString *elementName = [NSString stringWithUTF8String:(char *)name];
    [parser.delegate parser:parser didStartElement:elementName attributes:attributes];
}

void ___startElement_no_delegate(void *ctx,
                              const xmlChar *name,
                              const xmlChar **atts) {
    
    JFHTMLParser *parser = (__bridge JFHTMLParser *)ctx;
    [parser _flushBuffer];
}

void ___endElement(void *ctx,
                const xmlChar *name) {
    JFHTMLParser *parser = (__bridge JFHTMLParser *)ctx;
    [parser _flushBuffer];
    
    NSString *elementName = [NSString stringWithUTF8String:(char *)name];
    [parser.delegate parser:parser didEndElement:elementName];
}

void ___endElement_no_delegate(void *ctx,
                            const xmlChar *name) {
    
    JFHTMLParser *parser = (__bridge JFHTMLParser *)ctx;
    [parser _flushBuffer];
}

void ___characters(void *ctx,
                const xmlChar *ch,
                int len) {
    JFHTMLParser *parser = (__bridge JFHTMLParser *)ctx;
    [parser _bufferCharacters:ch length:len];
}

void ___comment(void *context,
             const xmlChar *chars) {
    JFHTMLParser *parser = (__bridge JFHTMLParser *)context;
    NSString *string = [NSString stringWithCString:(const char *)chars encoding:parser->_encoding];
    [parser.delegate parser:parser foundComment:string];
}

void ___dterror(void *context, const char *msg, ...) {
    JFHTMLParser *myself = (__bridge JFHTMLParser *)context;
    
    char string[256];
    va_list arg_ptr;
    
    va_start(arg_ptr, msg);
    vsnprintf(string, 256, msg, arg_ptr);
    va_end(arg_ptr);
    
    NSString *errorMsg = [NSString stringWithUTF8String:string];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMsg forKey:NSLocalizedDescriptionKey];
    myself.parserError = [NSError errorWithDomain:@"JFHTMLParser" code:1 userInfo:userInfo];
    
    [myself.delegate parser:myself parseErrorOccurred:myself.parserError];
}

void ___cdataBlock(void *context, const xmlChar *value, int len) {
    JFHTMLParser *parser = (__bridge JFHTMLParser *)context;
    
    NSData *data = [NSData dataWithBytes:(const void *)value length:len];
    
    [parser.delegate parser:parser foundCDATA:data];
}

@end
