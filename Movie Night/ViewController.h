//
//  ViewController.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/14/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDBClient.h"
#import "MDBMovieSuggestionsCompiler.h"
#import "SelectionViewController.h"


@class HomeScreen;


@interface ViewController : UIViewController

@property (nonatomic, strong) NSArray *currentPhoneSize;
//@property (nonatomic, strong) HomeScreen *homeScreen;
@property (weak, nonatomic) IBOutlet HomeScreen *homeScreenImage;
@property (weak, nonatomic) IBOutlet UIButton *userOneBubble;
@property (weak, nonatomic) IBOutlet UIButton *userTwoBubble;

@property (nonatomic, strong) MDBMovieSuggestionsCompiler *suggestionsCompiler;

- (IBAction)selectPreferences:(id)sender;



@end

