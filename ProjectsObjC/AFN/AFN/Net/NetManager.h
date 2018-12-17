//
//   AFManager.h
//  ZTOBestSeller
//
//  Created by   on 2017/11/28.
//  Copyright © 2017年 ZTO. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AFHTTPSessionManager;

@interface NetManager : NSObject



+ (AFHTTPSessionManager *)shareAFManager;



@end
