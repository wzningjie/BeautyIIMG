//
//  NSString+Font.m
//  COMP
//
//  Created by 杨朋亮 on 28/7/15.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "NSString+Font.h"

@implementation NSString(Font)

-(CGSize)widthWithFont:(CGFloat)size{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(320, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return rect.size;
    
}

-(CGSize)widthWithFont:(CGFloat)size andMaxWidth:(CGFloat)rectWidth{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(rectWidth, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}

-(CGRect)rectWithFont:(CGFloat)size andMaxWidth:(CGFloat)rectWidth{
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};

    CGRect rect = [self boundingRectWithSize:CGSizeMake(rectWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    return rect;
    
}

-(CGFloat)heightWithFont:(CGFloat)size andMaxWidth:(CGFloat)rectWidth{
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(rectWidth, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return rect.size.height;
    
}

@end
