//
//  MovieDetailRequest.m
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import "MovieDetailRequest.h"

@implementation MovieDetailRequest

+ (void)requestMovieDetail:(NSDictionary *)data completionHandler:(void (^)(NSDictionary * _Nonnull, NSError * _Nonnull))completionHandler {
    NSDictionary * appConfig = [GetAppConfig getValusFromAppConfig];
    if ([data objectForKey: @"movieId"]) {
        NSString * url =  [NSString stringWithFormat:@"%@%@%@%@&language=%@",  [appConfig objectForKey:@"apiUrl"], data[@"movieId"], @"?api_key=", [appConfig objectForKey:@"apiKey"], [data objectForKey:@"language"]];
        
        [RequestManager request: url httpMethod:HttpMethodGet parameters: @{} completionHandler:^(id  _Nonnull response, NSError * _Nonnull error) {
            if(!error ) {
                completionHandler(response, error);
                
            } else {
                NSDictionary *returnData = @{ @"data": @"", @"error": @true };
                completionHandler(returnData, [NSError errorWithDomain: @"https://developers.themoviedb.org" code:500 userInfo:@{NSLocalizedFailureReasonErrorKey: @"The server response is not readable"}]);
            }
        }];
        
    } else {
        NSDictionary *returnData = @{ @"data": @"", @"error": @true };
        completionHandler(returnData, [NSError errorWithDomain: @"https://developers.themoviedb.org" code:403 userInfo:@{NSLocalizedFailureReasonErrorKey: @"Some data is missing"}]);
    }

    
}

@end
