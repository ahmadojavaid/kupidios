//
//  LocationVC.m
//  OPUS
//
//  Created by Kaushal PC on 15/03/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "LocationVC.h"
#import "LocationHelper.h"
#import "SearchPlaceVC.h"
@import GooglePlaces;

@interface LocationVC ()<LocationUpdateDelegate, SearchPlaceUpdate>

@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (nonatomic, readonly) MKPlacemark *placemark;

@property (weak, nonatomic) IBOutlet UISlider *sliderDistance;
@property (weak, nonatomic) IBOutlet UIView *vwSliderFlow;
@property (weak, nonatomic) IBOutlet UILabel *lblSliderCount;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UIView *vwAddress;

@property (strong,nonatomic) IBOutlet UITextField *txtSearch;

@property (strong,nonatomic) IBOutlet UIView *vwSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnHomeLocation;
@property (weak, nonatomic) IBOutlet UIView *vwTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;


@end

@implementation LocationVC
{
    CLLocationCoordinate2D Location;
    int i,flag;
    MKCircle *circle;
    double searchedLat,searchedLong;
    int annotationFrom;
    BOOL search;
    int candidatetype;
    BOOL currentLocation;
    
}
@synthesize searchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentLocation=0;
   
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];

    
    [[LocationHelper sharedInstance] updateLocation];
    [LocationHelper sharedInstance].delegate=self;
    self.MapView.delegate = self;
    i = 0;flag=0;
    

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    [self.vwSearch addGestureRecognizer:tapGestureRecognizer];
    

    //location on map
    double lat = [[appDelegate GetData:klatitude] doubleValue];
    double lng = [[appDelegate GetData:klongitude] doubleValue];
    
    Location = CLLocationCoordinate2DMake(lat, lng);
    
    [self zoomForLocation];
    
    CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    [self getAddressFromLatLon:LocationAtual];
    annotationFrom=0;
    
    [self.MapView removeAnnotation:[self.MapView userLocation]];
    self.MapView.showsUserLocation = NO;
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=lat;
    myCoordinate.longitude=lng;
    annotation.coordinate = myCoordinate;
    [self.MapView addAnnotation:annotation];
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
    [self localize];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.vwTitle.hidden = NO;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.btnHomeLocation.frame = CGRectMake(self.btnHomeLocation.frame.origin.x, self.btnHomeLocation.frame.origin.y, self.btnHomeLocation.frame.size.width, self.btnHomeLocation.frame.size.width);
    self.btnHomeLocation.layer.cornerRadius = self.btnHomeLocation.frame.size.width/2;
    
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.width = SCREEN_SIZE.width;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    
    [self.view bringSubviewToFront:self.vwTitle];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)changeUiforMap
{
    [self.MapView removeOverlay:circle];
    circle = [MKCircle circleWithCenterCoordinate:Location radius:(int)self.sliderDistance.value/0.00062137119];
    [self.MapView addOverlay:circle];
}

#pragma mark - To Get user location


-(void)LocationUpdated
{
    [self.MapView removeAnnotations:self.MapView.annotations];
    
    NSLog(@"%@, %@",[LocationHelper sharedInstance].latitude,[LocationHelper sharedInstance].longitude);
    double lat;
    double lng;
    if(currentLocation==1)
    {
        lat = [[LocationHelper sharedInstance].latitude doubleValue];
        lng = [[LocationHelper sharedInstance].longitude doubleValue];
        
    }
    else
    {
        lat = Location.latitude;
        lng = Location.longitude;
    }
    
    searchedLat = lat;
    searchedLong = lng;
    
    Location = CLLocationCoordinate2DMake(lat, lng);
    
    [self zoomForLocation];
    
    CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    [self getAddressFromLatLon:LocationAtual];
    annotationFrom=0;
    
    [self.MapView removeAnnotation:[self.MapView userLocation]];
    self.MapView.showsUserLocation = NO;
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=lat;
    myCoordinate.longitude=lng;
    annotation.coordinate = myCoordinate;
    [self.MapView addAnnotation:annotation];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor clearColor];
    circleView.fillColor = [UIColor colorWithRed:0.0/255.0 green:184.0/255.0 blue:182.0/255.0 alpha:0.3];
    return circleView;
}

-(void)zoomForLocation
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(Location, ((int)self.sliderDistance.value/0.00062137119)*3+6000, ((int)self.sliderDistance.value/0.00062137119)*3+6000);
    MKCoordinateRegion adjustedRegion = [self.MapView regionThatFits:viewRegion];
    [self.MapView setRegion:adjustedRegion animated:YES];
    self.MapView.showsUserLocation = YES;
}

- (void) getAddressFromLatLon:(CLLocation *)bestLocation
{

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:bestLocation completionHandler:^(NSArray *placemarks, NSError *error){
        
        if (error)
        {
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        self.lblAddress.text = [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.administrativeArea];
        [self labelResizing];
    }];
}

