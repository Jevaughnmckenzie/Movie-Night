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
@property (nonatomic, strong) MDBClient *mdbClient;
@property (nonatomic, strong) NSArray *genreList;

@end

@implementation ViewController

-(void)setMdbClient:(MDBClient *)mdbClient{
    
    _mdbClient = mdbClient;
    
    
}

//-(instancetype)init{
//    self = [super init];
//    
//    if (self){
//        _suggestionsCompiler = [MDBMovieSuggestionsCompiler new];
//    }
//    
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setMainPageViews];
    self.suggestionsCompiler = [MDBMovieSuggestionsCompiler new];
    
    NSLog(@"%@", self.suggestionsCompiler.userOnePreferredGeneres);
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
        
        
        
        __weak NSMutableSet *userOneSet = self.suggestionsCompiler.userOnePreferredGeneres;
        __weak NSMutableSet *userTwoSet = self.suggestionsCompiler.userTwoPreferredGeneres;
        
        resultsController.movieSuggestions = [MDBMovieSuggestionsCompiler new];
        
        resultsController.movieSuggestions.userOnePreferredGeneres = userOneSet;
        
        resultsController.movieSuggestions.userTwoPreferredGeneres = userTwoSet;
        
    } else{
        SelectionViewController *controller = [segue destinationViewController];
        controller.userSender = sender;
    }
    
}
//morjcql@gmail.com

@end
