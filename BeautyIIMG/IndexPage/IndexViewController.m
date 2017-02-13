//
//  IndexViewController.m
//  BeautyIIMG
//
//  Created by 杨朋亮 on 10/2/17.
//  Copyright © 2017年 daibou007. All rights reserved.
//

#import "IndexViewController.h"

#import "Config.h"
#import "RequestEnd.h"
#import "NSDictionary+json.h"
#import "Model.h"


#import "ImagesPageViewController.h"
#import "MineCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "IconsPageViewController.h"

#import "IconCollectionViewCell.h"
#import "ModelCotionViewCell.h"

#import "ModelPageViewController.h"

#define KCollectionViewHeight 180

@interface IndexViewController ()<BHInfiniteScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong , nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) BHInfiniteScrollView* infinitePageView;

@property (nonatomic ,strong) UICollectionView *secondCollectionView;
@property (nonatomic ,strong) UICollectionView *hotCollectionView;
@property (nonatomic ,strong) UICollectionView *recommendCollectionView;

@property (nonatomic,strong) NSMutableArray *iconsArray;
@property (nonatomic,strong) NSMutableArray *modelsArray;
@property (nonatomic,strong) NSMutableArray *hotsArray;
@property (nonatomic,strong) NSMutableArray *bannerArray;
@property (nonatomic,strong) NSMutableArray *fixedArray;
@property (nonatomic,strong) NSMutableArray *wordsArray;

@property (nonatomic) CGFloat viewTotalHeight;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.scrollView];
    
    
    self.iconsArray = [[NSMutableArray alloc] init];
    self.modelsArray = [[NSMutableArray alloc] init];
    self.hotsArray = [[NSMutableArray alloc] init];
    self.fixedArray = [[NSMutableArray alloc] init];
    self.wordsArray = [[NSMutableArray alloc] init];
    self.bannerArray =  [[NSMutableArray alloc] init];
    
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/*
 POST /www/photo/index.htm HTTP/1.1
 Content-Length: 47
 Content-Type: application/x-www-form-urlencoded
 Host: data.shangxian.net
 Connection: Keep-Alive
 
 appVer=1.2&type=6%2C7%2C8%2C9%2C10%2C11&appId=2
 */
- (void)refresh{
    NSString *path = [[NSString alloc] initWithFormat:@"%@%@",[Config instance].rootUrl,@"/www/photo/index.htm"];
    [RequestEnd ajax:@{@"url":path,
                       @"parms":@{@"appVer":[NSNumber numberWithFloat:1.2],
                                  @"type":@"6,7,8,9,10,11",
                                  @"appId":[NSNumber numberWithInt:2]
                                  }
                       } succ:^(id responseData) {
                           NSDictionary *dataDic = [[NSDictionary alloc] initWithJson:responseData];
                           
                           NSArray *iconsData = dataDic[@"icon"];
                           for (NSDictionary *dic in iconsData) {
                               IconDataModel *icon =  [IconDataModel mj_objectWithKeyValues:dic];
                               [self.iconsArray addObject:icon];
                           }
                           
                           NSArray *fixedData = dataDic[@"fixed"];
                           for (NSDictionary *dic in fixedData) {
                               FixedDataModel *icon =  [FixedDataModel mj_objectWithKeyValues:dic];
                               [self.fixedArray addObject:icon];
                           }
                           
                           NSArray *bannerData = dataDic[@"banner"];
                           for (NSDictionary *dic in bannerData) {
                               BannerDataModel *icon =  [BannerDataModel mj_objectWithKeyValues:dic];
                               [self.bannerArray addObject:icon];
                           }
                           
                           NSArray *hotData = dataDic[@"hot"];
                           for (NSDictionary *dic in hotData) {
                               HotDataModel *icon =  [HotDataModel mj_objectWithKeyValues:dic];
                               [self.hotsArray addObject:icon];
                           }
                           
                           NSArray *modelData = dataDic[@"model"];
                           for (NSDictionary *dic in modelData) {
                               ModelDataModel *icon =  [ModelDataModel mj_objectWithKeyValues:dic];
                               [self.modelsArray addObject:icon];
                           }
                           
                           
                           NSLog(@"");
                           
                           [self loadUI];
                           
                           
                       } fail:^(id responseData) {
                           
                           NSLog(@"刷新firstPage失败");
                       }];
}

