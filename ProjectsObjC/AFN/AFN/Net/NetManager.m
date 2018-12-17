//
//   AFManager.m
//  ZTOBestSeller
//
//  Created by   on 2017/11/28.
//  Copyright © 2017年 ZTO. All rights reserved.
//

#import "NetManager.h"


#import <AFNetworking/AFNetworking.h>

@implementation NetManager

+ (AFHTTPSessionManager *)shareAFManager{
   
    //NSLog(@"请求的数据是：%@",dataDict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval: 40];
    //去除网络返回的null
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    
    
    //Header
    // [manager.requestSerializer setValue: [CacheShared getToken] forHTTPHeaderField:@"X-TOKEN"];
    [manager.requestSerializer setValue: @"123" forHTTPHeaderField:@"X-TOKEN"];
    
    //NSLog(@"token是  ==  %@",access_token);
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"X-PLATFORM"];
    
  //  [manager.requestSerializer setValue:[Utils getUTCTime] forHTTPHeaderField:@"X-TIMESTAMP"];
    
    [manager.requestSerializer setValue: @"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}


@end
