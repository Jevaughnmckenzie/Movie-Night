//
//  MDBMovieSuggestionsCompiler.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDBClient.h"
#import "MDBEndpoint.h"

@interface MDBMovieSuggestionsCompiler : NSObject

@property (nonatomic) NSMutableDictionary *userOnePreferredGeneres;
@property (nonatomic) NSMutableDictionary *userTwoPreferredGeneres;
@property (nonatomic) NSMutableDictionary *levelOneGenres;
@property (nonatomic) NSMutableDictionary *levelTwoGenres;
@property (nonatomic) NSMutableArray *recommendedMovies;

@property (nonatomic) MDBClient *apiClient;
@property (nonatomic) MDBEndpoint *endpoint;


-(void)prioritizeGenreSelections;
//-(NSArray*)compileMovieRecommendations;
//-(void)extractMovieRecomendationsToBlock:(void(^)(NSArray*))movieListHolder;



@end
