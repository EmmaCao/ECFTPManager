//
//  PhotoListTableViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/31.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "PhotoListTableViewController.h"
#import "AlbumModel.h"

@interface PhotoListTableViewController ()

@property (nonatomic, strong) NSArray<AlbumModel *> *albums;

@end

@implementation PhotoListTableViewController

static NSString *cellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"照片库";
    self.tableView.tableFooterView = [UIView new];
    
    [self getAlbum];
}

-(void)getAlbum
{
    PHFetchOptions *fetchResOption = [[PHFetchOptions alloc] init];
    fetchResOption.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]]; //按照日期降序排序
    fetchResOption.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeImage]; //过滤剩下照片类型
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            
            PHFetchResult *smartAlbumsRes = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
            
            NSMutableArray<AlbumModel *> *tarr = [NSMutableArray array];
            for (PHAssetCollection *assetCollection in smartAlbumsRes)
            {
                PHFetchResult<PHAsset *> *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
                if (fetchResult.count) {
                    
                    AlbumModel *album = [[AlbumModel alloc] init];
                    album.assetCollection = assetCollection;
                    album.title = assetCollection.localizedTitle;
                    [tarr addObject:album];
                    
                    NSMutableArray<AssetModel *> *tmassets = [NSMutableArray array];
                    for (PHAsset *asset in fetchResult) {
                        AssetModel *object = [[AssetModel alloc] init];
                        object.asset = asset;
                        [tmassets addObject:object];
                    }
                    
                    album.assetArray = [NSArray arrayWithArray:tmassets];
                }
            }
            self.albums = tarr;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albums.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    AlbumModel *model = self.albums[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"file"];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",(long)model.assetArray.count];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(NSArray<AlbumModel *> *)albums
{
    if (!_albums) {
        _albums = [NSArray array];
    }
    return _albums;
}


@end
