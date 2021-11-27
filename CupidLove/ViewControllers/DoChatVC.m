//
//  DoChatVC.m
//  CupidLove
//
//  Created by APPLE on 29/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "DoChatVC.h"
#import "ChatLeftCell.h"
#import "ChatRightCell.h"
#import "DateRequest.h"
#import "DateRequestRecCell.h"

#import "IQKeyboardManager.h"
#import <Foundation/Foundation.h>
#import "FriendDetailsVC.h"
#import "PlaceSearchCell.h"
#import "CKCalendarView.h"
#import "ChatVC.h"
#import "DayCell.h"
#import "LocationHelper.h"
#import "InAppPurchaseVC.h"
@import GooglePlaces;
@import EventKit;

#import "UIImageView+WebCache.h"
#import "StarRatingView.h"

#define kLabelAllowance 50.0f
#define kStarViewHeight 30.0f
#define kStarViewWidth 160.0f
#define kLeftPadding 5.0f


@interface DoChatVC () <CKCalendarDelegate, SSOnlineOfflineFriendsDelegate, SSMessageDelegate, UITextFieldDelegate, UIScrollViewDelegate,ComposeMessageDelegate>
{
    NSArray *numbers;
    NSTimer *timer;
}

@property(weak,nonatomic) IBOutlet UIView *vwMessageSend;

@property(weak,nonatomic) IBOutlet UIView *viewPreferences;
@property(weak,nonatomic) IBOutlet UITextField *txtMessage;//for message typed
@property(weak,nonatomic) IBOutlet UIImageView *imgProfile;//topview profile pic
@property(weak,nonatomic) IBOutlet UITableView *tblChat;//display chat
@property(weak,nonatomic) IBOutlet UIView *topView;
@property(weak,nonatomic) IBOutlet UIView *bottomView;

@property(nonatomic, weak) CKCalendarView *calendar1;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSArray *disabledDates;


@property (weak, nonatomic) IBOutlet UIView *vwImg;
@property (weak, nonatomic) IBOutlet UIView *popupBG;

@property (weak, nonatomic) IBOutlet UIView *setDateView;

@property (nonatomic, weak) IBOutlet UIView *datepickView;
@property (nonatomic, weak) IBOutlet UIView *timepickView;

@property (nonatomic, weak) IBOutlet UISlider *hourSlider;
@property (nonatomic, weak) IBOutlet UISlider *minuteSlider;

@property (nonatomic, weak) IBOutlet UILabel *hour;

@property (nonatomic, weak) IBOutlet UILabel *minute;

@property (weak, nonatomic) IBOutlet UIView *viewAM;
@property (weak, nonatomic) IBOutlet UIView *viewPM;
@property (weak, nonatomic) IBOutlet UIView *viewPoint;
@property (weak, nonatomic) IBOutlet UIView *viewAmPmSlide;
@property (weak, nonatomic) IBOutlet UIView *viewDate;
@property (weak, nonatomic) IBOutlet UIView *viewTime;

@property (weak, nonatomic) IBOutlet UIButton *btnDateTime;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveReq;

@property(weak,nonatomic) IBOutlet UILabel *lblName;

@property(weak,nonatomic) IBOutlet UIImageView *imgPref1;
@property(weak,nonatomic) IBOutlet UIImageView *imgPref2;
@property(weak,nonatomic) IBOutlet UIImageView *imgPref3;
@property(weak,nonatomic) IBOutlet UIImageView *imgPref4;
@property(weak,nonatomic) IBOutlet UILabel *lblPref1;
@property(weak,nonatomic) IBOutlet UILabel *lblPref2;
@property(weak,nonatomic) IBOutlet UILabel *lblPref3;
@property(weak,nonatomic) IBOutlet UILabel *lblPref4;


@property (weak, nonatomic) IBOutlet UIView *placeView;
@property (weak, nonatomic) IBOutlet UIView *SelectedplaceView;

@property (weak, nonatomic) IBOutlet UITableView *tblPlaceSearch;
@property (weak, nonatomic) IBOutlet UITableView *tblSelectedPlace;

@property(weak,nonatomic) IBOutlet UILabel *lblNearByYou;
@property(weak,nonatomic) IBOutlet UILabel *lblSelectedPlace;
@property(weak,nonatomic) IBOutlet UILabel *lblOnlineOffline;

@property (strong, nonatomic) IBOutlet UILabel *lblSetDate;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblHours;
@property (strong, nonatomic) IBOutlet UILabel *lblMins;
@property (strong, nonatomic) IBOutlet UILabel *lblAM;
@property (strong, nonatomic) IBOutlet UILabel *lblPM;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UIView *vwTitle;
@property (weak, nonatomic) IBOutlet UIView *vwBack;
@property (weak, nonatomic) IBOutlet UIButton *btnReport;
@property (weak, nonatomic) IBOutlet UIView *vwSaveRequest;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *act;

@end

@implementation DoChatVC
{
    CGRect screenRect;
    NSString *hide;
    NSInteger messageCount;
    NSString *dateTime;
    NSMutableArray *arrSelection;
    
    //for setting icon according to user preferences
    NSString *pref1;
    NSString *pref2;
    NSString *pref3;
    NSString *pref4;
    
    NSDate *selectedDate;
    GMSPlacesClient *_placesClient;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    double latitude_UserLocation,longitude_UserLocation;
    int set;
    int selectedrow;
    NSMutableArray *name,*rating,*distance,*imgPlaces,*placeId;
    NSString *key;
    UIColor *strip;
    CKCalendarView *calendar;
    NSMutableArray *arrOnline;
    
    NSString *strAPISelection;
    NSString *hourText, *minuteText;
    BOOL flgUserOnline;
    
}@synthesize locationManager;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.txtMessage.delegate = self;

    //TODO: CHeck here
    self.strJid = [self.strJid lowercaseString];
    
    self.hourSlider.minimumTrackTintColor = Theme_Color;
    self.minuteSlider.minimumTrackTintColor = Theme_Color;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    
    [self.navigationController.navigationBar addSubview:self.topView];
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    self.lblSetDate.text = [MCLocalization stringForKey:@"Set Date"];
    self.lblDate.text = [MCLocalization stringForKey:@"Date"];
    self.lblTime.text = [MCLocalization stringForKey:@"Time"];
    self.lblHours.text = [MCLocalization stringForKey:@"Hours :"];
    self.lblMins.text = [MCLocalization stringForKey:@"Minutes :"];
    self.lblAM.text = @"AM";
    self.lblPM.text = @"PM";
    
    [self.btnDateTime setTitle:[MCLocalization stringForKey:@"Select DATE and TIME"] forState:UIControlStateNormal];
    [self.btnSaveReq setTitle:[MCLocalization stringForKey:@"Set Date and Time"] forState:UIControlStateNormal];
    [self.btnSave setTitle:[MCLocalization stringForKey:@"save"] forState:UIControlStateNormal];
    
    strAPISelection=[[NSString alloc] init];

    
    

    
    //get user preferences
    NSArray *tempString = [[appDelegate GetData:kdatePref] componentsSeparatedByString:@","];
    pref1=tempString[0];
    pref2=tempString[1];
    pref3=tempString[2];
    pref4=tempString[3];
    
    //set view according to user preferences
    switch ([pref1 intValue]) {
        case 1:
            self.imgPref1.image=[UIImage imageNamed:@"iconCoffee"];
            self.lblPref1.text=[MCLocalization stringForKey:@"Coffee"];
            break;
        case 2:
            self.imgPref1.image=[UIImage imageNamed:@"iconDrink"];
            self.lblPref1.text=[MCLocalization stringForKey:@"Drink"];
            break;
        case 3:
            self.imgPref1.image=[UIImage imageNamed:@"iconFood"];
            self.lblPref1.text=[MCLocalization stringForKey:@"Food"];
            break;
        case 4:
            self.imgPref1.image=[UIImage imageNamed:@"iconFun"];
            self.lblPref1.text=[MCLocalization stringForKey:@"Fun"];
            break;
            
        default:
            break;
    }
    switch ([pref2 intValue]) {
        case 1:
            self.imgPref2.image=[UIImage imageNamed:@"iconCoffee"];
            self.lblPref2.text=[MCLocalization stringForKey:@"Coffee"];
            break;
        case 2:
            self.imgPref2.image=[UIImage imageNamed:@"iconDrink"];
            self.lblPref2.text=[MCLocalization stringForKey:@"Drink"];
            break;
        case 3:
            self.imgPref2.image=[UIImage imageNamed:@"iconFood"];
            self.lblPref2.text=[MCLocalization stringForKey:@"Food"];
            break;
        case 4:
            self.imgPref2.image=[UIImage imageNamed:@"iconFun"];
            self.lblPref2.text=[MCLocalization stringForKey:@"Fun"];
            break;
            
        default:
            break;
    }
    switch ([pref3 intValue]) {
        case 1:
            self.imgPref3.image=[UIImage imageNamed:@"iconCoffee"];
            self.lblPref3.text=[MCLocalization stringForKey:@"Coffee"];
            break;
        case 2:
            self.imgPref3.image=[UIImage imageNamed:@"iconDrink"];
            self.lblPref3.text=[MCLocalization stringForKey:@"Drink"];
            break;
        case 3:
            self.imgPref3.image=[UIImage imageNamed:@"iconFood"];
            self.lblPref3.text=[MCLocalization stringForKey:@"Food"];
            break;
        case 4:
            self.imgPref3.image=[UIImage imageNamed:@"iconFun"];
            self.lblPref3.text=[MCLocalization stringForKey:@"Fun"];
            break;
            
        default:
            break;
    }
    switch ([pref4 intValue]) {
        case 1:
            self.imgPref4.image=[UIImage imageNamed:@"iconCoffee"];
            self.lblPref4.text=[MCLocalization stringForKey:@"Coffee"];
            break;
        case 2:
            self.imgPref4.image=[UIImage imageNamed:@"iconDrink"];
            self.lblPref4.text=[MCLocalization stringForKey:@"Drink"];
            break;
        case 3:
            self.imgPref4.image=[UIImage imageNamed:@"iconFood"];
            self.lblPref4.text=[MCLocalization stringForKey:@"Food"];
            break;
        case 4:
            self.imgPref4.image=[UIImage imageNamed:@"iconFun"];
            self.lblPref4.text=[MCLocalization stringForKey:@"Fun"];
            break;
            
        default:
            break;
    }
    //set chat header
    self.lblName.text=self.strChatName;
    
    [self.act startAnimating];
    [self.imgProfile sd_setImageWithURL:[Util EncodedURL:self.strImgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image!=nil){
            self.imgProfile.image=image;
        }
        else{
            self.imgProfile.image = [UIImage imageNamed:@"TempProfile"];
        }
        [self.act stopAnimating];
    }];
    
    //set text color for chat textbox
    UIColor *color = [UIColor whiteColor];
    
    UIFont *font=[UIFont fontWithName:@"Lato-Regular" size:12];
    self.txtMessage.attributedPlaceholder = [[NSAttributedString alloc] initWithString: [MCLocalization stringForKey:@" Type your message..."] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    
    //add sample data for chat display--> remove once data is available from sever
    self.btnDateTime.titleLabel.text=[MCLocalization stringForKey:@"Select DATE and TIME"];
    self.btnSaveReq.titleLabel.text=[MCLocalization stringForKey:@"Send Date Request"];

    
    dateTime=[[NSMutableString alloc] init];
    messageCount=arrSelection.count;
    screenRect = [[UIScreen mainScreen] bounds];
    hide=@"Yes";

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];

    [self CalenderData];
    
    self.tblChat.tag=100;
    
    self.tblPlaceSearch.tag = 101;
    self.tblSelectedPlace.tag = 102;
    
    _hourSlider.minimumValue = 1;
    _hourSlider.maximumValue = 12;
    _hourSlider.continuous = YES;
    _hourSlider.value = 00;
    
    _minuteSlider.minimumValue = 0;
    _minuteSlider.maximumValue = 59;
    _minuteSlider.continuous = YES;
    _minuteSlider.value = 00;
    
    // As the slider moves it will continously call the -valueChanged:
    
    _hourSlider.continuous = YES;
    [_hourSlider addTarget:self action:@selector(hoursliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_minuteSlider addTarget:self action:@selector(minutesliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    [_hourSlider setThumbImage: [UIImage imageNamed:@"SliderHandle"] forState:UIControlStateNormal];
    [_minuteSlider setThumbImage: [UIImage imageNamed:@"SliderHandle"] forState:UIControlStateNormal];
    
    UISwipeGestureRecognizer *swipeRightOrange = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    swipeRightOrange.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeLeftOrange = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    swipeLeftOrange.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.viewPoint addGestureRecognizer:swipeRightOrange];
    [self.viewPoint addGestureRecognizer:swipeLeftOrange];
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    [self.viewAmPmSlide addGestureRecognizer:singleTapGestureRecognizer];
    
    /*to get place search*/
    
    [LocationHelper sharedInstance].delegate=self;
    [[LocationHelper sharedInstance] updateLocation];
    
    rating = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    distance = [[NSMutableArray alloc]init];
    imgPlaces = [[NSMutableArray alloc]init];
    placeId=[[NSMutableArray alloc]init];
    [rating addObject:@""];
    [name addObject:@""];
    [distance addObject:@""];
    [imgPlaces addObject:@""];
    
    _placesClient = [GMSPlacesClient sharedClient];
    
    
    [XMPPMessageArchivingCoreDataStorage sharedInstance].delegate=self;
    [XMPPMessageArchivingCoreDataStorage sharedInstance].otherjid=self.strJid;

}
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.topView.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    appDelegate.strPageName = @"DoChatPage";
    
    selectedrow = 0;
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    [SSOnlineOfflineFriends shareInstance].delegate = self;
    [[SSOnlineOfflineFriends shareInstance] setSSOnlineOfflineFriendsDelegate];
    
    [[SSConnectionClasses shareInstance] updateUserUnreadMessageOfJID:self.strJid];
    
    [SSMessageControl shareInstance].otherjid = self.strJid;
    [SSMessageControl shareInstance].delegate = self;
    [[SSMessageControl shareInstance] setSSMessageDelegate];
    [self.txtMessage resignFirstResponder];
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect tempFrame = self.topView.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    tempFrame.size.width = SCREEN_SIZE.width;
    self.topView.frame = tempFrame;
    
    //make image round
    self.SelectedplaceView.frame=CGRectMake(0, -self.SelectedplaceView.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.SelectedplaceView.frame.size.height);
    self.setDateView.frame=CGRectMake(0, -self.setDateView.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.setDateView.frame.size.height);
    self.placeView.frame=CGRectMake(0, -self.placeView.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.placeView.frame.size.height);

    self.imgProfile.frame = CGRectMake(0, 0, self.imgProfile.frame.size.height, self.imgProfile.frame.size.height);
    self.act.center = self.imgProfile.center;
    self.btnReport.frame = CGRectMake(self.btnReport.frame.origin.x, 3, self.navigationController.navigationBar.frame.size.height-8, self.navigationController.navigationBar.frame.size.height-8);
    
    self.imgProfile.layer.cornerRadius=(self.imgProfile.frame.size.height/2);
    self.imgProfile.layer.masksToBounds = YES;
    UIColor *border= [UIColor whiteColor];
    self.imgProfile.layer.borderColor=border.CGColor;
    [self.imgProfile.layer setBorderWidth: 2.0];
    
    CGRect temp = self.imgPref1.frame;
    temp.size.height = temp.size.width;
    self.imgPref1.frame = temp;
    temp.origin.x = self.imgPref2.frame.origin.x;
    self.imgPref2.frame = temp;
    temp.origin.x = self.imgPref3.frame.origin.x;
    self.imgPref3.frame = temp;
    temp.origin.x = self.imgPref4.frame.origin.x;
    self.imgPref4.frame = temp;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    appDelegate.strPageName=@"";
    self.topView.hidden = YES;
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [SSMessageControl shareInstance].delegate=nil;
    [SSOnlineOfflineFriends shareInstance].delegate=nil;
    
    [XMPPMessageArchivingCoreDataStorage sharedInstance].delegate=nil;
    [XMPPMessageArchivingCoreDataStorage sharedInstance].otherjid=nil;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Location Delegate
/*!
 * @discussion Set Latitude and Longitude from delegate
 */
- (void) LocationUpdated
{
    latitude_UserLocation= [[LocationHelper sharedInstance].latitude floatValue];
    longitude_UserLocation= [[LocationHelper sharedInstance].longitude floatValue];
}

#pragma mark - btnClick
/*!
 * @discussion Go to user Display Page
 * @param sender For indentify sender
 */
- (IBAction)btnUserDetailClicked:(id)sender
{
    [self getUserDetails:self.strFriendId];
}
/*!
 * @discussion Send message
 * @param sender For indentify sender
 */
- (IBAction)btnSendClicked:(id)sender
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    self.txtMessage.text = [self.txtMessage.text stringByTrimmingCharactersInSet:whitespace];
    
    if (self.txtMessage.text.length>0)
    {
         if ([self.lblOnlineOffline.text isEqualToString:@"Online"] || [self.lblOnlineOffline.text isEqualToString:@"Typing..."])
         {
                    [[SSMessageControl shareInstance] sendPausedChatToUser:self.strJid];
         }
        [[SSMessageControl shareInstance] sendMessage:self.txtMessage.text to:self.strJid];
        if (!([self.lblOnlineOffline.text isEqualToString:[MCLocalization stringForKey:@"Online"]] || [self.lblOnlineOffline.text isEqualToString:[MCLocalization stringForKey:@"Typing..."]]))
        {
            [self SendPush:self.strFriendId Message:self.txtMessage.text UserID:[appDelegate GetData:kuserid]];
        }
        self.txtMessage.text=nil;
    }
}