-(void)labelResizing
{
    if ([self.lblAddress.text isEqualToString:@"(null), (null)"])
    {
        self.lblAddress.text = @"--";
        currentLocation=1;
        [self LocationUpdated];
        self.txtSearch.text = @"";
    }
    [self.lblAddress sizeToFit];
    self.vwAddress.frame = CGRectMake(self.vwAddress.frame.origin.x, self.vwAddress.frame.origin.y, self.lblAddress.frame.origin.x+self.lblAddress.frame.size.width+8, self.vwAddress.frame.size.height);
    
    if (self.vwAddress.frame.size.width > SCREEN_SIZE.width-(SCREEN_SIZE.width-self.btnHomeLocation.frame.origin.x)-10-self.vwAddress.frame.origin.x)
    {
        self.vwAddress.frame = CGRectMake(self.vwAddress.frame.origin.x, self.vwAddress.frame.origin.y, SCREEN_SIZE.width-(SCREEN_SIZE.width-self.btnHomeLocation.frame.origin.x)-10-self.vwAddress.frame.origin.x, self.vwAddress.frame.size.height);
        self.lblAddress.frame = CGRectMake(self.lblAddress.frame.origin.x, self.lblAddress.frame.origin.y, self.vwAddress.frame.size.width-self.lblAddress.frame.origin.x-10, self.lblAddress.frame.size.height);
    }
}

- (MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *SFAnnotationIdentifier = @"";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
    
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation                                                                             reuseIdentifier:SFAnnotationIdentifier];
    UIImage *flagImage = [UIImage imageNamed:@"pin"];
    
    // You may need to resize the image here.
    annotationView.image = flagImage;
    annotationView.centerOffset = CGPointMake(17, -17);
    
    if (annotationFrom==1)
    {
        if ([annotation isKindOfClass:[MKUserLocation class]])
        {
            return nil;
        }
    }
    return annotationView;
}

#pragma mark - Button Clicks

-(IBAction)btnMyLocationClicked:(id)sender
{
    
    NSLog(@"%@",sender);
    currentLocation=1;
    [self LocationUpdated];
    self.txtSearch.text = @"";
    
}

- (IBAction)btnDoneClicked:(id)sender
{
    [self updateLocation];
}

/*!
 * @discussion Open Menu
 * @param sender For indetifying sender
 */
- (IBAction)btnMenuClicked:(id)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];

}


#pragma mark - Tap gesture Handler

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    SearchPlaceVC *vc = [[SearchPlaceVC alloc]  initWithNibName:@"SearchPlaceVC" bundle:nil];
    vc.delegate=self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Place Search Delegate

-(void)UpdateSearchedPlace:(NSString *)strLat Long:(NSString *)strLng PlaceName:(NSString *)strPlacename
{
    searchedLat = [strLat doubleValue];
    searchedLong = [strLng doubleValue];
    
    self.txtSearch.text = strPlacename;
    
    CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:searchedLat longitude:searchedLong];
    [self getAddressFromLatLon:LocationAtual];
    
    
    [self.MapView removeAnnotations:self.MapView.annotations];
    annotationFrom=1;
    self.MapView.showsUserLocation = NO;
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=searchedLat;
    myCoordinate.longitude=searchedLong;
    annotation.coordinate = myCoordinate;
    [self.MapView addAnnotation:annotation];
    
    Location = CLLocationCoordinate2DMake(searchedLat,searchedLong);
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeUiforMap) object:nil];
    [self performSelector:@selector(changeUiforMap) withObject:nil afterDelay:0.6];
    
    [self zoomForLocation];
    
}


#pragma mark - api call
-(void) updateLocation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
         {
             if (responseObject == false)
             {
                 
                 ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
                 return ;
             }
             else {
                 NSString *str=@"userUpdateLatLong";
                 
                 NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
                 [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
                 [dict setValue:[NSString stringWithFormat:@"%f", searchedLat] forKey:@"location_lat"];
                 [dict setValue:[NSString stringWithFormat:@"%f", searchedLong] forKey:@"location_long"];
                 
                 SHOW_LOADER_ANIMTION();
                 
                 NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
                 [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                     
                     HIDE_PROGRESS;
                     
                     if(success && [[dictionary valueForKey:@"error"] intValue]==0 ){
                         [appDelegate SetData:[dictionary valueForKey:@"latitude"] value:klatitude];
                         [appDelegate SetData:[dictionary valueForKey:@"longitude"]  value:klongitude];
                     }
                     
                 }];
             }
         }];
    });
}

#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblLocation.text=[MCLocalization stringForKey:@"Location"];
    self.txtSearch.placeholder=[MCLocalization stringForKey:@"Search for Places"];
    [self.btnDone setTitle:[MCLocalization stringForKey:@"DONE"] forState:UIControlStateNormal];
}

@end

