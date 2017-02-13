//
//  IconsPageViewController.m
//  BeautyIIMG
//
//  Created by 杨朋亮 on 12/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#define WL_XIB(string) ([[[NSBundle mainBundle] loadNibNamed:string owner:nil options:nil] lastObject])
#define WL_NIB(key) ([UINib nibWithNibName:key bundle:nil])

#import "IconsPageViewController.h"
#import "WaterFallFlowCollectionViewCell.h"
#import "WaterFallFlowCollectionReusableView.h"
#import "WaterFallFlowCollectionViewFlowLayout.h"
#import "UIImageView+WebCache.h"

#import "IconCollectionViewCell.h"

#import "ImagesPageViewController.h"
#import <MJRefresh/MJRefresh.h>

NSString* kWaterFallFlowCollectionViewCell = @"IconCollectionViewCell";

@interface IconsPageViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,strong) IconDataModel *iconData;
@property (nonatomic) int pageIndex;
@property (nonatomic, strong) MJRefreshAutoFooter *refreshFooter;

@end

@implementation IconsPageViewController

-(id)initWithIcon:(IconDataModel*)data{
    self = [super init];
    if (self) {
        self.iconData = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.iconData.name;
    
    self.itemArray = [NSMutableArray array];
    
    float viewWidth = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(viewWidth/2.0, viewWidth/2.0*1.5)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    self.waterFallFlowCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height) collectionViewLayout:flowLayout];
    
    
    UINib *cellNib = [UINib nibWithNibName:@"IconCollectionViewCell" bundle:nil];
    [self.waterFallFlowCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"IconCollectionViewCell"];
    
    [self.waterFallFlowCollectionView setBackgroundColor:[UIColor whiteColor]];
    
    self.waterFallFlowCollectionView.dataSource = self;
    self.waterFallFlowCollectionView.delegate = self;
    
    [self.view addSubview:self.waterFallFlowCollectionView];
    
    self.refreshFooter = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self refreshNextPage];
    }];
    
    [self.waterFallFlowCollectionView setMj_footer:self.refreshFooter];
    
    [self refresh];
}
/*
 POST /www/photo/getIcon.htm HTTP/1.1
 Content-Length: 43
 Content-Type: application/x-www-form-urlencoded
 Host: data.shangxian.net
 Connection: Keep-Alive
 
 pageSize=10&currentPage=1&appCategoryId=113
 */
-(void)refresh{
    
    NSString *path = [[NSString alloc] initWithFormat:@"%@%@",[Config instance].rootUrl,@"/www/photo/getIcon.htm"];
    [RequestEnd ajax:@{@"url":path,
                       @"parms":@{@"appVer":[NSNumber numberWithFloat:1.2],
                                  @"type":@"6,7,8,9,10,11",
                                  @"appId":[NSNumber numberWithInt:2],
                                   @"currentPage":[NSNumber numberWithInt:self.pageIndex],
                                   @"appCategoryId":self.iconData.appCategoryId,
                                  @"pageSize":[NSNumber numberWithInt:10]
                                  }
                       } succ:^(id responseData) {
                           
                           [self.waterFallFlowCollectionView.mj_footer endRefreshing];
                           
                           NSDictionary *dataDic = [[NSDictionary alloc] initWithJson:responseData];
                           NSNumber *result = dataDic[@"resultCode"];
                           if([result intValue] == 0){
                               NSDictionary *pages = dataDic[@"page"];
                               NSArray *records = pages[@"records"];
                               for (NSDictionary *dic in records) {
                                   CategoryDataModel *catg = [CategoryDataModel mj_objectWithKeyValues:dic];
                                   [self.itemArray addObject:catg];
                               }
                           }
                          
                           [self loadUI];
                           
                           
                       } fail:^(id responseData) {
                           
                           NSLog(@"刷新firstPage失败");
                       }];
}

- (void)refreshNextPage{
    self.pageIndex++;
    [self refresh];
}

- (void)loadUI{
    [self.waterFallFlowCollectionView reloadData];
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IconCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWaterFallFlowCollectionViewCell forIndexPath:indexPath];
    
    CategoryDataModel *cdm = [self.itemArray objectAtIndex:indexPath.row];
    NSString *path = [NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,cdm.firstPicAddress];
    [cell.imageView sd_setImageWithURL:[[NSURL alloc] initWithString:path]];
    [cell.titleLabel setHidden:YES];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryDataModel *cdm = [self.itemArray objectAtIndex:indexPath.row];
    ImagesPageViewController *vtr = [[ImagesPageViewController alloc] initWithResData:cdm.categoryId];
    vtr.ctgData = cdm;
    vtr.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vtr animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