-(void)closePreferences {
    hide = @"Yes";
    [UIView animateWithDuration:0.7 animations:^{
        CGRect temp = self.viewPreferences.frame;
        temp.origin.y = screenRect.size.height;
        self.viewPreferences.frame = temp;
    } completion:^(BOOL finished) {
        self.popupBG.hidden = YES;
    }];
}

/*!
 * @discussion Close Pop-up for Date Request
 * @param sender For indentify sender
 */

- (IBAction)btnCloseClicked:(id)sender
{
    //close all the pop-ups open for send date request
    [self btnClosePlaceClicked:nil];
    [self btnCloseSelectedPlaceClicked:nil];
    [self btnCloseDateTimeClicked:nil];
    self.popupBG.hidden = YES;

}

- (IBAction)btnClosePlaceClicked:(id)sender
{
    [UIView animateWithDuration:0.7 animations:^{
        self.placeView.frame=CGRectMake(0, -(self.placeView.frame.size.height), [UIScreen mainScreen].bounds.size.width, self.placeView.frame.size.height);
    } completion:^(BOOL finished) {
        self.popupBG.hidden = YES;

    }];
}
- (IBAction)btnCloseSelectedPlaceClicked:(id)sender
{
    [UIView animateWithDuration:0.7 animations:^{
        self.SelectedplaceView.frame=CGRectMake(0, -(self.SelectedplaceView.frame.size.height), [UIScreen mainScreen].bounds.size.width, self.SelectedplaceView.frame.size.height);
    } completion:^(BOOL finished) {
        [self.btnDateTime setTitle:[MCLocalization stringForKey:@"Select DATE and TIME"] forState:UIControlStateNormal];
        [self.btnSaveReq setTitle:[MCLocalization stringForKey:@"Set Date and Time"] forState:UIControlStateNormal];
    }];
}
- (IBAction)btnCloseDateTimeClicked:(id)sender
{
    [UIView animateWithDuration:0.7 animations:^{
        self.setDateView.frame=CGRectMake(0, -(self.setDateView.frame.size.height), [UIScreen mainScreen].bounds.size.width, self.setDateView.frame.size.height);
    } completion:^(BOOL finished) {
        self.hourSlider.value=1;
        self.minuteSlider.value=0;
        self.hour.text=@"HH";
        self.minute.text=@"MM";
        
        NSCalendar *calendar1 = [NSCalendar currentCalendar];
        NSDate *currentDate = [NSDate date];
        int currentDay = (int)[calendar1 component:NSCalendarUnitDay fromDate:currentDate];
        int currentMonth = (int)[calendar1 component:NSCalendarUnitMonth fromDate:currentDate];
        int currentYear = (int)[calendar1 component:NSCalendarUnitYear fromDate:currentDate];
        
        dateTime=[NSString stringWithFormat:@"%.2d/%.2d/%.4d",currentDay,currentMonth,currentYear];
        
        [calendar reloadData];
    }];
}
/*!
 * @discussion Set Date and time if Not already set, otherwise send Date Request
 * @param sender For indentify sender
 */
- (IBAction)btnsetDateandTimeClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;

    //set date time and send date request
    if(btn.tag ==1)
    {
        //set date time or send date request button
        if([self.btnSaveReq.titleLabel.text isEqualToString:[MCLocalization stringForKey:@"Send Date Request"]])
        {
            //send date request
            [calendar reloadData];
            
            NSCalendar *calendar1 = [NSCalendar currentCalendar];
            NSDate *currentDate = [NSDate date];
            int currentDay = (int)[calendar1 component:NSCalendarUnitDay fromDate:currentDate];
            int currentMonth = (int)[calendar1 component:NSCalendarUnitMonth fromDate:currentDate];
            int currentYear = (int)[calendar1 component:NSCalendarUnitYear fromDate:currentDate];
            
            dateTime=[NSString stringWithFormat:@"%.2d/%.2d/%.4d",currentDay,currentMonth,currentYear];
            
            
            [UIView animateWithDuration:0.7 animations:^{
                self.SelectedplaceView.frame=CGRectMake(0, -(self.SelectedplaceView.frame.size.height), [UIScreen mainScreen].bounds.size.width, self.SelectedplaceView.frame.size.height);
                self.placeView.frame=CGRectMake(0, -(self.placeView.frame.size.height), [UIScreen mainScreen].bounds.size.width, self.placeView.frame.size.height);
                } completion:^(BOOL finished) {
                    
                    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
                    [dict1 setObject:self.btnDateTime.titleLabel.text forKey:@"TimeOfDate"];
                    [self.btnDateTime setTitle:[MCLocalization stringForKey:@"Select DATE and TIME"] forState:UIControlStateNormal];
                    [self.btnSaveReq setTitle:[MCLocalization stringForKey:@"Set Date and Time"] forState:UIControlStateNormal];
                    
                    self.popupBG.hidden = YES;
                    
                    //sender type :0-sender, 1-reciever, cell type:0-message, 1-date request
                    [dict1 setObject:[imgPlaces objectAtIndex:selectedrow] forKey:@"imgPlace"];
                    [dict1 setObject:[rating objectAtIndex:selectedrow]   forKey:@"StarRating"];
                    [dict1 setObject:[name objectAtIndex:selectedrow] forKey:@"Title"];
                    
                    float dis = [[distance objectAtIndex:selectedrow] floatValue];
                    [dict1 setObject:[NSString stringWithFormat:@"%.2f miles",dis] forKey:@"Distance"];

                    NSError *error;
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict1
                                                                       options:NSJSONWritingPrettyPrinted 
                                                                         error:&error];
                    
                    if (! jsonData)
                    {
                        NSLog(@"Got an error: %@", error);
                    }
                    else
                    {
                        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        
                        NSString *strSendRequest=[NSString stringWithFormat:@"$***$%@$***$%@#",[placeId objectAtIndex:selectedrow],jsonString];
                        
//                        NSData *data = [strSendRequest dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//                        NSString *goodValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

                        NSData *data1 = [strSendRequest dataUsingEncoding:NSUTF16StringEncoding];
                        NSString *decodevalue = [[NSString alloc] initWithData:data1 encoding:NSUTF16StringEncoding];
                        
                        [[SSMessageControl shareInstance] sendMessage:decodevalue to:self.strJid];
                        if (![self.lblOnlineOffline.text isEqualToString:[MCLocalization stringForKey:@"Online"]])
                        {
                            [self SendPush:self.strFriendId Message:@"Date Request..." UserID:[appDelegate GetData:kuserid]];
                        }
                    }
                    dateTime = [[NSMutableString alloc] init];
                    [self.btnDateTime setTitle:[MCLocalization stringForKey:@"Select DATE and TIME"] forState:UIControlStateNormal];
                    [self.btnSaveReq setTitle:[MCLocalization stringForKey:@"Set Date and Time"] forState:UIControlStateNormal];
                    
                    self.timepickView.hidden=YES;
                    self.datepickView.hidden=NO;
            }];
        }
        else
        {
            //set date time
            [UIView animateWithDuration:0.7 animations:^{
                self.setDateView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.setDateView.frame.size.height);
            } completion:^(BOOL finished) {
                self.popupBG.hidden = NO;
            }];
        }
    }
    else
    {
        //set date time button
        self.viewDate.backgroundColor = [Util colorWithHexString:@"AAAAAA"];
        self.viewTime.backgroundColor = [Util colorWithHexString:@"555555"];
        
        if ([self.btnDateTime.titleLabel.text isEqualToString:[MCLocalization stringForKey:@"Select DATE and TIME"]]) {
            //no time and date selected
            //set current time
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:now];
            NSDateComponents *components1 = [calendar components:NSCalendarUnitMinute fromDate:now];

            if ((int)[components hour] > 12) {
                self.hour.text = [NSString stringWithFormat:@"%02d", (int)[components hour] - 12];
                [self.hourSlider setValue:(int)[components hour] - 12 animated:YES];
                [self handleSingleTapGesture:nil];
            } else {
                self.hour.text = [NSString stringWithFormat:@"%02d", (int)[components hour]];
                [self.hourSlider setValue:(int)[components hour] animated:YES];
            }
            self.minute.text = [NSString stringWithFormat:@"%02d", (int)[components1 minute]];
            [self.minuteSlider setValue:(int)[components1 minute] animated:YES];
        } else {
            //date and time is selected
            int hh = [hourText intValue];
            int mm = [minuteText intValue];
            [self.hourSlider setValue:hh animated:YES];
            [self.minuteSlider setValue:mm animated:YES];
            self.hour.text = [NSString stringWithFormat:@"%02d", (int)self.hourSlider.value];
            self.minute.text = [NSString stringWithFormat:@"%02d", (int)self.minuteSlider.value];
        }
        
        [UIView animateWithDuration:0.7 animations:^{
            self.setDateView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.setDateView.frame.size.height);
        } completion:^(BOOL finished) {
            self.popupBG.hidden = NO;
        }];
    }
    
}
/*!
 * @discussion Display Time Selection View
 * @param sender For indentify sender
 */
