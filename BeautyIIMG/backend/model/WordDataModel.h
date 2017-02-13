//
//  WordDataModel.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 12/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordDataModel : NSObject

@property (nonatomic, strong) NSDictionary *gmtCreated;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *isDel;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *parentId;
@property (nonatomic, strong) NSNumber *sort;
@property (nonatomic, strong) NSNumber *type;

@end
