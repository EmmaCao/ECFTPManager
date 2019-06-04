//
//  ConnectFtp.m
//  ECFTPManager
//
//  Created by Emma on 2019/6/4.
//  Copyright © 2019 Emma. All rights reserved.
//

#import "ConnectFtp.h"
#import "FtpModel.h"

@interface ConnectFtp()<NSURLSessionDelegate>

@property (nonatomic, strong) NSDictionary *monthAbbr;
@property (nonatomic, strong) NSString *currentYear;

@end

@implementation ConnectFtp

-(void)connectFtp:(NSString *)serverName
          success:(void (^)(NSArray<FtpModel *> *resArr))success
{
    if (![serverName containsString:@"ftp"]) {
        serverName = NSStringFormat(@"ftp://%@", serverName);
    }
    
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
    NSURL *url = [NSURL URLWithString:serverName];
    
    NSLog(@"%@", serverName);
    
    NSURLSessionDataTask *connTask = [defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        
        NSString *resStr = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        NSLog(@"======resultStr=====\n%@",resStr);
        NSLog(@"%@", response);
        NSArray *resArray = [resStr componentsSeparatedByString:@"\r\n"];
        NSLog(@"%@", resArray);
        if (success) {
            success([self parseFTPString:resArray]);
        }
    }];
    //start with connect
    [connTask resume];
}

-(NSArray<FtpModel *> *)parseFTPString:(NSArray *)ftpFileArray
{
    NSMutableArray<FtpModel *> *result = [NSMutableArray array];
    for (NSString *string in ftpFileArray) {
        if ([string isEqualToString:ftpFileArray.lastObject]) {
            continue;
        }
        NSArray *tArr = [string componentsSeparatedByString:@" "];
        FtpModel *model = [[FtpModel alloc] init];
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
