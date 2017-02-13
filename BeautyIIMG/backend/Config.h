//
//  Config.h
//  COMP
//
//  Created by 杨朋亮 on 23/6/15.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Config: NSObject{

}

@property (strong, nonatomic) NSString *rootUrl;


+ (Config*)instance;



@end
