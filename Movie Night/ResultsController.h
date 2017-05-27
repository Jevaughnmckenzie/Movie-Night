//
//  ResultsController.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/20/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDBMovieSuggestionsCompiler.h"

@class ViewController;

@interface ResultsController : UITableViewController

@property (nonatomic) MDBMovieSuggestionsCompiler *movieSuggestions;

@end
