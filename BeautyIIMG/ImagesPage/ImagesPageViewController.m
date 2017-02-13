//
//  ImagesPageViewController.m
//  BeautyIIMG
//
//  Created by 杨朋亮 on 12/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import "ImagesPageViewController.h"

#import "Config.h"
#import "RequestEnd.h"
#import "NSDictionary+json.h"


#import "MJExtension.h"

@interface ImagesPageViewController ()


@property (nonatomic,strong) NSNumber *resorceId;
@property (nonatomic,strong) NSMutableArray *imagesArray;

@end

@implementation ImagesPageViewController

-(id)initWithResData:(NSNumber*)resourceId{
    self = [super init];
    if (self) {
        self.resorceId = resourceId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    self.imagesArray = [NSMutableArray array];

    if(self.ctgData){
        self.title = self.ctgData.name;
    }else if(self.bannerData){
        self.title = self.bannerData.name;
    }else if(self.picData){
        self.title = self.picData.name;
    }

    
    
    // Set options
    self.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    self.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    self.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    self.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    self.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    self.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    self.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    self.autoPlayOnAppear = NO; // Auto-play first video
    
    // Customise selection images to change colours if required
    self.customImageSelectedIconName = @"ImageSelected.png";
    self.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    
    if (self.ctgData) {

        NSArray *pics = [self.ctgData.picAddress componentsSeparatedByString:@","];
        for (NSString *str in pics) {
            [self.imagesArray addObject:[NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,str]];
        }
        [self reloadData];
    }else if(self.picData){
        NSArray *pics = [self.picData.picAddress componentsSeparatedByString:@","];
        for (NSString *str in pics) {
            [self.imagesArray addObject:[NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,str]];
        }
        [self reloadData];
    }else{
        [self refresh];
    }
    
}

/*
 POST /www/photo/getPictures.htm HTTP/1.1
 Content-Length: 14
 Content-Type: application/x-www-form-urlencoded
 Host: data.shangxian.net
 Connection: Keep-Alive
 
 resourceId=171
*/

-(void)refresh{
    NSString *path = [[NSString alloc] initWithFormat:@"%@%@",[Config instance].rootUrl,@"/www/photo/getPictures.htm"];
    [RequestEnd ajax:@{@"url":path,
                       @"parms":@{@"appVer":[NSNumber numberWithFloat:1.2],
                                  @"type":@"6,7,8,9,10,11",
                                  @"appId":[NSNumber numberWithInt:2],
                                  @"resourceId":self.resorceId
                                  }
                       } succ:^(id responseData) {
                           NSDictionary *dataDic = [[NSDictionary alloc] initWithJson:responseData];
                           NSLog(@"%@",responseData);
                           NSNumber *result = dataDic[@"resultCode"];
                           if([result intValue] == 0){
                               PicturesDataModel *picture = [PicturesDataModel mj_objectWithKeyValues:dataDic[@"pictures"]];
                               NSArray *pics = [picture.picAddress componentsSeparatedByString:@","];
                               for (NSString *str in pics) {
                                   [self.imagesArray addObject:[NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,str]];
                               }
                           }
                           
                           [self reloadData];
                           
                       } fail:^(id responseData) {
                           
                           NSLog(@"刷新firstPage失败");
                       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - MWPhotoBrowserDelegate
- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index{
    if(self.ctgData){
        return self.ctgData.name;
    }else if(self.bannerData){
        return self.bannerData.name;
    }
    return @"";
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return [self.imagesArray count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    NSURL *url = [[NSURL alloc] initWithString:[self.imagesArray objectAtIndex:index]];
    MWPhoto *photo = [[MWPhoto alloc] initWithURL:url];
    return photo;
}
@end
