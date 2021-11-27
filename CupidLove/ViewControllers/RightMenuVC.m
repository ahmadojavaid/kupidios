//
//  RightMenuVC.m
//  CupidLove
//
//  Created by Umesh on 11/22/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import "RightMenuVC.h"
#import "NotificationVC.h"
#import "ChatVC.h"
#import "SettingsVC.h"
#import "WelcomeVC.h"
#import "FriendProfileVC.h"
#import "BlockedVC.h"
#import "RemoveAdVC.h"
#import "FriendDetailsVC.h"
#import "MyProfileVC.h"
#import "LocationVC.h"
#import "InAppPurchaseVC.h"

@interface RightMenuVC ()
@property(strong,nonatomic) IBOutlet UIView *vwRight;
@property(strong,nonatomic) IBOutlet UIImageView *imgProfile;
@property(strong,nonatomic) IBOutlet UIActivityIndicatorView *act;
@property (strong,nonatomic) IBOutlet UILabel *lblUserName;
@property (strong,nonatomic) IBOutlet UILabel *lblChatCounter;
@property(strong,nonatomic) IBOutlet UIView *vwChatCounter;
@property(strong,nonatomic) IBOutlet UIView *vwimg;
@property(strong,nonatomic) IBOutlet UIView *vwNotificationCounter;
@property(strong,nonatomic) IBOutlet UIView *vwRemoveAdds;

@property(strong,nonatomic) IBOutlet UIImageView *imgSelection1;
@property(strong,nonatomic) IBOutlet UIImageView *imgSelection2;
@property(strong,nonatomic) IBOutlet UIImageView *imgSelection3;
@property(strong,nonatomic) IBOutlet UIImageView *imgSelection4;
@property(strong,nonatomic) IBOutlet UIImageView *imgSelection5;
@property(strong,nonatomic) IBOutlet UIImageView *imgSelection6;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelection7;

@property (strong, nonatomic) IBOutlet UILabel *lblStartPlaying;
@property (strong, nonatomic) IBOutlet UILabel *lblChat;
@property (strong, nonatomic) IBOutlet UILabel *lblNotification;
@property (strong, nonatomic) IBOutlet UILabel *lblSettings;
@property (strong, nonatomic) IBOutlet UILabel *lblRemoveAds;
@property (strong, nonatomic) IBOutlet UILabel *lblLogout;
@property (strong, nonatomic) IBOutlet UILabel *lblMyProfile;
@property(strong,nonatomic) IBOutlet UIImageView *imgMenuLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;


@end

