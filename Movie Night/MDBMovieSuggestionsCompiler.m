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


-(void)prioritizeGenreSelections{
    
    if ((self.userOnePreferredGeneres.count >= 1) && (self.userTwoPreferredGeneres.count >= 1)) {
        
        NSSet *mainUserGenreSelection = [NSMutableSet new];
        NSSet *secondaryUserGenreSelection = [NSMutableSet new];
        
        self.levelOneGenres = [NSMutableSet set];
        self.levelTwoGenres = [NSMutableSet set];
        
        if (self.userOnePreferredGeneres.count >= self.userTwoPreferredGeneres.count){
            mainUserGenreSelection = self.userOnePreferredGeneres;
            secondaryUserGenreSelection = self.userTwoPreferredGeneres;
        } else {
            mainUserGenreSelection = self.userTwoPreferredGeneres;
            secondaryUserGenreSelection = self.userOnePreferredGeneres;
        }
        
        [mainUserGenreSelection enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([secondaryUserGenreSelection member:obj]){
                NSString *mutualObject = [[NSString alloc]initWithString:obj];
                [self.levelOneGenres addObject:mutualObject];
            }
            
            if (![self.levelOneGenres containsObject:obj]) {
                [self.levelTwoGenres addObject:obj];
            }
            
        }];
        
        for (int i = 0; i < secondaryUserGenreSelection.count; i++){
            if (![self.levelOneGenres containsObject:secondaryUserGenreSelection.allObjects[i]]){
                [self.levelTwoGenres addObject:secondaryUserGenreSelection.allObjects[i]];
            }
        }
        
        
    }
    NSLog(@"Level one genres: %@\nLevel Two genres: %@", self.levelOneGenres, self.levelTwoGenres);
}

@end
