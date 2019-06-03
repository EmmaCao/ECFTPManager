//
//  TextfieldTableViewCell.h
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextfieldTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *lblText;
@property (nonatomic, strong) UITextField *txfInput;

@end

NS_ASSUME_NONNULL_END
