//
//  LocationHelper.m
//  CupidLove
//
//  Created by APPLE on 20/01/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "LocationHelper.h"



@implementation LocationHelper 
{
    NSString *location;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
}

+ (instancetype)sharedInstance
{
    
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
    });
   
    return sharedInstance;
}
#pragma mark --------- CLLocationManager delegate methods---------

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    
    CLLocation *newLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0) {
            
            placemark = [placemarks lastObject];
            NSString *lati = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            NSString *longi= [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            
//            NSString *myState = placemark.administrativeArea;
//            NSString *myCountry = placemark.country;
            
            self.latitude=lati;
            self.longitude=longi;
            
            //callind delegate
            [self.delegate LocationUpdated];
            [manager stopUpdatingLocation];
           
        } else {
            NSLog(@"Error::%@", error.debugDescription);
        }
    } ];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
    self.latitude=0;
    self.longitude=0;
    [self.delegate LocationUpdated];
}

#pragma mark --method---

- (void) updateLocation
{
    if ([CLLocationManager locationServicesEnabled]){
        
        //Location Services Enabled        
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            
            ALERTVIEW([MCLocalization stringForKey:@"Please go to Settings and turn on Location Service for this app."], appDelegate.window.rootViewController);
        }
        
        //enable location
        geocoder = [[CLGeocoder alloc] init];
        if (locationManager == nil)
        {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.delegate = self;
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
    }
    else{
        ALERTVIEW([MCLocalization stringForKey:@"Please enable Location Service for this app."], appDelegate.window.rootViewController);
    }
    
    
    
    
}



@end
