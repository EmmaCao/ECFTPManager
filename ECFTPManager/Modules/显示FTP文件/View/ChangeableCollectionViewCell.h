//
//  ChangeableCollectionViewCell.h
//  ECFTPManager
//
//  Created by Emma on 2019/5/30.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FtpModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangeableCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) FtpModel *model;

@end

NS_ASSUME_NONNULL_END
