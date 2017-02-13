//
//  ModelPageViewController.m
//  BeautyIIMG
//
//  Created by 杨朋亮 on 10/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import "ModelPageViewController.h"
#import "Model.h"
#import "Config.h"
#import "RequestEnd.h"
#import "NSDictionary+json.h"
#import "MJExtension.h"

#import "ModelPageHeaderView.h"
#import "ImagesPageViewController.h"

#import "UIImageView+WebCache.h"
#import "IconCollectionViewCell.h"


#define KCollectionViewHeight 180

@interface ModelPageViewController ()

@property (nonatomic) CGFloat viewTotalHeight;
@property (nonatomic,strong) NSNumber *resourceId;
@property (nonatomic ,strong) NSMutableArray *pictureAlumArray;
@property (nonatomic ,strong) ModelDetailDataModel *modelInfo;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) ModelPageHeaderView *headSectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;


@end

@implementation ModelPageViewController

-(id)initWithResData:(NSNumber*)resourceId{
    self = [super init];
    if (self) {
        self.resourceId = resourceId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pictureAlumArray = [NSMutableArray array];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self refresh];
}

/*
 POST /www/photo/getModel.htm HTTP/1.1
 Content-Length: 13
 Content-Type: application/x-www-form-urlencoded
 Host: data.shangxian.net
 Connection: Keep-Alive
 
 resourceId=75
 */

-(void)refresh{
    NSString *path = [[NSString alloc] initWithFormat:@"%@%@",[Config instance].rootUrl,@"/www/photo/getModel.htm"];
    [RequestEnd ajax:@{@"url":path,
                       @"parms":@{@"appVer":[NSNumber numberWithFloat:1.2],
                                  @"type":@"6,7,8,9,10,11",
                                  @"appId":[NSNumber numberWithInt:2],
                                  @"resourceId":self.resourceId
                                  }
                       } succ:^(id responseData) {
                           NSDictionary *dataDic = [[NSDictionary alloc] initWithJson:responseData];
                           NSLog(@"%@",responseData);
                           NSNumber *result = dataDic[@"resultCode"];
                           if([result intValue] == 0){
                               NSDictionary *model = dataDic[@"model"];
                               self.modelInfo = [ModelDetailDataModel mj_objectWithKeyValues:model];
                               self.modelInfo.descriptio = dataDic[@"model"][@"description"];
                               
                               NSArray *pics = dataDic[@"model_picAddress"];
                               for (NSDictionary *dic in pics) {
                                   PicturesDataModel *pdm = [PicturesDataModel mj_objectWithKeyValues:dic];
                                   [self.pictureAlumArray addObject:pdm];
                               }
                           }
                           [self loadUI];
                           
                           
                       } fail:^(id responseData) {
                           
                           NSLog(@"刷新firstPage失败");
                       }];
}

- (void)loadUI{
    
    self.title = self.modelInfo.name;
    
    [self.contentView setBackgroundColor:[UIColor lightGrayColor]];
    
    self.viewTotalHeight = 0.0f;
    
    self.headSectionView = [ModelPageHeaderView fromXib];
    
    NSString *path = [NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,self.modelInfo.picAddress];
    [self.headSectionView.headView sd_setImageWithURL:[[NSURL alloc] initWithString:path]];
    [self.headSectionView.headView.layer setMasksToBounds:YES];
    [self.headSectionView.headView.layer setCornerRadius:self.headSectionView.headView.bounds.size.width/2];
    
    [self.headSectionView.nameLabel setText:self.modelInfo.name];
    [self.headSectionView.subLabel setText:self.modelInfo.role];
    NSString *infor = [NSString stringWithFormat:@"身高：%@ 年龄：%d；特征：%@  三围：%@ 简介：%@",
                       self.modelInfo.height,
                       [self.modelInfo.age intValue],
                       self.modelInfo.characteristics,
                       self.modelInfo.measurements,
                       self.modelInfo.descriptio
                       ];
    [self.headSectionView.inforLabel setText:infor];
    
    [self.contentView addSubview:self.headSectionView];
    self.viewTotalHeight += self.headSectionView.bounds.size.height;
    
    self.viewTotalHeight += 10;
    
    float viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat realHeight = ([self.pictureAlumArray count] / 2) * viewWidth/2.0*1.5;
    
    UICollectionViewFlowLayout *hotFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [hotFlowLayout setItemSize:CGSizeMake(viewWidth/2.0, viewWidth/2.0*1.5)];
    [hotFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    hotFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    hotFlowLayout.minimumInteritemSpacing = 0;
    hotFlowLayout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,self.viewTotalHeight,self.view.bounds.size.width,realHeight > KCollectionViewHeight?realHeight:KCollectionViewHeight) collectionViewLayout:hotFlowLayout];
    
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib *cellNib = [UINib nibWithNibName:@"IconCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"IconCollectionViewCell"];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.collectionView setScrollEnabled:NO];
    
    [self.contentView addSubview:self.collectionView];
    
    self.viewTotalHeight += self.collectionView.bounds.size.height;
    
    [self.contentView setContentSize:CGSizeMake(0, self.viewTotalHeight + 20)];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PicturesDataModel *data = [self.pictureAlumArray objectAtIndex:indexPath.row];
    ImagesPageViewController *vtr = [[ImagesPageViewController alloc] initWithResData:nil];
    vtr.picData = data;
    
    vtr.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vtr animated:YES];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.pictureAlumArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IconCollectionViewCell *cell = (IconCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"IconCollectionViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"IconCollectionViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    
    PicturesDataModel  *pdm = [self.pictureAlumArray objectAtIndex:indexPath.row];
    
    [cell.titleLabel setHidden:YES];
    
    NSArray *pics = [pdm.picAddress componentsSeparatedByString:@","];
    NSString *path = [NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,[pics firstObject]];
    [cell.imageView sd_setImageWithURL:[[NSURL alloc] initWithString:path]];
    
    return cell;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