- (IBAction)btnTimeClicked:(id)sender {
    self.timepickView.hidden=NO;
    self.datepickView.hidden=YES;
    
    self.viewDate.backgroundColor = [Util colorWithHexString:@"555555"];
    self.viewTime.backgroundColor = [Util colorWithHexString:@"AAAAAA"];
}
/*!
 * @discussion Display Date Selection View
 * @param sender For indentify sender
 */
- (IBAction)btnDate1Clicked:(id)sender {
    self.datepickView.hidden=NO;
    self.timepickView.hidden=YES;
    
    self.viewDate.backgroundColor = [Util colorWithHexString:@"AAAAAA"];
    self.viewTime.backgroundColor = [Util colorWithHexString:@"555555"];
}
/*!
 * @discussion Save Selected Date and Time
 * @param sender For indentify sender
 */
- (IBAction)btnSaveDateClicked:(id)sender {
    if([dateTime isEqualToString:@""]){
        self.datepickView.hidden=NO;
        self.timepickView.hidden=YES;
        ALERTVIEW([MCLocalization stringForKey:@"Please select proper Date"], self);
        return;
    }
//    Get current Date and selected Date
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    int currentDay = (int)[calendar1 component:NSCalendarUnitDay fromDate:currentDate];
    int currentMonth = (int)[calendar1 component:NSCalendarUnitMonth fromDate:currentDate];
    int currentYear = (int)[calendar1 component:NSCalendarUnitYear fromDate:currentDate];
    
    NSString *selectedDate = dateTime;
    NSString *currentDate1 = [NSString stringWithFormat:@"%.2d/%.2d/%.4d",currentDay,currentMonth,currentYear];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *selectedDateFormat = [dateFormatter dateFromString:selectedDate];
    NSDate *currentDateFormat = [dateFormatter dateFromString:currentDate1];

    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [selectedDateFormat compare:currentDateFormat]; // comparing two dates
    
//    get current time and selected time
    NSString *ampm;
    if(self.viewPoint.frame.origin.x == 0)
    {
        ampm=@"PM";
    }
    else
    {
        ampm = @"AM";
    }
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:@"hh:mm a"];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *date1 = [NSDate date];
    
    int hour1 = (int)[cal component:NSCalendarUnitHour fromDate:date1];
    int minute = (int)[cal component:NSCalendarUnitMinute fromDate:date1];
    NSString *am = @"AM";
    
    int hour;
    if(hour1>12)
    {
        hour = hour1 - 12;
        am = @"PM";
    }
    else
    {
        hour = hour1;
    }
    
    NSString *currentTime1 = [NSString stringWithFormat:@"%.2d:%.2d %@",hour,minute,am];
    
    NSString *selectedTime1 = [NSString stringWithFormat:@"%@:%@ %@",([self.hour.text isEqualToString:@"HH"]?@"12":self.hour.text),([self.minute.text isEqualToString:@"MM"]?@"00":self.minute.text),ampm];
    
    hourText = [self.hour.text isEqualToString:@"HH"]?@"12":self.hour.text;
    minuteText = [self.minute.text isEqualToString:@"MM"]?@"00":self.minute.text;
    
    NSDate *currentTime = [dateFormatter1 dateFromString:currentTime1];
    NSDate *selectedTime = [dateFormatter1 dateFromString:selectedTime1];
    
    NSComparisonResult result1;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result1 = [selectedTime compare:currentTime]; // comparing two dates

    NSString *temp = [NSString stringWithFormat:@"%@ , %@",dateTime,selectedTime1];


    if(result == NSOrderedAscending) {
        //selected date is less then current date
    }
    else if(result == NSOrderedDescending) {
       //selected date is greater then current date
        [UIView animateWithDuration:0.7 animations:^{
            self.setDateView.frame = CGRectMake(0, -(self.setDateView.frame.size.height), [UIScreen mainScreen].bounds.size.width, self.setDateView.frame.size.height);
        } completion:^(BOOL finished) {
            self.popupBG.hidden = NO;
            //save date
            [self.btnDateTime setTitle:temp forState:UIControlStateNormal];
            [self.btnSaveReq setTitle:[MCLocalization stringForKey:@"Send Date Request"] forState:UIControlStateNormal];
            self.datepickView.hidden = NO;
            self.timepickView.hidden = YES;
            self.hourSlider.value = 1;
            self.minuteSlider.value = 0;
            self.hour.text = @"HH";
            self.minute.text = @"MM";
            
            [self.vwSaveRequest setHidden:false];
        }];
        [UIView animateWithDuration:0.7 animations:^{
            self.SelectedplaceView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.SelectedplaceView.frame.size.height);
        }];

    }
    else {
        
        if(result1==NSOrderedAscending) {
            ALERTVIEW([MCLocalization stringForKey:@"Please Select Future date and time"], self);
        }
        else if(result1==NSOrderedDescending) {
            [UIView animateWithDuration:0.7 animations:^{
                self.setDateView.frame=CGRectMake(0, -(self.setDateView.frame.size.height), [UIScreen mainScreen].bounds.size.width, self.setDateView.frame.size.height);
            } completion:^(BOOL finished) {
                self.popupBG.hidden = YES;
                self.popupBG.hidden = NO;
                //save date
                [self.btnDateTime setTitle:temp forState:UIControlStateNormal];
                [self.btnSaveReq setTitle:[MCLocalization stringForKey:@"Send Date Request"] forState:UIControlStateNormal];
                self.datepickView.hidden = NO;
                self.timepickView.hidden = YES;
                self.hourSlider.value = 1;
                self.minuteSlider.value = 0;
                self.hour.text = @"HH";
                self.minute.text = @"MM";
                
                [self.vwSaveRequest setHidden:false];
            }];
            [UIView animateWithDuration:0.7 animations:^{
                self.SelectedplaceView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.SelectedplaceView.frame.size.height);
            }];

        }
        else
        {
            ALERTVIEW([MCLocalization stringForKey:@"selected time is equal to current time.Please select future time"], self);
        }
    }
}
/*!
 * @discussion Go back to Chat List
 * @param sender For indentify sender
 */

- (IBAction)btnBackClicked:(id)sender
{
    if (self.strComeFrom.length>0)
    {
        //when come from it's a match
        ChatVC *VC = [[ChatVC alloc] initWithNibName:@"ChatVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}
/*!
 * @discussion Open Menu
 * @param sender For indentify sender
 */
- (IBAction)btnMenuClicked:(id)sender {

    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];
}
/*!
 * @discussion Date Request for Preference one
 * @param sender For indentify sender
 */
- (IBAction)btnOneClicked:(id)sender
{
    SHOW_LOADER_ANIMTION();
    
    //open pop-ups for preference one
    [self.txtMessage resignFirstResponder];
    
    switch ([pref1 intValue]) {
        case 1:
            set=1;
            break;
        case 2:
            set=2;
            break;
        case 3:
            set=3;
            break;
        case 4:
            set=4;
            break;
            
        default:
            break;
    }

    [self searchforPlaces];
    [self.tblPlaceSearch reloadData];
    
    if(imgPlaces.count==0)
    {
        HIDE_PROGRESS;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:appNAME message:[MCLocalization stringForKey:@"There is no nearby Place to Show"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSIndexPath* ip = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tblPlaceSearch scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [UIView animateWithDuration:0.7 animations:^{
        self.placeView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.placeView.frame.size.height);
    } completion:^(BOOL finished) {
        self.popupBG.hidden = NO;
        HIDE_PROGRESS;
    }];
}
/*!
 * @discussion Date Request for Preference two
 * @param sender For indentify sender
 */
- (IBAction)btnTwoClicked:(id)sender
{
    SHOW_LOADER_ANIMTION();
    
    //open pop-ups for preference two
    [self.txtMessage resignFirstResponder];
    
    switch ([pref2 intValue]) {
        case 1:
            set=1;
            break;
        case 2:
            set=2;
            break;
        case 3:
            set=3;
            break;
        case 4:
            set=4;
            break;
        default:
            break;
    }
    
    [self searchforPlaces];
    [self.tblPlaceSearch reloadData];
    
    if(imgPlaces.count==0)
    {
        HIDE_PROGRESS;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:appNAME message:[MCLocalization stringForKey:@"There is no nearby Place to Show"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSIndexPath* ip = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tblPlaceSearch scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [UIView animateWithDuration:0.7 animations:^{
        self.placeView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.placeView.frame.size.height);
    } completion:^(BOOL finished) {
        self.popupBG.hidden = NO;
        HIDE_PROGRESS;
    }];

}
/*!
 * @discussion Date Request for Preference three
 * @param sender For indentify sender
 */
- (IBAction)btnThreeClicked:(id)sender
{
    SHOW_LOADER_ANIMTION();

    //open pop-ups for preference three
    [self.txtMessage resignFirstResponder];
    
    switch ([pref3 intValue]) {
        case 1:
            set=1;
            break;
        case 2:
            set=2;
            break;
        case 3:
            set=3;
            break;
        case 4:
            set=4;
            break;
        default:
            break;
    }

    [self searchforPlaces];
    [self.tblPlaceSearch reloadData];
    
    if(imgPlaces.count == 0)
    {
        HIDE_PROGRESS;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:appNAME message:[MCLocalization stringForKey:@"There is no nearby Place to Show"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){   }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSIndexPath* ip = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tblPlaceSearch scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [UIView animateWithDuration:0.7 animations:^{
        self.placeView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.placeView.frame.size.height);
    } completion:^(BOOL finished) {
        self.popupBG.hidden = NO;
        HIDE_PROGRESS;
    }];
}
/*!
 * @discussion Date Request for Preference Four
 * @param sender For indentify sender
 */
- (IBAction)btnFourClicked:(id)sender
{
    SHOW_LOADER_ANIMTION();
    //open pop-ups for preference four
    [self.txtMessage resignFirstResponder];
    
    switch ([pref4 intValue]) {
        case 1:
            set=1;
            break;
        case 2:
            set=2;
            break;
        case 3:
            set=3;
            break;
        case 4:
            set=4;
            break;
            
        default:
            break;
    }

    [self searchforPlaces];
    [self.tblPlaceSearch reloadData];
    
    if(imgPlaces.count == 0)
    {
        HIDE_PROGRESS;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:appNAME message:[MCLocalization stringForKey:@"There is no nearby Place to Show"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Ok"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){   }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSIndexPath* ip = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tblPlaceSearch scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [UIView animateWithDuration:0.7 animations:^{
        self.placeView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.placeView.frame.size.height);
    } completion:^(BOOL finished) {
        self.popupBG.hidden = NO;
        HIDE_PROGRESS;
    }];

}
/*!
 * @discussion Display all Date Preference
 * @param sender For indentify sender
 */
- (IBAction)btnDateClicked:(id)sender
{
    
    if ([[appDelegate GetData:GOOGLE_API_KEY] isEqualToString:@""] || [[appDelegate GetData:GOOGLE_API_KEY] isEqualToString:@"Key Not Found"]) {
        return;
    } else {
        //display date preferences icon for sending date request
        [self.txtMessage resignFirstResponder];
        if([hide isEqualToString:@"No"]){
            [self closePreferences];
        }
        else{
            hide=@"No";
            [UIView animateWithDuration:0.5 animations:^{
                self.viewPreferences.frame = CGRectMake(0, self.bottomView.frame.origin.y-self.viewPreferences.frame.size.height-5, SCREEN_SIZE.width, self.viewPreferences.frame.size.height);
            }];
        }
    }
}
/*!
 * @discussion Select Place
 * @param sender For indentify sender
 */
-(void)btncellClicked:(UIButton*)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.placeView.frame=CGRectMake(0, -(self.placeView.frame.size.height), [UIScreen mainScreen].bounds.size.width, self.placeView.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.SelectedplaceView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.SelectedplaceView.frame.size.height);
        } completion:^(BOOL finished) {
            self.popupBG.hidden = NO;
        }];
    }];
}
/*!
 * @discussion Accept Date request
 * @param sender For indentify sender
 */
