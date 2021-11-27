//
//  LoginWithEmailVC.m
//  CupidLove
//
//  Created by Umesh on 11/10/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import "LoginWithEmailVC.h"
#import "SignUpVC.h"
#import "FriendProfileVC.h"
#import "RightMenuVC.h"
#import "BlockedVC.h"

@interface LoginWithEmailVC ()

@property(weak,nonatomic) IBOutlet UITextField *txtEmail;
@property(weak,nonatomic) IBOutlet UITextField *txtPassword;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
@property (strong, nonatomic) IBOutlet UILabel *lblSignIn;
@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UIButton *btnsignup;
@property (strong, nonatomic) IBOutlet UIButton *btnForgotPass;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;

@property (weak, nonatomic) IBOutlet UIView *vwForWidth;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UIImageView *imgPass;
@property (weak, nonatomic) IBOutlet UIView *vwPassword;

@end

@implementation LoginWithEmailVC{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    UIColor *color = [UIColor whiteColor];
    UIFont *font=[UIFont fontWithName:@"Lato-Regular" size:14];
    self.txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"UserName" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    self.txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];

}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self localize];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*!
 * @discussion For Returning from TextField
 * @param textField For identifying textField
 */
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Button Clicked
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
 * @discussion For Forgot Password
 * @param sender For identifying sender
 */
- (IBAction)btnForgotPasswordClicked:(id)sender{
    NSString *strEmail = [self.txtEmail.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (strEmail.length>0)
    {
        if ([Util ValidateEmailString:strEmail])
        {
            [self ForgotPassword];
        }
        else{
            ALERTVIEW([MCLocalization stringForKey:@"Invalid Email."], self);
        }
        
    }
    else{
        ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Username!!"], self);
    }
}
/*!
 * @discussion For Login process
 * @param sender For identifying sender
 */
- (IBAction)btnLoginClicked:(id)sender
{
    NSString *strEmail = [self.txtEmail.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (strEmail.length>0)
    {
        if ([Util ValidateEmailString:strEmail])
        {
            if (self.txtPassword.text.length>0)
            {
                [self Login];
            }
            else
            {
                ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Password!!"], self);

            }
        }
        else{
            ALERTVIEW([MCLocalization stringForKey:@"Invalid Username!!"], self);
        }
    }
    else{
        ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Username!!"], self);
    }

}
/*!
 * @discussion When back button is clicked, Navigate to previous page
 * @param sender For identifying sender
 */
- (IBAction)btnBackCliked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Api Calls
/*!
 * @discussion WebService Call Login with Email
 */
-(void)Login
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
             NSString *str=@"login";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:[self.txtEmail.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"email"];
             [dict setValue:self.txtPassword.text forKey:@"password"];
             [dict setValue:kdevice forKey:@"device"];
             [dict setValue:[appDelegate GetData:kdeviceToken] forKey:@"device_token"];
             
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 HIDE_PROGRESS;
                
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     if([[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"status"] intValue]==1){
                         [appDelegate SetData:@"yes" value:kBlocked];
                         
                         RightMenuVC *Rightvc=[[RightMenuVC alloc]initWithNibName:@"RightMenuVC" bundle:nil];
                         BlockedVC *vc=[[BlockedVC alloc]initWithNibName:@"BlockedVC" bundle:nil];
                         self.nav=[[UINavigationController alloc]initWithRootViewController:vc];
                         [self.navigationController setNavigationBarHidden:NO animated:NO];

                         MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController                                                                                  containerWithCenterViewController:self.nav leftMenuViewController:Rightvc rightMenuViewController:nil];
                         
                         container.panMode=MFSideMenuPanModeNone;
                         appDelegate.window.rootViewController=container;
                         [appDelegate.window makeKeyAndVisible];
                     }
                     
                     [appDelegate SetData:@"no" value:kChatSubscription];
                     [appDelegate SetData:@"no" value:kLocationService];
                     [appDelegate SetData:@"no" value:kAddsRemoved];
                     [appDelegate SetData:@"no" value:kSuperLike];

                     if ([dictionary objectForKey:@"user_purchase"])
                     {
                         //purchased
                         NSArray *arr = [[NSArray alloc] initWithArray:[dictionary objectForKey:@"user_purchase"]];
                         for (int i = 0; i < arr.count; i++) {
                             if ([[[arr objectAtIndex:i] valueForKey:@"purchasekey"] isEqualToString:kPaidChat])
                             {
                                 //paid chat purchased
                                 [appDelegate SetData:@"yes" value:kChatSubscription];
                             }
                             else if ([[[arr objectAtIndex:i] valueForKey:@"purchasekey"] isEqualToString:kPaidLocation])
                             {
                                 //paid location purchased
                                 [appDelegate SetData:@"yes" value:kLocationService];
                             }
                             else if ([[[arr objectAtIndex:i] valueForKey:@"purchasekey"] isEqualToString:kPaidAd])
                             {
                                 //paid location purchased
                                 [appDelegate SetData:@"yes" value:kAddsRemoved];
                             }
                             else if ([[[arr objectAtIndex:i] valueForKey:@"purchasekey"] isEqualToString:@"PAID_SUPERLIKE"])
                             {
                                 //paid superlike purchased
                                 [appDelegate SetData:@"yes" value:kSuperLike];
                             }
                         }
                     }
                     
//                     if ([[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"enableAdd"] intValue]==1)
//                     {
//                         [appDelegate SetData:@"no" value:kAddsRemoved];
//                     }
//                     else
//                     {
//                         [appDelegate SetData:@"yes" value:kAddsRemoved];
//                     }
                     // save users info
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"lname"] value:kLname];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"age"] value:kAge];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"fname"] value:kUserName];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"AuthToken"] value:kauthToken];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"id"] value:kuserid];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"date_pref"] value:kdatePref];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"gender_pref"] value:kgenderPref];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"min_age_pref"] value:kminAgePref];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"max_age_pref"] value:kmaxAgePref];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"min_dist_pref"] value:kMinDistance];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"max_dist_pref"] value:kmaxDistance];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"about"] value:kabout];
                     
                     [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"profile_image"]] value:kprofileimage];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"location_lat"] value:klatitude];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"location_long"] value:klongitude];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"height"] value:kheight];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"religion"] value:kreligion];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"ethnicity"] value:kethnicity];
                     
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"kids"] value:kno_of_kids];
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"que_id"] value:kquestionID];
                     
                     if([[appDelegate GetData:kquestionID] integerValue] < 1){
                         [appDelegate SetData:@"1" value:kquestionID];
                     }
                     else if([[appDelegate GetData:kquestionID] integerValue] >25 ){
                         [appDelegate SetData:@"25" value:kquestionID];
                     }
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"que_ans"] value:kanswer];
                     
                     
                     [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img1"]] value:kimg1];
                     
                     NSString *temp=[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img2"];
                    
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img2"]] value:kimg2];
                     }
                     temp=[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img3"];
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img3"]] value:kimg3];
                     }
                     
                     temp=[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img4"];
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img4"]] value:kimg4];
                     }
                     
                     temp=[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img5"];
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img5"]] value:kimg5];
                     }
                     
                     temp=[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img6"];
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"user_gallary"] valueForKey:@"img6"]] value:kimg6];
                     }

                     
                     //TODO: testing
                     [SSConnectionClasses shareInstance].totalUnReadMsgcount = [[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"notificationcounter"] intValue];
                    // [UIApplication sharedApplication].applicationIconBadgeNumber = [SSConnectionClasses shareInstance].totalUnReadMsgcount;
                     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                     
                     [appDelegate SetData:[[dictionary valueForKey:@"loginUserDetails"]valueForKey:@"ejuser"] value:kejID];
                     
                     [appDelegate ChangeViewController];
                     
                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Your Username or Password is incrroect!!"], self);
                 }
             }];
         }
     }];
}
/*!
 * @discussion WebService Call Forgot Password
 */
