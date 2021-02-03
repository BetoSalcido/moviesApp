//
//  MovieDetailRequest.h
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"
#import "GetAppConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailRequest : NSObject

+ (void)requestMovieDetail:(NSDictionary *)data completionHandler:(void (^)(NSDictionary *response, NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
