//
//  WelcomeVC.m
//  CupidLove
//
//  Created by APPLE on 10/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "WelcomeVC.h"
#import "LoginWithEmailVC.h"
#import "DetailsSignUpVC.h"
#import "LocationHelper.h"
#import "SignUpVC.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface WelcomeVC ()<UIScrollViewDelegate, LocationUpdateDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property(weak,nonatomic) IBOutlet UIView *vw;
@property(weak,nonatomic) IBOutlet UIImageView *img1;
@property(weak,nonatomic) IBOutlet UIImageView *img2;
@property(weak,nonatomic) IBOutlet UIImageView *img3;
@property(weak,nonatomic) IBOutlet UIImageView *img4;
@property(weak,nonatomic) IBOutlet UIScrollView *scrl;
@property(weak,nonatomic) IBOutlet UIPageControl *page;
@property (weak,nonatomic) IBOutlet UIView *myPickerView;

@property(weak,nonatomic) IBOutlet UILabel *lbltagline;
@property (strong, nonatomic) IBOutlet UILabel *lblLofinwithFB;
@property (strong, nonatomic) IBOutlet UILabel *lblloginwithEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnAlreadyHaveAnAccount;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIPickerView *pckLangs;
@property (strong, nonatomic) IBOutlet UIButton *btnChooseLanguage;

@property (weak, nonatomic) IBOutlet UIImageView *imgFb;
@property (weak, nonatomic) IBOutlet UILabel *lblSeperator1;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblSeperator2;


@end

@implementation WelcomeVC {

    NSMutableDictionary *fbDetails;
    NSString *mylatitude;
    NSString *mylongitude;
    int Counter;
    NSMutableArray *arrLanguages,*arrRTLStatus;
    NSString *selectedLanguage;
    NSString *strSelectedRTLStatus;
    bool rtlNotSet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //clear current access tocken of Facebook
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [FBSDKProfile setCurrentProfile:nil];

    [LocationHelper sharedInstance].delegate=self;
    [[LocationHelper sharedInstance] updateLocation];

    rtlNotSet =  false;
    
    selectedLanguage=@"English";
    strSelectedRTLStatus = @"0";
    [appDelegate SetData:strSelectedRTLStatus value:krtl];
    [self localize];
    
    arrLanguages=[[NSMutableArray alloc] init];
    arrRTLStatus=[[NSMutableArray alloc] init];

    [self defaultLanguage];

    self.pckLangs.delegate=self;
    self.pckLangs.dataSource=self;
    self.pckLangs.showsSelectionIndicator=YES;

    fbDetails=[[NSMutableDictionary alloc] init];   
    
    self.page.enabled=NO;
    
    self.vw.backgroundColor = [Theme_Color colorWithAlphaComponent:0.5];
    
    if(![appDelegate.isAppConfigurationSaved isEqualToString:@"Saved"]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getAllConfiguration];
        });
    }
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //image slider
    self.scrl.showsHorizontalScrollIndicator = NO;
    
    self.scrl.frame=CGRectMake(0,0,SCREEN_SIZE.width, SCREEN_SIZE.height);
    self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width*4, SCREEN_SIZE.height);
    self.vw.frame=CGRectMake(0,0,SCREEN_SIZE.width*4, SCREEN_SIZE.height);
    self.img1.frame=CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    self.img2.frame=CGRectMake(SCREEN_SIZE.width, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    self.img3.frame=CGRectMake(SCREEN_SIZE.width*2, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    self.img4.frame=CGRectMake(SCREEN_SIZE.width*3, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.timer invalidate];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    Counter=0;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(ScrollImage) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/*!
 * @discussion Scroll Images
 */
-(void)ScrollImage
{
    if (Counter==3) {
        Counter=-1;
    }
    Counter++;
    
    self.page.currentPage=Counter;
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrl setContentOffset:CGPointMake(SCREEN_SIZE.width*Counter, 0)];
    }];
    
}

#pragma mark - Location Delegate
/*!
 * @discussion Set Latitude and Longitude from delegate
 */
- (void) LocationUpdated{
    mylatitude=[LocationHelper sharedInstance].latitude;
    mylongitude=[LocationHelper sharedInstance].longitude;
}
#pragma mark - btnclick
/*!
 * @discussion For Sign up, Navigate to Sign Up page
 * @param sender For identifying sender
 */
