//
//  ModelPageHeaderView.h
//  BeautyIIMG
//
//  Created by 杨朋亮 on 10/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelPageHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;

+(id)fromXib;


@end
