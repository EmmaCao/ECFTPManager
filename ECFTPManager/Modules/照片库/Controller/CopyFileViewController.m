//
//  CopyFileViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/6/4.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "CopyFileViewController.h"
#import "FtpModel.h"
#import "ConnectFtp.h"

@interface CopyFileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<FtpModel *> *dataSource;

@end

@implementation CopyFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(addFolder)];
    self.navigationItem.rightBarButtonItem = btnAdd;
    
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight-50);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), KScreenWidth, 50)];
    bottomView.layer.borderColor = KLightGrayColor.CGColor;
    bottomView.layer.borderWidth = 1;
    [self.view addSubview:bottomView];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(50, 10, 80, 30)];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnCancel];
    
    UIButton *btnSave = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnCancel.frame)+10, 10, 80, 30)];
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btnSave];
    
    [self connectFtp];
}

-(void)cancel
{
    if(self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)save
{
    
}

-(void)connectFtp
{
    ConnectFtp *cftp = [[ConnectFtp alloc] init];
    [cftp connectFtp:self.serverName success:^(NSArray<FtpModel *> * _Nonnull resArr) {
        self.dataSource = resArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(void)addFolder
{
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.imageView.image = [UIImage imageNamed:@"folder"];
    FtpModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *folderName = self.dataSource[indexPath.row].title;
    NSString *serverNameFolder = NSStringFormat(@"%@/%@", self.serverName, folderName);
    CopyFileViewController *vc = [[CopyFileViewController alloc] init];
    vc.serverName = serverNameFolder;
    vc.title = folderName;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setDataSource:(NSArray<FtpModel *> *)dataSource
{
    NSMutableArray<FtpModel *> *marr = [NSMutableArray array];
    for (FtpModel *fm in dataSource) {
        if (fm.fileType == FtpFoler) {
            [marr addObject:fm];
        }
    }
    _dataSource = marr;
}


@end
