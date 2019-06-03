//
//  PhotoCollectionViewCell.m
//  ECFTPManager
//
//  Created by Emma on 2019/6/3.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "PhotoModel.h"

@interface PhotoCollectionViewCell()

@property (nonatomic, strong) UIImageView *imgvThumbnail;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblDate;
@property (nonatomic, strong) UIImageView *imgvSelect;

@end

@implementation PhotoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

//1. 初始化子视图
-(void)setupUI
{
//    self.backgroundColor = [UIColor grayColor];
    
    UIImageView *imgvThumbnail = [[UIImageView alloc] init];
//    imgvThumbnail.backgroundColor = [UIColor redColor];
    imgvThumbnail.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imgvThumbnail];
    self.imgvThumbnail = imgvThumbnail;
    
    UILabel *lblName = [[UILabel alloc] init];
//    lblName.backgroundColor = [UIColor redColor];
    lblName.numberOfLines = 2;
    lblName.lineBreakMode = NSLineBreakByTruncatingMiddle;
    lblName.textColor = [UIColor blackColor];
    lblName.font = [UIFont systemFontOfSize:15.0];
    lblName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lblName];
    self.lblName = lblName;
    
    UILabel *lblDate = [[UILabel alloc] init];
//    lblDate.backgroundColor = [UIColor redColor];
    lblDate.textColor = [UIColor grayColor];
    lblDate.font = [UIFont systemFontOfSize:11.0];
    lblDate.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lblDate];
    self.lblDate = lblDate;
    
    UIImageView *imgvSelect = [[UIImageView alloc] init];
    //    imgvThumbnail.backgroundColor = [UIColor redColor];
    imgvSelect.contentMode = UIViewContentModeScaleAspectFit;
    imgvSelect.image = [UIImage imageNamed:@"unselect"];
    [self.contentView addSubview:imgvSelect];
    self.imgvSelect = imgvSelect;
    self.imgvSelect.hidden = YES;
    self.userInteractionEnabled = NO;
}

//2. 布局子视图
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imgvThumbnail.frame = self.model.cellFrame.thumbnailFrame;
    self.lblName.frame = self.model.cellFrame.nameFrame;
    self.lblDate.frame = self.model.cellFrame.dateFrame;
    self.imgvSelect.frame = self.model.cellFrame.selectFrame;
}

//3. 填充数据
-(void)setModel:(PhotoModel *)model
{
    _model = model;
    
    [WZMediaFetcher fetchThumbnailWithAsset:model.asset.asset synchronous:NO handler:^(UIImage *thumbnail) {
        
        self.imgvThumbnail.image = thumbnail;
    }];
    self.lblName.text = [model.asset.asset valueForKey:@"filename"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    self.lblDate.text = [dateFormatter stringFromDate:model.asset.asset.creationDate];
    
    if (model.isEditMode) {
        self.imgvSelect.hidden = NO;
        self.userInteractionEnabled = YES;
    }
    else{
        self.imgvSelect.hidden = YES;
        self.userInteractionEnabled = NO;
    }
}

-(void)setSelected:(BOOL)selected
{
    if (selected) {
        self.imgvSelect.image = [UIImage imageNamed:@"select"];
    }
    else{
        self.imgvSelect.image = [UIImage imageNamed:@"unselect"];
    }
}

@end
