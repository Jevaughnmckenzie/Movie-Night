//
//  ResultsController.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/20/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "ResultsController.h"

/*
 Overall Fucntion:
 ----------------
 create a list of movies for specific gerne
 create list of movies for a given actor
 
 once list of movies by actor and genre are formed, compare them to find intersections
 
 add those intersections to the movieList property and display them
 
 */


/*
 
 Possible implementation:
 create key-value observer for 
 
 */

@interface ResultsController ()

@property (nonatomic) NSMutableSet *movieList;
@property (nonatomic) __block NSMutableDictionary *moviesByLevelOneActors;
@property (nonatomic) __block NSMutableDictionary *moviesByLevelOneGenres;

@property (nonatomic) __block int levelOneActorMovieIterationCount;
@property (nonatomic) __block int levelOneGenreMovieIterationCount;

@property (nonatomic) __block BOOL moviesByActorsAreLoaded;
@property (nonatomic) __block BOOL moviesByGenreAreLoaded;

@end

@implementation ResultsController

static NSString * const reuseIdentifier = @"MovieCell";
static int const maxNumberOfPagesToLoad = 3;
static void *tableViewDataContext = &tableViewDataContext;


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"userOne genres: %@\nuserTwo genres: %@", self.movieSuggestions.userOnePreferredGeneres, self.movieSuggestions.userTwoPreferredGeneres);
    
    
    self.movieList = [NSMutableSet new];
    NSMutableDictionary *moviesByLevelOneActors = [NSMutableDictionary dictionary];
    
    self.moviesByLevelOneGenres = [NSMutableDictionary new];
    self.moviesByLevelOneActors = [NSMutableDictionary new];
    
    [self.movieSuggestions prioritizeGenreSelections];
    [self.movieSuggestions prioritizeActorSelections];
    
//    [self compileMovieRecommendations];
    [self getMoviesByGenre];
    [self getMoviesByActor];
    
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
    
    cell.textLabel.text = self.movieList.allObjects[indexPath.row];
    
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



//-(void)compileMovieRecommendations{
//    
//    
//    
//    // Connect to the internet to get movie titles for the most prefered GENRES first
//    [self.movieSuggestions.levelOneGenres enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        
//        int genreId = [obj integerValue];
//        
//        self.movieSuggestions.endpoint = [MDBEndpoint new];
//        
//        for (int i = 1 ; i <= maxNumberOfPagesToLoad ; i++){
//            
//            
//            [self.movieSuggestions.endpoint setEndpointForMovieListWithGenreId:genreId andJSONPage:i];
//            
//            [self.movieSuggestions.apiClient fetchMoviesByGenre:self.movieSuggestions.endpoint completion:^(NSDictionary *movieInfo, NSError *error) {
//                
//                [self.movieList addObjectsFromArray:movieInfo.allKeys];
//                
//                NSLog(@"Movie titles: %@", self.movieList);
//                if (i == maxNumberOfPagesToLoad){
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.tableView reloadData];
//                    });
//                }
//            }];
//        }
//    }];
//
//}

-(void)compileMovieRecommendations{
    
    
    
}

-(void)getMoviesByGenre{
    
    self.levelOneGenreMovieIterationCount = 0;
    
    // Connect to the internet to get movie titles for the most prefered GENRES first
    [self.movieSuggestions.levelOneGenres enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull genre, id  _Nonnull genreID, BOOL * _Nonnull stop) {
        
        int genreId = [genreID integerValue];
        
        self.movieSuggestions.endpoint = [MDBEndpoint new];
        
        for (int i = 1 ; i <= maxNumberOfPagesToLoad ; i++){
            
            [self.movieSuggestions.endpoint setEndpointForMovieListWithGenreId:genreId andJSONPage:i];
            
            [self.movieSuggestions.apiClient fetchMoviesByGenre:self.movieSuggestions.endpoint completion:^(NSDictionary *movieInfo, NSError *error) {
                
                
                
                // rounding up the first 5 pages of results from the network
                //request into a dictionary to be enumerated over
                
                [self.moviesByLevelOneGenres addEntriesFromDictionary:movieInfo];
                
                self.levelOneGenreMovieIterationCount++;
                
                if (self.levelOneGenreMovieIterationCount == ((int)self.movieSuggestions.levelOneActors.count * maxNumberOfPagesToLoad)){
                    self.moviesByGenreAreLoaded = YES;
                    NSLog(@"getMoviesByGenre prints: %@", self.moviesByLevelOneGenres);
                } else{
                    self.moviesByGenreAreLoaded = NO;
                }
                
            }];
        }
    }];
}

-(void)getMoviesByActor{
    self.levelOneActorMovieIterationCount = 0;
    
    // Connect to the internet to get movie titles for the most prefered GENRES first
    [self.movieSuggestions.levelOneActors enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull actor, id  _Nonnull actorID, BOOL * _Nonnull stop) {
        
        int actorIdInt = [actorID integerValue];
        
        self.movieSuggestions.endpoint = [MDBEndpoint new];
        
        for (int i = 1 ; i <= maxNumberOfPagesToLoad ; i++){
            
            [self.movieSuggestions.endpoint setEndpointForMovieListWithActorId:actorIdInt andJSONPage:i];
            
            [self.movieSuggestions.apiClient fetchMoviesByActor:self.movieSuggestions.endpoint completion:^(NSDictionary *movieInfo, NSError *error) {
                
                //FIXME: implement error handling
                
                // rounding up the first 5 pages of results from the network
                //request into a dictionary to be enumerated over
                
                [self.moviesByLevelOneActors addEntriesFromDictionary:movieInfo];
                
                self.levelOneActorMovieIterationCount++;
                
                if (self.levelOneActorMovieIterationCount == ((int)self.movieSuggestions.levelOneActors.count * maxNumberOfPagesToLoad)){
                    self.moviesByActorsAreLoaded = YES;
                    NSLog(@"getMoviesByActor prints: %@", self.moviesByLevelOneActors);
                } else{
                    self.moviesByActorsAreLoaded = NO;
                }
                
            }];
        }
    }];
}


//-(void)compileRecommendedMoviesByEnumeratingMoviesByGenres:(NSDictionary*)moviesByGenres andMoviesByActors:(NSDictionary*)moviesByActors{
//    
//    
//        [moviesByGenres enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull movieTitle, id  _Nonnull movieID, BOOL * _Nonnull stop) {
//
//            [moviesByActors enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull actorName, id  _Nonnull movieID, BOOL * _Nonnull stop) {
//                if ([movieID isEqual:movieID]){
//                    [self.movieSuggestions.levelOneMovieRecommendation setValue:movieID forKey:movieTitle];
//                }
//
//                [self.movieList addObjectsFromArray:self.movieSuggestions.levelOneMovieRecommendation.allKeys];
//
//                NSLog(@"Movie titles: %@", self.movieList);
//                if (i == maxNumberOfPagesToLoad){
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.tableView reloadData];
//                    });
//                }
//            }];
//            
//        }];
//    
//}

/*
 
 fetch list of relavent movies by genres
 fetch list of relevant actors
 
 
 compare the IDs of movies an actor is "known_for" (results.known_for.id) and IDs of movies in genreList (results.id)
    for each applicable genre:
        enumerate over each movie,
        check evaluate if an actor has the id for that movie in its "known_for" array
        if yes, add that movie to a set to be displayed.
        if no, move on to the next movie
    repeat for each selected actor
 
 display movies in four tiers:
 level one genre with level one actors
 level one gernre with level two actor
 level two genre with level one actors
 level two gernes with level two actors
 
 */

@end