- (IBAction)btnSignUpClicked:(id)sender
{
    SignUpVC *vc=[[SignUpVC alloc]initWithNibName:@"SignUpVC" bundle:nil];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController pushViewController:vc animated:YES];
}
/*!
 * @discussion When Login with Email is selected, Redirect to Login with Email Page
 * @param sender For indentifying sender
 */
- (IBAction)btnLoginWithEmail:(id)sender
{
    LoginWithEmailVC *vc=[[LoginWithEmailVC alloc] initWithNibName:@"LoginWithEmailVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
/*!
 * @discussion Language selection view will display
 * @param sender For indentifying sender
 */
- (IBAction)btnSelectLanguageClicked:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect temp = self.myPickerView.frame;
        temp.origin.y = 667*SCREEN_SIZE.height/667-temp.size.height;
        self.myPickerView.frame = temp;
        
    } completion:^(BOOL finished) {
        
    }];
}
/*!
 * @discussion Select language
 * @param sender For indentifying sender
 */
-(IBAction)btnDoneClicked:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect temp = self.myPickerView.frame;
        temp.origin.y = 667*SCREEN_SIZE.height/667;
        self.myPickerView.frame = temp;
        //set language here
        
        for (int i = 0; i<arrLanguages.count; i++)
        {
            if ([selectedLanguage containsString:[arrLanguages objectAtIndex:i]])
            {
                [MCLocalization sharedInstance].language = [[arrLanguages objectAtIndex:i] lowercaseString];
                [[NSUserDefaults standardUserDefaults] setObject:[[arrLanguages objectAtIndex:i] lowercaseString] forKey:@"SelectedLanguage"] ;
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.btnChooseLanguage setTitle:[MCLocalization stringForKey:@"Choose Language"] forState:UIControlStateNormal];
            }
        }
        
        [MCLocalization sharedInstance].noKeyPlaceholder = @"[No '{key}' in '{language}']";
        
        if(([[appDelegate GetData:krtl] isEqualToString:@"0"] && [strSelectedRTLStatus isEqualToString:@"0"]) || ([[appDelegate GetData:krtl] isEqualToString:@"1"] && [strSelectedRTLStatus isEqualToString:@"1"]) ){
            rtlNotSet = false;
        }
        else{
            rtlNotSet = true;
        }
        
        [appDelegate SetData:strSelectedRTLStatus value:krtl];
        
        [self localize];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"] != YES)
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstTime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
       
    } completion:^(BOOL finished) {
        
    }];
}
/*!
 * @discussion Cancel select language
 * @param sender For indentifying sender
 */
-(IBAction)btnCancelClicked:(id)sender {
    //Cancel date picker
    [UIView animateWithDuration:0.5 animations:^{
        CGRect temp = self.myPickerView.frame;
        temp.origin.y = 667*SCREEN_SIZE.height/667;
        self.myPickerView.frame = temp;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    Counter=scrollView.contentOffset.x/SCREEN_SIZE.width;
    self.page.currentPage=scrollView.contentOffset.x/SCREEN_SIZE.width;
}

#pragma mark - Facebook Login
/*!
 * @discussion Called when login with Facebook is selected
 * @param sender For indentifying sender
 */
- (IBAction)btnFbLoginClicked:(id)sender {
    SHOW_LOADER_ANIMTION();
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login setLoginBehavior:FBSDKLoginBehaviorWeb];
    
    [login logInWithReadPermissions: @[@"public_profile", @"email",  @"user_birthday",@"user_education_history",@"user_work_history"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//         [login logInWithReadPermissions: @[@"public_profile", @"email",   @"user_photos",@"user_birthday",@"user_education_history",@"user_work_history"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            HIDE_PROGRESS;
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            HIDE_PROGRESS;
            NSLog(@"Cancelled");
        } else {
            
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture, email, id,first_name, last_name, birthday,education,work,interested_in, gender"}]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 
                 if (!error) {
                   
                     fbDetails=result;
                     
                     NSString *birthdate = [fbDetails valueForKey:@"birthday"];
                     if([birthdate length] > 0){
                         
                         NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                         [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                         NSDate *dateToday =[[NSDate alloc]init];

                         int time = [dateToday timeIntervalSinceDate:[dateFormatter dateFromString:birthdate]];
                         int allDays = (((time/60)/60)/24);
                         int days = allDays%365;
                         int years = (allDays-days)/365;
                         if(years < 18){
                             HIDE_PROGRESS;
                             ALERTVIEW([MCLocalization stringForKey:@"You must be 18+ For using this App."], self);
                         }
                         else{
                             [self checkFbID];
                         }
                    
                     }
                     else{
                         HIDE_PROGRESS;
                         ALERTVIEW([MCLocalization stringForKey:@"Please add your birthday to FaceBook! You must be 18+ For using this App."], self);
                     }
                     
                    
                 }
             }];
            
        }
    }];
}
#pragma mark - api call
/*!
 * @discussion Webservice call for login with Facebook
 */
