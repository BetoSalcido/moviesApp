//
//  MovieDetailHeaderTC.h
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailHeaderTC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)configureCell:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
