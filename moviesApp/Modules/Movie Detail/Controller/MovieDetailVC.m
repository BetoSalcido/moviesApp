//
//  MovieDetailVC.m
//  moviesApp
//
//  Created by Beto Salcido on 02/02/21.
//

#import "MovieDetailVC.h"
#import "moviesApp-Swift.h"

@interface MovieDetailVC ()

@end

@implementation MovieDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLoadingViewWithTransparent:true];
    [self configView];
    [self configModel];
    [self configTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [movieDetailDataModel getMovieDetail: _dataToSend];
}

- (void)configTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
}

- (void)configModel {
    movieDetailDataModel = [[MovieDetailDataModel alloc ] init];
    movieDetailDataModel.delegate = self;
}

- (void)configView {
    _dataToSend = @{@"movieId": @(_movieId), @"language": @"en"};
    _languageButton.title = @"ES";
    _languageButton.target = self;
    _languageButton.action = @selector(languageButtonPressed:);
}

- (IBAction)languageButtonPressed:(UIBarButtonItem*)btn {
    [self showLoadingViewWithTransparent:true];
    if ([[_dataToSend objectForKey:@"language"] isEqualToString:@"en"]) {
        _dataToSend = @{@"movieId": @(_movieId), @"language": @"es"};
        _languageButton.title = @"EN";
    } else {
        _dataToSend = @{@"movieId": @(_movieId), @"language": @"en"};
        _languageButton.title = @"ES";
    }
    [movieDetailDataModel getMovieDetail: _dataToSend];
}

#pragma mark - UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MovieDetailHeaderTC *cell  = [_tableView dequeueReusableCellWithIdentifier: @"MovieDetailHeader"];
        [cell configureCell: [_movieDetail objectForKey:@"title"]];
        return cell;
        
    } else if (indexPath.row == 1) {
        MovieDetailTC *cell  = [_tableView dequeueReusableCellWithIdentifier: @"MovieDetail"];
        [cell configureCell: _movieDetail];
        return cell;
        
    } else {
        MovieDetailDescriptionTC *cell  = [_tableView dequeueReusableCellWithIdentifier: @"MovieDetailDescription"];
        [cell configureCell:_movieDetail];
        return cell;
    }
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 112;
    } else if (indexPath.row == 1) {
        return 210;
    } else {
        return UITableViewAutomaticDimension;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 112;
    } else if (indexPath.row == 1) {
        return 210;
    } else {
        return UITableViewAutomaticDimension;
    }
}


#pragma mark - MovieDetailDelegate
- (void)didReceiveMovieDetail:(nonnull NSDictionary *)response {
    [self removeLoadingView];
    if ([[response objectForKey:@"error"] boolValue]) {
        __weak __typeof__(self) weakSelf = self;
        [self showSimpleAlertControllerWithTitle: @"Lo sentimos" message: @"Ocurrió un problema inesperado. Por favor, intenta de nuevo." actionTitle: @"Cerrar" actionBlock: ^(UIAlertAction * _Nonnull action) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        
    } else {
        _movieDetail = response;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_tableView setHidden: false];
            [self->_tableView reloadData];
        });

    }
}

@end
