//
//  PhotoModel.m
//  ECFTPManager
//
//  Created by Emma on 2019/6/3.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

-(instancetype)initPhotoModelWith:(WZMediaAsset *)asset
{
    PhotoModel *model = [[PhotoModel alloc] init];
    model.asset = asset;
    model.editMode = NO;
    return model;
}

-(PhotoCellFrame *)cellFrame
{
    if (!_cellFrame) {
        _cellFrame = [[PhotoCellFrame alloc] initWithModel:self];
    }
    return _cellFrame;
}

@end
