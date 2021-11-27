//
//  AppDelegate.m
//  CupidLove
//
//  Created by APPLE on 10/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeVC.h"
#import "RightMenuVC.h"
#import "FriendProfileVC.h"
#import "ImageUploadVC.h"
#import "DatePreferencesVC.h"
#import "DiscoveryPreferencesVC.h"
#import "NotificationVC.h"
#import <Photos/Photos.h>
#import "ItsAMatchVC.h"
#import "DetailsSignUpVC.h"
#import "ChatVC.h"
#import "DoChatVC.h"
#import "BlockedVC.h"
#import "AdminPushVC.h"
#import "IAPShare.h"

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface AppDelegate ()

@end

@implementation AppDelegate{

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //TODO: Remove this when done from admin
//    [[NSUserDefaults standardUserDefaults] setValue:@"com.montotech.FindFellow.PaidChat" forKey:kChatSubscriptionInAppPurchase];
//    [[NSUserDefaults standardUserDefaults] setValue:@"com.montotech.FindFellow.Location" forKey:kLocationInAppPurchase];
//    [[NSUserDefaults standardUserDefaults] setValue:@"com.montotech.FindFellow.SuperLike" forKey:kSuperLikeInAppPurchase];

    //TODO: change for production YES or for developement NO
    [IAPShare sharedHelper].iap.production = NO;

    self.LoaderImages = [[NSMutableArray alloc] init];
    NSString *strTemp=[[NSString alloc] init];
    for (int i = 0;i < 120; i++) {
        strTemp = [NSString stringWithFormat:@"cupid_00%03d.png",i];
        [self.LoaderImages addObject:[UIImage imageNamed:strTemp]];
    }
    
    // Using a file per one individual language:
    NSDictionary * languageURLPairs =
    @{
      @"english":[[NSBundle mainBundle] URLForResource:@"English.json" withExtension:nil],
      @"french":[[NSBundle mainBundle] URLForResource:@"French.json" withExtension:nil],
      @"russian":[[NSBundle mainBundle] URLForResource:@"Russian.json" withExtension:nil],
      @"arabic":[[NSBundle mainBundle] URLForResource:@"Arabic.json" withExtension:nil],
      @"hindi":[[NSBundle mainBundle] URLForResource:@"Hindi.json" withExtension:nil],
      };
    
    //select Default Language
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"] == YES)
    {
        [MCLocalization loadFromLanguageURLPairs:languageURLPairs defaultLanguage:[[NSUserDefaults standardUserDefaults] valueForKey:@"SelectedLanguage"]];
    }
    else
    {
        [MCLocalization loadFromLanguageURLPairs:languageURLPairs defaultLanguage:@"English"];
        [[NSUserDefaults standardUserDefaults] setObject:@"english" forKey:@"SelectedLanguage"];
    }
    
    [MCLocalization sharedInstance].noKeyPlaceholder = @"[No '{key}' in '{language}']";
    
    [[NSUserDefaults standardUserDefaults] synchronize];

#if TARGET_IPHONE_SIMULATOR
    NSLog(@"On Simulator");
#else
    [self registerForRemoteNotifications];
#endif
    
    if(![[appDelegate GetData:GOOGLE_API_KEY] isEqualToString:@"Key Not Found"]){
        
        [GMSPlacesClient provideAPIKey:[appDelegate GetData:GOOGLE_API_KEY]];
        [GADMobileAds configureWithApplicationID:[appDelegate GetData:GOOGLE_API_KEY]];
    }

//    [GMSPlacesClient provideAPIKey:GOOGLE_API_KEY];
//    //for admob
//    [GADMobileAds configureWithApplicationID:GOOGLE_API_KEY];

    self.strPageName=[[NSString alloc] init];
    
    self.cardsLoadedIndex=0;
    self.indexAllcards=0;
    self.arrChats=[[NSMutableArray alloc]init];

    application.statusBarHidden=NO;
   
    [NSThread sleepForTimeInterval:0.6];
    self.selectedImagesAssets=[[NSMutableArray alloc]init];
    self.selectedImages=[[NSMutableArray alloc]init];
    self.selectedFbImages=[[NSMutableArray alloc]init];
    self.selectedFbImagesIds=[[NSMutableArray alloc]init];
    self.editImage=@"";
    self.editImageName=@"";
    self.flag_next=@"back";
    
    self.allCards=[[NSMutableArray alloc] init];
    self.allUsersDetails=[[NSMutableArray alloc] init];
    self.loadedCards=[[NSMutableArray alloc] init];
    
    //TODO: Remove this line
   //[appDelegate SetData:@"UploadImages" value:@"Page"];
    
    if([[appDelegate GetData:@"Page"] isEqualToString:@"UploadImages"]) {
        [appDelegate SetData:@"hide" value:@"flagBack"];
        ImageUploadVC *newVc = [[ImageUploadVC alloc]initWithNibName:@"ImageUploadVC" bundle:nil];
        self.nav = [[UINavigationController alloc] initWithRootViewController:newVc] ;
        [self.nav setNavigationBarHidden:YES animated:NO];
        self.window.rootViewController=self.nav;
        [self.window makeKeyAndVisible];
    }
    else if ([[appDelegate GetData:@"Page"] isEqualToString:@"DetailsSignUp"]) {
        DetailsSignUpVC *newVc = [[DetailsSignUpVC alloc]initWithNibName:@"DetailsSignUpVC" bundle:nil];
        self.nav = [[UINavigationController alloc] initWithRootViewController:newVc] ;
        [self.nav setNavigationBarHidden:NO animated:NO];
        self.window.rootViewController = self.nav;
        [self.window makeKeyAndVisible];
    }
    else if ([[appDelegate GetData:@"Page"] isEqualToString:@"DatePref"]) {
        
        [appDelegate SetData:@"hide" value:@"flagBack"];
        
        DatePreferencesVC *newVc=[[DatePreferencesVC alloc]initWithNibName:@"DatePreferencesVC" bundle:nil];
        self.nav=[[UINavigationController alloc] initWithRootViewController:newVc] ;
        [self.nav setNavigationBarHidden:NO animated:YES];
        self.window.rootViewController=self.nav;
        [self.window makeKeyAndVisible];
    }
    else if ([[appDelegate GetData:@"Page"] isEqualToString:@"DiscPref"]) {
        [appDelegate SetData:@"hide" value:@"flagBack"];
        DiscoveryPreferencesVC *newVc=[[DiscoveryPreferencesVC alloc]initWithNibName:@"DiscoveryPreferencesVC" bundle:nil];
        self.nav=[[UINavigationController alloc] initWithRootViewController:newVc] ;
         [self.nav setNavigationBarHidden:NO animated:YES];
        self.window.rootViewController=self.nav;
        [self.window makeKeyAndVisible];
    }
    else{
        if([[appDelegate GetData:kauthToken] isEqualToString:@"Key Not Found"]) {
            WelcomeVC *newVc=[[WelcomeVC alloc]initWithNibName:@"WelcomeVC" bundle:nil];
            self.nav=[[UINavigationController alloc] initWithRootViewController:newVc] ;
            [self.nav setNavigationBarHidden:YES animated:YES];
            self.window.rootViewController=self.nav;
            [self.window makeKeyAndVisible];
        }
        else
        {
            [appDelegate ChangeViewController];
        }
    }
    
    //facebook Login
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

#pragma mark - Application Delegate
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url
                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    return handled;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    [[NotificationCounterUpdater sharedInstance] UpdateNotificationCounter];
    [[NotificationCounterUpdater sharedInstance] StopUpdating];
    [[SSConnectionClasses shareInstance] disconnect];
    
//    [UIApplication sharedApplication].applicationIconBadgeNumber = [SSConnectionClasses shareInstance].totalUnReadMsgcount;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self SetDict:[SSConnectionClasses shareInstance].userUnreadCountDict value:kUnreadDict];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
    if(![[appDelegate GetData:kuserid] isEqualToString:@"Key Not Found"])
    {
        [[ApiManager sharedInstance] RegisterLoginXMPP];
        [[NotificationCounterUpdater sharedInstance] StartUpdating];
        //TODO:Testing
        [[NotificationCounterUpdater sharedInstance] UpdateNotificationCounter];

    }
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     [self SetDict:[SSConnectionClasses shareInstance].userUnreadCountDict value:kUnreadDict];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSMutableString *sbuf = [NSMutableString stringWithCapacity:100];
    const unsigned char *buf = deviceToken.bytes;
    NSInteger i;
    for (i=0; i<deviceToken.length; ++i) {
        [sbuf appendFormat:@"%02lX", (unsigned long)buf[i]];
    }
    [appDelegate SetData:sbuf value:kdeviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
    
}
/*!
 * @discussion Creates object of AppDelegate
 */
-(AppDelegate*) appobj
{
    return (AppDelegate*) [[UIApplication sharedApplication] delegate];
}
/*!
 * @discussion For change view controller
 */
-(void)ChangeViewController
{
    
    
    if(![[appDelegate GetData:kuserid] isEqualToString:@"Key Not Found"])
    {
        if ([[appDelegate GetData:kXMPPEnabled] isEqualToString:@"true"])
        {
            
            [[ApiManager sharedInstance] RegisterLoginXMPP];
        }
        [SSConnectionClasses shareInstance].userUnreadCountDict=[[self GetDict:kUnreadDict] mutableCopy];
        NSArray *arr= [SSConnectionClasses shareInstance].userUnreadCountDict.allKeys;
        [SSConnectionClasses shareInstance].totalUnReadMsgcount=0;
        for (int i=0;i<arr.count;i++)
        {
            [SSConnectionClasses shareInstance].totalUnReadMsgcount= [SSConnectionClasses shareInstance].totalUnReadMsgcount+[[[SSConnectionClasses shareInstance].userUnreadCountDict valueForKey:[arr objectAtIndex:i]] intValue];
        }
        
        if ([[appDelegate GetData:kNotificationCount] isEqualToString:@"Key Not Found"])
        {
            
        }
        else
        {
            [SSConnectionClasses shareInstance].totalUnReadMsgcount=[SSConnectionClasses shareInstance].totalUnReadMsgcount+[[appDelegate GetData:kNotificationCount] intValue];
        }
        
        [[NotificationCounterUpdater sharedInstance] StartUpdating];
    }
    
    
    NSString *strBlocked=[self GetData:kBlocked];
    if ([strBlocked isEqualToString:@"yes"])
    {
        [appDelegate SetData:[NSString stringWithFormat:@"1"] value:kSelecttion];
        RightMenuVC *Rightvc=[[RightMenuVC alloc]initWithNibName:@"RightMenuVC" bundle:nil];
        BlockedVC *vc=[[BlockedVC alloc]initWithNibName:@"BlockedVC" bundle:nil];
        self.nav=[[UINavigationController alloc]initWithRootViewController:vc];
        [self.nav setNavigationBarHidden:NO animated:NO];

        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                        containerWithCenterViewController:self.nav
                                                        leftMenuViewController:Rightvc
                                                        rightMenuViewController:nil];
        
        container.panMode=MFSideMenuPanModeNone;
        self.window.rootViewController=container;
        [self.window makeKeyAndVisible];
        
    }
    else
    {
        [[AdRemoveBlock sharedInstance] StartUpdating];
        
        [appDelegate SetData:[NSString stringWithFormat:@"1"] value:kSelecttion];
        RightMenuVC *Rightvc=[[RightMenuVC alloc]initWithNibName:@"RightMenuVC" bundle:nil];
        FriendProfileVC *vc=[[FriendProfileVC alloc]initWithNibName:@"FriendProfileVC" bundle:nil];
        self.nav=[[UINavigationController alloc]initWithRootViewController:vc];
        [self.nav setNavigationBarHidden:NO animated:NO];

        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController                                                                                  containerWithCenterViewController:self.nav leftMenuViewController:Rightvc rightMenuViewController:nil];
        
        container.panMode=MFSideMenuPanModeNone;
        
        
        self.window.rootViewController=container;
        [self.window makeKeyAndVisible];
        
    }
    
    
    
}
/*!
 * @discussion Set data to NSUserDeaults
 * @param strValue Dictionary Value for given key
 * @param strKey Key-name for storing values
 */
