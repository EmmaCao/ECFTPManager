//
//  PhotoCellFrame.m
//  ECFTPManager
//
//  Created by Emma on 2019/6/3.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "PhotoCellFrame.h"
#import "PhotoModel.h"

@interface PhotoCellFrame()

@property (nonatomic, weak) PhotoModel *model;

@end

@implementation PhotoCellFrame

-(instancetype)initWithModel:(PhotoModel *)model
{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

-(CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGFloat cellw = (KScreenWidth-KCVInteritemSpace*2)/3;
        CGFloat btnImgW = KLabelHeight;
        
        self.thumbnailFrame = CGRectMake(0, KNormalSpace, cellw, cellw);
        
        self.nameFrame = CGRectMake(0, CGRectGetMaxY(self.thumbnailFrame)+KNormalSpace, cellw, KLabelHeight*2);
        
        self.dateFrame = CGRectMake(0, CGRectGetMaxY(self.nameFrame)+KNormalSpace, cellw, KLabelHeight);
        
        self.selectFrame = CGRectMake(cellw-btnImgW-KNormalSpace, CGRectGetMaxY(self.nameFrame)+KNormalSpace, btnImgW, btnImgW);
        
        _cellHeight = CGRectGetMaxY(self.dateFrame)+KNormalSpace;
    }
    return _cellHeight;
}

@end
