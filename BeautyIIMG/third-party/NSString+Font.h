//
//  NSString+Font.h
//  COMP
//
//  Created by 杨朋亮 on 28/7/15.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(Font) 


-(CGSize)widthWithFont:(CGFloat)size;
-(CGSize)widthWithFont:(CGFloat)size andMaxWidth:(CGFloat)rectWidth;
-(CGRect)rectWithFont:(CGFloat)size andMaxWidth:(CGFloat)rectWidth;
-(CGFloat)heightWithFont:(CGFloat)size andMaxWidth:(CGFloat)rectWidth;

@end
