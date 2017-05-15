//
//  ApiClient.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/15/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApiClient <NSObject>

@property (nonatomic) NSURLSession;
@property (nonatomic) NSURLSessionConfiguration;



@end
