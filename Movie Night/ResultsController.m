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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"userOne genres: %@\nuserTwo genres: %@", self.movieSuggestions.userOnePreferredGeneres, self.movieSuggestions.userTwoPreferredGeneres);
    
    [self.movieSuggestions prioritizeGenreSelections];
    
    
    
    [self listMovieSuggestions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)listMovieSuggestions{
    
    [self.movieSuggestions extractMovieRecomendationsToBlock:^(NSArray *) {
        
    }];
    self.movieList = [[NSMutableArray alloc] initWithArray: self.movieSuggestions.recommendedMovies];
    [self.tableView reloadData];
    
    
    
}




@end