-(void)SetDict:(NSDictionary *)strValue value:(NSString *)strKey
{
    [[NSUserDefaults standardUserDefaults] setObject:strValue forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/*!
 * @discussion Set data to NSUserDeaults
 * @param strKey Key-name for storing values
 * @return value for given key
 */
-(NSDictionary *)GetDict:(NSString *)strKey
{
    if ([[NSUserDefaults standardUserDefaults]
         objectForKey:strKey]!=nil)
    {
        NSDictionary *savedValue = [[NSUserDefaults standardUserDefaults]
                                objectForKey:strKey];
        return  savedValue;
        
    }
    else
    {
        return  [[NSDictionary alloc] init] ;
    }
}
/*!
 * @discussion Set data to NSUserDeaults
 * @param strValue Dictionary Value for given key
 * @param strKey Key-name for storing values
 */
-(void)SetData:(NSString *)strValue value:(NSString *)strKey
{
    [[NSUserDefaults standardUserDefaults] setObject:strValue forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/*!
 * @discussion Get data from NSUserDeaults
 * @param strKey Key-name for getting values
 * @return value for given key
 */
-(NSString *)GetData:(NSString *)strKey
{
    if ([[NSUserDefaults standardUserDefaults]
         stringForKey:strKey]!=nil)
    {
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                 stringForKey:strKey];
        return  savedValue;
        
    }
    else
    {
        return  @"Key Not Found";
    }
    
    
}
/*!
 * @discussion Remove key-value pair from NSUserDeaults
 * @param strKey Key-name for removing values
 */
-(void)RemoveData:(NSString *)strKey
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/*!
 * @discussion Register device for remote notification
 */
- (void)registerForRemoteNotifications {
    
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
       
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center setDelegate:self];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                dispatch_async(dispatch_get_main_queue(), ^{
                      [[UIApplication sharedApplication] registerForRemoteNotifications];
                });

            }
        }];
    }
    else {
        // Code for old versions

        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        

        
    }
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    //notification present
    
    if ([notification.request.identifier isEqualToString:@"LocalNotification"])
    {
        
    }
    else
    {
       
       // [UIApplication sharedApplication].applicationIconBadgeNumber =[[[notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"badge"] intValue];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        NSDictionary *dict= [notification.request.content.userInfo valueForKey:@"data"];
        if([[dict valueForKey:@"type"] intValue]==4)
        {
            AdminPushVC *vc=[[AdminPushVC alloc]initWithNibName:@"AdminPushVC" bundle:nil];
            vc.strMessage=[dict valueForKey:@"message"];
            vc.view.frame=self.window.rootViewController.view.frame;
            vc.view.tag=11111;
            [vc.btnOk addTarget:self
                         action:@selector(HidePopUp)
               forControlEvents:UIControlEventTouchUpInside];
            [self.window.rootViewController.view addSubview:vc.view];
            return ;
        }
       
        
    }
    
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//TODO:- Check this for badge -
//-(void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo {
//
//    UIApplicationState state = [application applicationState];
//    if (state == UIApplicationStateActive) {
//        // do stuff when app is active
//
//    }else{
//        // do stuff when app is in background
//        [UIApplication sharedApplication].applicationIconBadgeNumber =
//        [UIApplication sharedApplication].applicationIconBadgeNumber+1;
//        /* to increment icon badge number */
//    }
//}

