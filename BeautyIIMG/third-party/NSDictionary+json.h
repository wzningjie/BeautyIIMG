//
//  NSDictionary+json.h
//  COMP
//
//  Created by 杨朋亮 on 8/7/15.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (json)

-(NSString*)toJson;
-(id)initWithJson:(NSString*)json;

@end
