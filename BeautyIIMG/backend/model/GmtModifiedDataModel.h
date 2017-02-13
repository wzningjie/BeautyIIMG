//
//  GmtModifiedDataModel.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 12/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GmtModifiedDataModel : NSObject

@property (nonatomic, strong) NSNumber *date;
@property (nonatomic, strong) NSNumber *day;
@property (nonatomic, strong) NSNumber *hours;
@property (nonatomic, strong) NSNumber *minutes;
@property (nonatomic, strong) NSNumber *month;
@property (nonatomic, strong) NSNumber *seconds;
@property (nonatomic, strong) NSNumber *time;
@property (nonatomic, strong) NSString *timezoneOffset;
@property (nonatomic, strong) NSNumber *year;

@end
