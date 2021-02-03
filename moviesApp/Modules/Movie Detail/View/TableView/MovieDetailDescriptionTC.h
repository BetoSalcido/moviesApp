//
//  MovieDetailDescriptionTC.h
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailDescriptionTC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

- (void)configureCell:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
