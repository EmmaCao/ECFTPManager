//
//  PhotoCollectionViewCell.h
//  ECFTPManager
//
//  Created by Emma on 2019/6/3.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PhotoModel;

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) PhotoModel *model;

@end

NS_ASSUME_NONNULL_END
