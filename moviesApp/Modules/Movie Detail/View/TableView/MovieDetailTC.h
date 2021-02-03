//
//  MovieDetailTC.h
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailTC : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

- (void)configureCell:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
