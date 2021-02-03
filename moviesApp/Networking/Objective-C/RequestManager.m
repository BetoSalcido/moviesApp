//
//  RequestManager.m
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import "RequestManager.h"

@implementation RequestManager

+ (void)request:(NSString *)url httpMethod:(HttpMethod)httpMethod parameters:(NSDictionary *)parameters completionHandler:(void (^)(id response, NSError *error))completionHandler {
    NSURL *endPointURL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:endPointURL];
    request.timeoutInterval = 45.0;
    [request setHTTPMethod: httpMethod];
    
    if ([httpMethod isEqualToString: HttpMethodPost]) {
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]];
    }
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        if (!completionHandler) {
            NSLog(@"No completionHandler: provided for request: %@", url);
            return;
        }
        
        if (connectionError) {
            NSLog(@"Connection Error: %@", connectionError);
            completionHandler(nil, connectionError);
            return;
        }
        
        if (!data) {
            NSLog(@"Parameters: %@\nRequest for URL: %@", parameters, request.URL.absoluteString);
            completionHandler(nil, [NSError errorWithDomain: @"https://developers.themoviedb.org" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Unable to get response from server."}]);
            return;
        }
        
        NSError *jsonError = nil;
        id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        NSLog(@"RESPONSE \n%@\n", responseObject);
        if (jsonError) {
            completionHandler(nil, [NSError errorWithDomain: @"https://developers.themoviedb.org" code:0 userInfo:@{NSLocalizedDescriptionKey: @"The server response is not readable"}]);
            return;
        }
        completionHandler(responseObject, nil);
    }];
    
    [task resume];
    
}

@end
