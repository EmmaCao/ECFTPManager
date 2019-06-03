//
//  PhotoListTableViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/31.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "PhotoListTableViewController.h"
#import "WZMediaFetcher.h"
#import "PhotoDetailViewController.h"
#import "PhotoModel.h"

@interface PhotoListTableViewController ()

@property (nonatomic, strong) NSArray<WZMediaAssetCollection *> *albums;
@property (nonatomic, strong) NSArray<PhotoModel *> *assets;

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
            
            NSMutableArray<WZMediaAssetCollection *> *tarr = [NSMutableArray array];
            for (PHAssetCollection *assetCollection in smartAlbumsRes)
            {
                PHFetchResult<PHAsset *> *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
                if (fetchResult.count) {
                    
                    WZMediaAssetCollection *album = [[WZMediaAssetCollection alloc] init];
                    album.assetCollection = assetCollection;
                    album.title = assetCollection.localizedTitle;
                    [tarr addObject:album];
                    
                    NSMutableArray<WZMediaAsset *> *tmassets = [NSMutableArray array];
                    for (PHAsset *asset in fetchResult) {
                        WZMediaAsset *object = [[WZMediaAsset alloc] init];
                        object.asset = asset;
                        [tmassets addObject:object];
                    }
                    
                    album.mediaAssetArray = [NSArray arrayWithArray:tmassets];
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
    WZMediaAssetCollection *model = self.albums[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"file"];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",(long)model.mediaAssetArray.count];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoDetailViewController *vc = [[PhotoDetailViewController alloc] init];
    vc.assetCollection = self.albums[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSArray<WZMediaAssetCollection *> *)albums
{
    if (!_albums) {
        _albums = [NSArray array];
    }
    return _albums;
}


@end
