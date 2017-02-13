//
//  PicturesDataModel.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 12/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicturesDataModel : NSObject

@property (nonatomic, strong) NSNumber *categoryId;
@property (nonatomic, strong) NSNumber *collectionCount;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSDictionary *gmtCreated;//:{"date":28,"day":1,"hours":9,"minutes":59,"month":10,"seconds":26,"time":1480298366000,"timezoneOffset":-480,"year":116},
@property (nonatomic, strong) NSDictionary *gmtModified;//:{"date":12,"day":0,"hours":17,"minutes":39,"month":1,"seconds":29,"time":1486892369000,"timezoneOffset":-480,"year":117},
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *isDel;
@property (nonatomic, strong) NSString *labelIds;
@property (nonatomic, strong) NSString *modelId;
@property (nonatomic, strong) NSString *name;//".....................pose......",
@property (nonatomic, strong) NSString *picAddress;//"/resources/2016/11/28/73118496-1be8-462e-b542-2f49f857e49c.jpg,/resources/2016/11/28/d5f614f9-7401-4061-acc8-2448e9390472.jpg,/resources/2016/11/28/a126a52d-732f-4e2d-825c-f9f8f32de37d.jpg,/resources/2016/11/28/9cacaf4a-6d2f-4d9c-b8c8-665c37d8e544.jpg,/resources/2016/11/28/b4db11d6-acd2-4f13-b78a-4cb40cd2f820.jpg,/resources/2016/11/28/71465440-d924-4268-982d-c85077e7f331.jpg,/resources/2016/11/28/02c30311-e4ee-4194-b843-8e86c4f83091.jpg,/resources/2016/11/28/8ce16eb7-1868-4775-b344-f86d29a5636f.jpg,/resources/2016/11/28/aa80bcf1-98de-4a55-bca6-bfca569157bf.jpg,/resources/2016/11/28/a8fdf9d4-b383-4ed0-a505-efc2a5dd6080.jpg,/resources/2016/11/28/a7ac785e-359d-46e5-a336-02a3f7f9360f.jpg,/resources/2016/11/28/a8e01257-bdcf-43f5-96f0-e1226925a3b4.jpg,/resources/2016/11/28/cc0b74fe-849c-491c-bb26-ecbb37adbafc.jpg,/resources/2016/11/28/e3a0aa87-1598-4205-a0a5-2f63d66c6e56.jpg,/resources/2016/11/28/1156f877-b516-4615-88d0-623d9323f67d.jpg,/resources/2016/11/28/d2acad9f-5274-42b5-9215-1564728195a0.jpg,/resources/2016/11/28/13176741-3f48-4d69-a718-58ac2473200f.jpg,/resources/2016/11/28/34a3d236-0c0a-44d3-8ae5-fa83e72e42fb.jpg,/resources/2016/11/28/668fc3df-f0b5-4cd4-892b-2f1e3e16d19f.jpg,/resources/2016/11/28/f8d5bcb2-7ece-4147-a0a1-33ee42d6c478.jpg,/resources/2016/11/28/260308f3-8f1c-4f47-9d78-560ce6e7bf93.jpg,/resources/2016/11/28/2eb33d10-8f27-471d-b295-9c54d7b3835a.jpg,/resources/2016/11/28/a1f711a9-3299-4951-9dd9-f1eb4a2f23b9.jpg,/resources/2016/11/28/635a8fd6-bb64-44ca-a2ae-05e7a6c1d88f.jpg,/resources/2016/11/28/23ac17bc-2360-4150-87e6-65a583f8a003.jpg,/resources/2016/11/28/8df6044b-0248-425b-a244-54920a707c43.jpg",
@property (nonatomic, strong) NSNumber *shareCount;
@property (nonatomic, strong) NSNumber *thumbUpCount;

@end