-(void)btnAcceptClicked:(UIButton*)sender
{
    UIButton *btn=(UIButton  *)sender;
    
    NSString *str=[[arrSelection objectAtIndex:btn.tag] valueForKey:@"Message"];
    //    str=[self JSONStringRemove:str];
    NSString *strAccept=[NSString stringWithFormat:@"%@1",str];
    [[SSMessageControl shareInstance] sendMessage:strAccept to:self.strJid];
    
    
    if (![self.lblOnlineOffline.text isEqualToString:@"Online"])
    {
        [self SendPush:self.strFriendId Message:@"Date Request Accepted." UserID:[appDelegate GetData:kuserid]];
    }
    
    NSArray *arr = [[[arrSelection objectAtIndex: btn.tag] valueForKey:@"Message"] componentsSeparatedByString:@"$***$"];
    NSArray *arr1 =[[arr objectAtIndex:arr.count-1] componentsSeparatedByString:@"#"];
    NSString *strJson=[arr1 objectAtIndex:0];
    NSLog(@"%@",strJson);
    NSData *webData = [strJson dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:webData options:0 error:&error];
    
    //event entry calender
    
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        
        NSArray *arrTemp=[strAccept componentsSeparatedByString:@"\"TimeOfDate\" : \"" ];
        if (arrTemp.count==1) {
            arrTemp=[strAccept componentsSeparatedByString:@"\"TimeOfDate\":\"" ];
        }
        
        
        NSArray *arrTemp2=[[arrTemp objectAtIndex:1] componentsSeparatedByString:@"\"Title\" : \""];
        if (arrTemp2.count==1) {
            arrTemp2=[[arrTemp objectAtIndex:1] componentsSeparatedByString:@"\"Title\":\""];
        }
        
        NSString *strDateTime=[arrTemp2 objectAtIndex:0];
        NSLog(@"%@",strDateTime);
        
        NSArray *strTemp7=[[arrTemp2 objectAtIndex:1] componentsSeparatedByString:@"\","] ;
        NSString *location=[strTemp7 objectAtIndex:0];
        NSLog(@"%@",location);
        
        NSArray *arrTemp3=[strDateTime componentsSeparatedByString:@"\\/"];
        int day=[[arrTemp3 objectAtIndex:1] intValue];
        int month=[[arrTemp3 objectAtIndex:0] intValue];
        
        NSArray *arrTemp4=[[arrTemp3 objectAtIndex:2] componentsSeparatedByString:@" , "];
        if (arrTemp4.count==1) {
              arrTemp4=[[arrTemp3 objectAtIndex:2] componentsSeparatedByString:@","];
        }
        
        int year=[[arrTemp4 objectAtIndex:0] intValue];
        NSArray *arrTemp5=[[arrTemp4 objectAtIndex:1] componentsSeparatedByString:@
                           " "];
        
        NSArray *arrTemp6=[[arrTemp5 objectAtIndex:0] componentsSeparatedByString:@":"];
        int hours=[[arrTemp6 objectAtIndex:0] intValue];
        int minutes=[[arrTemp6 objectAtIndex:1] intValue];
        
        NSArray *arrTemp7=[[arrTemp5 objectAtIndex:1] componentsSeparatedByString:@"\""];
        NSString *strAmPm=[arrTemp7 objectAtIndex:0] ;
        
        NSLog(@"ampm=%@",strAmPm);
        if([strAmPm isEqualToString:@"PM"]){
            hours=hours+12;
        }
        
        NSLog(@"day=%d,month=%d,year=%d,hours=%d,minutes=%d",day,month,year,hours,minutes);
        
        
        // Get the appropriate calendar
        NSCalendar *myCalendar = [NSCalendar currentCalendar];
        
        // Create the start date components
        NSDateComponents *startComponents = [[NSDateComponents alloc] init];
        startComponents.timeZone=[NSTimeZone defaultTimeZone];
        [startComponents setDay:day];
        [startComponents setMonth:month];
        [startComponents setYear:year];
        [startComponents setHour: hours];
        [startComponents setMinute:minutes];
        [startComponents setSecond:0];
        
        NSDate *startDate=[[myCalendar dateFromComponents:startComponents] dateByAddingTimeInterval:0];
        NSDate *endDate = [[myCalendar dateFromComponents:startComponents] dateByAddingTimeInterval:60*60]; //set 1 hour meeting
        
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = [NSString stringWithFormat:@"%@:Date with %@",appNAME, self.lblName.text];
        NSLog(@"%@",[self ConvertedText:[jsonDict valueForKey:@"Title"]]);
        event.location=[self ConvertedText:[jsonDict valueForKey:@"Title"]];
        event.startDate=startDate;
        event.endDate=endDate;
        
        //set alarm 1 hour befor event
        EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:60*60*-1];
        event.alarms = [NSArray arrayWithObject:alarm];
        event.calendar = [store defaultCalendarForNewEvents];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
    }];
}
/*!
 * @discussion Decline Date Request
 * @param sender For indentify sender
 */
-(void)btnDeclineClicked:(UIButton*)sender
{
    UIButton *btn=(UIButton * )sender;
    NSString *str=[[arrSelection objectAtIndex:btn.tag] valueForKey:@"Message"];

    NSString *strDecline=[NSString stringWithFormat:@"%@0",str];

    [[SSMessageControl shareInstance] sendMessage:strDecline to:self.strJid];
    if (![self.lblOnlineOffline.text isEqualToString:[MCLocalization stringForKey:@"Online"]])
    {
        [self SendPush:self.strFriendId Message:@"Date Request Declined." UserID:[appDelegate GetData:kuserid]];
    }
}
/*!
 * @discussion Options for blocking user
 * @param sender For indentify sender
 */
- (IBAction)btnOptionsClicked:(id)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:[MCLocalization stringForKey:@"Options"] preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Block"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        strAPISelection=@"Block";

        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:appNAME message:[MCLocalization stringForKey:@"Are you Sure Want to Block User ?"] delegate:self cancelButtonTitle:[MCLocalization stringForKey:@"Cancel"] otherButtonTitles:[MCLocalization stringForKey:@"Yes"], nil];
//        [alert show];
       
        
        [self dismissViewControllerAnimated:YES completion:nil];
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:appNAME
                                     message:@"Are you Sure Want to Block User?"
                                     preferredStyle:UIAlertControllerStyleAlert];
        //Add Buttons
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        [self BlockUser:self.strFriendId];
                                    }];
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        
        //Add your buttons to alert controller
        
        [alert addAction:noButton];
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];

    }]];

    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"UnMatch"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        strAPISelection=@"Unmatch";
        
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:appNAME message:[MCLocalization stringForKey:@"Are you Sure Want to Unmatch with this User ?"] delegate:self cancelButtonTitle:[MCLocalization stringForKey:@"Cancel"] otherButtonTitles:[MCLocalization stringForKey:@"Yes"],nil];
//        [alert show];

        [self dismissViewControllerAnimated:YES completion:nil];
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:appNAME
                                     message:@"Are you Sure Want to Unmatch with this User?"
                                     preferredStyle:UIAlertControllerStyleAlert];
        //Add Buttons
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        [self UnMatchUser:self.strFriendId];
                                    }];
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        
        //Add your buttons to alert controller
        
        [alert addAction:noButton];
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];

    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Report User"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        strAPISelection=@"ReportUser";
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:appNAME message:[MCLocalization stringForKey:@"Are you Sure Want to report this User?"] delegate:self cancelButtonTitle:[MCLocalization stringForKey:@"Cancel"] otherButtonTitles:[MCLocalization stringForKey:@"Yes"],nil];
//        [alert show];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:appNAME
                                     message:@"Are you Sure Want to report this User?"
                                     preferredStyle:UIAlertControllerStyleAlert];
        //Add Buttons
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        [self reportUser:self.strFriendId];
                                    }];
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        
        //Add your buttons to alert controller
        
        [alert addAction:noButton];
        [alert addAction:yesButton];

        [self presentViewController:alert animated:YES completion:nil];

    }]];

    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];

}
//#pragma mark - Alert view action handle
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0)
//    {
//        //Code for cancel button
//        strAPISelection=@"";
//    }
//    if (buttonIndex == 1)
//    {
//        //Code for Yes button
//
//        if([strAPISelection isEqualToString:@"Block"]){
//            [self BlockUser:self.strFriendId];
//        }
//        else if ([strAPISelection isEqualToString:@"Unmatch"]){
//            [self UnMatchUser:self.strFriendId];
//        }
//        else if([strAPISelection isEqualToString:@"ReportUser"]){
//            [self reportUser:self.strFriendId];
//        }
//    }
//}

#pragma mark - Get Searched Places
/*!
 * @discussion Get Places for Date
 */
