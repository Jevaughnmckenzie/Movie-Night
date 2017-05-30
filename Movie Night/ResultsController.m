//
//  ResultsController.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/20/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "ResultsController.h"

@interface ResultsController ()

@property (nonatomic) NSMutableArray *movieList;

@end

@implementation ResultsController

static NSString * const reuseIdentifier = @"MovieCell";
static void *tableViewDataContext = &tableViewDataContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"userOne genres: %@\nuserTwo genres: %@", self.movieSuggestions.userOnePreferredGeneres, self.movieSuggestions.userTwoPreferredGeneres);
    
    
    self.movieList = [NSMutableArray new];
    
    [self.movieSuggestions prioritizeGenreSelections];
    
    [self compileMovieRecommendations];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.movieList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDBMovieCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = self.movieList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)compileMovieRecommendations{
    
    
    
    // Connect to the internet to get movie titles for the most prefered GENRES first
    [self.movieSuggestions.levelOneGenres enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        int genreId = [(NSNumber*)obj integerValue];
        
        self.movieSuggestions.endpoint = [MDBEndpoint new];
        [self.movieSuggestions.endpoint setEndpointForMovieListWithGenreId:genreId];
        
        [self.movieSuggestions.apiClient fetchMovies:self.movieSuggestions.endpoint completion:^(NSArray *movieTitles, NSError *error) {
            
            [self.movieList addObjectsFromArray:movieTitles];
            
            NSLog(@"Movie titles: %@", self.movieList);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }];

}


@end
