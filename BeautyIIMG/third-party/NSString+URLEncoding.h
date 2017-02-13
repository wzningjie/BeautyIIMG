//
//  NSString+URLEncoding.h
//  MOP
//
//  Created by admin on 13-11-21.
//  Copyright (c) 2013年 NewLand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
- (NSString *)encodedURLString;
- (NSString *)encodedURLParameterString;
- (NSString *)decodedURLString;
- (NSString *)removeQuotes;
@end
