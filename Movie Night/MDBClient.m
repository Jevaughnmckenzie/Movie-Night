//
//  MDBClient.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/15/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "MDBClient.h"

@implementation MDBClient


-(instancetype)init{
    self = [super init];
    
    _genres = [NSMutableArray array];
    _endpoint = [MDBEndpoint new];
    
    return self;
}

-(void) fetchGenres: (void (^)(NSArray*))completion{
    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    
//    NSString *urlString = [NSString stringWithFormat:@"%@", self.endpoint.urlString ];
//    
    NSURL *url = [self.endpoint genreListEndpoint];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:60];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData * _Nullable data,
                                                            NSURLResponse * _Nullable response,
                                                            NSError * _Nullable error) {
        NSData *jsonData = [[NSData alloc] initWithContentsOfURL:url];
        self.jsonGenresDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        NSLog(@"resoonse dictionary: %@", _jsonGenresDict);
        
        [self.genres addObjectsFromArray:[self.jsonGenresDict valueForKeyPath:@"genres.name"]];
        completion(self.genres);
    
        
        
    }];
    
    [task resume];
}

-(void)displayGenres{
    
}
@end
