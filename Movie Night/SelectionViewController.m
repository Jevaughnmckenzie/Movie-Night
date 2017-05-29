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
@property (nonatomic, strong) MDBEndpoint *endpoint;
@property (nonatomic, strong) MDBClient *mdbClient;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, strong) UIBarButtonItem *nextButton;

@property (nonatomic, strong) NSDictionary *genreList;
@property (nonatomic, strong) NSMutableDictionary *selectedRows;
@property (nonatomic, strong) NSMutableDictionary *selectedGenres;


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
    
    self.navigationItem.rightBarButtonItem = self.doneButton;
    
    self.tableView.allowsMultipleSelection = YES;
    
    [self initializeProperties];
    
    [self listGenres];
    
    
    
}

-(void)initializeProperties{
        
    // Handles all of the network requesting
    self.mdbClient = [MDBClient new];
    
    // Holds the index paths of the selected rows
    self.selectedRows = [NSMutableDictionary new];
    
    // Holds the correspnding cell title text for each selected row
    self.selectedGenres = [NSMutableDictionary new];
    
    // The list of genres displayed when the view loads
    self.genreList = [NSDictionary new];
        
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

    return self.genreList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GenreCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = self.genreList.allKeys[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GenreCell *selectedCell = [GenreCell new];
    selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self.selectedGenres setValue:[self.genreList valueForKey:selectedCell.textLabel.text] forKey:selectedCell.textLabel.text ];

    NSLog(@"%@", self.selectedGenres);
    
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
    
    
    
    [self.selectedGenres removeObjectForKey:deselectedCell.textLabel.text];
    NSLog(@"%@", self.selectedGenres);
    
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
    
    self.endpoint = [MDBEndpoint new];
    
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

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isEqual:self.navigationController.viewControllers[0]]){
        NSLog(@"Moving to the root viewcontroller!");
    }
}

// MARK: Recomendations Compiler
- (IBAction)storeGenrePreferences:(id)sender {
    
    
    
    ViewController *homeScreen = [ViewController new];
    // Access the root view controller to pass along movie preferences without segue
    homeScreen = self.navigationController.viewControllers[mainViewController];
    
    // FIXME: the bubble images should change depending on which bubble was pressed to get to this viewController
    if (self.userSender.tag == userOneButton){
//        homeScreen.suggestionsCompiler.userOnePreferredGeneres = self.selectedGenres;
        homeScreen.userOneBubble.imageView.image = [UIImage imageNamed:@"bubble-selected.png"];
    } else {
//        homeScreen.suggestionsCompiler.userTwoPreferredGeneres = self.selectedGenres;
        homeScreen.userTwoBubble.imageView.image = [UIImage imageNamed:@"bubble-selected.png"];
    }
    
    // Sends the selected genre information to the main screen. Will then be passed on to the ResultsController
    
    if (self.userSender.tag == userOneButton) {
        homeScreen.suggestionsCompiler.userOnePreferredGeneres = self.selectedGenres;
    } else if (self.userSender.tag == userTwoButton){
        homeScreen.suggestionsCompiler.userTwoPreferredGeneres = self.selectedGenres;
    }
    
    NSLog(@"%@", homeScreen.suggestionsCompiler.userOnePreferredGeneres);
    NSLog(@"%@", homeScreen.suggestionsCompiler.userTwoPreferredGeneres);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


@end