@implementation RightMenuVC
{
    NSString *strBlocked;
    Boolean flag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self localize];
    self.lblNotificationCount.textColor = Theme_Color;
    self.lblChatCounter.textColor = Theme_Color;
    self.act.color = Theme_Color;
    flag = true;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    strBlocked=[appDelegate GetData:kBlocked];

    if ([[appDelegate GetData:kAddsRemoved] isEqualToString:@"yes"] || ![[appDelegate GetData:kPaidAd] isEqualToString:@"yes"]) {
        self.vwRemoveAdds.hidden=YES;
    }
    else
    {
        self.vwRemoveAdds.hidden=NO;
    }
    
    
    [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
    
    if ([[appDelegate GetData:kNotificationCount] isEqualToString:@"Key Not Found"])
    {
        
    }
    else
    {
        [SSConnectionClasses shareInstance].totalUnReadMsgcount=[SSConnectionClasses shareInstance].totalUnReadMsgcount-[[appDelegate GetData:kNotificationCount] intValue];
    }

    
    if ([SSConnectionClasses shareInstance].totalUnReadMsgcount<=0)
    {
        self.vwChatCounter.hidden=YES;
    }
    else
    {
        self.vwChatCounter.hidden=NO;
            self.lblChatCounter.text=[NSString stringWithFormat:@"%ld",(long)[SSConnectionClasses shareInstance].totalUnReadMsgcount];
    }
 //   self.lblUserName.text=[NSString stringWithFormat:@"%@ %@",[[appDelegate GetData:kUserName] capitalizedString],[[appDelegate GetData:kLname] capitalizedString]];
//    self.lblUserName.text = @"sgbius bgbzsgbz gzu9s hguz hguzs lng";
    
    NSString *strName = [NSString stringWithFormat:@"%@ %@, %@",[[appDelegate GetData:kUserName] capitalizedString],[[appDelegate GetData:kLname] capitalizedString], [appDelegate GetData:kAge]];
    if(strName.length >41){
        strName = [strName substringToIndex:41];
    }
    self.lblUserName.text = strName;
    
    [self.act startAnimating];
    [self.imgProfile sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kprofileimage]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image!=nil){
            self.imgProfile.image = image;
        }
        else{
            self.imgProfile.image = [UIImage imageNamed:@"TempProfile"];
        }
        [self.act stopAnimating];
    }];
    
    [self notificationCount];
    
    self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width,SCREEN_SIZE.height);

}
- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    if(flag && [[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.imgProfile.layer.cornerRadius=12;
    self.imgProfile.layer.masksToBounds = YES;
    self.imgProfile.layer.borderColor= [UIColor whiteColor].CGColor;
    self.imgProfile.layer.borderWidth=1.5f;
    self.vwRight.frame=CGRectMake(self.vwRight.frame.origin.x,0,self.vwRight.frame.size.width,[UIScreen mainScreen].bounds.size.height);
    self.vwimg.frame=CGRectMake((self.vwRight.frame.size.width-self.imgProfile.frame.size.height+5)/2,self.vwimg.frame.origin.y, self.imgProfile.frame.size.height+5, self.imgProfile.frame.size.height+5);
    self.imgProfile.frame = CGRectMake( 0,0,self.imgProfile.frame.size.height,self.imgProfile.frame.size.height);
    
  //  self.imgProfile.frame = CGRectMake( 0,0,self.imgProfile.frame.size.height+5,self.imgProfile.frame.size.height+5);
    
   self.imgMenuLogo.center = CGPointMake(self.imgProfile.frame.origin.x+self.imgProfile.frame.size.width, self.imgProfile.frame.origin.y+self.imgProfile.frame.size.height);
    self.lblUserName.frame = CGRectMake(self.lblUserName.frame.origin.x,self.vwimg.frame.size.height+self.vwimg.frame.origin.y+15,self.lblUserName.frame.size.width,self.lblUserName.frame.size.height);
    self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,self.view.frame.size.width,SCREEN_SIZE.height);
}

-(void)HideShowSelection:(int)index
{
    if (index==1)
    {
        self.imgSelection1.hidden=NO;
        self.imgSelection2.hidden=YES;
        self.imgSelection3.hidden=YES;
        self.imgSelection4.hidden=YES;
        self.imgSelection5.hidden=YES;
        self.imgSelection6.hidden=YES;
        self.imgSelection7.hidden=YES;
    }
    else if (index==2)
    {
        self.imgSelection1.hidden=YES;
        self.imgSelection2.hidden=NO;
        self.imgSelection3.hidden=YES;
        self.imgSelection4.hidden=YES;
        self.imgSelection5.hidden=YES;
        self.imgSelection6.hidden=YES;
        self.imgSelection7.hidden=YES;
    }
    else if (index==3)
    {
        self.imgSelection1.hidden=YES;
        self.imgSelection2.hidden=YES;
        self.imgSelection3.hidden=NO;
        self.imgSelection4.hidden=YES;
        self.imgSelection5.hidden=YES;
        self.imgSelection6.hidden=YES;
        self.imgSelection7.hidden=YES;
    }
    else if (index==4)
    {
        self.imgSelection1.hidden=YES;
        self.imgSelection2.hidden=YES;
        self.imgSelection3.hidden=YES;
        self.imgSelection4.hidden=NO;
        self.imgSelection5.hidden=YES;
        self.imgSelection6.hidden=YES;
        self.imgSelection7.hidden=YES;
    }
    else if (index==5)
    {
        self.imgSelection1.hidden=YES;
        self.imgSelection2.hidden=YES;
        self.imgSelection3.hidden=YES;
        self.imgSelection4.hidden=YES;
        self.imgSelection5.hidden=NO;
        self.imgSelection6.hidden=YES;
        self.imgSelection7.hidden=YES;
    }
    else if (index==6)
    {
        self.imgSelection1.hidden=YES;
        self.imgSelection2.hidden=YES;
        self.imgSelection3.hidden=YES;
        self.imgSelection4.hidden=YES;
        self.imgSelection5.hidden=YES;
        self.imgSelection6.hidden=NO;
        self.imgSelection7.hidden=YES;
    }
    else if (index==7)
    {
        self.imgSelection1.hidden=YES;
        self.imgSelection2.hidden=YES;
        self.imgSelection3.hidden=YES;
        self.imgSelection4.hidden=YES;
        self.imgSelection5.hidden=YES;
        self.imgSelection6.hidden=YES;
        self.imgSelection7.hidden=NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-btn clicks
/*!
 * @discussion For Logout
 * @param sender For indentify sender
 */
- (IBAction)btnLogoutClicked:(id)sender {
    
    ///logout api
    [self Logout];
    
}
/*!
 * @discussion Go to Notification page
 * @param sender For indentify sender
 */
- (IBAction)btnNotificationClicked:(id)sender
{
    [appDelegate SetData:[NSString stringWithFormat:@"3"] value:kSelecttion];

    if ([strBlocked isEqualToString:@"yes"])
    {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        BlockedVC *VC = [[BlockedVC alloc] initWithNibName:@"BlockedVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
   
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else
    {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        NotificationVC *VC = [[NotificationVC alloc] initWithNibName:@"NotificationVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        [self.navigationController setNavigationBarHidden:NO animated:NO];

        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    

}
/*!
 * @discussion Go to MyProfile page
 * @param sender For indentify sender
 */
- (IBAction)btnMyProfilePageClicked:(id)sender
{
    [appDelegate SetData:[NSString stringWithFormat:@"6"] value:kSelecttion];
    
    if ([strBlocked isEqualToString:@"yes"])
    {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        BlockedVC *VC = [[BlockedVC alloc] initWithNibName:@"BlockedVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else
    {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        MyProfileVC *VC = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    
    
}
/*!
 * @discussion Go to my details page
 * @param sender For indentify sender
 */
- (IBAction)btnMyProfileClicked:(id)sender
{
    [appDelegate SetData:[NSString stringWithFormat:@"1"] value:kSelecttion];

    if ([strBlocked isEqualToString:@"yes"]) {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        BlockedVC *VC = [[BlockedVC alloc] initWithNibName:@"BlockedVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
       
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

    }
    else
    {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        FriendProfileVC *VC = [[FriendProfileVC alloc] initWithNibName:@"FriendProfileVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
      
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    
}
/*!
 * @discussion Go to Chat page
 * @param sender For indentify sender
 */
- (IBAction)btnChatClicked:(id)sender {
    
    [appDelegate SetData:[NSString stringWithFormat:@"2"] value:kSelecttion];

    if ([strBlocked isEqualToString:@"yes"])
    {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        BlockedVC *VC = [[BlockedVC alloc] initWithNibName:@"BlockedVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
 
    }
    else
    {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        ChatVC *VC = [[ChatVC alloc] initWithNibName:@"ChatVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
}
/*!
 * @discussion Go to Settings page
 * @param sender For indentify sender
 */
- (IBAction)btnSettingsClicked:(id)sender
{
    [appDelegate SetData:[NSString stringWithFormat:@"4"] value:kSelecttion];

    if ([strBlocked isEqualToString:@"yes"]) {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        BlockedVC *VC = [[BlockedVC alloc] initWithNibName:@"BlockedVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

    }
    else
    {
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        SettingsVC *VC = [[SettingsVC alloc] initWithNibName:@"SettingsVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
}

/*!
 * @discussion Go to remove ads page
 * @param sender For indentify sender
 */
- (IBAction)btnRemoveAddsClicked:(id)sender
{
//    [appDelegate SetData:[NSString stringWithFormat:@"5"] value:kSelecttion];
//
//    if ([strBlocked isEqualToString:@"yes"]) {
//        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
//        BlockedVC *VC = [[BlockedVC alloc] initWithNibName:@"BlockedVC" bundle:nil];
//        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//        NSArray *controllers = [NSArray arrayWithObject:VC];
//        navigationController.viewControllers = controllers;
//        [self.navigationController setNavigationBarHidden:NO animated:NO];
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//
//    }
//    else
//    {
//        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
//        RemoveAdVC *VC = [[RemoveAdVC alloc] initWithNibName:@"RemoveAdVC" bundle:nil];
//        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//        NSArray *controllers = [NSArray arrayWithObject:VC];
//        navigationController.viewControllers = controllers;
//        [self.navigationController setNavigationBarHidden:NO animated:NO];
//        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//    }
    if ([strBlocked isEqualToString:@"yes"])
    {
        [appDelegate SetData:[NSString stringWithFormat:@"5"] value:kSelecttion];
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        BlockedVC *VC = [[BlockedVC alloc] initWithNibName:@"BlockedVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else
    {
        if ([[appDelegate GetData:kAddsRemoved] isEqualToString:@"yes"] && ![[appDelegate GetData:kRemoveAddInAppPurchase] isEqualToString:@""])
        {
            [appDelegate SetData:[NSString stringWithFormat:@"5"] value:kSelecttion];
            [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
            BlockedVC *VC = [[BlockedVC alloc] initWithNibName:@"BlockedVC" bundle:nil];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:VC];
            navigationController.viewControllers = controllers;
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
        else
        {
            //inapp purchase
            //            LocationServiceVC *vc = [[LocationServiceVC alloc] initWithNibName:@"LocationServiceVC" bundle:nil];
            
            // 1 remove ad
            // 2 Chat
            // 3 Location
            // 4 Superlike
            
            InAppPurchaseVC *vc = [[InAppPurchaseVC alloc] initWithNibName:@"InAppPurchaseVC" bundle:nil];
            self.definesPresentationContext = YES; //self is presenting view controller
            vc.view.backgroundColor = [UIColor clearColor];
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            vc.fromPage = 1; // from superlike purchase
            [self presentViewController:vc animated:YES completion:nil];
        }
    }

}

- (IBAction)btnProfileClicked:(id)sender
{
//    [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
//    UserDetailVC *VC = [[UserDetailVC alloc] initWithNibName:@"UserDetailVC" bundle:nil];
//    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//    NSArray *controllers = [NSArray arrayWithObject:VC];
//    navigationController.viewControllers = controllers;
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
////    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
////
////    FriendDetailsVC *vc=[[FriendDetailsVC alloc] initWithNibName:@"FriendDetailsVC" bundle:nil];
//////    vc.dictDetails=[dictionary valueForKey:@"body"];
//////    vc.strFriendID = [appDelegate GetData:kuserid] ;
////    [self.navigationController pushViewController:vc animated:YES];
    [self getUserDetails];
}

/*!
 * @discussion Go to location page
 * @param sender For indentify sender
 */
- (IBAction)btnLocationClicked:(id)sender {
    
    if ([strBlocked isEqualToString:@"yes"])
    {
        [appDelegate SetData:[NSString stringWithFormat:@"7"] value:kSelecttion];
        [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
        BlockedVC *VC = [[BlockedVC alloc] initWithNibName:@"BlockedVC" bundle:nil];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:VC];
        navigationController.viewControllers = controllers;
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
    else
    {
        if (![[appDelegate GetData:kLocationService] isEqualToString:@"yes"] && [[appDelegate GetData:kPaidLocation] isEqualToString:@"yes"] && ![[appDelegate GetData:kLocationInAppPurchase] isEqualToString:@""])
        {
            //inapp purchase
            //            LocationServiceVC *vc = [[LocationServiceVC alloc] initWithNibName:@"LocationServiceVC" bundle:nil];
            
            // 1 remove ad
            // 2 Chat
            // 3 Location
            // 4 Superlike
            
            InAppPurchaseVC *vc = [[InAppPurchaseVC alloc] initWithNibName:@"InAppPurchaseVC" bundle:nil];
            self.definesPresentationContext = YES; //self is presenting view controller
            vc.view.backgroundColor = [UIColor clearColor];
            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            vc.fromPage = 3; // from superlike purchase
            [self presentViewController:vc animated:YES completion:nil];
        }
        else
        {
            [appDelegate SetData:[NSString stringWithFormat:@"7"] value:kSelecttion];
            [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
            LocationVC *VC = [[LocationVC alloc] initWithNibName:@"LocationVC" bundle:nil];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            NSArray *controllers = [NSArray arrayWithObject:VC];
            navigationController.viewControllers = controllers;
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
        }
    }
}


#pragma mark - Api Calls
/*!
 * @discussion WebService call for Logout
 */
-(void)Logout
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
             NSString *str=@"api_logout";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
               
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     [[SSConnectionClasses shareInstance] disconnect];
                     [appDelegate RemoveData:kauthToken];
                     [appDelegate.selectedImages removeAllObjects];
                     appDelegate.flag_next=@"";
                     [appDelegate RemoveData:kimg1];
                     [appDelegate RemoveData:kimg2];
                     [appDelegate RemoveData:kimg3];
                     [appDelegate RemoveData:kimg4];
                     [appDelegate RemoveData:kimg5];
                     [appDelegate RemoveData:kimg6];
                     [appDelegate RemoveData:kuserid];
                     [appDelegate RemoveData:kdatePref];
                     [appDelegate RemoveData:kgenderPref];
                     [appDelegate RemoveData:kminAgePref];
                     [appDelegate RemoveData:kmaxAgePref];
                     [appDelegate RemoveData:kMinDistance];
                     [appDelegate RemoveData:kmaxDistance];
                     [appDelegate RemoveData:kabout];
                     [appDelegate RemoveData:kuserid];
                     [appDelegate RemoveData:kLname];
                     [appDelegate RemoveData:kUserName];
                     [appDelegate RemoveData:klatitude];
                     [appDelegate RemoveData:klongitude];
                     [appDelegate RemoveData:kprofileimage];
                     [appDelegate RemoveData:kheight];
                     [appDelegate RemoveData:kreligion];
                     [appDelegate RemoveData:kethnicity];
                     [appDelegate RemoveData:kno_of_kids];
                     [appDelegate RemoveData:kquestionID];
                     [appDelegate RemoveData:kanswer];
                     [appDelegate RemoveData:kBlocked];
                     [appDelegate RemoveData:kOneSuperLikeDone];
                     
//                     [appDelegate SetData:@"no" value:kPaidAd];
//                     [appDelegate SetData:@"no" value:kPaidChat];
//                     [appDelegate SetData:@"no" value:kPaidLocation];
//                     [appDelegate SetData:@"no" value:kPaidSuperLike];

                     [appDelegate RemoveData:kinstaAuth];
                     [appDelegate SetData:@"no" value:kAddsRemoved];
                     [appDelegate SetData:@"no" value:kChatSubscription];
                     [appDelegate SetData:@"no" value:kLocationService];
                     NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                     for (NSHTTPCookie *each in cookieStorage.cookies) {
                         [cookieStorage deleteCookie:each];
                     }
                     
                     [FBSDKAccessToken setCurrentAccessToken:nil];
                     [FBSDKProfile setCurrentProfile:nil];
                     [appDelegate RemoveData:kXmppUserLogin];
                     [appDelegate RemoveData:kXmppUserRegister];
                     
                     [appDelegate RemoveData:kejID];
                     
                     //TODO: testing
                     [SSConnectionClasses shareInstance].totalUnReadMsgcount = 0;
                     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
 
                     WelcomeVC *VC = [[WelcomeVC alloc] initWithNibName:@"WelcomeVC" bundle:nil];
                     UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                     NSArray *controllers = [NSArray arrayWithObject:VC];
                     navigationController.viewControllers = controllers;
                     [navigationController setNavigationBarHidden:YES animated:NO];
                     [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

                 }
                 else
                 {
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
                 
             }];
         }
     }];
}
/*!
 * @discussion WebService call for notification count
 */
-(void) notificationCount
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
             NSString *str=@"getNotificationCount";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                   //notification count
                     int notification=[[dictionary valueForKey:@"count"] intValue] ;
                     if (notification==0)
                     {
                         [appDelegate SetData:[NSString stringWithFormat:@"%d",notification] value:kNotificationCount];
                         self.vwNotificationCounter.hidden=YES;
                     }
                     else
                     {
                         [SSConnectionClasses shareInstance].totalUnReadMsgcount=[SSConnectionClasses shareInstance].totalUnReadMsgcount+[[appDelegate GetData:kNotificationCount] intValue];

                         [appDelegate SetData:[NSString stringWithFormat:@"%d",notification] value:kNotificationCount];
                         self.vwNotificationCounter.hidden=NO;
                         self.lblNotificationCount.text=[NSString stringWithFormat:@"%d",notification];
                     }
                 }
             }];
         }
     }];
}

-(void) getUserDetails
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
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"userid"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 // HIDE_PROGRESS;
                 HIDE_PROGRESS;
                 if( success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     //send to friendstory page
                     [self HideShowSelection:[[appDelegate GetData:kSelecttion] intValue]];
                     FriendDetailsVC *VC = [[FriendDetailsVC alloc] initWithNibName:@"FriendDetailsVC" bundle:nil];
                     VC.dictDetails = [dictionary valueForKey:@"body"];
                     UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                     NSArray *controllers = [NSArray arrayWithObject:VC];
                     navigationController.viewControllers = controllers;
                     [self.navigationController setNavigationBarHidden:NO animated:NO];
                     
                     [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Please try again!!"], self);
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
    self.lblNotification.text=[MCLocalization stringForKey:@"Notifications"];    
    self.lblLogout.text=[MCLocalization stringForKey:@"Log Out"];
    self.lblRemoveAds.text=[MCLocalization stringForKey:@"Remove Ads"];
    self.lblSettings.text=[MCLocalization stringForKey:@"My Preferences"];
    self.lblChat.text=[MCLocalization stringForKey:@"Chat"];
    self.lblStartPlaying.text=[MCLocalization stringForKey:@"Start Playing"];
    self.lblMyProfile.text=[MCLocalization stringForKey:@"My Profile"];
    self.lblLocation.text=[MCLocalization stringForKey:@"Location"];    
}
/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.vwRight setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.imgProfile setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblStartPlaying setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblChat setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblNotification setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblMyProfile setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblSettings setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblRemoveAds setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblUserName setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblLogout setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblChatCounter setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblNotificationCount setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    self.lblStartPlaying.textAlignment = NSTextAlignmentRight;
    self.lblChat.textAlignment = NSTextAlignmentRight;
    self.lblNotification.textAlignment = NSTextAlignmentRight;
    self.lblSettings.textAlignment = NSTextAlignmentRight;
    self.lblRemoveAds.textAlignment = NSTextAlignmentRight;
    self.lblLogout.textAlignment = NSTextAlignmentLeft;
    self.lblMyProfile.textAlignment = NSTextAlignmentRight;
}
@end
