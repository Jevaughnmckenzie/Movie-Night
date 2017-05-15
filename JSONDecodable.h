//
//  JSONDecodable.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/15/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONDecodable <NSObject>

@property (nonatomic) NSDictionary *json;

@end
