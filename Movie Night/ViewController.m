//
//  ViewController.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/14/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "ViewController.h"
#import "HomeScreen.h"

enum SegueDestination {
    showResults = 0,
    pickUserOneGenres,
    pickUSerTwoGenres
};


@interface ViewController ()

@property (nonatomic, strong) NSArray *currentPhoneSize;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setMainPageViews];
    self.suggestionsCompiler = [MDBMovieSuggestionsCompiler new];
    
//    NSLog(@"%@", self.suggestionsCompiler.userOnePreferredGeneres);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMainPageViews{
    
    [self.homeScreenImage getPhoneType:self.view.frame.size.width andHeight:self.view.frame.size.height];
    [self.homeScreenImage setHomeScreenImage:self.homeScreenImage.currentPhoneSize];
}

-(IBAction)selectPreferences:(id)sender{
    
    [self performSegueWithIdentifier:@"PickGenres" sender:sender];
    
}

- (IBAction)viewResults:(id)sender {
    
    [self performSegueWithIdentifier:@"ShowResults" sender:sender];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIButton *buttonSender = sender;
    if (buttonSender.tag == showResults){
        ResultsController *resultsController = [ResultsController new];
        resultsController = [segue destinationViewController];
        
        __weak NSMutableDictionary *userOneGenres = self.suggestionsCompiler.userOnePreferredGeneres;
        __weak NSMutableDictionary *userTwoGenres = self.suggestionsCompiler.userTwoPreferredGeneres;
        
        __weak NSMutableDictionary *userOneActors = self.suggestionsCompiler.userOnePreferredActors;
        __weak NSMutableDictionary *userTwoActors = self.suggestionsCompiler.userTwoPreferredActors;
        
        resultsController.movieSuggestions = [MDBMovieSuggestionsCompiler new];
        
        resultsController.movieSuggestions.userOnePreferredGeneres = userOneGenres;
        resultsController.movieSuggestions.userTwoPreferredGeneres = userTwoGenres;
        
        resultsController.movieSuggestions.userOnePreferredActors = userOneActors;
        resultsController.movieSuggestions.userTwoPreferredActors = userTwoActors;
        
    } else{
        SelectionViewController *selectionController = [segue destinationViewController];
        [selectionController setSelectionType:genres];
        selectionController.userSender = [UIButton new];
        selectionController.userSender = sender;
//        NSLog(@"%lu", selectionController.userSender.tag);
    }
    
}


@end