-(void)searchforPlaces {
    
    rating = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    distance = [[NSMutableArray alloc]init];
    imgPlaces = [[NSMutableArray alloc]init];
    
    NSString *searchString=[[NSString alloc]init];
    int distance1=0;
    
    if(set==1)
    {
        searchString = @"Cafe";
        self.lblNearByYou.text=[MCLocalization stringForKey:@"Cafe Near By You"];
        distance1=5000;
    }
    else if(set==2)
    {
        searchString = @"Bar";
        self.lblNearByYou.text=[MCLocalization stringForKey:@"Bar Near By You"];
        distance1=5000;
    }
    else if (set==3)
    {
        searchString = @"Restaurant";
        self.lblNearByYou.text=[MCLocalization stringForKey:@"Restaurant Near By You"];
        distance1=5000;
    }
    else if (set ==4)
    {
        searchString = @"beach";
        self.lblNearByYou.text=[MCLocalization stringForKey:@"Beach Near By You"];
        distance1=15000;
    }
//    NSString *url_string = [NSString stringWithFormat: @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%d&type=%@&keyword=%@&key=%@", latitude_UserLocation, longitude_UserLocation, distance1, searchString, searchString, GOOGLE_API_KEY];
    
    NSString *url_string = [NSString stringWithFormat: @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=%d&type=%@&keyword=%@&key=%@", [appDelegate GetData:klatitude], [appDelegate GetData:klongitude], distance1, searchString, searchString, [appDelegate GetData:GOOGLE_API_KEY]];
    
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    set=0;
    
    //    parse JSON data
    
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    

    
    for (NSDictionary *groupDic in results) {

        
        NSString *name1 = [groupDic valueForKey:@"name"];
        
        NSString *rating1 = [groupDic valueForKey:@"rating"];
        float rating2 = ([rating1 floatValue]*100)/5;

        //        to calculate distance from the user
        
        NSString *stringLongitude = [[[groupDic objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lng"];
        NSString *stringLatitude = [[[groupDic objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lat"];
        
        double placeLatitude = [stringLatitude doubleValue];
        double placeLongitude = [stringLongitude doubleValue];
        
        CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:latitude_UserLocation longitude:longitude_UserLocation];
        CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:placeLatitude longitude:placeLongitude];
        
        CLLocationDistance distancebw = [startLocation distanceFromLocation:endLocation]; // aka double
        
        CLLocationDistance kilometers = distancebw / 1000.0;
        float miles = kilometers*0.62137;
        CGFloat rounded_up = ceilf(miles * 100) / 100;
        
        NSArray *allPhotosDictionaries = [groupDic objectForKey:@"photos"];
        NSDictionary *photoDict;
        
        if (allPhotosDictionaries.count > 0)
        {
            photoDict = [allPhotosDictionaries objectAtIndex:0];
        }
        else
        {
            photoDict = [[NSDictionary alloc] init];
        }
        
        NSString *photoRef = [photoDict objectForKey:@"photo_reference"];
        
//        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=%@&sensor=false&maxwidth=320", photoRef, GOOGLE_API_KEY];
        
        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=%@&sensor=false&maxwidth=320", photoRef,[appDelegate GetData: GOOGLE_API_KEY]];
        
        NSNumber *numrating = [NSNumber numberWithFloat:rating2];
        NSNumber *numdistance = [NSNumber numberWithFloat:rounded_up];
        NSString *place = [groupDic valueForKey:@"place_id"];
        
        [placeId addObject:place];
        [name addObject:name1];
        [rating addObject:numrating];
        [distance addObject:numdistance];
        [imgPlaces addObject:url];
    }
    
    NSString *nxtPageToken = [parsedObject objectForKey:@"next_page_token"];
    if(nxtPageToken!=nil)
    {
        [self getAnotherPageData:nxtPageToken];
    }
    
    
}
/*!
 * @discussion Get More Places for Date
 * @param nxtPageToken For indentify Next Page Token
 */
-(void)getAnotherPageData:(NSString*)nxtPageToken{
    
    NSString *searchString=[[NSString alloc]init];
    int distance1=0;
    
    if(set==1)
    {
        searchString = @"Cafe";
        distance1=5000;
    }
    else if(set==2)
    {
        searchString = @"Bar";
        distance1=5000;
    }
    else if (set==3)
    {
        searchString = @"Restaurant";
        distance1=5000;
    }
    else if (set==4)
    {
        searchString = @"beach";
        distance1=15000;
    }
    
//    NSError *error;
    
//    NSString *url_string = [NSString stringWithFormat: @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%d&type=%@&keyword=%@&key=%@&pagetoken=%@", latitude_UserLocation, longitude_UserLocation, distance1, searchString, searchString, GOOGLE_API_KEY, nxtPageToken];
    
    NSString *url_string = [NSString stringWithFormat: @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=%d&type=%@&keyword=%@&key=%@&pagetoken=%@", [appDelegate GetData:klatitude], [appDelegate GetData:klongitude], distance1, searchString, searchString,[appDelegate GetData:GOOGLE_API_KEY], nxtPageToken];
    
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
//    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    set=0;
    
    //    parse JSON data
    
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    
    for (NSDictionary *groupDic in results) {
        
        NSString *name1 = [groupDic valueForKey:@"name"];
        
        NSString *rating1 = [groupDic valueForKey:@"rating"];
        float rating2 = ([rating1 floatValue]*100)/5;
        
        //        to calculate distance from the user
        
        NSString *stringLongitude = [[[groupDic objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lng"];
        NSString *stringLatitude = [[[groupDic objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lat"];
        
        double placeLatitude = [stringLatitude doubleValue];
        double placeLongitude = [stringLongitude doubleValue];
        
        CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:latitude_UserLocation longitude:longitude_UserLocation];
        CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:placeLatitude longitude:placeLongitude];
        
        CLLocationDistance distancebw = [startLocation distanceFromLocation:endLocation];
        
        CLLocationDistance kilometers = distancebw / 1000.0;
        float miles = kilometers*0.62137;
        CGFloat rounded_up = ceilf(miles * 100) / 100;
        //        to get image from the google
        
        NSArray *allPhotosDictionaries = [groupDic objectForKey:@"photos"];
        NSDictionary *photoDict;
        
        if (allPhotosDictionaries.count > 0)
        {
            photoDict = [allPhotosDictionaries objectAtIndex:0];
        }
        else
        {
            photoDict = [[NSDictionary alloc] init];
        }
        
        NSString *photoRef = [photoDict objectForKey:@"photo_reference"];
        
//        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=%@&sensor=false&maxwidth=320", photoRef, GOOGLE_API_KEY];
        
        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=%@&sensor=false&maxwidth=320", photoRef, [appDelegate GetData:GOOGLE_API_KEY]];
        
        NSNumber *numrating = [NSNumber numberWithFloat:rating2];
        NSNumber *numdistance = [NSNumber numberWithFloat:rounded_up];
        NSString *place = [groupDic valueForKey:@"place_id"];
        
        [placeId addObject:place];

        [name addObject:name1];
        [rating addObject:numrating];
        [distance addObject:numdistance];
        [imgPlaces addObject:url];
    }
    
    nxtPageToken = [parsedObject objectForKey:@"next_page_token"];
    if(nxtPageToken!=nil)
    {
        [self getAnotherPageData:nxtPageToken];
    }
}

/*!
 * @discussion Convert given string to encoded string
 * @param str String needed to be encoded
 * @return Encoded string
 */
-(NSString *)ConvertedText:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *goodtext = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
    return goodtext;
}

#pragma mark - UITableView Delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"tblCell";
    
    PlaceSearchCell *cell = (PlaceSearchCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(tableView.tag==101){
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlaceSearchCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        self.tblPlaceSearch.rowHeight = 104;
        [cell.act startAnimating];
        [cell.img sd_setImageWithURL:[Util EncodedURL:[imgPlaces objectAtIndex:indexPath.row] ]completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            cell.img.image=image;
            if (cell.img.image == nil) {
                cell.img.image = [UIImage imageNamed:@"NoPlaceFound"];
            }
            [cell.act stopAnimating];
        }];
        
        int n = [[rating objectAtIndex:indexPath.row] intValue];
        
        dispatch_async(dispatch_get_main_queue(), ^{

                StarRatingView* starViewNoLabel = [[StarRatingView alloc]initWithFrame:CGRectMake(114, 40, 65, 10) andRating:n withLabel:NO animated:YES];
                
                if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
                    [starViewNoLabel setTransform:CGAffineTransformMakeScale(-1, 1)];
                    
                    starViewNoLabel.frame = CGRectMake(cell.frame.size.width - 10 - cell.img.frame.size.width - starViewNoLabel.frame.size.width, 40, 65, 10);
                }
                
                [cell addSubview:starViewNoLabel];
         
        });
        
        cell.lblTitle.text = [name objectAtIndex:indexPath.row];
        
        float dis = [[distance objectAtIndex:indexPath.row] floatValue];
        
        NSString *disFormat = [NSString stringWithFormat:@"%.2f miles",dis];
        
        cell.lblDistance.text = disFormat;
        CGFloat red = arc4random() % 255 / 255.0;
        CGFloat green = arc4random() % 255 / 255.0;
        CGFloat blue = arc4random() % 255 / 255.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        cell.lblColor.backgroundColor = color;
    }
    if(tableView.tag==102)
    {
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlaceSearchCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        self.tblSelectedPlace.rowHeight = 104;

        [cell.act startAnimating];
        [cell.img sd_setImageWithURL:[Util EncodedURL:[imgPlaces objectAtIndex:selectedrow] ]placeholderImage:[UIImage imageNamed:@"ProfileImage"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            cell.img.image=image;
            if (cell.img.image == nil) {
                cell.img.image = [UIImage imageNamed:@"NoPlaceFound"];
            }
            [cell.act stopAnimating];
           
        }];
        
        int n = [[rating objectAtIndex:selectedrow] intValue];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            StarRatingView* starViewNoLabel = [[StarRatingView alloc]initWithFrame:CGRectMake(114, 40, 65, 10) andRating:n withLabel:NO animated:YES];
            if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
                [starViewNoLabel setTransform:CGAffineTransformMakeScale(-1, 1)];
                starViewNoLabel.frame = CGRectMake(cell.frame.size.width - 10 - cell.img.frame.size.width - starViewNoLabel.frame.size.width, 40, 65, 10);
            }
            
            [cell addSubview:starViewNoLabel];
      
        });
        cell.lblTitle.text = [name objectAtIndex:selectedrow];
        
        self.lblSelectedPlace.text = [name objectAtIndex:selectedrow];
        
        float dis = [[distance objectAtIndex:selectedrow] floatValue];
        
        NSString *disFormat = [NSString stringWithFormat:@"%.2f miles",dis];
        
        cell.lblDistance.text = disFormat;
        CGFloat red = arc4random() % 255 / 255.0;
        CGFloat green = arc4random() % 255 / 255.0;
        CGFloat blue = arc4random() % 255 / 255.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        cell.lblColor.backgroundColor = color;
    }
    if(tableView.tag==100)
    {
        //sender type :0-sender, 1-reciever, cell type:0-message, 1-date request

        if([([[arrSelection objectAtIndex: indexPath.row] valueForKey:@"CellType"]) isEqualToString:@"2"])
        {
            static NSString *simpleTableIdentifier = @"DayCell";
            DayCell *cell =  [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DayCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            cell.lblDate.text=[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Time"];
            return cell;
        }
        else if([([[arrSelection objectAtIndex: indexPath.row] valueForKey:@"SenderType"]) isEqualToString:@"1"]){
          //receiving
            if([[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"CellType"]isEqualToString:@"0"]){
                //simple message
                static NSString *simpleTableIdentifier = @"ChatLeftCell";
                ChatLeftCell *cell =  [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
                if (cell == nil)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatLeftCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.vw.layer.cornerRadius=2.0;
                    cell.vw.layer.masksToBounds = NO;
                    cell.vw.layer.shadowOffset = CGSizeMake(5, 5);
                    cell.vw.layer.shadowRadius = 10.0;
                    cell.vw.layer.shadowOpacity = 0.2;
                }
//                NSData *data = [[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Message"] dataUsingEncoding:NSUTF8StringEncoding];
//                NSString *goodValue = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
               
                NSData *data1 = [[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Message"] dataUsingEncoding:NSUTF16StringEncoding];
                NSString *decodevalue = [[NSString alloc] initWithData:data1 encoding:NSUTF16StringEncoding];

                
                cell.lblMessage.text=decodevalue;
                cell.lblMessage.numberOfLines=0;
                cell.lblMessage.lineBreakMode=NSLineBreakByWordWrapping;

                if ([self heightofLable:cell.lblMessage]>21)
                {
                    cell.lblMessage.frame=CGRectMake(7,6, 241,[self heightofLable:cell.lblMessage]);
                    cell.vw.frame=CGRectMake(30,6,250,[self heightofLable:cell.lblMessage]+14);
                }
                else
                {
                    cell.lblMessage.frame=CGRectMake(7,6, 241,21);
                    cell.vw.frame=CGRectMake(30,6,250,cell.lblMessage.frame.size.height+14);
                }
                
                cell.vwBoarder.frame=CGRectMake(cell.vwBoarder.frame.origin.x,6,cell.vwBoarder.frame.size.width,cell.vw.frame.size.height);
                [cell.lblMessage sizeToFit];
                cell.lblTime.text=[[arrSelection objectAtIndex:indexPath.row]valueForKey:@"Time"];
                if ([cell.lblMessage.text isEqualToString:@"Request Accepted"])
                {
                    cell.lblMessage.text=@"Request Accepted";
                    NSString *myString = cell.lblMessage.text;
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                    
                    NSRange range = [myString rangeOfString:@"Accepted"];
                    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:26.0/255.0 green:202.0/255.0 blue:70.0/255.0 alpha:1] range:range];
                    cell.lblMessage.attributedText = attString;
                }
                else if ([cell.lblMessage.text isEqualToString:@"Request Declined"])
                {
                    NSString *myString = cell.lblMessage.text;
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                    
                    NSRange range = [myString rangeOfString:@"Declined"];
                    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:180.0/255.0 green:24.0/255.0 blue:32.0/255.0 alpha:1] range:range];
                    cell.lblMessage.attributedText = attString;
                    
                    
                }

                if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
                
                    cell.lblMessage.frame = CGRectMake(8, cell.lblMessage.frame.origin.y, cell.lblMessage.frame.size.width, cell.lblMessage.frame.size.height);
                }
                
                return cell;
            }
            else{
                //date request
                static NSString *simpleTableIdentifier = @"DateRequestRecCell";
                DateRequestRecCell *cell =  [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
                
                if (cell == nil)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DateRequestRecCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.vw.layer.cornerRadius=2.0;
                    
                }
                cell.lblTime.text=[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Time"];

                NSArray *arr = [[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Message"] componentsSeparatedByString:@"$***$"];
                NSArray *arr1 =[[arr objectAtIndex:arr.count-1] componentsSeparatedByString:@"#"];
                NSString *strJson=[arr1 objectAtIndex:0];

                NSData *webData = [strJson dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:webData options:0 error:&error];
                cell.btnAccept.hidden=YES;
                cell.btnDecline.hidden=YES;
                cell.lblRequest.hidden=YES;
                if ([[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Request"] isEqualToString:@"non"])
                {
                    cell.lblRequest.hidden=YES;
                    cell.btnAccept.hidden=NO;
                    cell.btnDecline.hidden=NO;
                }
                else if ([[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Request"] isEqualToString:@"Request Accepted"])
                {
                    cell.lblRequest.text=@"Request Accepted";
                    NSString *myString = cell.lblRequest.text;
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                    NSRange range = [myString rangeOfString:@"Accepted"];
                    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:26.0/255.0 green:202.0/255.0 blue:70.0/255.0 alpha:1] range:range];
                    cell.lblRequest.attributedText = attString;
                    cell.lblRequest.hidden=YES;
                    cell.btnAccept.hidden=YES;
                    cell.btnDecline.hidden=YES;

                    
                }
                else if ([[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Request"] isEqualToString:@"Request Declined"])
                {
                    cell.lblRequest.text=@"Request Declined";
                    NSString *myString = cell.lblRequest.text;
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                    NSRange range = [myString rangeOfString:@"Declined"];
                    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:180.0/255.0 green:24.0/255.0 blue:32.0/255.0 alpha:1] range:range];
                    cell.lblRequest.attributedText = attString;
                    cell.lblRequest.hidden=YES;
                    cell.btnAccept.hidden=YES;
                    cell.btnDecline.hidden=YES;
                }

                
                cell.lblTitle.text=[self ConvertedText:[jsonDict valueForKey:@"Title"]];
                cell.lblDistance.text=[jsonDict valueForKey:@"Distance"];
                [cell.dateTime setTitle:[self JSONString:[self ConvertedText:[jsonDict valueForKey:@"TimeOfDate"]]] forState:UIControlStateNormal];
                [cell.act startAnimating];
                

                
                [cell.imgPlace sd_setImageWithURL:[Util EncodedURL:[self JSONString:[self ConvertedText:[jsonDict valueForKey:@"imgPlace"]]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    cell.imgPlace.image=image;
                    if (cell.imgPlace.image == nil) {
                        cell.imgPlace.image = [UIImage imageNamed:@"NoPlaceFound"];
                    }

                    [cell.act stopAnimating];
                }];
                int n = [[jsonDict valueForKey:@"StarRating"] intValue];
                StarRatingView* starViewNoLabel = [[StarRatingView alloc]initWithFrame:CGRectMake(95,28, 65, 10) andRating:n withLabel:NO animated:YES];
                [cell.vwPlace addSubview:starViewNoLabel];
                CGFloat red = arc4random() % 255 / 255.0;
                CGFloat green = arc4random() % 255 / 255.0;
                CGFloat blue = arc4random() % 255 / 255.0;
                UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
                cell.lblColor.backgroundColor = color;
                cell.btnDecline.tag=indexPath.row;
                cell.btnAccept.tag=indexPath.row;
                [cell.btnAccept addTarget:self action:@selector(btnAcceptClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell.btnDecline addTarget:self action:@selector(btnDeclineClicked:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
                
            }
        }
        else{
            //sending
            if([[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"CellType"]isEqualToString:@"0"]){
               //simple message
                static NSString *simpleTableIdentifier = @"ChatRightCell";
                ChatRightCell *cell =  [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
                if (cell == nil)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatRightCell" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.vw.layer.cornerRadius=2.0;
                    cell.vw.layer.masksToBounds = NO;
                    cell.vw.layer.shadowOffset = CGSizeMake(5, 5);
                    cell.vw.layer.shadowRadius = 10.0;
                    cell.vw.layer.shadowOpacity = 0.2;
                }
//                NSData *data = [[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Message"] dataUsingEncoding:NSUTF8StringEncoding];
                
                
                NSData *data1 = [[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Message"] dataUsingEncoding:NSUTF16StringEncoding];
                NSString *decodevalue = [[NSString alloc] initWithData:data1 encoding:NSUTF16StringEncoding];
                
                cell.lblMessage.text=decodevalue;
                cell.lblMessage.numberOfLines=0;
                cell.lblMessage.lineBreakMode=NSLineBreakByWordWrapping;

                if ([self heightofLable:cell.lblMessage]>21) {
                    cell.lblMessage.frame=CGRectMake(7,6,241,[self heightofLable:cell.lblMessage]);
                    cell.vw.frame=CGRectMake(48,6,250,[self heightofLable:cell.lblMessage]+14);

                }
                else
                {
                    cell.lblMessage.frame=CGRectMake(7,6, 241,21);
                    cell.vw.frame=CGRectMake(48,6,250,cell.lblMessage.frame.size.height+14);

                }
                cell.vwBoarder.frame=CGRectMake(cell.vwBoarder.frame.origin.x,6,cell.vwBoarder.frame.size.width,cell.vw.frame.size.height);
                [cell.lblMessage sizeToFit];
                if ([cell.lblMessage.text isEqualToString:@"Request Accepted"])
                {
                    cell.lblMessage.text=@"Request Accepted";
                    NSString *myString = cell.lblMessage.text;
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                    NSRange range = [myString rangeOfString:@"Accepted"];
                    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:26.0/255.0 green:202.0/255.0 blue:70.0/255.0 alpha:1] range:range];
                    cell.lblMessage.attributedText = attString;
                }
                else if ([cell.lblMessage.text isEqualToString:@"Request Declined"])
                {
                    NSString *myString = cell.lblMessage.text;
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                    NSRange range = [myString rangeOfString:@"Declined"];
                    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:180.0/255.0 green:24.0/255.0 blue:32.0/255.0 alpha:1] range:range];
                    cell.lblMessage.attributedText = attString;
                }
                cell.lblTime.text=[[arrSelection objectAtIndex:indexPath.row]valueForKey:@"Time"];
                
                if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
                    
                    cell.lblMessage.frame = CGRectMake(8, cell.lblMessage.frame.origin.y, cell.lblMessage.frame.size.width, cell.lblMessage.frame.size.height);
                }
                
                return cell;
            }
            else{
                //date request
                static NSString *simpleTableIdentifier = @"DateRequest";
                DateRequest *cell =  [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
                
                if (cell == nil)
                {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DateRequest" owner:self options:nil];
                    cell = [nib objectAtIndex:0];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.vw.layer.cornerRadius=2.0;

                }
                cell.lblTime.text=[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Time"];
                
                
                NSArray *arr = [[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Message"] componentsSeparatedByString:@"$***$"];
               NSArray *arr1 =[[arr objectAtIndex:arr.count-1] componentsSeparatedByString:@"#"];
              NSString *strJson=[arr1 objectAtIndex:0];

                NSData *webData = [strJson dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:webData options:0 error:&error];
                
                
                
                cell.lblRequest.hidden=YES;
                if ([[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Request"] isEqualToString:@"non"])
                {
                    cell.lblRequest.hidden=YES;
                }
                else if ([[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Request"] isEqualToString:@"Request Accepted"])
                {
                    
                    cell.lblRequest.text=@"Request Accepted";
                    NSString *myString = cell.lblRequest.text;
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                    
                    NSRange range = [myString rangeOfString:@"Accepted"];
                    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:26.0/255.0 green:202.0/255.0 blue:70.0/255.0 alpha:1] range:range];
                    cell.lblRequest.attributedText = attString;

                    cell.lblRequest.hidden=YES;
                    
                    
                    EKEventStore *store = [EKEventStore new];
                    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                        if (!granted) { return; }
                        
                        NSArray *arrTemp=[strJson componentsSeparatedByString:@"\"TimeOfDate\" : \"" ];
                        
                        NSArray *arrTemp2=[[arrTemp objectAtIndex:1] componentsSeparatedByString:@"\"Title\" : \""];
                        
                        NSString *strDateTime=[arrTemp2 objectAtIndex:0];
                        NSArray *strTemp7=[[arrTemp2 objectAtIndex:1] componentsSeparatedByString:@"\","] ;
                        NSString *location=[strTemp7 objectAtIndex:0];

                        NSArray *arrTemp3=[strDateTime componentsSeparatedByString:@"\\/"];
                        int day=[[arrTemp3 objectAtIndex:0] intValue];
                        int month=[[arrTemp3 objectAtIndex:1] intValue];
                        
                        NSArray *arrTemp4=[[arrTemp3 objectAtIndex:2] componentsSeparatedByString:@" , "];
                        int year=[[arrTemp4 objectAtIndex:0] intValue];
                        NSArray *arrTemp5=[[arrTemp4 objectAtIndex:1] componentsSeparatedByString:@" "];
                        
                        NSArray *arrTemp6=[[arrTemp5 objectAtIndex:0] componentsSeparatedByString:@":"];
                        int hours=[[arrTemp6 objectAtIndex:0] intValue];
                        int minutes=[[arrTemp6 objectAtIndex:1] intValue];
                        
                        NSArray *arrTemp7=[[arrTemp5 objectAtIndex:1] componentsSeparatedByString:@"\""];
                        NSString *strAmPm=[arrTemp7 objectAtIndex:0] ;
                        
                        if([strAmPm isEqualToString:@"PM"]){
                            hours=hours+12;
                        }
                        
                        // Get the appropriate calendar
                        NSCalendar *myCalendar = [NSCalendar currentCalendar];
                        
                        // Create the start date components
                        NSDateComponents *startComponents = [[NSDateComponents alloc] init];
                        startComponents.timeZone=[NSTimeZone defaultTimeZone];
                        [startComponents setDay:day];
                        [startComponents setMonth:month];
                        [startComponents setYear:year];
                        [startComponents setHour: hours];
                        [startComponents setMinute:minutes];
                        [startComponents setSecond:0];
                        
                        NSDate *startDate=[[myCalendar dateFromComponents:startComponents] dateByAddingTimeInterval:0];
                        NSDate *endDate = [[myCalendar dateFromComponents:startComponents] dateByAddingTimeInterval:60*60]; //set 1 hour meeting
                        
                        //check event
                        
                        // Create the predicate from the event store's instance method
                        NSPredicate *predicate = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
                        // Fetch all events that match the predicate
                        NSArray *events = [store eventsMatchingPredicate:predicate];
                        
                        
                        EKEvent *event = [EKEvent eventWithEventStore:store];
                        event.title = [NSString stringWithFormat:@"%@:Date with %@", appNAME, self.lblName.text];
                        event.location = location;
                        event.startDate=startDate;
                        event.endDate=endDate;
                        
                        //set alarm 1 hour befor event
                        EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:60*60*-1];
                        event.alarms = [NSArray arrayWithObject:alarm];
                        event.calendar = [store defaultCalendarForNewEvents];
                        NSError *err = nil;
                        
                        if([events count] >0){
                            //already event is there
                            BOOL isPresent=false;
                            for(int i=0;i<[events count];i++){
                                
                                EKEvent *eventTemp = [events objectAtIndex:i];
                                
                                //check same event is there or different
                                if([[eventTemp title] isEqualToString:[event title]]){
                                    if([[eventTemp location] isEqualToString:[event location]]){
                                        
                                        if([[eventTemp startDate] isEqualToDate:[event startDate]]){
                                            if([[eventTemp endDate] isEqualToDate:[event endDate]]){
                                                
                                                isPresent = true;
                                            }
                                        }
                                    }
                                }
                                
                            }
                            if(!isPresent){
                                [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                            }
                        }
                        else{
                            
                            // make entry in calendar
                            
                            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                        }
                        
                        
                    }];
                   
                    
                }
                else if ([[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Request"] isEqualToString:@"Request Declined"])
                {
                    cell.lblRequest.text=@"Request Declined";
                    NSString *myString = cell.lblRequest.text;
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                    
                    NSRange range = [myString rangeOfString:@"Declined"];
                    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:180.0/255.0 green:24.0/255.0 blue:32.0/255.0 alpha:1] range:range];
                    cell.lblRequest.attributedText = attString;

                    cell.lblRequest.hidden=YES;
                }

                
                
                cell.lblTitle.text=[self ConvertedText:[jsonDict valueForKey:@"Title"]];
                cell.lblDistance.text=[jsonDict valueForKey:@"Distance"];
                
                [cell.dateTime setTitle:[self JSONString:[self ConvertedText:[jsonDict valueForKey:@"TimeOfDate"]]] forState:UIControlStateNormal];
                [cell.act startAnimating];
                [cell.imgPlace sd_setImageWithURL:[Util EncodedURL:[self JSONString:[self ConvertedText:[jsonDict valueForKey:@"imgPlace"]]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    cell.imgPlace.image=image;
                    if (cell.imgPlace.image == nil) {
                        cell.imgPlace.image = [UIImage imageNamed:@"NoPlaceFound"];
                    }
                    [cell.act stopAnimating];
                }];
                
                
                int n = [[jsonDict valueForKey:@"StarRating"] intValue];
                
                StarRatingView* starViewNoLabel = [[StarRatingView alloc]initWithFrame:CGRectMake(95,28, 65, 10) andRating:n withLabel:NO animated:YES];
                [cell.vwPlace addSubview:starViewNoLabel];
               
                CGFloat red = arc4random() % 255 / 255.0;
                CGFloat green = arc4random() % 255 / 255.0;
                CGFloat blue = arc4random() % 255 / 255.0;
                UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
                
                cell.lblColor.backgroundColor = color;

                return cell;
            }
            
        }

    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float n = 0.00;
    if(tableView.tag==100)
    {
        if([([[arrSelection objectAtIndex: indexPath.row] valueForKey:@"CellType"]) isEqualToString:@"2"])
        {
            return 45;
        }
        else if([([[arrSelection objectAtIndex: indexPath.row] valueForKey:@"CellType"]) isEqualToString:@"0"]){
            //message cell
            UILabel *lblpost=[[UILabel alloc] init];
//            NSData *data = [[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Message"] dataUsingEncoding:NSUTF8StringEncoding];
//            NSString *goodValue = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];

            NSData *data1 = [[[arrSelection objectAtIndex: indexPath.row] valueForKey:@"Message"] dataUsingEncoding:NSUTF16StringEncoding];
            NSString *decodevalue = [[NSString alloc] initWithData:data1 encoding:NSUTF16StringEncoding];
            
            lblpost.text=decodevalue;
            lblpost.textColor=[UIColor darkGrayColor];
            lblpost.font=[UIFont fontWithName:@"Lato-Regular" size:13.0];
            lblpost.numberOfLines = 0;
            lblpost.frame=CGRectMake(0,0, 241,21);
            if ([self heightofLable:lblpost]>21)
            {
                return 50+[self heightofLable:lblpost];
            }
            else
            {
                return 70;
            }
        }
        else{
            //date request cell
            n=190.00;
        }
    }
    else if(tableView.tag==101)
    {
        n=104.00;
    }
    else if(tableView.tag==102)
    {
        n=104.00;
    }
    return n;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==101){
        
        selectedrow=(int)indexPath.row;
        
        [self.vwSaveRequest setHidden:true];
        
//        [UIView animateWithDuration:0.7 animations:^{
//            self.SelectedplaceView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.SelectedplaceView.frame.size.height);
//        } completion:^(BOOL finished) {
//
//        }];
        
        if ([self.btnDateTime.titleLabel.text isEqualToString:[MCLocalization stringForKey:@"Select DATE and TIME"]]) {
            //no time and date selected
            //set current time
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:now];
            NSDateComponents *components1 = [calendar components:NSCalendarUnitMinute fromDate:now];
            
            if ((int)[components hour] > 12) {
                self.hour.text = [NSString stringWithFormat:@"%02d", (int)[components hour] - 12];
                [self.hourSlider setValue:(int)[components hour] - 12 animated:YES];
                [self handleSingleTapGesture:nil];
            } else {
                self.hour.text = [NSString stringWithFormat:@"%02d", (int)[components hour]];
                [self.hourSlider setValue:(int)[components hour] animated:YES];
            }
            self.minute.text = [NSString stringWithFormat:@"%02d", (int)[components1 minute]];
            [self.minuteSlider setValue:(int)[components1 minute] animated:YES];
        } else {
            //date and time is selected
            int hh = [hourText intValue];
            int mm = [minuteText intValue];
            [self.hourSlider setValue:hh animated:YES];
            [self.minuteSlider setValue:mm animated:YES];
            self.hour.text = [NSString stringWithFormat:@"%02d", (int)self.hourSlider.value];
            self.minute.text = [NSString stringWithFormat:@"%02d", (int)self.minuteSlider.value];
        }

        [UIView animateWithDuration:0.7 animations:^{
            self.setDateView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.setDateView.frame.size.height);
        } completion:^(BOOL finished) {
            self.popupBG.hidden = NO;
        }];

        [self.tblSelectedPlace reloadData];
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==101)
    {
        return name.count;
    }
    if(tableView.tag==102)
    {
        return 1;
    }else{
        return arrSelection.count;
    }
}


/*!
 * @discussion Convertvstring to Json String
 * @param aString String needed to be converted
 * @return Converted string
 */
-(NSString *)JSONString:(NSString *)aString
{
    if (aString.length > 0) {
        NSMutableString *s = [NSMutableString stringWithString:aString];
        [s replaceOccurrencesOfString:@"\\/" withString:@"/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
        return [NSString stringWithString:s];
    }
    else
    {
        return @"";
    }
}

/*!
 * @discussion Removes escape sequenses from json string
 * @param aString String needed to be converted
 * @return Converted string
 */
-(NSString *)JSONStringRemove:(NSString *)aString
{
    return [aString stringByReplacingOccurrencesOfString: @"\\/" withString:@"/"];
}

#pragma mark - Keybord Notification

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.vwMessageSend.frame = CGRectMake(0, SCREEN_SIZE.height - (kbSize.height + self.vwMessageSend.frame.size.height), SCREEN_SIZE.width, self.vwMessageSend.frame.size.height);
}

- (void)keyboardWillHide:(NSNotification*)notification {
    self.vwMessageSend.frame = CGRectMake(0, SCREEN_SIZE.height - (self.vwMessageSend.frame.size.height), SCREEN_SIZE.width, self.vwMessageSend.frame.size.height);
}

#pragma mark - Calender Deligate
/*!
 * @discussion Add and Dislay calendar
 */
- (void) CalenderData{
    
    if (self) {
        calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
        self.calendar1 = calendar;
        calendar.delegate = self;
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
        calendar.onlyShowCurrentMonth = NO;
        calendar.adaptHeightToNumberOfWeeksInMonth = YES;
        
        calendar.frame = CGRectMake(0, 0, 304*SCREEN_SIZE.width/375, self.datepickView.frame.size.height);
        
        [self.datepickView addSubview:calendar];
  
        self.view.backgroundColor = [UIColor whiteColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
/*!
 * @discussion Set Phone's date and time to calendar
 */
- (void)localeDidChange {
    [self.calendar1 setLocale:[NSLocale currentLocale]];
}

/*!
 * @discussion Check date is disable or not
 * @param date Date to be checked
 * @return Yes, if Date is disabled else No
 */
- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Calender color
/*!
 * @discussion Configure color of Calender
 * @param calendar calendar needed to be configured
 * @param dateItem DateItem for configuration
 * @param date Selected date
 */
- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
   
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}
/*!
 * @discussion Check date is selectable or not
 * @param calendar calendar for which date is checking
 * @param date Selected date
 * @return Yes if date is selectable else return no
 */
- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}


/*!
 * @discussion Called when date is selected
 * @param calendar calendar for which date is selected
 * @param date Selected date
 */
- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    
    dateTime = [self.dateFormatter stringFromDate:date];
    
  
}

/*!
 * @discussion Called when month is changed
 * @param calendar calendar for which month is changing
 * @param date Selected date
 * @return Yes if month is changed, Else No
 */
- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date) {
        self.calendar1.backgroundColor = [UIColor colorWithRed:73/255.0f green:73/255.0f blue:73/255.0f alpha:1.0f];
        return YES;
    } else {
        self.calendar1.backgroundColor = [UIColor colorWithRed:73/255.0f green:73/255.0f blue:73/255.0f alpha:1.0f];
        return NO;
    }
}
/*!
 * @discussion Set Layout of calender
 * @param calendar Calendar whose layout is needed to be set
 * @param frame Frame of calendar
 */
- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    
}


#pragma mark - Slider Delegate
/*!
 * @discussion Called when hour slider's value changed
 * @param sender For identifying sender Slider
 */
- (IBAction)hoursliderValueChanged:(id)sender {
    self.hour.text = [NSString stringWithFormat:@"%02d", (int)self.hourSlider.value];
}
/*!
 * @discussion Called when minutes slider's value changed
 * @param sender For identifying sender Slider
 */
- (IBAction)minutesliderValueChanged:(id)sender {
    self.minute.text = [NSString stringWithFormat:@"%02d", (int)self.minuteSlider.value];
}

/*!
 * @discussion Roundinf of value of Slider
 * @param slider For identifying sender Slider
 * @return Rounded value
 */
float RoundValue(UISlider * slider) {
    return roundf(slider.value * 2.0) * 1;
}

#pragma mark - Switch Delegate
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    if(self.viewPoint.frame.origin.x == 0)
    {
        [self slideToRightWithGestureRecognizer:nil];
    }
    else if (self.viewPoint.frame.origin.x == (self.viewAmPmSlide.frame.size.width/2))
    {
        [self slideToLeftWithGestureRecognizer:nil];
    }
   
}
-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer {
    if(self.viewPoint.frame.origin.x == 0){
        [UIView animateWithDuration:0.5 animations:^{
            self.viewPoint.frame = CGRectOffset(self.viewPoint.frame, self.viewPoint.frame.size.width, 0.0);
            self.viewPM.frame = CGRectOffset(self.viewPM.frame, self.viewPM.frame.size.width, 0.0);
            self.viewAM.frame = CGRectOffset(self.viewAM.frame, self.viewAM.frame.size.width, 0.0);
        }];
    }
}

-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer {
    if(self.viewPoint.frame.origin.x == (self.viewAmPmSlide.frame.size.width/2)) {
        [UIView animateWithDuration:0.5 animations:^{
            self.viewPoint.frame = CGRectOffset(self.viewPoint.frame, -self.viewPoint.frame.size.width, 0.0);
            self.viewPM.frame = CGRectOffset(self.viewPM.frame, -self.viewPM.frame.size.width, 0.0);
            self.viewAM.frame = CGRectOffset(self.viewAM.frame, -self.viewAM.frame.size.width, 0.0);
        }];
    }
}


#pragma mark - Chat Data
/*!
 * @discussion Get and Set Last seen of user
 */
-(void)GetLastSeen
{
    [[SSLastOnline shareInstance] getLastOnline:self.strJid getdata:^(NSDictionary *result) {
        
        if ([[result valueForKey:@"status"] isEqualToString:kSuccess])
        {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]-[[[result valueForKey:@"data"] valueForKey:@"lastSeenSec"] intValue]];
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateFormat:@"MMM dd, yyyy HH:mm"];
            NSString *lastTimestamp=[formatter1 stringFromDate:date];
            self.lblOnlineOffline.text=lastTimestamp;
        }
        else
        {
            self.lblOnlineOffline.text=[MCLocalization stringForKey:@"Offline"];
        }
        
//        [[SSMessageControl shareInstance] setSSMessageDelegate];
//        [[SSOnlineOfflineFriends shareInstance] setSSOnlineOfflineFriendsDelegate ];
    }];
}
/*!
 * @discussion Check is table data should be reloaded or not
 * @param data From which checking is done
 */
-(void)shouldReloadTable:(NSMutableArray *)data
{
    
    for (int i=0;i<data.count;i++)
    {
        if ([self.strJid isEqualToString:[[data objectAtIndex:i]valueForKey:@"jidStr"]])
        {
            if ([[[data objectAtIndex:i]valueForKey:@"online"] intValue]==0)
            {
                flgUserOnline=NO;
                [self GetLastSeen];
            }
            else if ([[[data objectAtIndex:i]valueForKey:@"online"] intValue]==1)
            {
                flgUserOnline=YES;
                self.lblOnlineOffline.text=@"Online";
            }
        }
    }
}
/*!
 * @discussion Check is table data should be reloaded or not
 * @param data From which checking is done
 */
- (void)shouldReloadTable1:(NSMutableArray*)data
{
    if (data.count > 0)
    {
        arrSelection=[[NSMutableArray alloc]init];
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"MMM dd, yyyy"];
        
        NSString *lastTimestamp = [formatter1 stringFromDate:[data.firstObject valueForKey:@"timestamp"]];
        NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
        [dict1 setObject:@"2" forKey:@"CellType"];
        NSString *currntTimeStamp = [formatter1 stringFromDate:[NSDate date]];
        if ([currntTimeStamp isEqualToString:lastTimestamp])
        {
            [dict1 setObject:[MCLocalization stringForKey:@"Today"] forKey:@"Time"];
        }
        else
        {
            [dict1 setObject:lastTimestamp forKey:@"Time"];
        }
        
        [arrSelection addObject:dict1];
        
        for (int i=0;i<data.count;i++)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            //sender type :0-sender, 1-reciever, cell type:0-message, 1-date request
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            NSString *lastTimestampLocal = [formatter1 stringFromDate:[[data objectAtIndex:i] valueForKey:@"timestamp"]];
            if ([lastTimestamp isEqualToString:lastTimestampLocal])
            {
                
            }
            else
            {
                lastTimestamp = lastTimestampLocal;
                dict1 = [[NSMutableDictionary alloc] init];
                [dict1 setObject:@"2" forKey:@"CellType"];
                NSString *currntTimeStamp=[formatter1 stringFromDate:[NSDate date]];
                if ([currntTimeStamp isEqualToString:lastTimestamp])
                {
                    [dict1 setObject:[MCLocalization stringForKey:@"Today"] forKey:@"Time"];
                }
                else
                {
                    [dict1 setObject:lastTimestamp forKey:@"Time"];
                }
                [arrSelection addObject:dict1];
            }
            [formatter setDateFormat:@"hh:mm a"];
            [dict setObject:[formatter stringFromDate:[[data objectAtIndex:i] valueForKey:@"timestamp"]] forKey:@"Time"];
           
             if([[[data objectAtIndex:i] valueForKey:@"messageText"] hasPrefix:@"$***$"])
            {
                NSArray *arr = [[[data objectAtIndex:i] valueForKey:@"messageText"]  componentsSeparatedByString:@"$***$"];
                NSArray *arr1 =[[arr objectAtIndex:arr.count-1] componentsSeparatedByString:@"#"];
                NSString *strJson=[arr1 objectAtIndex:0];
                
                
                bool flg = false;
                for (int j=0;j<arrSelection.count;j++)
                {
                    NSMutableDictionary *dictTemp=[arrSelection objectAtIndex:j];
                    if ([[dictTemp valueForKey:@"Message"] hasPrefix:@"$***$"])
                    {
                        NSArray *arrtemp = [[dictTemp valueForKey:@"Message"]  componentsSeparatedByString:@"$***$"];
                        NSArray *arr1temp =[[arrtemp objectAtIndex:arr.count-1] componentsSeparatedByString:@"#"];
                        NSString *strJsontemp=[arr1temp objectAtIndex:0];
                        
                        if ([[strJson stringByReplacingOccurrencesOfString:@"\\" withString:@""] isEqualToString:[strJsontemp stringByReplacingOccurrencesOfString:@"\\" withString:@""]])
                        {
                            if ([[arr1 objectAtIndex:arr1.count-1] intValue]==1)
                            {
                                [dictTemp setObject:@"Request Accepted" forKey:@"Request"];
                            }
                            else
                            {
                                [dictTemp setObject:@"Request Declined" forKey:@"Request"];
                            }
                            
                            [arrSelection replaceObjectAtIndex:j withObject:dictTemp];
                            flg=YES;
                        }
                        
                    }
                }
                if ([[arr1 objectAtIndex:arr1.count-1] length]>0 )
                {
                    [dict setObject:@"0" forKey:@"CellType"];
                    if ([[arr1 objectAtIndex:arr1.count-1] intValue]==1)
                    {
                        [dict setObject:@"Request Accepted" forKey:@"Message"];
                    }
                    else
                    {
                        [dict setObject:@"Request Declined" forKey:@"Message"];
                    }
                }
                else
                {
                    [dict setObject:@"non" forKey:@"Request"];
                    [dict setObject:@"1" forKey:@"CellType"];
                    [dict setObject:[[data objectAtIndex:i] valueForKey:@"messageText"] forKey:@"Message"];
                }
            }
            else
            {
                [dict setObject:@"0" forKey:@"CellType"];
                [dict setObject:[[data objectAtIndex:i] valueForKey:@"messageText"] forKey:@"Message"];

            }
            
            
            
            
            if ([[[data objectAtIndex:i] valueForKey:@"outgoing"] intValue]==1)
            {
                [dict setObject:@"0" forKey:@"SenderType"];
            }
            else
            {
                [dict setObject:@"1" forKey:@"SenderType"];
            }
            
            [arrSelection addObject:dict];
        }
        [self.tblChat reloadData];
        if (arrSelection.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath *ip=[NSIndexPath indexPathForRow:arrSelection.count-1 inSection:0];
                [self.tblChat scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionNone animated:NO];
                
            });
            
        }
    
    }

    
}




#pragma mark - Height Of Lable Delegate
/*!
 * @discussion Calculate height of lbl
 * @param lbl Whose height needed to be calculated
 * @return Required height of the lbl
 */
-(float)heightofLable:(UILabel *)lbl
{
    UILabel *lbl1=[[UILabel alloc] init];
    lbl1.frame=CGRectMake(0, 0, lbl.frame.size.width, CGFLOAT_MAX);
    lbl1.numberOfLines = 0;
    lbl1.font=lbl.font;
    lbl1.text=lbl.text;
    lbl1.lineBreakMode=NSLineBreakByWordWrapping;
    [lbl1 sizeToFit];
    return lbl1.frame.size.height;
}

#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self closePreferences];
    
    if (![[appDelegate GetData:kChatSubscription] isEqualToString:@"yes"] && [[appDelegate GetData:kPaidChat] isEqualToString:@"yes"] && ![[appDelegate GetData:kChatSubscriptionInAppPurchase] isEqualToString:@""]) {
//        ChatSubscriptionVC *vc = [[ChatSubscriptionVC alloc] initWithNibName:@"ChatSubscriptionVC" bundle:nil];
//        [self.navigationController pushViewController:vc animated:YES];
        
        InAppPurchaseVC *vc = [[InAppPurchaseVC alloc] initWithNibName:@"InAppPurchaseVC" bundle:nil];
        self.definesPresentationContext = YES; //self is presenting view controller
        vc.view.backgroundColor = [UIColor clearColor];
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        vc.fromPage = 2; // from superlike purchase
        [self presentViewController:vc animated:YES completion:nil];
        [self.txtMessage resignFirstResponder];
    }
}

#pragma mark - TextField Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tblChat)
    {
        [self closePreferences];
    }
}
- (IBAction)txtValueChanged:(id)sender
{
    if (flgUserOnline) {
        if (self.txtMessage.text.length>0)
        {
            NSLog(@"Online send Chat compose");
            
            [[SSMessageControl shareInstance] sendComposingChatToUser:self.strJid];
        }
        else
        {
            [[SSMessageControl shareInstance] sendPausedChatToUser:self.strJid];
        }
    }
    else
    {
                    NSLog(@"Offline");
    }



}


#pragma mark - APi calls
/*!
 * @discussion WebService call for Unmath friend
 * @param friendID Friend's Id
 */
-(void)UnMatchUser:(NSString *) friendID
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         SHOW_LOADER_ANIMTION();
        
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"userUnfriend";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:friendID forKey:@"friendid"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if( success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     
                     
                     [[SSAddFriend shareInstance] deleteFriendWithJid:self.strJid];
                     [self.navigationController popViewControllerAnimated:YES];
                     
                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Please try again!!"], self);
                 }
             }];
         }
     }];

}
/*!
 * @discussion WebService call for Report friend
 * @param friendID Friend's Id
 */
