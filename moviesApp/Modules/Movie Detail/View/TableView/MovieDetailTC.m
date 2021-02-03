//
//  MovieDetailTC.m
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import "MovieDetailTC.h"
#import "moviesApp-Swift.h"
#import "GetAppConfig.h"

@implementation MovieDetailTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(NSDictionary *)data {
    NSDictionary * appConfig = [GetAppConfig getValusFromAppConfig];
    NSString *url =  [NSString stringWithFormat:@"%@%@",  [appConfig objectForKey:@"imageUrl"], [data objectForKey:@"backdrop_path"]];
    [_backgroundImage online_setThumbnailImageWithPath: url];
    
    _releaseDateLabel.text = [NSString stringWithFormat:@"%@ %@", @"Release:",  [data objectForKey: @"release_date"]];
    _durationLabel.text = [NSString stringWithFormat:@"%@ %@ %@", @"Duration:",  [data objectForKey: @"runtime"], @"min"];
    _ratingLabel.text = [NSString stringWithFormat:@"%@ %@", @"Rating:",  [NSString stringWithFormat:@"%.1f", [[data objectForKey: @"vote_average"] doubleValue]]];
    
}

@end