-(void) checkFbID
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
       //  SHOW_LOADER_ANIMTION();
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"loginwithfb";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             if([[fbDetails valueForKey:@"first_name"] length]>0){
                 [dict setValue:[fbDetails valueForKey:@"first_name"] forKey:@"fname"];
             }
             else{
                 [dict setValue:@"-" forKey:@"fname"];
             }
             if([[fbDetails valueForKey:@"last_name"] length]>0){
                 [dict setValue:[fbDetails valueForKey:@"last_name"] forKey:@"lname"];
             }
             else{
                 [dict setValue:@"-" forKey:@"lname"];
             }
             if([[fbDetails valueForKey:@"email"] length]>0){
                 [dict setValue:[fbDetails valueForKey:@"email"] forKey:@"email"];
             }
             else{
                 [dict setValue:@"-" forKey:@"email"];
             }
             
             [dict setValue:[fbDetails valueForKey:@"id"] forKey:@"fb_id"];
             
             
             [dict setValue:[appDelegate GetData:kdeviceToken] forKey:@"device_token"];
             
             if([[fbDetails valueForKey:@"birthday"] length] >0){
                 
                 
                 NSArray *tempString=[[fbDetails valueForKey:@"birthday"] componentsSeparatedByString:@"/"];
                 
                 
                 [dict setValue:[NSString stringWithFormat:@"%@/%@/%@",tempString[1],tempString[0],tempString[2]] forKey:@"dob"];
             }
             else{
                 [dict setValue:@"-" forKey:@"dob"];
             }
            
             [dict setValue:@"About Me" forKey:@"about"];
             
           
             if([[fbDetails valueForKey:@"gender"] isEqualToString:@"male"]){
                 [dict setValue:@"male" forKey:@"gender"];
             }
             else{
                 [dict setValue:@"female" forKey:@"gender"];
             }
             if([[[fbDetails valueForKey:@"interested_in"] objectAtIndex:0] isEqualToString:@"male"]){
                 [dict setValue:@"male" forKey:@"gender_pref"];
             }
             else{
                 [dict setValue:@"female" forKey:@"gender_pref"];
             }

             [dict setValue:mylatitude forKey:@"location_lat"];
             [dict setValue:mylongitude forKey:@"location_long"];
             [dict setValue:@"1" forKey:@"access_location"];
             
             if([[[[[[fbDetails valueForKey:@"education"] objectAtIndex:0] valueForKey:@"concentration"] objectAtIndex:0] valueForKey:@"name"] length]>0){
                 [dict setValue:[[[[[fbDetails valueForKey:@"education"] objectAtIndex:0] valueForKey:@"concentration"] objectAtIndex:0] valueForKey:@"name"] forKey:@"education"];
             }
             else{
                 [dict setValue:@"-" forKey:@"education"];
                 [dict setValue:@"-" forKey:@"profession"];
             }
             if([[[[[fbDetails valueForKey:@"work"] objectAtIndex:0] valueForKey:@"position"] valueForKey:@"name"] length]>0){
                 [dict setValue:[[[[fbDetails valueForKey:@"work"] objectAtIndex:0] valueForKey:@"position"] valueForKey:@"name"] forKey:@"profession"];
             }
             else{
                 
                 [dict setValue:@"-" forKey:@"profession"];
             }
             
             [dict setValue:@"0" forKey:@"Status"];
             [dict setValue:kdevice forKey:@"device"];

             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     if([[[dictionary valueForKey:@"body"] valueForKey:@"new_user"] intValue]==1)
                     {
                         //new user
                         HIDE_PROGRESS;
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"age"] value:kAge];

                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"lname"] value:kLname];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"fname"] value:kUserName];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"id"] value:kuserid];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"AuthToken"]  value:kauthToken];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"gender_pref"] value:kgenderPref];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"location_lat"] value:klatitude];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"location_long"] value:klongitude];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"ejuser"] value:kejID];
                         
                         [appDelegate SetData:@"DetailsSignUp" value:@"Page"];
                         [[ApiManager sharedInstance] RegisterLoginXMPP];

                         DetailsSignUpVC *vc=[[DetailsSignUpVC alloc]initWithNibName:@"DetailsSignUpVC" bundle:nil];
                         [self.navigationController setNavigationBarHidden:NO animated:NO];
                         [self.navigationController pushViewController:vc animated:YES];
                     }
                     else{
                         
                         HIDE_PROGRESS;
                         //registered user
                         
                         //check for ads are enabled or disabled
                         if ([[[dictionary valueForKey:@"body"]valueForKey:@"enableAdd"] intValue]==1)
                         {
                             [appDelegate SetData:@"no" value:kAddsRemoved];
                         }
                         else
                         {
                             [appDelegate SetData:@"yes" value:kAddsRemoved];
                         }

                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"age"] value:kAge];

                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"lname"] value:kLname];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"fname"] value:kUserName];

                         [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"AuthToken"]  value:kauthToken];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]  valueForKey:@"id"] value:kuserid];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]  valueForKey:@"date_pref"] value:kdatePref];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]  valueForKey:@"gender_pref"] value:kgenderPref];
                         
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]  valueForKey:@"min_age_pref"] value:kminAgePref];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]  valueForKey:@"max_age_pref"] value:kmaxAgePref];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]  valueForKey:@"min_dist_pref"] value:kMinDistance];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]  valueForKey:@"max_dist_pref"] value:kmaxDistance];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]  valueForKey:@"about"] value:kabout];
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img1"]] value:kprofileimage];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"location_lat"] value:klatitude];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"location_long"] value:klongitude];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"height"] value:kheight];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"religion"] value:kreligion];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"ethnicity"] value:kethnicity];
                         
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"kids"] value:kno_of_kids];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"que_id"] value:kquestionID];
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"ejuser"] value:kejID];
                         if([[appDelegate GetData:kquestionID] integerValue] < 1){
                             [appDelegate SetData:@"1" value:kquestionID];
                         }
                         else if([[appDelegate GetData:kquestionID] integerValue] >25 ){
                             [appDelegate SetData:@"25" value:kquestionID];
                         }
                         [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"que_ans"] value:kanswer];
                         
                         //TODO: testing
                         [SSConnectionClasses shareInstance].totalUnReadMsgcount = [[[dictionary valueForKey:@"body"]valueForKey:@"notificationcounter"] intValue];
                        // [UIApplication sharedApplication].applicationIconBadgeNumber = [SSConnectionClasses shareInstance].totalUnReadMsgcount;
                         [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                         
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img1"]] value:kimg1];
                         NSString *temp=[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img2"];
                         if(temp!=nil){
                             [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img2"]] value:kimg2];
                         }
                         temp=[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img3"];
                         if(temp!=nil){
                             [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img3"]] value:kimg3];
                         }
                         
                         temp=[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img4"];
                         if(temp!=nil){
                             [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img4"]] value:kimg4];
                         }
                         
                         temp=[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img5"];
                         if(temp!=nil){
                             [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img5"]] value:kimg5];
                         }
                         
                         temp=[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img6"];
                         if(temp!=nil){
                             [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"user_gallary"] valueForKey:@"img6"]] value:kimg6];
                         }
                         [appDelegate ChangeViewController];
                         
                     }
                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something Went Wrong, Please Try Again."], self);
                     [FBSDKAccessToken setCurrentAccessToken:nil];
                     [FBSDKProfile setCurrentProfile:nil];
                 }

                
             }];
         }
     }];
}
/*!
 * @discussion Webservice call for getting all languages
 */
