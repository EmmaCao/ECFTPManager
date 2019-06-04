//
//  FtpViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "FtpViewController.h"
#import "ChangeableCollectionViewCell.h"
#import "ConnectFtp.h"

@interface FtpViewController ()< UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isList;
@property (nonatomic, strong) UICollectionViewFlowLayout *gridLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *listLayout;

@property (nonatomic, strong) UIBarButtonItem *btnStyle;
@property (nonatomic, strong) NSArray<FtpModel *> *dataSource;

@end

@implementation FtpViewController

static NSString *cellID = @"UICollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *btnStyle = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list"] style:UIBarButtonItemStylePlain target:self action:@selector(changeStyle)];
    self.navigationItem.rightBarButtonItem = btnStyle;
    self.btnStyle = btnStyle;
    
    [self ftp];
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.gridLayout];
    cv.showsVerticalScrollIndicator = YES;
    cv.backgroundColor = [UIColor whiteColor];
    cv.delegate = self;
    cv.dataSource = self;
    [self.view addSubview:cv];
    [cv registerClass:[ChangeableCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    self.collectionView = cv;
}

-(void)changeStyle
{
    _isList = !_isList;
    if (_isList) {
        [self.collectionView setCollectionViewLayout:self.listLayout animated:YES];
        self.btnStyle.image = [UIImage imageNamed:@"grid"];
    }
    else{
        [self.collectionView setCollectionViewLayout:self.gridLayout animated:YES];
        self.btnStyle.image = [UIImage imageNamed:@"list"];
    }
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
    ChangeableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.view.frame.size.width - 10)/3.0;
    FtpModel *model = self.dataSource[indexPath.row];
    if (_isList) {
        self.collectionView.backgroundColor = [UIColor grayColor];
        return CGSizeMake(self.view.frame.size.width, model.cellFrame.listCellHeight);
    }
    self.collectionView.backgroundColor = [UIColor whiteColor];
    return CGSizeMake(width, model.cellFrame.cellHeight);
}

-(UICollectionViewFlowLayout *)gridLayout
{
    if (!_gridLayout) {
        _gridLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (self.view.frame.size.width - 10)/3.0;
        _gridLayout.itemSize = CGSizeMake(width, width+100);
        _gridLayout.minimumLineSpacing = 5;
        _gridLayout.minimumInteritemSpacing = 5;
        _gridLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _gridLayout;
}

-(UICollectionViewFlowLayout *)listLayout
{
    if (!_listLayout) {
        _listLayout = [[UICollectionViewFlowLayout alloc] init];
        _listLayout.itemSize = CGSizeMake(self.view.frame.size.width, 190);
        _listLayout.minimumLineSpacing = 0.5;
        _listLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _listLayout;
}

-(void)ftp
{
    ConnectFtp *connFtp = [[ConnectFtp alloc] init];
    [connFtp connectFtp:self.serverName success:^(NSArray<FtpModel *> * _Nonnull resArr) {
        
        self.dataSource = resArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}

@end
