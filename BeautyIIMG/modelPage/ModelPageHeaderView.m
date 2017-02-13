//
//  ModelPageHeaderView.m
//  BeautyIIMG
//
//  Created by 杨朋亮 on 10/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import "ModelPageHeaderView.h"

@implementation ModelPageHeaderView


+(id)fromXib{
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"ModelPageHeaderView" owner:self options:nil];
    id mainView = [subviewArray objectAtIndex:0];
    return mainView;
}

@end
