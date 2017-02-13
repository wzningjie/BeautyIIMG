//
//  RequestEnd.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 11/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ktypeString @"6,7,8,9,10,11"
#define kRootUrl @"data.shangxian.net"
#define kIndexPath @"/www/photo/index.htm"

typedef void (^MIResponseCallback)(id responseData);

@interface RequestEnd : NSObject

+ (void)ajax:(id)data succ:(MIResponseCallback)succCallback fail:(MIResponseCallback) failCallback;

@end
