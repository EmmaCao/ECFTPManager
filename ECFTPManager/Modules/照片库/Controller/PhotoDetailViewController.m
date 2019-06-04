//
//  PhotoDetailViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/31.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoModel.h"
#import "ChooseFtpTableViewController.h"

@interface PhotoDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *gridLayout;
@property (nonatomic, strong) NSArray<PhotoModel *> *dataSource;
@property (nonatomic, strong) UIBarButtonItem *barbtn;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSMutableArray<PhotoModel *> *selectedImages;

@end

@implementation PhotoDetailViewController

static NSString *cellID = @"CollectionViewCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.gridLayout];
    cv.showsVerticalScrollIndicator = YES;
    cv.backgroundColor = [UIColor whiteColor];
    cv.delegate = self;
    cv.dataSource = self;
    cv.allowsMultipleSelection = YES;
    [self.view addSubview:cv];
    [cv registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    self.collectionView = cv;
    
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = barbtn;
    self.barbtn = barbtn;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight-50, KScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.borderColor = KLightGrayColor.CGColor;
    bottomView.layer.borderWidth = 1;
    [self.view addSubview:bottomView];
    UIButton *btnCopy = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth/2-50, 10, 100, 30)];
    [bottomView addSubview:btnCopy];
    [btnCopy setTitle:@"复制到" forState:UIControlStateNormal];
    [btnCopy setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnCopy addTarget:self action:@selector(copyTo) forControlEvents:UIControlEventTouchUpInside];
    self.bottomView = bottomView;
    self.bottomView.hidden = YES;
}

-(void)copyTo
{
    ChooseFtpTableViewController *vc = [[ChooseFtpTableViewController alloc] init];
    RootNavigationController *nav = [[RootNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)edit
{
    if ([self.barbtn.title isEqualToString:@"完成"]) {
        self.barbtn.title = @"编辑";
        for(PhotoModel *pm in self.dataSource)
        {
            pm.editMode = NO;
            self.bottomView.hidden = YES;
        }
    }
    else{
        self.barbtn.title = @"完成";
        for(PhotoModel *pm in self.dataSource)
        {
            pm.editMode = YES;
            self.bottomView.hidden = NO;
        }
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.view.frame.size.width - KNormalSpace)/3.0;
    PhotoModel *pm = self.dataSource[indexPath.row];
    return CGSizeMake(width, pm.cellFrame.cellHeight);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedImages addObject:self.dataSource[indexPath.row]];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedImages removeObject:self.dataSource[indexPath.row]];
}

-(void)setAssetCollection:(WZMediaAssetCollection *)assetCollection
{
    _assetCollection = assetCollection;
    NSMutableArray *marr = [NSMutableArray array];
    for (WZMediaAsset *asset in assetCollection.mediaAssetArray) {
        PhotoModel *pm = [[PhotoModel alloc] initPhotoModelWith:asset];
        [marr addObject:pm];
    }
    self.dataSource = marr;
}

-(UICollectionViewFlowLayout *)gridLayout
{
    if (!_gridLayout) {
        _gridLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (self.view.frame.size.width - KNormalSpace)/3.0;
        _gridLayout.itemSize = CGSizeMake(width, width);
        _gridLayout.minimumLineSpacing = KLineSpacing;
        _gridLayout.minimumInteritemSpacing = KCVInteritemSpace;
        _gridLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _gridLayout;
}

-(NSMutableArray<PhotoModel *> *)selectedImages
{
    if (!_selectedImages) {
        _selectedImages = [NSMutableArray array];
    }
    return _selectedImages;
}

@end
