//
//  GenreCell.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/15/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "GenreCell.h"

@implementation GenreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//-(void) fetchGenres{
//    NSURLSession *session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSString *urlString = @"https://api.themoviedb.org/3/genre/movie/list?api_key=6fceaf9e1e4b8cd45f44340c8798a4b1&language=en-US";
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSData *jsonData = [[NSData alloc] initWithContentsOfURL:url];
//        self.jsonGenresDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
//        NSLog(@"resoonse dictionary: %@", _jsonGenresDict);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.genres addObjectsFromArray:[self.jsonGenresDict valueForKeyPath:@"genres.name"]];
//            
//        });
//        
//        
//    }];
//    
//    [task resume];
//}


@end
