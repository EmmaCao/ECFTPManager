//
//  RootNavigationController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()<UIGestureRecognizerDelegate>

/** 是否开启系统右滑返回 */
@property (nonatomic, assign) BOOL isSystemSlidBack;

@end

@implementation RootNavigationController

//APP生命周期中，只会执行一次
+(void)initialize
{
    //导航栏主题，title文字属性
//    UINavigationBar *navBar = [UINavigationBar appearance];
    //导航栏背景图
//    [navBar setBackgroundImage:[UIImage imageNamed:@"tabbarbg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

//根视图禁用右滑返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count == 1 ? NO:YES;
}

/**
 *  返回到制定的类视图
 *
 *  @param className    类名
 *  @param animated     是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)className animated:(BOOL)animated
{
    id vc = [self getCurrentViewControllerClass:className];
    if (vc != nil && [vc isKindOfClass:[UIViewController class]]) {
        [self popToAppointViewController:vc animated:animated];
        return YES;
    }
    return NO;
}

/**
 *  获取当前导航器显示的视图
 *
 *  @param className    要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)className
{
    Class classobj = NSClassFromString(className);
    
    NSArray *szArray = self.viewControllers;
    for (id vc in szArray) {
        if ([vc isMemberOfClass:classobj]) {
            return vc;
        }
    }
    return nil;
}

@end
