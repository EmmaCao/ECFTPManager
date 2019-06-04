//
//  RootViewController.h
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 基类 */
@interface RootViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

/** 是否显示返回按钮，默认情况是YES */
@property (nonatomic, assign) BOOL isShowBack;

/** 默认返回按钮的点击事件，默认是返回，子类可重写 */
-(void)backBtnClicked;

@end

NS_ASSUME_NONNULL_END
