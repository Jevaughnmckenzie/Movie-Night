//
//  MDBMovieSuggestionsCompiler.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "MDBMovieSuggestionsCompiler.h"

@implementation MDBMovieSuggestionsCompiler


- (instancetype)init
{
    self = [super init];
    if (self) {
        _userOnePreferredGeneres = [NSMutableSet new];
        _userTwoPreferredGeneres = [NSMutableSet new];
        _recommendedMovies = [NSMutableArray new];
    }
    return self;
}

/*
 
 give level one preference to genres listed in both genre sets. 
 give level two preference to the other genres listed. 
 
 do the same for actors in both sets
 
 within the level one genre results, seacrch for level one actors, then search for level two actors
 repeat for level two genre results
 
 */

@end
