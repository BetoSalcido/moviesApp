//
//  MovieDetailHeaderTC.m
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import "MovieDetailHeaderTC.h"

@implementation MovieDetailHeaderTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureCell:(NSString *)title {
    _titleLabel.text = title;
}

@end
