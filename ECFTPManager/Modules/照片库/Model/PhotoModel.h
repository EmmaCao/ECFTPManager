//
//  PhotoModel.h
//  ECFTPManager
//
//  Created by Emma on 2019/6/3.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoCellFrame.h"

@class WZMediaAsset;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoModel : NSObject

@property (nonatomic, strong) WZMediaAsset *asset;
@property (nonatomic, strong) PhotoCellFrame *cellFrame;
@property (nonatomic, getter=isEditMode) BOOL editMode;

-(instancetype)initPhotoModelWith:(WZMediaAsset *)asset;

@end

NS_ASSUME_NONNULL_END
