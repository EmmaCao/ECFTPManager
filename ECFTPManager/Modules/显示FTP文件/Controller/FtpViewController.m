//
//  FtpViewController.m
//  ECFTPManager
//
//  Created by Emma on 2019/5/29.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "FtpViewController.h"
#import "ChangeableCollectionViewCell.h"

@interface FtpViewController ()<NSURLSessionDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSDictionary *monthAbbr;
@property (nonatomic, strong) NSString *currentYear;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isList;
@property (nonatomic, strong) UICollectionViewFlowLayout *gridLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *listLayout;

@property (nonatomic, strong) UIBarButtonItem *btnStyle;
@property (nonatomic, strong) NSArray<DisplayModel *> *dataSource;

@end

@implementation FtpViewController

static NSString *cellID = @"UICollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *btnStyle = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"list"] style:UIBarButtonItemStylePlain target:self action:@selector(changeStyle)];
    self.navigationItem.rightBarButtonItem = btnStyle;
    self.btnStyle = btnStyle;
    
    [self ftp];
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.gridLayout];
    cv.showsVerticalScrollIndicator = YES;
    cv.backgroundColor = [UIColor whiteColor];
    cv.delegate = self;
    cv.dataSource = self;
    [self.view addSubview:cv];
    [cv registerClass:[ChangeableCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    self.collectionView = cv;
}

-(void)changeStyle
{
    _isList = !_isList;
    if (_isList) {
        [self.collectionView setCollectionViewLayout:self.listLayout animated:YES];
        self.btnStyle.image = [UIImage imageNamed:@"grid"];
    }
    else{
        [self.collectionView setCollectionViewLayout:self.gridLayout animated:YES];
        self.btnStyle.image = [UIImage imageNamed:@"list"];
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.view.frame.size.width - 10)/3.0;
    DisplayModel *model = self.dataSource[indexPath.row];
    if (_isList) {
        self.collectionView.backgroundColor = [UIColor grayColor];
        return CGSizeMake(self.view.frame.size.width, model.cellFrame.listCellHeight);
    }
    self.collectionView.backgroundColor = [UIColor whiteColor];
    return CGSizeMake(width, model.cellFrame.cellHeight);
}

-(UICollectionViewFlowLayout *)gridLayout
{
    if (!_gridLayout) {
        _gridLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (self.view.frame.size.width - 10)/3.0;
        _gridLayout.itemSize = CGSizeMake(width, width+100);
        _gridLayout.minimumLineSpacing = 5;
        _gridLayout.minimumInteritemSpacing = 5;
        _gridLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _gridLayout;
}

-(UICollectionViewFlowLayout *)listLayout
{
    if (!_listLayout) {
        _listLayout = [[UICollectionViewFlowLayout alloc] init];
        _listLayout.itemSize = CGSizeMake(self.view.frame.size.width, 190);
        _listLayout.minimumLineSpacing = 0.5;
        _listLayout.sectionInset = UIEdgeInsetsZero;
    }
    return _listLayout;
}

-(void)ftp
{
    //1.创建NSURLSessionConfiguration
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //配置默认会话的缓存行为
    NSString *cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *cachePath = [cachesDirectory stringByAppendingPathComponent:@"MyCache"];
    
    /**
     iOS需要设置相对路径：~/Library/Caches
     OS X要设置绝对路径
     */
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:16384 diskCapacity:268435456 diskPath:cachePath];
    
    defaultConfiguration.URLCache = cache;
    defaultConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    //2.创建NSURLSession
//    NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];
    
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:nil];
    
    //3.创建NSURLSessionDataTask
    NSURL *url = [NSURL URLWithString:@"ftp://xxx"];
    
    NSURLSessionDataTask *connTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        
        NSString *resStr = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        NSLog(@"======resultStr=====\n%@",resStr);
        NSLog(@"%@", response);
        NSArray *resArray = [resStr componentsSeparatedByString:@"\r\n"];
        NSLog(@"%@", resArray);
        self.dataSource = [self parseFTPString:resArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    //start with connect
    [connTask resume];
}

-(NSArray<DisplayModel *> *)parseFTPString:(NSArray *)ftpFileArray
{
    NSMutableArray<DisplayModel *> *result = [NSMutableArray array];
    for (NSString *string in ftpFileArray) {
        if ([string isEqualToString:ftpFileArray.lastObject]) {
            continue;
        }
        NSArray *tArr = [string componentsSeparatedByString:@" "];
        DisplayModel *model = [[DisplayModel alloc] init];
        __block NSInteger flag = 1;
        __block NSString *year;
        __block NSString *month;
        __block NSString *day;
        __block NSString *time;
        if ([tArr[0] hasPrefix:@"-"]) {
            model.fileType = FtpFile;
            model.icon = @"file";
        }
        else{
            model.fileType = FtpFoler;
            model.icon = @"folder";
        }
        [tArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *sobj = (NSString *)obj;
            if (idx <= 8) {
                return;
            }
            else if(idx > 8 && idx < tArr.count-1){
                if ([sobj isEqualToString:@" "] || [sobj isEqualToString:@""]) {
                    return ;
                }
                else if (flag == 1) {
                    flag = 2;
                    model.size = sobj;
                    return ;
                }
                else if(flag == 2){
                    flag = 3;
                    month = [self.monthAbbr objectForKey:sobj];
                }
                else if(flag == 3){
                    flag = 4;
                    day = sobj;
                }
                else if(flag == 4){
                    if ([sobj containsString:@":"]) {
                        year = self.currentYear;
                        time = sobj;
                    }
                    else{
                        year = sobj;
                    }
                }
                if (idx == tArr.count-2) {
                    flag = 1;
                    model.time = [NSString stringWithFormat:@"%@/%@/%@", year, month, day];
                }
            }
            else{
                model.title = sobj;
            }
        }];
        [result addObject:model];
    }
    NSLog(@"%@", result);
    return result;
}

-(NSString *)currentYear
{
    if (!_currentYear) {
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:[NSDate date]];
        _currentYear = [NSString stringWithFormat:@"%ld",(long)[components year]];
    }
    return _currentYear;
}

-(NSDictionary *)monthAbbr
{
    if (!_monthAbbr) {
        _monthAbbr = @{
                       @"Jan":@"1",
                       @"Feb":@"2",
                       @"Mar":@"3",
                       @"Apr":@"4",
                       @"May":@"5",
                       @"Jun":@"6",
                       @"Jul":@"7",
                       @"Aug":@"8",
                       @"Sep":@"9",
                       @"Oct":@"10",
                       @"Nov":@"11",
                       @"Dec":@"12",
                       };
    }
    return _monthAbbr;
}

@end
