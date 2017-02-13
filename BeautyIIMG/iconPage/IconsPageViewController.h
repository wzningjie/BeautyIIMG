//
//  IconsPageViewController.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 12/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Model.h"
#import "Config.h"
#import "RequestEnd.h"
#import "NSDictionary+json.h"

@interface IconsPageViewController : UIViewController

@property(nonatomic,strong) UICollectionView* waterFallFlowCollectionView;

- (id)initWithIcon:(IconDataModel*)data;

@end
