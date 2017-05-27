//
//  ResultsController.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/20/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "ResultsController.h"

@interface ResultsController ()



@end

@implementation ResultsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"userOne genres: %@\nuserTwo genres: %@", self.movieSuggestions.userOnePreferredGeneres, self.movieSuggestions.userTwoPreferredGeneres);
    
    [self.movieSuggestions prioritizeGenreSelections];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





@end
