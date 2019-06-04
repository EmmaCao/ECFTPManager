//
//  FtpModel.m
//  ECFTPManager
//
//  Created by Emma on 2019/6/4.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "FtpModel.h"

@implementation FtpModel

-(DisplayCellFrame *)cellFrame
{
    if (!_cellFrame) {
        _cellFrame = [[DisplayCellFrame alloc] initWithModel:self];
    }
    return _cellFrame;
}

@end
