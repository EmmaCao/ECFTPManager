//
//  ChooseFtpTableViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/6/4.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "ChooseFtpTableViewController.h"
#import "CopyFileViewController.h"

@interface ChooseFtpTableViewController ()

@property (nonatomic, strong) NSArray *ftps;

@end

@implementation ChooseFtpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"拷贝文件";
    UIBarButtonItem *btnFinished = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    self.navigationItem.rightBarButtonItem = btnFinished;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self addNotification];
}

-(void)finish
{
    if(self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ftps.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"连接";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.ftps[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CopyFileViewController *vc = [[CopyFileViewController alloc] init];
    vc.title = @"/";
    NSString *serverName = self.ftps[indexPath.row];
    vc.serverName = serverName;
    [self.navigationController pushViewController:vc animated:YES];
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
