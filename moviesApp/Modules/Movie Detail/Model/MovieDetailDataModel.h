//
//  MovieDetailDataModel.h
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import <Foundation/Foundation.h>
#import "MovieDetailRequest.h"w

NS_ASSUME_NONNULL_BEGIN

@class MovieDetailDataModel;
@protocol MovieDetailDelegate <NSObject>
    - (void)didReceiveMovieDetail:(NSDictionary *)response;
@end

@interface MovieDetailDataModel : NSObject {
}
    @property (nonatomic, weak) id <MovieDetailDelegate> delegate;

- (void)getMovieDetail:(NSInteger)movieId;

@end

NS_ASSUME_NONNULL_END
