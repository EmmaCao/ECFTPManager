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

@interface PhotoDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *gridLayout;
@property (nonatomic, strong) NSArray<PhotoModel *> *dataSource;
@property (nonatomic, strong) UIBarButtonItem *barbtn;

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
}

-(void)edit
{
    if ([self.barbtn.title isEqualToString:@"完成"]) {
        self.barbtn.title = @"编辑";
        for(PhotoModel *pm in self.dataSource)
        {
            pm.editMode = NO;
        }
    }
    else{
        self.barbtn.title = @"完成";
        for(PhotoModel *pm in self.dataSource)
        {
            pm.editMode = YES;
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

@end
