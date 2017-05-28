//
//  MDBMovieSuggestionsCompiler.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDBMovieSuggestionsCompiler : NSObject

@property (nonatomic) NSMutableDictionary *userOnePreferredGeneres;
@property (nonatomic) NSMutableDictionary *userTwoPreferredGeneres;
@property (nonatomic) NSMutableDictionary *levelOneGenres;
@property (nonatomic) NSMutableDictionary *levelTwoGenres;
@property (nonatomic) NSMutableArray *recommendedMovies;

//-(void)compileMovieRecommendations;

-(void)prioritizeGenreSelections;

@end
