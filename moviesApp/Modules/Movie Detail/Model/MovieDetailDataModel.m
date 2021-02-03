//
//  MovieDetailDataModel.m
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import "MovieDetailDataModel.h"

@implementation MovieDetailDataModel
@synthesize delegate;

- (void)getMovieDetail:(NSInteger)movieId {
    NSDictionary * data = @{@"movieId": @(movieId)};
    
    __weak __typeof__(self) weakSelf = self;
    [MovieDetailRequest requestMovieDetail: data completionHandler:^(NSDictionary * _Nonnull response, NSError * _Nonnull error) {
        if(!error) {
            [weakSelf.delegate didReceiveMovieDetail: response];
            
        } else {
            NSDictionary *response = @{ @"data": @"", @"error": @true };
            [weakSelf.delegate didReceiveMovieDetail: response];
        }
    }];
}


@end