-(void) allLangauges
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
             NSString *str=@"all_languages";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     [arrLanguages removeAllObjects];
                     [arrRTLStatus removeAllObjects];
                     arrLanguages = [[NSMutableArray alloc] init];
                     arrRTLStatus = [[NSMutableArray alloc] init];;
                     self.btnChooseLanguage.hidden=NO;
                     //set list of languages that can be choosen
                     
                     NSMutableArray *dictLangs= [[dictionary valueForKey:@"language"] mutableCopy];
                     for(int i=0; i<[dictLangs count];i++){
                         if([[[dictLangs objectAtIndex:i] valueForKey:@"rtl"] intValue] == 0){
                             [arrRTLStatus addObject:@"0"];
                         }
                         else{
                             [arrRTLStatus addObject:@"1"];
                         }
                         [arrLanguages addObject:[[dictLangs objectAtIndex:i] valueForKey:@"name"]];
                     }
                     
                     self.btnChooseLanguage.hidden=YES;
                     if(arrLanguages.count>0){
                         [self.pckLangs selectRow:0 inComponent:0 animated:YES];
                         selectedLanguage=[arrLanguages objectAtIndex:0];
                         strSelectedRTLStatus = [arrRTLStatus objectAtIndex:0];
                         if(arrLanguages.count>1){
                             self.btnChooseLanguage.hidden=NO;
                         }
                         
                     }
                     
                     [self.pckLangs reloadAllComponents];
                     [self.pckLangs selectRow:0 inComponent:0 animated:YES];
                    
                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something Went Wrong, Please Try Again."], self);
                 }
    
             }];
         }
     }];
}
/*!
 * @discussion Webservice call for getting default language
 */
