//
//  DisplayModel.h
//  ECFTPManager
//
//  Created by Emma on 2019/5/30.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DisplayCellFrame.h"

typedef enum : NSUInteger {
    FtpFoler,
    FtpFile,
} FtpFileType;

NS_ASSUME_NONNULL_BEGIN

@interface DisplayModel : NSObject

@property (nonatomic, assign) FtpFileType fileType;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) DisplayCellFrame *cellFrame;

@end

NS_ASSUME_NONNULL_END
