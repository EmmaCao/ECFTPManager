//
//  MainTableViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "MainTableViewController.h"
#import "AddFtpTableViewController.h"
#import "FtpViewController.h"
#import "PhotoListTableViewController.h"

@interface MainTableViewController ()

@property (nonatomic, strong) NSArray *categorys;
@property (nonatomic, strong) NSArray *ftps;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FTP";
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(addFtp)];
    self.navigationItem.rightBarButtonItem = btnAdd;
    
    [self addNotification];
}

-(void)dealloc
{
    [self removeNotification];
}

-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFtpOnMain) name:@"refreshFtpOnMain" object:nil];
}
-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshFtpOnMain" object:nil];
}

-(void)refreshFtpOnMain
{
    [self getFtps];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)addFtp
{
    AddFtpTableViewController *vc = [[AddFtpTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    RootNavigationController *nav = [[RootNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.ftps.count > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return self.categorys.count;
    }
    else{
        return self.ftps.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    if (section == 1) {
        title = @"连接";
    }
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.categorys[indexPath.row];
    }
    else{
        cell.textLabel.text = self.ftps[indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PhotoListTableViewController *vc = [[PhotoListTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        FtpViewController *vc = [[FtpViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSArray *)categorys
{
    if (!_categorys) {
        _categorys = [NSArray array];
        _categorys = @[@"照片库"];
    }
    return _categorys;
}

-(void)getFtps
{
    NSString *hostnameOrIP = [[NSUserDefaults standardUserDefaults] objectForKey:@"hostnameOrIP"];
    if (hostnameOrIP) {
        _ftps = @[hostnameOrIP];
    }
}

-(NSArray *)ftps
{
    if (!_ftps) {
        _ftps = [NSArray array];
        [self getFtps];
    }
    return _ftps;
}

@end
