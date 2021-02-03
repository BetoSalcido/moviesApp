//
//  MovieDetailDescriptionTC.m
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import "MovieDetailDescriptionTC.h"

@implementation MovieDetailDescriptionTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(NSMutableDictionary *)data {
    _descriptionLabel.text = [data objectForKey: @"overview"];
}

@end
