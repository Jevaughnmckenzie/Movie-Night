//
//  MDBMovieSuggestionsCompiler.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "MDBMovieSuggestionsCompiler.h"

@implementation MDBMovieSuggestionsCompiler

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
    NSLog(@"Level one genres: %@\nLevel Two genres: %@", self.levelOneGenres, self.levelTwoGenres);
}





@end
