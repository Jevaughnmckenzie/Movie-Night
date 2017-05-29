//
//  MDBEndpoint.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/17/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>


// Description: all methods configures the endpoint components to create a url string

@interface MDBEndpoint : NSObject
//Note:
// Think about using a combination of arrays and enums to store and access the url sections in a readible way

@property (nonatomic, readonly) NSString *baseURL;
@property (nonatomic) NSString *path;
@property (nonatomic, readonly) NSMutableDictionary *queryString;
@property (nonatomic, readonly) NSString *urlString;
@property (nonatomic, readonly) NSURLQueryItem *apiKey;
@property (nonatomic) NSURLComponents *urlComponents;
@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) NSURLRequest *request;

-(void)setEndpointForGenreList;
-(void)setEndpointForMovieListWithGenreId:(int)Id;
@end
