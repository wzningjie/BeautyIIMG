//
//  UIView+UIView_Animation.m
//  MOP
//
//  Created by SoftMI on 13-11-11.
//  Copyright (c) 2013年 NewLand. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (UIView_Animation)

- (void) animateWithRect:(CGRect) rect {
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = rect;
                     }
                     completion:^(BOOL finished){
                     }];
}

@end
