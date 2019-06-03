//
//  DisplayCellFrame.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/30.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "DisplayCellFrame.h"
#import "DisplayModel.h"

@interface DisplayCellFrame()

@property (nonatomic, weak) DisplayModel *model;

@end

@implementation DisplayCellFrame

-(instancetype)initWithModel:(DisplayModel *)model
{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

-(CGFloat)cellHeight
{
    self.isList = NO;
    
    if (!_cellHeight)
    {
        CGFloat margin = 5;
        CGFloat itemW = ([UIScreen mainScreen].bounds.size.width-5*2)/3;
        CGFloat lblW = itemW-2*margin;
        
        //icon frame
        self.iconFrame = CGRectMake(margin, margin, lblW, lblW);
        
        //title frame
        CGFloat lblTitleY = CGRectGetMaxY(self.iconFrame)+margin;
        //    CGRect titleRect = [self.model.title boundingRectWithSize:CGSizeMake(itemW-2*margin, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:nil];
        self.titleFrame = CGRectMake(margin, lblTitleY, lblW, 40);
        
        //size frame
        CGFloat lblSizeY = CGRectGetMaxY(self.titleFrame)+margin;
        self.sizeFrame = CGRectMake(margin, lblSizeY, lblW, 20);
        
        //time frame
        CGFloat lblTimeY = CGRectGetMaxY(self.sizeFrame)+margin;
        self.timeFrame = CGRectMake(margin, lblTimeY, lblW, 20);
        
        _cellHeight = CGRectGetMaxY(self.timeFrame)+margin;
    }
    return _cellHeight;
}

-(CGFloat)listCellHeight
{
    self.isList = YES;
    
    if (!_listCellHeight)
    {
        CGFloat margin = 10;
        CGFloat iconW  = 50;
        CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
        CGFloat lblH = 20;

        //icon frame
        self.listIconFrame = CGRectMake(margin, margin, iconW, iconW);

        //title frame
        CGFloat lblTitleX = CGRectGetMaxX(self.listIconFrame)+margin;
        CGFloat lblTitleW = viewW - lblTitleX - margin;
        self.listTitleFrame = CGRectMake(lblTitleX, margin, lblTitleW, 2*lblH);

        //time frame
        CGFloat lblTimeX = lblTitleX;
        CGFloat lblTimeY = CGRectGetMaxY(self.listTitleFrame)+margin;
        self.listTimeFrame = CGRectMake(lblTimeX, lblTimeY, 150, lblH);
        
        //size frame
        CGFloat lblSizeX = CGRectGetMaxX(self.listTimeFrame)+margin;
        CGFloat lblSizeY = lblTimeY;
        self.listSizeFrame = CGRectMake(lblSizeX, lblSizeY, 100, lblH);

        _listCellHeight = CGRectGetMaxY(self.listTimeFrame)+margin;
    }
    return _listCellHeight;
}

@end
