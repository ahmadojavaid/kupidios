//
//  LocationVC.h
//  LADate
//
//  Created by Kaushal PC on 15/03/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationVC : UIViewController<MKMapViewDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong,nonatomic) IBOutlet UISearchBar *searchBar;

@end
