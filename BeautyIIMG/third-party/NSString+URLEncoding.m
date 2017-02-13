//
//  NSString+URLEncoding.m
//  MOP
//
//  Created by admin on 13-11-21.
//  Copyright (c) 2013年 NewLand. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)
- (NSString *)encodedURLString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,                   // characters to leave unescaped (NULL = all escaped sequences are replaced)
                                                                           CFSTR("?=&+"),          // legal URL characters to be escaped (NULL = all legal characters are replaced)
                                                                           kCFStringEncodingUTF8)); // encoding
    return result;
}

- (NSString *)encodedURLParameterString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR(":/=,!$&'()*+;[]@#?"),
                                                                           kCFStringEncodingUTF8));
    return result;
}

- (NSString *)decodedURLString {
    NSString *result = (NSString*)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (CFStringRef)self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8));
    
    return result;
    
}

-(NSString *)removeQuotes
{
    NSUInteger length = [self length];
    NSString *ret = self;
    if ([self characterAtIndex:0] == '"') {
        ret = [ret substringFromIndex:1];
    }
    if ([self characterAtIndex:length - 1] == '"') {
        ret = [ret substringToIndex:length - 2];
    }
    
    return ret;
}
@end
