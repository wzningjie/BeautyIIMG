//
//  ImagesPageViewController.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 12/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "Model.h"


@interface ImagesPageViewController : MWPhotoBrowser <MWPhotoBrowserDelegate>

@property (nonatomic,strong) BannerDataModel *bannerData;
@property (nonatomic,strong) CategoryDataModel *ctgData;
@property (nonatomic,strong) HotDataModel *hotData;
@property (nonatomic ,strong) PicturesDataModel *picData;

-(id)initWithResData:(NSNumber*)resourceId;


@end
