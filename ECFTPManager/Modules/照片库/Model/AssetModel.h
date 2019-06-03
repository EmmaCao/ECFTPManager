//
//  AssetModel.h
//  ECFTPManager
//
//  Created by Emma on 2019/5/31.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** media类型 */
typedef enum : NSUInteger {
    /** 位置类型（默认） */
    MediaTypeUnknow = 0,
    /** 图片类型 */
    MediaTypePhoto = 1,
    /** 视频类型 */
    MediaTypeVideo = 2,
    /** 音频类型 */
    MediaTypeAudio = 3,
} MediaType;

@interface AssetModel : NSObject

/** 元数据资源 */
@property (nonatomic, strong) PHAsset *asset;
/** 媒体类型 */
@property (nonatomic, assign) MediaType *mediaType;

@end

NS_ASSUME_NONNULL_END
