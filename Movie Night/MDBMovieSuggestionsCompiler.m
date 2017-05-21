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
        _recommendedMovies = [NSMutableArray array];
    }
    return self;
}

@end
