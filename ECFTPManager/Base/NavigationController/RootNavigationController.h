//
//  RootNavigationController.h
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 导航控制器基类
 */
@interface RootNavigationController : UINavigationController

/**
 *  返回到制定的类视图
 *
 *  @param className    类名
 *  @param animated     是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)className animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
