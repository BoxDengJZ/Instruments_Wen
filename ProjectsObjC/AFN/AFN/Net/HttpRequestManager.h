

#import <Foundation/Foundation.h>




typedef void(^FailureBlock)(NSString *statusCode,NSString *Message);

typedef void (^SuccessBlock)(id response,id data,NSString *Message);

@interface HttpRequestManager : NSObject



#pragma mark -- 查询信息
+ (void)queryInfoParams:(NSDictionary *)params success:(SuccessBlock)success
                failure:(FailureBlock)failure;



+ (void)getProductsParams:(NSDictionary *)params success:(SuccessBlock)success
                  failure:(FailureBlock)failure;


#pragma mark -- 获取商品详情
+ (void)getProductDetailParams:(NSDictionary *)params success:(SuccessBlock)success
                       failure:(FailureBlock)failure;

@end