-(void) defaultLanguage
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
             NSString *str=@"default_language";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     //set default language
                     
                     [MCLocalization sharedInstance].language = [[dictionary valueForKey:@"language"] lowercaseString];
                     [[NSUserDefaults standardUserDefaults] setObject:[[dictionary valueForKey:@"language"] lowercaseString] forKey:@"SelectedLanguage"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     [self.btnChooseLanguage setTitle:[MCLocalization stringForKey:@"Choose Language"] forState:UIControlStateNormal];
                     
                     strSelectedRTLStatus = [dictionary valueForKey:@"rtl"];
                     if([strSelectedRTLStatus isEqualToString:@"1"]){
                          rtlNotSet =  true;
                     }
                     else{
                          rtlNotSet =  false;
                     }
                    
                     [appDelegate SetData:strSelectedRTLStatus value:krtl];
                     
                     [self allLangauges];
                     [self localize];
                 }
                 else
                 {
                     HIDE_PROGRESS;
                     ALERTVIEW([MCLocalization stringForKey:@"Something Went Wrong, Please Try Again."], self);
                 }
                 
             }];
         }
     }];
}

/*!
 * @discussion Webservice call for getting app configuration
 */
-(void) getAllConfiguration
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
      //   SHOW_LOADER_ANIMTION();
         if (responseObject == false)
         {
          //   HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"get_all_configuration";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 if(success){
                     
                     [appDelegate SetData:[dictionary valueForKey:@"GOOGLE_PLACE_API_KEY"] value:GOOGLE_API_KEY];
                     [appDelegate SetData:[dictionary valueForKey:@"adMobKey"] value:KadMobKey];
                     [appDelegate SetData:[dictionary valueForKey:@"adMobVideoKey"] value:KadMobVideoKey];
                     [appDelegate SetData:[dictionary valueForKey:@"RemoveAddInAppPurchase"] value:kRemoveAddInAppPurchase];
                     [appDelegate SetData:[dictionary valueForKey:@"TermsAndConditionsUrl"] value:kTermsAndConditionsUrl];
                     [appDelegate SetData:[dictionary valueForKey:@"INSTAGRAM_CALLBACK_BASE"] value:INSTAGRAM_CALLBACK_BASE];
                     [appDelegate SetData:[dictionary valueForKey:@"INSTAGRAM_CLIENT_SECRET"] value:INSTAGRAM_CLIENT_SECRET];
                     [appDelegate SetData:[dictionary valueForKey:@"INSTAGRAM_CLIENT_ID"] value:INSTAGRAM_CLIENT_ID];

                     [appDelegate SetData:[dictionary valueForKey:@"XMPP_ENABLE"] value:kXMPPEnabled];

                     [appDelegate SetData:[dictionary valueForKey:@"APP_XMPP_HOST"] value:kXMPPHostName];
                     [appDelegate SetData:[dictionary valueForKey:@"APP_XMPP_SERVER"] value:kXMPPPrefix];
                     [appDelegate SetData:[dictionary valueForKey:@"XMPP_DEFAULT_PASSWORD"] value:kUserPassword];

                     [appDelegate SetData:[dictionary valueForKey:@"RemoveAddInAppPurchase"] value:kRemoveAddInAppPurchase];
                     [appDelegate SetData:[dictionary valueForKey:@"PaidChatInAppPurchase"] value:kChatSubscriptionInAppPurchase];
                     [appDelegate SetData:[dictionary valueForKey:@"LocationInAppPurchase"] value:kLocationInAppPurchase];
                     [appDelegate SetData:[dictionary valueForKey:@"SuperLikeInAppPurchase"] value:kSuperLikeInAppPurchase];
                     
                     if ([[dictionary valueForKey:@"PAID_CHAT"] isEqualToString:@"ON"]) {
                         [appDelegate SetData:@"yes" value:kPaidChat];
                     } else {
                         [appDelegate SetData:@"no" value:kPaidChat];
                     }
                     if ([[dictionary valueForKey:@"PAID_LOCATION"] isEqualToString:@"ON"]) {
                         [appDelegate SetData:@"yes" value:kPaidLocation];
                     } else {
                         [appDelegate SetData:@"no" value:kPaidLocation];
                     }
                     if ([[dictionary valueForKey:@"PAID_SUPERLIKE"] isEqualToString:@"ON"]) {
                         [appDelegate SetData:@"yes" value:kPaidSuperLike];
                     } else {
                         [appDelegate SetData:@"no" value:kPaidSuperLike];
                     }
                     if ([[dictionary valueForKey:@"PAID_AD"] isEqualToString:@"ON"]) {
                         [appDelegate SetData:@"yes" value:kPaidAd];
                     } else {
                         [appDelegate SetData:@"no" value:kPaidAd];
                     }

                     if(![[appDelegate GetData:GOOGLE_API_KEY] isEqualToString:@"Key Not Found"]){
                         
                         [GMSPlacesClient provideAPIKey:[appDelegate GetData:GOOGLE_API_KEY]];
                         [GADMobileAds configureWithApplicationID:[appDelegate GetData:GOOGLE_API_KEY]];
                     }
                     appDelegate.isAppConfigurationSaved = @"Saved";
                 }
                 else
                 {
//                     HIDE_PROGRESS;
                     ALERTVIEW([MCLocalization stringForKey:@"Something Went Wrong, Please Try Again."], self);
                 }
                 
             }];
         }
     }];
}

