//
//  IconDataModel.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 12/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GmtModifiedDataModel.h"
#import "GmtCreatedDataModel.h"

@interface IconDataModel : NSObject

@property (nonatomic, strong) NSNumber *appCategoryId;
@property (nonatomic, strong) NSNumber *classesId;
@property (nonatomic,strong) GmtCreatedDataModel *gmtCreated;
@property (nonatomic,strong) GmtModifiedDataModel *gmtModified;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *isCheck;
@property (nonatomic, strong) NSNumber *isDel;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picAddress;
@property (nonatomic, strong) NSNumber *sort;
@property (nonatomic, strong) NSNumber *typeTwo;


@end
