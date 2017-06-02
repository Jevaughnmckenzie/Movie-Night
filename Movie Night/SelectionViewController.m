//
//  SelectionViewController.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/15/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "SelectionViewController.h"
#import "ViewController.h"

enum buttons{
    userOneButton = 1,
    userTwoButton = 2
};



@interface SelectionViewController ()

@property (nonatomic) int selectionType;

@property (nonatomic, weak) ViewController *homeScreen;
@property (nonatomic, strong) MDBEndpoint *endpoint;
@property (nonatomic, strong) MDBClient *mdbClient;

@property (strong, nonatomic)  UIBarButtonItem *doneButton;
@property (nonatomic, strong)  UIBarButtonItem *nextButton;

@property (nonatomic) int senderTag;

@property (nonatomic, strong) NSDictionary *genreList;
@property (nonatomic, strong) NSDictionary *actorsList;
@property (nonatomic, strong) NSMutableDictionary *selectedRows;
@property (nonatomic, strong) NSMutableDictionary *selectedGenres;
@property (nonatomic, strong) NSMutableDictionary *selectedActors;


@end

@implementation SelectionViewController


static NSString * const reuseIdentifier = @"GenreCell";
static const int mainViewController = 0;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initializeProperties];
    
    switch (self.selectionType) {
        case genres:
            
            self.navigationItem.rightBarButtonItem = self.nextButton;
            [self listGenres];
            break;
            
        case actors:
            
            self.navigationItem.rightBarButtonItem = self.doneButton;
            [self listActors];
            break;
    }
//    NSLog(@"%i", self.senderTag);
    
    self.tableView.allowsMultipleSelection = YES;
}

