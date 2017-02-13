//
//  NSDictionary+json.m
//  COMP
//
//  Created by 杨朋亮 on 8/7/15.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "NSDictionary+json.h"

@implementation NSDictionary (json)

-(NSString*)toJson{

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:&error];

    if (!jsonData) {
        NSLog(@"JSON error: %@", error);
    } else {
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        return JSONString;
    }
   return @"";
}

-(id)initWithJson:(NSString*)json{

    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error = nil;
    NSDictionary *myDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];

    if(!myDictionary) {
        NSLog(@"%@",error);
    }
    else {
        //Do Something
        NSLog(@"%@", myDictionary);
        return myDictionary;
    }
    return nil;
}

@end