#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lbltagline.text=[MCLocalization stringForKey:@"Meet Cool people around you..!"];
    self.lblLofinwithFB.text=[MCLocalization stringForKey:@"Login with Facebook"];
    self.lblloginwithEmail.text=[MCLocalization stringForKey:@"Login with Email"];
    [self.btnCancel setTitle:[MCLocalization stringForKey:@"Cancel"] forState:UIControlStateNormal];
    [self.btnDone setTitle:[MCLocalization stringForKey:@"Done"] forState:UIControlStateNormal];
    [self.btnAlreadyHaveAnAccount setTitle:[MCLocalization stringForKey:@"Don't have an account? Tap to SignUp"] forState:UIControlStateNormal];
    
    if(rtlNotSet){
        [self setRTL];
    }
    
}
/*!
 * @discussion set RTL UI
 */
- (void)setRTL{
    rtlNotSet = false;
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"]){
        self.lblLofinwithFB.textAlignment = NSTextAlignmentRight;
        self.lblloginwithEmail.textAlignment = NSTextAlignmentRight;
    }
    else{
        self.lblLofinwithFB.textAlignment = NSTextAlignmentLeft;
        self.lblloginwithEmail.textAlignment = NSTextAlignmentLeft;
    }
    
    CGRect tempFrame = self.imgFb.frame;
    tempFrame.origin.x = SCREEN_SIZE.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgFb.frame = tempFrame ;
    
    tempFrame = self.imgEmail.frame;
    tempFrame.origin.x = SCREEN_SIZE.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgEmail.frame = tempFrame ;
    
    tempFrame = self.lblSeperator1.frame;
    tempFrame.origin.x = SCREEN_SIZE.width - tempFrame.origin.x - tempFrame.size.width ;
    self.lblSeperator1.frame = tempFrame ;
    
    tempFrame = self.lblSeperator2.frame;
    tempFrame.origin.x = SCREEN_SIZE.width - tempFrame.origin.x - tempFrame.size.width ;
    self.lblSeperator2.frame = tempFrame ;
    
    tempFrame = self.lblloginwithEmail.frame;
    tempFrame.origin.x = SCREEN_SIZE.width - tempFrame.origin.x - tempFrame.size.width ;
    self.lblloginwithEmail.frame = tempFrame ;
    
    tempFrame = self.lblLofinwithFB.frame;
    tempFrame.origin.x = SCREEN_SIZE.width - tempFrame.origin.x - tempFrame.size.width ;
    self.lblLofinwithFB.frame = tempFrame ;
    
}
#pragma mark - PickerView Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return arrLanguages.count;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [arrLanguages objectAtIndex:row];
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}

#pragma mark- PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    selectedLanguage=[arrLanguages objectAtIndex:row];
    strSelectedRTLStatus = [arrRTLStatus objectAtIndex:row];
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [arrLanguages objectAtIndex:row];
}


@end