-(void)initializeProperties{
    
    // Handles all of the network requesting
    self.mdbClient = [MDBClient new];
    
    // Creates the url that will be used to retrieve the desired resource
    self.endpoint = [MDBEndpoint new];
    
    // Holds the index paths of the selected rows
    self.selectedRows = [NSMutableDictionary new];
    
    // Will be used to refer to which user is currently making selections
    self.senderTag = (int) self.userSender.tag;
    
    // Holds reference to the root controller of the navigation controller
    _homeScreen = self.navigationController.viewControllers[mainViewController];
    
    switch (_selectionType) {
        case genres:
            // Holds the correspnding cell title text for each selected row
            self.selectedGenres = [NSMutableDictionary new];
            
            // The list of genres displayed when the view loads
            self.genreList = [NSDictionary new];
            
            self.nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(storeGenrePreferences:)];
            break;
            
        case actors:
            self.selectedActors = [NSMutableDictionary new];
            
            self.actorsList = [NSDictionary new];
            
            self.doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(storeActorPreferences:)];
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     NSUInteger numberOfRows = 0;
    
    switch (self.selectionType) {
        case genres:
            numberOfRows = self.genreList.count;
            break;
        case actors:
            numberOfRows = self.actorsList.count;
            break;
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    GenreCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    GenreCell *cell = (GenreCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[GenreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    // Configure the cell...
    
    switch (self.selectionType) {
        case genres:
            cell.textLabel.text = self.genreList.allKeys[indexPath.row];
            break;
        case actors:
            cell.textLabel.text = self.actorsList.allKeys[indexPath.row];
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GenreCell *selectedCell = [GenreCell new];
    selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    switch (self.selectionType) {
        case genres:
            [self.selectedGenres setValue:[self.genreList valueForKey:selectedCell.textLabel.text] forKey:selectedCell.textLabel.text ];
//            NSLog(@"%@", self.selectedGenres);
            break;
        case actors:
            [self.selectedActors setValue:[self.actorsList valueForKey:selectedCell.textLabel.text] forKey:selectedCell.textLabel.text ];
            NSLog(@"selected Actors: %@", self.selectedActors);
            break;
    }
    
    

    
    
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GenreCell *selectedCell = [GenreCell new];
    selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (self.tableView.indexPathsForSelectedRows.count == 3) {
        return nil;
    } else {
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GenreCell *deselectedCell = [GenreCell new];
    deselectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    switch (self.selectionType) {
        case genres:
            [self.selectedGenres removeObjectForKey:deselectedCell.textLabel.text];
//            NSLog(@"%@", self.selectedGenres);
            break;
        case actors:
            [self.selectedActors removeObjectForKey:deselectedCell.textLabel.text];
//            NSLog(@"%@", self.selectedActors);
            break;
    }
    
    if (self.tableView.indexPathsForSelectedRows.count == 3){
        self.tableView.allowsSelection = YES;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//}


// MARK: Genre Tableview
-(void)listGenres{
    
    [self.endpoint setEndpointForGenreList];

    [self.mdbClient fetchGenres:self.endpoint completion:^(NSDictionary *genres, NSError* error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.genreList = genres;
            [self.tableView reloadData];
            
            if (error != nil ){
                UIAlertController *loadingGenresAlert = [UIAlertController alertControllerWithTitle:error.localizedDescription message:@"Please contact Jevaughn McKenzie to deal with this issue." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
                
                [loadingGenresAlert addAction:okButton];
                [self presentViewController:loadingGenresAlert animated:YES completion:nil];
            }
        });
    }];
    
}

-(void)listActors{
    
    [self.endpoint setEndpointForPopularActorsList];
    
    [self.mdbClient fetchActors:self.endpoint completion:^(NSDictionary *actors, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.actorsList = actors;
            [self.tableView reloadData];
            
            if (error != nil ){
                UIAlertController *loadingGenresAlert = [UIAlertController alertControllerWithTitle:error.localizedDescription message:@"Please contact Jevaughn McKenzie to deal with this issue." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
                
                [loadingGenresAlert addAction:okButton];
                [self presentViewController:loadingGenresAlert animated:YES completion:nil];
            }
        });
    }];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isEqual:self.navigationController.viewControllers[0]]){
        NSLog(@"Moving to the root viewcontroller!");
    }
}

// MARK: Storing Selections
- (void)storeGenrePreferences:(id)sender {
    
    // Sends the selected genre information to the main screen. Will be passed on to the later ResultsController
    
    if (self.senderTag == userOneButton) {
        self.homeScreen.suggestionsCompiler.userOnePreferredGeneres = self.selectedGenres;
        NSLog(@"%@", self.homeScreen.suggestionsCompiler.userOnePreferredGeneres);
    } else if (self.senderTag == userTwoButton){
       self. homeScreen.suggestionsCompiler.userTwoPreferredGeneres = self.selectedGenres;
        NSLog(@"%@", self.homeScreen.suggestionsCompiler.userTwoPreferredGeneres);
    }
    
    
    
    
    SelectionViewController *selectionController = [SelectionViewController new];
    [selectionController setSelectionType:actors];
    [self.navigationController pushViewController:selectionController animated:YES];
    selectionController.userSender = self.userSender;
    
}

- (void)storeActorPreferences:(id)sender {
    
    if (self.senderTag == userOneButton) {
        self.homeScreen.suggestionsCompiler.userOnePreferredActors = self.selectedActors;
        NSLog(@"%@", self.homeScreen.suggestionsCompiler.userOnePreferredActors);
    } else if (self.senderTag == userTwoButton){
        self. homeScreen.suggestionsCompiler.userTwoPreferredActors = self.selectedActors;
        NSLog(@"%@", self.homeScreen.suggestionsCompiler.userTwoPreferredActors);
    }
    
    if (self.senderTag == userOneButton){
        //        homeScreen.suggestionsCompiler.userOnePreferredGeneres = self.selectedGenres;
        self.homeScreen.userOneBubble.imageView.image = [UIImage imageNamed:@"bubble-selected.png"];
    } else {
        //        homeScreen.suggestionsCompiler.userTwoPreferredGeneres = self.selectedGenres;
        self.homeScreen.userTwoBubble.imageView.image = [UIImage imageNamed:@"bubble-selected.png"];
    }
    
    
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



@end
