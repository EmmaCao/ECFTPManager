//
//  PhotoDetailViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/31.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *gridLayout;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.gridLayout];
    cv.showsVerticalScrollIndicator = YES;
    cv.backgroundColor = [UIColor whiteColor];
    cv.delegate = self;
    cv.dataSource = self;
    [self.view addSubview:cv];
    self.collectionView = cv;
}


@end
