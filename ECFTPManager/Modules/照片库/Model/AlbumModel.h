//
//  AlbumModel.h
//  ECFTPManager
//
//  Created by Emma on 2019/5/31.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlbumModel : NSObject

/** 数据载体 */
@property (nonatomic, strong) NSArray<AssetModel *> *assetArray;
/** 相册的载体 */
@property (nonatomic, strong) PHAssetCollection *assetCollection;
/** 相册的title */
@property (nonatomic, strong) NSString *title;
/** 封面资源，默认是assetArray的首个元素 */
@property (nonatomic, strong) AssetModel *coverAsset;

@end

NS_ASSUME_NONNULL_END
