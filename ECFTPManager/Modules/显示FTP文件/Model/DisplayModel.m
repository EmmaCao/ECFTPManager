//
//  DisplayModel.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/30.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "DisplayModel.h"

@implementation DisplayModel

-(DisplayCellFrame *)cellFrame
{
    if (!_cellFrame) {
        _cellFrame = [[DisplayCellFrame alloc] initWithModel:self];
    }
    return _cellFrame;
}

@end
