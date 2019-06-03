//
//  TextfieldTableViewCell.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "TextfieldTableViewCell.h"

@implementation TextfieldTableViewCell

//1.初始化子视图
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *lblText = [[UILabel alloc] init];
        [self.contentView addSubview:lblText];
        self.lblText = lblText;
        
        UITextField *txfInput = [[UITextField alloc] init];
        [self.contentView addSubview:txfInput];
        self.txfInput = txfInput;
    }
    return self;
}

//2.布局子视图，此时控件中已经有值
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftmargin = 18;
    CGFloat margin = 10;
    CGFloat lblTextW = 150;
    CGFloat lblTextH = 20;
    
    //text frame
    CGFloat lblTextX = leftmargin;
    CGFloat lblTextY = margin;
    CGSize lblTextSize = CGSizeMake(lblTextW, lblTextH);
    CGRect lblTextFrame = CGRectMake(lblTextX, lblTextY, lblTextSize.width, lblTextSize.height);
    self.lblText.frame = lblTextFrame;
    
    //input textfield frame
    CGFloat txfInputX = CGRectGetMaxX(lblTextFrame)+margin;
    CGFloat txfInputY = margin;
    CGSize txfTextSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-txfInputX-margin, 30);
    self.txfInput.frame = CGRectMake(txfInputX, txfInputY, txfTextSize.width, txfTextSize.height);
    self.txfInput.textAlignment = NSTextAlignmentRight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