-(void)ForgotPassword
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
             NSString *str=@"forgot_password";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:[self.txtEmail.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"email"];
           
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 HIDE_PROGRESS;
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                    
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
                 else if(success && [[dictionary valueForKey:@"error"] intValue]==1){
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong! Please try again !!"], self);
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
    self.lblSignIn.text=[MCLocalization stringForKey:@"SIGN IN"];
    
    [self.btnForgotPass setTitle:[MCLocalization stringForKey:@"Forgot Password"] forState:UIControlStateNormal];
    [self.btnsignup setTitle:[MCLocalization stringForKey:@"Don't have an account? Tap to SignUp"] forState:UIControlStateNormal];
    [self.btnSignIn setTitle:[MCLocalization stringForKey:@"SIGN IN"] forState:UIControlStateNormal];
    
    UIColor *color = [UIColor whiteColor];
    UIFont *font=[UIFont fontWithName:@"Lato-Regular" size:14];
    self.txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"UserName"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    self.txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Password"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    
    [self.lblSignIn sizeToFit];
    self.lblSignIn.frame = CGRectMake((SCREEN_SIZE.width - self.lblSignIn.frame.size.width)/2 , self.lblSignIn.frame.origin.y, self.lblSignIn.frame.size.width, self.lblSignIn.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblSignIn.frame.origin.x, self.lblTitleUnderline.frame.origin.y, self.lblSignIn.frame.size.width, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
    
    if( [[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self setRTL];
    }
   
}
/*!
 * @discussion set RTL UI
 */
- (void)setRTL{
    
    CGRect tempFrame = self.txtEmail.frame;
    tempFrame.origin.x = 39 * SCREEN_SIZE.width/375 ;
    self.txtEmail.frame = tempFrame ;
    
    tempFrame = self.txtPassword.frame;
    tempFrame.origin.x = 39 * SCREEN_SIZE.width/375 ;
    self.txtPassword.frame = tempFrame ;
    
    tempFrame = self.btnForgotPass.frame;
    tempFrame.origin.x =  35 * SCREEN_SIZE.width/375  ;
    self.btnForgotPass.frame = tempFrame ;
}

/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.vwForWidth setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwPassword setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.txtEmail setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtPassword setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    self.txtEmail.textAlignment = NSTextAlignmentRight;
    self.txtPassword.textAlignment = NSTextAlignmentRight;
    self.btnForgotPass.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}
@end
