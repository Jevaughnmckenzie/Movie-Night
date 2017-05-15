//
//  Movie.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/14/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Movie : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *thumbnailImagePath;
@property (nonatomic, strong) NSString *posterImagePath;
@property (nonatomic, strong) NSString *tagLine;

@end
