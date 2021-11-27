//
//  SearchPlaceVC.h
//  OPUS
//
//  Created by Kaushal PC on 26/04/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchPlaceUpdate <NSObject>
- (void)UpdateSearchedPlace:(NSString *)strLat  Long:(NSString *)strLng PlaceName:(NSString *)strPlacename;
@end

@interface SearchPlaceVC : UIViewController

@property (strong,nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic, assign) id <SearchPlaceUpdate> delegate;

@end
