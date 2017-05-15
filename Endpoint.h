//
//  Endpoint.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/15/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Endpoint <NSObject>

@property (nonatomic) NSString *baseURL;
@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *detailMethod;
@property (nonatomic) NSMutableDictionary *queryString;

@end
