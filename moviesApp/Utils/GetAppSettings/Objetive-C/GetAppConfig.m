//
//  GetAppConfig.m
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import "GetAppConfig.h"

@implementation GetAppConfig

+ (NSDictionary*)getValusFromAppConfig {
    NSString* apiConfig = [[NSBundle mainBundle] pathForResource:@"AppConfig" ofType:@"plist"];
    NSDictionary *apiConfigDict = [NSDictionary dictionaryWithContentsOfFile:apiConfig];
    return apiConfigDict;
}

@end
