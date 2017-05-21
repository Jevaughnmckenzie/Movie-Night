//
//  MDBClient.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/15/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDBEndpoint.h"

@interface MDBClient : NSObject

@property (nonatomic, strong) MDBEndpoint *endpoint;
@property (nonatomic, strong) NSDictionary *jsonGenresDict;
@property (nonatomic, strong) NSMutableArray *genres;

-(void) fetchGenres: (void (^)(NSArray*))completion;
//-(void) fetchMovieThumbnails;
//-(void) fetchActors;

@end