/*!
 * @discussion Called to let your app know which action was selected by the user for a given notification.
 * @param center Notfication center
 * @param response Notification response
 */


-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    if ([response.notification.request.identifier isEqualToString:@"LocalNotification"])
    {
        //local notification
        NSDictionary *dict= response.notification.request.content.userInfo ;
        MFSideMenuContainerViewController *vc = (MFSideMenuContainerViewController *)[[UIApplication sharedApplication].keyWindow rootViewController];
        UINavigationController *navController =  (UINavigationController *)vc.centerViewController;
        UIViewController *rootViewController = navController.topViewController;
        if ([NSStringFromClass(rootViewController.class) isEqualToString:@"DoChatVC"] || [NSStringFromClass(rootViewController.class) isEqualToString:@"ChatVC"])
        {
            
            [appDelegate SetData:[NSString stringWithFormat:@"2"] value:kSelecttion];
            DoChatVC *dochatvc=[[DoChatVC alloc]initWithNibName:@"DoChatVC" bundle:nil];
            for (int i=0;i<self.arrChats.count;i++)
            {
//                NSString *strUserName=[NSString stringWithFormat:@"%@_%@%@",[[self.arrChats objectAtIndex:i] valueForKey:@"friendid"],[[[self.arrChats objectAtIndex:i] valueForKey:@"friend_FName"] lowercaseString],Userpostfix];
                NSString *strUserName=[NSString stringWithFormat:@"%@%@",[[[self.arrChats objectAtIndex:i] valueForKey:@"ejuser"] lowercaseString],Userpostfix];
                
                if ([[dict valueForKey:@"MessageFrom"] isEqualToString:strUserName])
                {
                    NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[self.arrChats objectAtIndex:i] valueForKey:@"profile_image"]];
                    if([temp isEqualToString:imageUrl]){
                        temp=[NSString stringWithFormat:@"%@uploadg/default.png",imageUrl];
                    }
                    dochatvc.strFriendId=[[self.arrChats objectAtIndex:i] valueForKey:@"friendid"];
                    
                    //changed
                    dochatvc.strChatName=[NSString stringWithFormat:@"%@ %@",[[self.arrChats objectAtIndex:i] valueForKey:@"fname"],[[self.arrChats objectAtIndex:i] valueForKey:@"lname"]];
                    //prev code
//                    dochatvc.strChatName=[NSString stringWithFormat:@"%@ %@",[[self.arrChats objectAtIndex:i] valueForKey:@"friend_FName"],[[self.arrChats objectAtIndex:i] valueForKey:@"friend_LName"]];
                    dochatvc.strImgUrl=temp;
                    dochatvc.strJid=[dict valueForKey:@"MessageFrom"];
                    [appDelegate.nav pushViewController:dochatvc animated:YES];
                }
            }
            return;
        }
        else
        {
            [appDelegate SetData:[NSString stringWithFormat:@"2"] value:kSelecttion];

                RightMenuVC *Rightvc = [[RightMenuVC alloc]initWithNibName:@"RightMenuVC" bundle:nil];
                ChatVC *newVc = [[ChatVC alloc]initWithNibName:@"ChatVC" bundle:nil];
                newVc.strJid = [dict valueForKey:@"MessageFrom"];
                appDelegate.nav = [[UINavigationController alloc]initWithRootViewController:newVc];
           [appDelegate.nav setNavigationBarHidden:NO animated:NO];
            
            MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController                                                                                  containerWithCenterViewController:self.nav leftMenuViewController:Rightvc rightMenuViewController:nil];
            
                container.panMode=MFSideMenuPanModeNone;
                appDelegate.window.rootViewController=container;
                [appDelegate.window makeKeyAndVisible];
                
            return;
        }
        
    }
    else
    {
        //push notification        
        NSDictionary *dict= [response.notification.request.content.userInfo valueForKey:@"data"];
        
         if([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
         {
             if([appDelegate.strPageName isEqualToString:@"NotificationPage"]){
                
                 if([[dict valueForKey:@"type"] intValue]==1){
                    
                     [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh object:self];
                 }
                 else{
                     [self normamlNavigation:dict];
                 }
        
        
             }
             else if ([appDelegate.strPageName isEqualToString:@"ChatPage"]){
                 
                 if([[dict valueForKey:@"type"] intValue]==1){
                     
                     [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh object:self];
                 }
                 else{
                     [self normamlNavigation:dict];
                 }
        
             }
             else if ([appDelegate.strPageName isEqualToString:@"DoChatPage"]){
                 //do chat page
                 [self normamlNavigation:dict];
                 
             }
             else{
                 //for another page
                 [self normamlNavigation:dict];
             }
         }

         else{
             
             //app in background or inactive
             [self normamlNavigation:dict];
             
         }

    }
    
     completionHandler();
}
/*!
 * @discussion Normal navigation process when user click notification
 * @param dict Diction contianing information about notification
 */
-(void) normamlNavigation:(NSDictionary *)dict{
    //type==2-->like back , approve notification
    if([[dict valueForKey:@"type"] intValue]==2){
        
        NSString *strProfile_url= [dict valueForKey:@"friend_profileImg_url"];
        NSString *strFriend_fname=[dict valueForKey:@"friend_Fname"];
        NSString *strFriend_lname=[dict valueForKey:@"friend_Lname"];
        NSString *strFriend_id=[dict valueForKey:@"friendid"];
        NSString *str_jid = [dict valueForKey:@"friend_ejuser"];
        
        [appDelegate SetData:[NSString stringWithFormat:@"3"] value:kSelecttion];

        RightMenuVC *Rightvc=[[RightMenuVC alloc]initWithNibName:@"RightMenuVC" bundle:nil];
        ItsAMatchVC *newVc=[[ItsAMatchVC alloc]initWithNibName:@"ItsAMatchVC" bundle:nil];
        newVc.strImgUrl=[NSString stringWithFormat:@"%@%@",imageUrl,strProfile_url];;
        newVc.strFid=strFriend_id;
        newVc.strFname=strFriend_fname;
        newVc.strLname=strFriend_lname;
        newVc.strJid=[NSString stringWithFormat:@"%@%@",[str_jid lowercaseString],Userpostfix];
        self.nav=[[UINavigationController alloc]initWithRootViewController:newVc];
     
        [self.nav setNavigationBarHidden:NO animated:NO];
        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController                                                                                  containerWithCenterViewController:self.nav leftMenuViewController:Rightvc rightMenuViewController:nil];
        
        container.panMode=MFSideMenuPanModeNone;
        
        
        self.window.rootViewController=container;
        [self.window makeKeyAndVisible];
        
    }
    //type-1 --first like
    else if([[dict valueForKey:@"type"] intValue]==1){
        
        [appDelegate SetData:[NSString stringWithFormat:@"3"] value:kSelecttion];

        RightMenuVC *Rightvc=[[RightMenuVC alloc]initWithNibName:@"RightMenuVC" bundle:nil];
        NotificationVC *newVc=[[NotificationVC alloc]initWithNibName:@"NotificationVC" bundle:nil];
        
        self.nav=[[UINavigationController alloc]initWithRootViewController:newVc];
        [self.nav setNavigationBarHidden:NO animated:NO];
        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController                                                                                  containerWithCenterViewController:self.nav leftMenuViewController:Rightvc rightMenuViewController:nil];
        
        container.panMode=MFSideMenuPanModeNone;
        
        
        self.window.rootViewController=container;
        [self.window makeKeyAndVisible];
        
    }
    //type=3 message notification
    else if([[dict valueForKey:@"type"]  intValue]==3)
    {
        
        NSString *strProfile_url= [dict valueForKey:@"friend_profileImg_url"];
        NSString *strFriend_fname=[dict valueForKey:@"friend_Fname"];
        NSString *strFriend_lname=[dict valueForKey:@"friend_Lname"];
        NSString *strFriend_id=[dict valueForKey:@"friendid"];
        NSString *str_jid = [dict valueForKey:@"friend_ejuser"];
        
        [appDelegate SetData:[NSString stringWithFormat:@"2"] value:kSelecttion];
        RightMenuVC *Rightvc=[[RightMenuVC alloc]initWithNibName:@"RightMenuVC" bundle:nil];
        DoChatVC *newVc=[[DoChatVC alloc]initWithNibName:@"DoChatVC" bundle:nil];
        newVc.strImgUrl=[NSString stringWithFormat:@"%@%@",imageUrl,strProfile_url];
//        newVc.strJid=[NSString stringWithFormat:@"%@_%@%@", strFriend_id,[strFriend_fname lowercaseString],Userpostfix];
        newVc.strJid=[NSString stringWithFormat:@"%@%@",[str_jid lowercaseString],Userpostfix];
       //  newVc.strJid=str_jid;
        newVc.strChatName=[NSString stringWithFormat:@"%@ %@", strFriend_fname,strFriend_lname];
        newVc.strFriendId=strFriend_id;
        newVc.strComeFrom=@"Notification";
        self.nav=[[UINavigationController alloc]initWithRootViewController:newVc];
    
        [self.nav setNavigationBarHidden:NO animated:NO];

        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController                                                                                  containerWithCenterViewController:self.nav leftMenuViewController:Rightvc rightMenuViewController:nil];
        
        container.panMode=MFSideMenuPanModeNone;
        self.window.rootViewController=container;
        [self.window makeKeyAndVisible];
        
    }
    else if([[dict valueForKey:@"type"]  intValue]==4){
        //type 4:message from admin
        if([[dict valueForKey:@"type"] intValue]==4)
        {
            AdminPushVC *vc=[[AdminPushVC alloc]initWithNibName:@"AdminPushVC" bundle:nil];
            vc.strMessage=[dict valueForKey:@"message"];
            vc.view.tag=11111;
            vc.view.frame=self.window.rootViewController.view.frame;
            [vc.btnOk addTarget:self
                       action:@selector(HidePopUp)
             forControlEvents:UIControlEventTouchUpInside];
            [self.window.rootViewController.view addSubview:vc.view];
            return ;
        }
        
    }
    
    else{
        NSLog(@"unknown type");
    }

}


/*!
 * @discussion Hides pop-up
 */
-(void)HidePopUp
{
    for (UIView *subview in self.window.rootViewController.view.subviews)
    {
        if (subview.tag==11111)
        {
            [subview removeFromSuperview];
        }
    }

}


@end
