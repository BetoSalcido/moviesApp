//
//  MovieDetailVC.h
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import <UIKit/UIKit.h>
#import "MovieDetailDataModel.h"
#import "MovieDetailTC.h"
#import "MovieDetailHeaderTC.h"
#import "MovieDetailDescriptionTC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailVC : UIViewController <MovieDetailDelegate, UITableViewDelegate, UITableViewDataSource> {
    MovieDetailDataModel *movieDetailDataModel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSUInteger movieId;
@property (nonatomic) NSDictionary * movieDetail;

@end

NS_ASSUME_NONNULL_END
