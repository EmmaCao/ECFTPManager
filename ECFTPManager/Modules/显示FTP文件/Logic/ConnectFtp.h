//
//  ConnectFtp.h
//  ECFTPManager
//
//  Created by Emma on 2019/6/4.
//  Copyright © 2019 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FtpModel;

NS_ASSUME_NONNULL_BEGIN

@interface ConnectFtp : NSObject

-(void)connectFtp:(NSString *)serverName
          success:(void (^)(NSArray<FtpModel *> *resArr))success;

@end

NS_ASSUME_NONNULL_END
