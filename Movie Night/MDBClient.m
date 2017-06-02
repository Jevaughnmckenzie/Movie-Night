//
//  MDBClient.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/15/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "MDBClient.h"

@implementation MDBClient
NSString * const MDBNetworkingErrorDomain = @"com.jevaughnmckenzie.MovieNight.NetworkingError";
const int MissingHTTPResponseError = 10;
const int UnexpectedResponseError = 20;
const int InvalidAPIKey = 30;
const int ResourceNotFound = 40;



-(instancetype)init{
    self = [super init];
    
    if (self){
        _endpoint = [MDBEndpoint new];
    }
    
    return self;
}

-(NSURLSessionDataTask*)jsonTaskWithRequest:(NSURLRequest*)urlRequest completion:(void(^)(NSDictionary*, NSHTTPURLResponse*, NSError*))completion{
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                                                if (HTTPResponse == nil){
                                                    
                                                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString localizedStringWithFormat:@"Missing HTTP Response"] forKey:NSLocalizedDescriptionKey];
                                                    
                                                    NSError *error = [NSError errorWithDomain: MDBNetworkingErrorDomain code:MissingHTTPResponseError userInfo:userInfo];
                                                    
                                                    completion(nil, nil, error);
                                                    return;
                                                }
                                                
                                                if (data == nil) {
                                                    completion(nil, HTTPResponse, error);
                                                    return;
                                                } else {
//                                                    switch (HTTPResponse.statusCode) {
//                                                        case 200:
                                                            @try {
                                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                                completion(json, HTTPResponse, nil);
                                                            } @catch (NSException *exception) {
                                                                NSLog(@"Exception thrown: %@", exception);
                                                            } @finally {
                                                                return;
                                                            }
//                                                            break;
                                                    
//                                                        case 401:
//                                                            // Invalid API Key
//                                                            @try {
//                                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//                                                                completion(json, HTTPResponse, nil);
//                                                            } @catch (NSError *error) {
//                                                                completion(nil, HTTPResponse, error);
//                                                            } @catch (NSException *exception) {
//                                                                NSLog(@"Exception thrown: %@", exception);
//                                                            } @finally {
//                                                                return;
//                                                            }
//                                                            break;
//                                                        
//                                                        case 404:
//                                                            @try {
//                                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//                                                                completion(json, HTTPResponse, nil);
//                                                            } @catch (NSError *error) {
//                                                                completion(nil, HTTPResponse, error);
//                                                            } @catch (NSException *exception) {
//                                                                NSLog(@"Exception thrown: %@", exception);
//                                                            } @finally {
//                                                                return;
//                                                            }
//                                                            break;
//                                                            
//                                                        default:
//                                                            NSLog(@"Recived HTTP response: %li, which was not handled.", (long)HTTPResponse.statusCode);
//                                                            break;
//                                                    }
                                                }
                                            }];
    
    return task;
}

-(void)fetch:(MDBEndpoint*)endpoint parse:(void(^)(NSDictionary*, NSError*))jsonData {
    NSURLRequest *request = endpoint.request;
    NSURLSessionDataTask *task = [self jsonTaskWithRequest:request completion:^(NSDictionary *json,
                                                                                NSHTTPURLResponse *response,
                                                                                NSError *error) {
        
        if (json == nil) {
            NSLog(@"The network request did not deliver the JSON correctly");
            NSLog(@"Error message: %@", error);
            return;
        } else if ((response.statusCode == 401) || (response.statusCode == 404)){
            
            if (response.statusCode == 401) {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString localizedStringWithFormat:@"Incorrect or invalid API key"] forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:MDBNetworkingErrorDomain code:InvalidAPIKey userInfo:userInfo];
            } else if (response.statusCode == 404){
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString localizedStringWithFormat:@"Invalid URL"] forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:MDBNetworkingErrorDomain code:ResourceNotFound userInfo:userInfo];
            }
            
            NSLog(@"%@ at: %@", [json valueForKey:@"status_message"], endpoint.url);
        }
        
           jsonData(json, error);
        
        
    }];
    
    [task resume];
}

+(void)displayAlert{
}

-(void) fetchGenres:(MDBEndpoint*)genres completion:(void (^)(NSDictionary*, NSError*))completion{
    
    [self fetch:genres parse:^void(NSDictionary *genresJSON, NSError *error) {
        NSArray *genreKey = [genresJSON valueForKeyPath:@"genres.name"];
        NSArray *genreIDValue = [genresJSON valueForKeyPath:@"genres.id"];
        
        NSDictionary *genres = [NSDictionary dictionaryWithObjects:genreIDValue forKeys:genreKey];
        
        completion(genres, error);
    }];
}

-(void) fetchActors:(MDBEndpoint*)actors completion:(void (^)(NSDictionary*, NSError*))completion{
    
    [self fetch:actors parse:^(NSDictionary *actorsJSON, NSError *error) {
        NSArray *actorKey = [actorsJSON valueForKeyPath:@"results.name"];
        NSArray *actorIDValue = [actorsJSON valueForKeyPath:@"results.id"];
        NSArray *movieRoles = [actorsJSON valueForKeyPath:@"results.known_for.id"];
        
        
        NSDictionary *actors = [NSDictionary dictionaryWithObjects:actorIDValue forKeys:actorKey];

        completion(actors, error);
    }];
    
}

-(void) fetchMoviesByGenre:(MDBEndpoint*)movies completion:(void (^)(NSDictionary*, NSError*))completion{

    [self fetch:movies parse:^(NSDictionary *moviesJSON, NSError *error) {
    
        NSArray *movieTitles = [moviesJSON valueForKeyPath:@"results.original_title"];
        NSArray *movieIDs = [moviesJSON valueForKeyPath:@"results.id"];
        
        NSDictionary *movieInfo = [NSDictionary dictionaryWithObjects:movieIDs forKeys:movieTitles];
        
//        NSLog(@"Movie Titles and IDs: %@", movieInfo);
        
        //FIXME: Use movieInfo in the the completion block so it can be parsed and enumerated over later.
        completion(movieInfo, error);
    }];
    
}

-(void)fetchMoviesByActor:(MDBEndpoint*)actorMovieCredits completion:(void (^)(NSDictionary*, NSError*))completion{
    
    [self fetch:actorMovieCredits parse:^(NSDictionary *actorMovieCreditsJSON, NSError *error){
        
        NSArray *movieTitles = [actorMovieCreditsJSON valueForKeyPath:@"cast.original_title"];
        NSArray *movieIDs = [actorMovieCreditsJSON valueForKeyPath:@"cast.id"];
        
        NSDictionary *movieInfo = [NSDictionary dictionaryWithObjects:movieIDs forKeys:movieTitles];
        
        NSLog(@"Movie Titles and IDs: %@", movieInfo);
        
        //FIXME: Use movieInfo in the the completion block so it can be parsed and enumerated over later.
        completion(movieInfo, error);
        
    }];
    
}


@end
