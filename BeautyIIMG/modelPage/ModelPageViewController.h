//
//  ModelPageViewController.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 10/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelPageViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>




-(id)initWithResData:(NSNumber*)resourceId;

@end
