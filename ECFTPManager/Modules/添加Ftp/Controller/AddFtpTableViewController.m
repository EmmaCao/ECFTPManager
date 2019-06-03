//
//  AddFtpTableViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "AddFtpTableViewController.h"
#import "TextfieldTableViewCell.h"

@interface AddFtpTableViewController ()

@property (nonatomic, strong) NSDictionary *connectText;
@property (nonatomic, strong) NSDictionary *connectAsText;
@property (nonatomic, strong) NSString *hostnameOrIP;

@end

@implementation AddFtpTableViewController

static NSString *cellID = @"TextfieldTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建连接";
    
    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveFtp)];
    self.navigationItem.rightBarButtonItem = btnSave;
    
    [self.tableView registerClass:[TextfieldTableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.estimatedRowHeight = 44;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackButton)];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)clickBackButton
{
    if(self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)saveFtp
{
    [self.view endEditing:YES];
    
    TextfieldTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    self.hostnameOrIP = cell.txfInput.text;
    
    if (self.hostnameOrIP.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入主机名称或IP！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:self.hostnameOrIP forKey:@"hostnameOrIP"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFtpOnMain" object:nil];
    [self clickBackButton];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.connectText.count;
    }
    return self.connectAsText.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"连接";
    }
    return @"连接作为";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextfieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSString *key = @"";
    NSString *value = @"";
    if (indexPath.section == 0) {
        key = [self.connectText allKeys][indexPath.row];
        value = [self.connectText objectForKey:key];
        
    }
    else{
        key = [self.connectAsText allKeys][indexPath.row];
        value = [self.connectAsText objectForKey:key];
    }
    cell.lblText.text = key;
    cell.txfInput.placeholder = value;
    
    return cell;
}

-(NSDictionary *)connectText
{
    if(!_connectText)
    {
        _connectText = [NSDictionary dictionary];
        _connectText = @{@"显示名称":@"可选",
                         @"主机名称或IP":@"必填"};
    }
    return _connectText;
}

-(NSDictionary *)connectAsText
{
    if (!_connectAsText) {
        _connectAsText = [NSDictionary dictionary];
        _connectAsText = @{@"用户名":@"可选",
                           @"密码":@"可选"};
    }
    return _connectAsText;
}


@end
