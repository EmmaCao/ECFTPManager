//
//  DisplayCellFrame.h
//  ECFTPManager
//
//  Created by Emma on 2019/5/30.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FtpModel;

NS_ASSUME_NONNULL_BEGIN

@interface DisplayCellFrame : NSObject

@property (nonatomic, assign) BOOL isList;

@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect sizeFrame;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect listIconFrame;
@property (nonatomic, assign) CGRect listTitleFrame;
@property (nonatomic, assign) CGRect listSizeFrame;
@property (nonatomic, assign) CGRect listTimeFrame;
@property (nonatomic, assign) CGFloat listCellHeight;

-(instancetype)initWithModel:(FtpModel *)model;

@end

NS_ASSUME_NONNULL_END