-(void)reportUser:(NSString *) friendID
{
    
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         SHOW_LOADER_ANIMTION();
         
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"reporteuser";
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:friendID forKey:@"report_to_id"];
              [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 if( success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     [self UnMatchUser:friendID];
                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Please try again!!"], self);
                 }
             }];
         }
     }];
}
/*!
 * @discussion WebService call for Block friend
 * @param friendID Friend's Id
 */
-(void)BlockUser:(NSString *) friendID
{
    
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         SHOW_LOADER_ANIMTION();
        
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"blockuser";
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:friendID forKey:@"blockid"];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:@"1" forKey:@"blockstatus"];
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                   
                     [self.navigationController popViewControllerAnimated:YES];

                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Please try again!!"], self);
                 }
             }];
         }
     }];
}


/*!
 * @discussion WebService call for Getting friends
 * @param friendID Friend's Id
 */
-(void) getUserDetails:(NSString *) friendID
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         SHOW_LOADER_ANIMTION();
        
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"getuserdetails";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];

              [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:friendID forKey:@"userid"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if( success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     
                     //send to friendstory page
                     
                     FriendDetailsVC *vc=[[FriendDetailsVC alloc] initWithNibName:@"FriendDetailsVC" bundle:nil];
                     vc.dictDetails=[dictionary valueForKey:@"body"];
                     vc.strFriendID = friendID ;
                     [self.navigationController pushViewController:vc animated:YES];
                     
                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Please try again!!"], self);
                 }
             }];
         }
     }];
}

