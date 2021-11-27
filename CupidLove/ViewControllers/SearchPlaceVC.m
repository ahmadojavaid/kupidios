//
//  SearchPlaceVC.m
//  OPUS
//
//  Created by Kaushal PC on 26/04/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "SearchPlaceVC.h"

@import GooglePlaces;

@interface SearchPlaceVC ()<GMSAutocompleteTableDataSourceDelegate, UISearchDisplayDelegate, UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tblSearchPlaces;
@property (strong,nonatomic) GMSAutocompleteTableDataSource *tblDataSource;

@property (strong,nonatomic) IBOutlet UIView *vwSearchHeader;
@property (strong,nonatomic) IBOutlet UIView *vwSearchInner;
@property (weak, nonatomic) IBOutlet UILabel *lblSearchforLocation;


@end

@implementation SearchPlaceVC
{
    UISearchDisplayController *searchController;
    double searchedLat,searchedLong;
    Boolean firstime;
}
@synthesize searchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44.0f)];
    
    _tblDataSource = [[GMSAutocompleteTableDataSource alloc] init];
    _tblDataSource.delegate = self;
    
    searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchController.searchResultsDataSource = _tblDataSource;
    searchController.searchResultsDelegate = _tblDataSource;
    searchController.delegate = self;
    
    [self.vwSearchInner addSubview:searchBar];
    searchBar.delegate = self;
    firstime=NO;
    
    [self localize];
}

-(void)viewDidLayoutSubviews
{
    if (firstime==NO)
    {
        [searchBar becomeFirstResponder];
        firstime=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Clicked

- (IBAction)btnSearchBackClicked:(id)sender
{
    [self searchBarShouldEndEditing:searchBar];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Tableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tblSearchPlaces)
    {
        return 0;
    }
    return 0;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [_tblDataSource sourceTextHasChanged:searchString];
    return NO;
}

// Handle the user's selection.
- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource didAutocompleteWithPlace:(GMSPlace *)place
{
    [searchController setActive:NO animated:YES];
    
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    
    searchedLat = place.coordinate.latitude;
    searchedLong = place.coordinate.longitude;
    NSString *la = [NSString stringWithFormat:@"%f",searchedLat];
    NSString *lo = [NSString stringWithFormat:@"%f",searchedLong];
    if(self.delegate)
    {
        [self.delegate UpdateSearchedPlace:la Long:lo PlaceName:place.name];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSourcedidFailAutocompleteWithError:(NSError *)error {
    [searchController setActive:NO animated:YES];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource didFailAutocompleteWithError:(NSError *)error
{
    
}

- (void)didUpdateAutocompletePredictionsForTableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource
{
    // Turn the network activity indicator off.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // Reload table data.
    [searchController.searchResultsTableView reloadData];
}

- (void)didRequestAutocompletePredictionsForTableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource {
    // Turn the network activity indicator on.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // Reload table data.
    [searchController.searchResultsTableView reloadData];
}

#pragma mark - UISearchBar Delegate

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    search=YES;
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
//    search=NO;
    return YES;
}

#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblSearchforLocation.text=[MCLocalization stringForKey:@"Search for Location"];
}

@end
