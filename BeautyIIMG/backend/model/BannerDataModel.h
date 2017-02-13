//
//  BannerDataModel.h
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

@interface BannerDataModel : NSObject

 @property (nonatomic ,strong) NSNumber *classesId;
 @property (nonatomic ,strong) NSString *classesName;
 @property (nonatomic ,strong) NSNumber *id;
 @property (nonatomic ,strong) NSNumber *isCheck;
 @property (nonatomic, strong) NSString *name;
 @property (nonatomic, strong) NSString *nickName;
 @property (nonatomic, strong) NSString *note;
 @property (nonatomic, strong) NSString *picAddress;
 @property (nonatomic, strong) NSArray  *picture;
 @property (nonatomic ,strong) NSNumber *resourceId;
 @property (nonatomic ,strong) NSNumber *sort;
 @property (nonatomic ,strong) NSNumber *type;
 


@end