/*!
 * @discussion WebService call for sending push notification when reciever of the message is offline
 * @param friendID Friend's Id
 * @param strMessage Sent message
 * @param strUserId ID of logged in user
 */
-(void)SendPush:(NSString *)friendID Message:(NSString *)strMessage UserID:(NSString *)strUserId
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"sendmessage";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:friendID forKey:@"friendid"];
             [dict setValue:strMessage forKey:@"message"];
             [dict setValue:strUserId forKey:@"id"];
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if( success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     
                 }
                 else{

                    
                 }
             }];
         }
     }];
}
/*!
 * @discussion Composed by other user as a typing
 */
-(void)chatStatus:(NSString *)status
{
    
    NSLog(@"%@",status);
    
    
//
//
//
//    timer=[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(StopTyping) userInfo:nil repeats:YES];

}


/*!
 * @discussion Check if status is typing or last seen
 */
-(void)StopTyping
{
    [timer invalidate];

}

-(void)ComposeStatus:(NSString *)status
{
    NSLog(@"%@",status);
    
    if ([status  isEqualToString:@"Typing..."])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblOnlineOffline.text=[MCLocalization stringForKey:@"Typing..."];
        });
    }
    if ([status  isEqualToString:@"Paused..."])
    {
        if (flgUserOnline)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.lblOnlineOffline.text=[MCLocalization stringForKey:@"Online"];
            });
        }
        else
        {
            [self GetLastSeen];
        }
    }

}
#pragma mark - RTL setup
/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.vwMessageSend setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.txtMessage setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.txtMessage.textAlignment = NSTextAlignmentRight;
    
    [self.lblPref1 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblPref2 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblPref3 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblPref4 setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    self.lblMins.textAlignment = NSTextAlignmentRight;
    self.lblHours.textAlignment = NSTextAlignmentRight;
    [self.hourSlider setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.minuteSlider setTransform:CGAffineTransformMakeScale(-1, 1)];
}

@end
