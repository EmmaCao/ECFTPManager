//
//  RootViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/** 是否显示返回按钮 */
-(void)setIsShowBack:(BOOL)isShowBack
{
    _isShowBack = isShowBack;
    NSInteger vcCount = self.navigationController.viewControllers.count;
    //下面判断的逻辑是，当vc所在的导航控制器中的vc个数大于1， 后者是present出来的vc时，才展示返回按钮，其他情况不展示
    if (isShowBack && (vcCount > 1 || self.navigationController.presentingViewController != nil)) {
        [self addNavigationItemWithImageNames:@[@"back_icon"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
    }
    else{
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem *NULLBar = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
    }
}

-(void)backBtnClicked
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 导航栏，添加图片按钮
/**
 *  导航栏添加图片按钮
 *
 *  @param  imageNames  图标数组
 *  @param  isLeft      是否是左边，非左即右
 *  @param  target      目标
 *  @param  action      点击方法
 *  @param  tags        tags数组，回调区分用
 */
-(void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray *items = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString *imageName in imageNames) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:action];
        item.tag = [tags[i++] integerValue];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    }
    else{
        self.navigationItem.rightBarButtonItems = items;
    }
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

@end
