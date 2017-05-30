//
//  SelectionViewController.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/15/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenreCell.h"
#import "MDBClient.h"
#import "MDBMovieSuggestionsCompiler.h"

@class ViewController;

enum selectionType{
    genres,
    actors
};

@interface SelectionViewController : UITableViewController

@property (nonatomic, strong) UIButton *userSender;

-(instancetype)initWithSelectionType:(int)selectionType;

-(void)setSelectionType:(int)selectionType;

@end