- (void)loadUI{
    //banner
    
    [self.scrollView setBackgroundColor:[UIColor lightGrayColor]];
    
    self.viewTotalHeight = 0.0f;
    
    NSMutableArray *images = [NSMutableArray array];
    for (BannerDataModel *banner in self.bannerArray) {
        NSString *path = [NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,banner.picAddress];
        [images addObject:path];
    }
    
    
    self.infinitePageView = [BHInfiniteScrollView
                             infiniteScrollViewWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 220)
                             Delegate:self
                             ImagesArray:images
                             PlageHolderImage:[UIImage imageNamed:@""]
                             InfiniteLoop:YES];
    self.infinitePageView.delegate = self;
    [self.scrollView addSubview:self.infinitePageView];
    self.viewTotalHeight += 220.0f;
   
    //icon
    float viewWidth = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(viewWidth/4.0, 85)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    CGFloat realHeight = ([self.iconsArray count] / 4 + 1) * 85.0f;
    
    self.secondCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,self.viewTotalHeight,self.view.bounds.size.width,realHeight > KCollectionViewHeight?realHeight:KCollectionViewHeight) collectionViewLayout:flowLayout];
    
    
    self.secondCollectionView.delegate = self;
    self.secondCollectionView.dataSource = self;
    
    UINib *cellNib = [UINib nibWithNibName:@"MineCollectionViewCell" bundle:nil];
    [self.secondCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"MineCollectionViewCell"];
    
    [self.secondCollectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.secondCollectionView setScrollEnabled:NO];
    
    [self.scrollView addSubview:self.secondCollectionView];
    self.viewTotalHeight += self.secondCollectionView.bounds.size.height;
    
    //hot
    
    self.viewTotalHeight += 10;
    
    UILabel *hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.viewTotalHeight, self.view.bounds.size.width, 35)];
    hotLabel.text = @"  热门";
    hotLabel.textColor = [UIColor redColor];
    [self.scrollView addSubview:hotLabel];
    self.viewTotalHeight += hotLabel.bounds.size.height;
    
    
    realHeight = ([self.hotsArray count] / 2) * viewWidth/2.0*1.5;
    
    UICollectionViewFlowLayout *hotFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [hotFlowLayout setItemSize:CGSizeMake(viewWidth/2.0 - 10, viewWidth/2.0*1.5)];
    [hotFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    hotFlowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    hotFlowLayout.minimumInteritemSpacing = 0;
    hotFlowLayout.minimumLineSpacing = 0;
    
    self.hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,self.viewTotalHeight,self.view.bounds.size.width,realHeight > KCollectionViewHeight?realHeight:KCollectionViewHeight) collectionViewLayout:hotFlowLayout];
    
    
    self.hotCollectionView.delegate = self;
    self.hotCollectionView.dataSource = self;
    
    cellNib = [UINib nibWithNibName:@"IconCollectionViewCell" bundle:nil];
    [self.hotCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"IconCollectionViewCell"];
    
    [self.hotCollectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.hotCollectionView setScrollEnabled:NO];
    
    [self.scrollView addSubview:self.hotCollectionView];
    self.viewTotalHeight += self.hotCollectionView.bounds.size.height;
    
    
    //recommend
    self.viewTotalHeight += 10;
    
    UILabel *recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.viewTotalHeight, self.view.bounds.size.width, 35)];
    recommendLabel.text = @"  推荐";
    recommendLabel.textColor = [UIColor redColor];
    [self.scrollView addSubview:recommendLabel];
    self.viewTotalHeight += recommendLabel.bounds.size.height;
    
    realHeight = ([self.modelsArray count] / 2) * 55;
    
    UICollectionViewFlowLayout *modelFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [modelFlowLayout setItemSize:CGSizeMake(viewWidth/2.0 - 6, 55)];
    [modelFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    modelFlowLayout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
    modelFlowLayout.minimumInteritemSpacing = 0;
    modelFlowLayout.minimumLineSpacing = 0;
    
    self.recommendCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,self.viewTotalHeight,self.view.bounds.size.width,realHeight > KCollectionViewHeight?realHeight:KCollectionViewHeight) collectionViewLayout:modelFlowLayout];
    
    
    self.recommendCollectionView.delegate = self;
    self.recommendCollectionView.dataSource = self;
    
    cellNib = [UINib nibWithNibName:@"ModelCotionViewCell" bundle:nil];
    [self.recommendCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"ModelCotionViewCell"];
    
    [self.recommendCollectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.recommendCollectionView setScrollEnabled:NO];
    
    [self.scrollView addSubview:self.recommendCollectionView];
    self.viewTotalHeight += self.recommendCollectionView.bounds.size.height;
    
    [self.scrollView setContentSize:CGSizeMake(0, self.viewTotalHeight + 20)];
    
}

