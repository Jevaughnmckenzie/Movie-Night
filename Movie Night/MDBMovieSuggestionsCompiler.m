//
//  MDBMovieSuggestionsCompiler.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "MDBMovieSuggestionsCompiler.h"

@implementation MDBMovieSuggestionsCompiler

static int const maxNumberOfPagesToLoad = 5;
/*
 
 give level one preference to genres listed in both genre sets. 
 give level two preference to the other genres listed. 
 
 do the same for actors in both sets
 
 within the level one genre results, seacrch for level one actors, then search for level two actors
 repeat for level two genre results
 
 */

-(instancetype)init{
    self = [super init];
    
    if (self){
        
        _recommendedMovies = [NSMutableArray array];
        _apiClient = [MDBClient new];
        _levelOneMovieRecommendation = [NSMutableDictionary new];
        
    }
    
    return self;
}


-(void)prioritizeGenreSelections{
    
    if ((self.userOnePreferredGeneres.count >= 1) && (self.userTwoPreferredGeneres.count >= 1)) {
        
        NSMutableDictionary *mainUserGenreSelection = [NSMutableDictionary new];
        NSMutableDictionary *secondaryUserGenreSelection = [NSMutableDictionary new];
        
        self.levelOneGenres = [NSMutableDictionary new];
        self.levelTwoGenres = [NSMutableDictionary new];
        
        if (self.userOnePreferredGeneres.count >= self.userTwoPreferredGeneres.count){
            mainUserGenreSelection = self.userOnePreferredGeneres;
            secondaryUserGenreSelection = self.userTwoPreferredGeneres;
        } else {
            mainUserGenreSelection = self.userTwoPreferredGeneres;
            secondaryUserGenreSelection = self.userOnePreferredGeneres;
        }
        
        [mainUserGenreSelection enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            // Check to see if the two dictionaries have mutual key-value pairs
            if ([secondaryUserGenreSelection valueForKey:key]){
                [self.levelOneGenres setValue:obj forKey:key];
            }else {
                [self.levelTwoGenres setValue:obj forKey:key];
            }
        }];
        
        // Drians any extra genres that were not already filtered from the 'secondaryUserGenreSelection' dictionary into the levelTwoGenres dictionary
        for (int i = 0; i < secondaryUserGenreSelection.count; i++){
            
            NSString *key = secondaryUserGenreSelection.allKeys[i];
            
            if (![self.levelOneGenres valueForKey:secondaryUserGenreSelection.allKeys[i]]){
                [self.levelTwoGenres setValue:[secondaryUserGenreSelection valueForKey:key] forKey:key];
            }
        }
        
        
    }
//    NSLog(@"Level one genres: %@\nLevel Two genres: %@", self.levelOneGenres, self.levelTwoGenres);
}

-(void)prioritizeActorSelections{
    
    if ((self.userOnePreferredActors.count >= 1) && (self.userTwoPreferredActors.count >= 1)) {
        
        NSMutableDictionary *mainUserActorSelection = [NSMutableDictionary new];
        NSMutableDictionary *secondaryUserActorSelection = [NSMutableDictionary new];
        
        self.levelOneActors = [NSMutableDictionary new];
        self.levelTwoActors = [NSMutableDictionary new];
        
        if (self.userOnePreferredActors.count >= self.userTwoPreferredGeneres.count){
            mainUserActorSelection = self.userOnePreferredActors;
            secondaryUserActorSelection = self.userTwoPreferredActors;
        } else {
            mainUserActorSelection = self.userTwoPreferredActors;
            secondaryUserActorSelection = self.userOnePreferredActors;
        }
        
        [mainUserActorSelection enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            // Check to see if the two dictionaries have mutual key-value pairs
            if ([secondaryUserActorSelection valueForKey:key]){
                [self.levelOneActors setValue:obj forKey:key];
            }else {
                [self.levelTwoActors setValue:obj forKey:key];
            }
        }];
        
        // Drians any extra genres that were not already filtered from the 'secondaryUserGenreSelection' dictionary into the levelTwoGenres dictionary
        for (int i = 0; i < secondaryUserActorSelection.count; i++){
            
            NSString *key = secondaryUserActorSelection.allKeys[i];
            
            if (![self.levelOneActors valueForKey:secondaryUserActorSelection.allKeys[i]]){
                [self.levelTwoActors setValue:[secondaryUserActorSelection valueForKey:key] forKey:key];
            }
        }
        
        
    }
//    NSLog(@"Level one actors: %@\nLevel Two actors: %@", self.levelOneActors, self.levelTwoActors);
}




@end
