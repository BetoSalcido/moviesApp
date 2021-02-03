//
//  RequestManager.h
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Success handler
typedef void (^SuccessHandler)(id response, BOOL success);
/// Failure handler
typedef void (^FailureHandler)(NSError *error);
///Http methods
typedef NSString * HttpMethod;
static NSString * const HttpMethodGet = @"GET";
static NSString * const HttpMethodPost = @"POST";

@interface RequestManager : NSObject

+ (void)request:(NSString *)url httpMethod:(HttpMethod)httpMethod parameters:(NSDictionary *)parameters completionHandler:(void (^)(id response, NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
