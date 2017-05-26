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

-(void)setUrl:(NSURL *)url{
    _url = url;
}

-(void)setRequest:(NSURLRequest *)request{
    _request = request;
}

-(NSString*)baseURL{
    return BASIC_BASE_URL;
}

-(NSURLQueryItem*)apiKey{
    return [NSURLQueryItem queryItemWithName:@"api_key" value:API_KEY];
}

-(NSURL*)genreListEndpoint{
    
    self.urlComponents = [NSURLComponents new];
    
    self.urlComponents.scheme = URL_PROTOCOL;
    self.urlComponents.host = self.baseURL;
    self.urlComponents.path = @"/3/genre/movie/list";
    self.urlComponents.queryItems = @[self.apiKey];
    
    [self setUrl:self.urlComponents.URL];
    [self setRequest:[NSURLRequest requestWithURL:self.url]];
    
    return self.urlComponents.URL;
    
    
    
}

@end
