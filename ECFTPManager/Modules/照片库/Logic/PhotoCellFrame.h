//
//  PhotoCellFrame.h
//  ECFTPManager
//
//  Created by Emma on 2019/6/3.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoModel;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCellFrame : NSObject

@property (nonatomic, assign) CGRect thumbnailFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect dateFrame;
@property (nonatomic, assign) CGRect selectFrame;
@property (nonatomic, assign) CGFloat cellHeight;

-(instancetype)initWithModel:(PhotoModel *)model;

@end

NS_ASSUME_NONNULL_END
