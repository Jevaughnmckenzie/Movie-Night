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
    
    _genres = [NSMutableArray array];
    _endpoint = [MDBEndpoint new];
    
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
            
            NSLog(@"%@", [json valueForKey:@"status_message"]);
        }
        
           jsonData(json, error);
        
        
    }];
    
    [task resume];
}

+(void)displayAlert{
}

-(void) fetchGenres:(MDBEndpoint*)endpoint completion:(void (^)(NSArray*, NSError*))completion{
//    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@", self.endpoint.urlString ];
////
//    NSURL *url = [self.endpoint genreListEndpoint];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url
//                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                         timeoutInterval:60];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//                                        completionHandler:^(NSData * _Nullable data,
//                                                            NSURLResponse * _Nullable response,
//                                                            NSError * _Nullable error) {
//        NSData *jsonData = [[NSData alloc] initWithContentsOfURL:url];
//        self.jsonGenresDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
//        NSLog(@"resoonse dictionary: %@", self.jsonGenresDict);
    
    [self fetch:endpoint parse:^void(NSDictionary *json, NSError *error) {
        NSArray *genres = [json valueForKeyPath:@"genres.name"];
        
        completion(genres, error);
    }];
}

-(void)displayGenres{
    
}
@end
