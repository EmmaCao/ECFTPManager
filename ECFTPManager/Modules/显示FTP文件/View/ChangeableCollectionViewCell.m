//
//  ChangeableCollectionViewCell.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/30.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "ChangeableCollectionViewCell.h"

@interface ChangeableCollectionViewCell()

@property (nonatomic, strong) UIImageView *imgvIcon;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblSize;
@property (nonatomic, strong) UILabel *lblTime;

@end

@implementation ChangeableCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

//1.初始化子视图
-(void)setupUI
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgvIcon = [[UIImageView alloc] init];
//    imgvIcon.backgroundColor = [UIColor redColor];
    imgvIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imgvIcon];
    self.imgvIcon = imgvIcon;
    
    UILabel *lblTitle = [[UILabel alloc] init];
//    lblTitle.backgroundColor = [UIColor redColor];
    lblTitle.textColor = [UIColor blackColor];
    lblTitle.font = [UIFont systemFontOfSize:15];
    lblTitle.numberOfLines = 2;
    lblTitle.lineBreakMode = NSLineBreakByTruncatingMiddle;
//    lblTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lblTitle];
    self.lblTitle = lblTitle;
    
    UILabel *lblSize = [[UILabel alloc] init];
//    lblSize.backgroundColor = [UIColor redColor];
    lblSize.textColor = [UIColor grayColor];
    lblSize.font = [UIFont systemFontOfSize:11];
//    lblSize.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lblSize];
    self.lblSize = lblSize;
    
    UILabel *lblTime = [[UILabel alloc] init];
//    lblTime.backgroundColor = [UIColor redColor];
    lblTime.textColor = [UIColor grayColor];
    lblTime.font = [UIFont systemFontOfSize:15];
//    lblTime.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lblTime];
    self.lblTime = lblTime;
}

//2.布局子视图
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.model.cellFrame.isList) {
        self.lblTitle.textAlignment = NSTextAlignmentLeft;
        self.lblSize.textAlignment = NSTextAlignmentLeft;
        self.lblTime.textAlignment = NSTextAlignmentLeft;
        self.imgvIcon.frame = self.model.cellFrame.listIconFrame;
        self.lblTitle.frame = self.model.cellFrame.listTitleFrame;
        self.lblSize.frame = self.model.cellFrame.listSizeFrame;
        self.lblTime.frame = self.model.cellFrame.listTimeFrame;
    }
    else{
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblSize.textAlignment = NSTextAlignmentCenter;
        self.lblTime.textAlignment = NSTextAlignmentCenter;
        self.imgvIcon.frame = self.model.cellFrame.iconFrame;
        self.lblTitle.frame = self.model.cellFrame.titleFrame;
        self.lblSize.frame = self.model.cellFrame.sizeFrame;
        self.lblTime.frame = self.model.cellFrame.timeFrame;
    }
}

//3.填充数据
-(void)setModel:(FtpModel *)model
{
    _model = model;
    
    self.imgvIcon.image = [UIImage imageNamed:model.icon];
    self.lblTitle.text = model.title;
    if (model.fileType == FtpFoler) {
        self.lblSize.hidden = YES;
    }
    else{
        self.lblSize.text = model.size;
    }
    self.lblTime.text = model.time;
}

@end
