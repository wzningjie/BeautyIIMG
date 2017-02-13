//
//  FixedDataModel.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 12/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

/**
 @property (nonatomic, strong) NSNumber *
 @property (nonatomic, strong) NSString *
 @property (nonatomic, strong) NSArray *
 @property (nonatomic, strong) NSDictionary *
 */

#import <Foundation/Foundation.h>
#import "GmtModifiedDataModel.h"
#import "GmtCreatedDataModel.h"

@interface FixedDataModel : NSObject

 @property (nonatomic, strong) NSNumber *bannerId;
 @property (nonatomic, strong) NSString *desc;
 @property (nonatomic, strong) NSNumber *down;
 @property (nonatomic,strong) GmtCreatedDataModel *gmtCreated;
 @property (nonatomic,strong) GmtModifiedDataModel *gmtModified;
 @property (nonatomic, strong) NSNumber *ID;
 @property (nonatomic, strong) NSNumber *isDel;
 @property (nonatomic, strong) NSString *picAddress;
 @property (nonatomic, strong) NSString *size;
 @property (nonatomic, strong) NSNumber *sort;
 @property (nonatomic, strong) NSString *url;
 @property (nonatomic, strong) NSNumber *userId;

@end
