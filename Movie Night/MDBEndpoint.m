//
//  MDBEndpoint.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/17/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "MDBEndpoint.h"


@implementation MDBEndpoint
static NSString *const URL_PROTOCOL = @"https";
static NSString *const BASIC_BASE_URL = @"api.themoviedb.org";
static NSString *const API_KEY = @"6fceaf9e1e4b8cd45f44340c8798a4b1";


-(NSString*)baseURL{
    return BASIC_BASE_URL;
}


-(NSURLQueryItem*)apiKey{
    return [NSURLQueryItem queryItemWithName:@"api_key" value:API_KEY];
}

-(NSURL*)genreListEndpoint{
    
    NSURLComponents *urlComponents = [NSURLComponents new];
    
    urlComponents.scheme = URL_PROTOCOL;
    urlComponents.host = self.baseURL;
    urlComponents.path = @"/3/genre/movie/list";
    urlComponents.queryItems = @[self.apiKey];
    
    return urlComponents.URL;
    
}

@end
