//
//  MDBMovieSuggestionsCompiler.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDBMovieSuggestionsCompiler : NSObject

@property (nonatomic) NSMutableSet *userOnePreferredGeneres;
@property (nonatomic) NSMutableSet *userTwoPreferredGeneres;
@property (nonatomic) NSMutableArray *recommendedMovies;

//-(void)compileMovieRecommendations;


@end