#pragma  mark - BHInfiniteScrollViewDelegate
/** 点击图片*/
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index{
    BannerDataModel *banner = [self.bannerArray objectAtIndex:index];
    
    ImagesPageViewController *vtr = [[ImagesPageViewController alloc] initWithResData:banner.resourceId];
    vtr.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vtr animated:YES];
}

/** 图片滚动*/
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didScrollToIndex:(NSInteger)index{
}




#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.secondCollectionView){
        IconDataModel *data = [self.iconsArray objectAtIndex:indexPath.row];
        IconsPageViewController *vtr = [[IconsPageViewController alloc] initWithIcon:data];
        vtr.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vtr animated:YES];
    }else if(collectionView == self.hotCollectionView){
        HotDataModel *data = [self.hotsArray objectAtIndex:indexPath.row];
        ImagesPageViewController *vtr = [[ImagesPageViewController alloc] initWithResData:data.resourceId];
        vtr.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vtr animated:YES];
    }else if(collectionView == self.recommendCollectionView){
        ModelDataModel *data = [self.modelsArray objectAtIndex:indexPath.row];
        ModelPageViewController *vtr = [[ModelPageViewController alloc] initWithResData:data.resourceId];
        vtr.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vtr animated:YES];
    }

}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView == self.secondCollectionView){
        return [self.iconsArray count];
    }else if(collectionView == self.hotCollectionView){
        return [self.hotsArray count];
    }else if(collectionView == self.recommendCollectionView){
        return [self.modelsArray count];
    }
    return  0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.secondCollectionView){
        MineCollectionViewCell *cell = (MineCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MineCollectionViewCell" forIndexPath:indexPath];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MineCollectionViewCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        IconDataModel *icon = [self.iconsArray objectAtIndex:indexPath.row];
        
        [cell.titleView setText:icon.name];
        
        NSString *path = [NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,icon.picAddress];
        [cell.iconView sd_setImageWithURL:[[NSURL alloc] initWithString:path]];
        
        return cell;
    }else if(collectionView == self.hotCollectionView){
        IconCollectionViewCell *cell = (IconCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"IconCollectionViewCell" forIndexPath:indexPath];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"IconCollectionViewCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        HotDataModel *icon = [self.hotsArray objectAtIndex:indexPath.row];
        
        NSString *path = [NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,icon.picAddress];
        [cell.imageView sd_setImageWithURL:[[NSURL alloc] initWithString:path]];
        [cell.titleLabel setText:icon.name];
        
        return cell;
    }else if(collectionView == self.recommendCollectionView){
        ModelCotionViewCell *cell = (ModelCotionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ModelCotionViewCell" forIndexPath:indexPath];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ModelCotionViewCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        ModelDataModel *icon = [self.modelsArray objectAtIndex:indexPath.row];
        
        NSString *path = [NSString stringWithFormat:@"%@%@",[Config instance].rootUrl,icon.picAddress];
        [cell.headView sd_setImageWithURL:[[NSURL alloc] initWithString:path]];
        [cell.titleLabel setText:icon.nickName];
        [cell.subTitleLabel setText:icon.name];
        
        return cell;
    }
    return nil;
}

@end
