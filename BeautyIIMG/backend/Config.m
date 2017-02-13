//
//  Config.m
//  COMP
//
//  Created by 杨朋亮 on 23/6/15.
//  Copyright (c) 2015年 admin. All rights reserved.
//


#import "Config.h"

@interface Config()


@end

@implementation Config

-(id)init{
    self = [super init];
    if (self) {
        self.rootUrl = @"http://data.shangxian.net";
    }
    return self;
}

+ (Config*)instance{
    static Config*sharedConfig = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedConfig = [[self alloc] init];
    });
    return sharedConfig;
}


@end
