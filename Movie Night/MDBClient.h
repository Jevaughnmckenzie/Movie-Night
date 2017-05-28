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


-(NSURLSessionDataTask*)jsonTaskWithRequest:(NSURLRequest*)urlRequest completion:(void(^)(NSDictionary*, NSHTTPURLResponse*, NSError*))completion;
-(void)fetch:(MDBEndpoint*)endpoint parse:(void(^)(NSDictionary*, NSError*))jsonData;
-(void) fetchGenres:(MDBEndpoint*)endpoint completion:(void (^)(NSDictionary*, NSError*))completion;
//-(void) fetchMovieThumbnails;
//-(void) fetchActors;

@end
