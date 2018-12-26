
#import "HttpRequestManager.h"

#import "NetManager.h"


#import <AFNetworking/AFNetworking.h>

@implementation HttpRequestManager

#pragma mark --  baseRequest

/**
 @param msg_type 请求type
 @param version 请求版本
 @param dataDict 请求数据
 @param encrypt 是否加密
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)baseNetWorkType:(NSString *)msg_type
                version:(NSString *)version
               dataDict:(NSDictionary *)dataDict
              isEncrypt:(BOOL)encrypt
                success:(SuccessBlock)success
                failure:(FailureBlock)failure
{

    //NSLog(@"请求的数据是：%@",dataDict);
    AFHTTPSessionManager *manager = [ NetManager shareAFManager];
    [manager.requestSerializer setValue:msg_type forHTTPHeaderField:@"X-METHOD"];
    
    //设置请求体数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *dataStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dataDict options:0 error:nil] encoding:NSUTF8StringEncoding];
    
    if (encrypt) {
        NSString *str = dataStr;
        NSData *encodeData = [str dataUsingEncoding:NSUTF8StringEncoding];
        dataStr = [encodeData base64EncodedStringWithOptions:0];
    }
    
    //NSLog(@"请求的base64数据是：%@",dataStr);
    //  NSLog(@"digest是：%@",[dataDict dicMD5_Base64]);
    
    [dict setValue:dataStr forKey:@"data"];
    [dict setValue:version forKey:@"version"];
   // [dict setValue: [dataDict MD5_Base64] forKey:@"digest"];
    
    
    [manager POST: @"http://www.baidu.com" parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDict = (NSDictionary *)responseObject;
       // NSLog(@"返回数据的是:%@",[responseDict yy_modelToJSONString]);

        NSString *responseMessage = [responseDict valueForKey:@"msg"];
        
        NSString *statusCode = [responseDict valueForKey:@"code"];
        
        NSString *responseData = [responseDict valueForKey:@"data"];
     
        if ([statusCode isEqualToString: @"S200"]) {
            success(responseDict,responseData,responseMessage);
        }  else{
            failure(statusCode,responseMessage);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"-1", @"6666666");
    }];
}






/******************************* 查询信息 *****************************/
#pragma mark -- 查询信息
+ (void)queryInfoParams:(NSDictionary *)params success:(SuccessBlock)success
                    failure:(FailureBlock)failure{
    
    [ HttpRequestManager baseNetWorkType:@"queryInfo" version: @"2.0" dataDict:params isEncrypt:NO success:^(id response, id data, NSString *Message) {
        success(response,data,Message);
        
    } failure:^(NSString *statusCode, NSString *Message) {
        failure(statusCode,Message);
    }];
}






#pragma mark -- 获取所有商品
+ (void)getProductsParams:(NSDictionary *)params success:(SuccessBlock)success
                    failure:(FailureBlock)failure{
    
    [ HttpRequestManager baseNetWorkType:@"getProducts" version:@"2.0" dataDict:params isEncrypt:NO success:^(id response, id data, NSString *Message) {
        success(response,data,Message);
        
    } failure:^(NSString *statusCode, NSString *Message) {
        failure(statusCode,Message);
    }];
}





#pragma mark -- 获取商品详情
+ (void)getProductDetailParams:(NSDictionary *)params success:(SuccessBlock)success
                             failure:(FailureBlock)failure{
    
    [ HttpRequestManager baseNetWorkType:@"getProductDetail" version:@"2.0" dataDict:params isEncrypt:NO success:^(id response, id data, NSString *Message) {
        success(response,data,Message);
        
    } failure:^(NSString *statusCode, NSString *Message) {
        failure(statusCode,Message);
    }];
}




@end

