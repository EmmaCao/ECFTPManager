//
//  AssetModel.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/31.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "AssetModel.h"

@implementation AssetModel

-(void)setAsset:(PHAsset *)asset
{
    _asset = [asset isKindOfClass:[PHAsset class]] ? asset : nil;
}

@end
