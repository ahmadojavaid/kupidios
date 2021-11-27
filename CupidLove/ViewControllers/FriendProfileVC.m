	//
//  FriendProfileVC.m
//  CupidLove
//
//  Created by Umesh on 11/11/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import "FriendProfileVC.h"
#import "MutualFriendsCell.h"
#import "LocationHelper.h"
#import "LNBRippleEffect.h"
#import "FriendDetailsVC.h"
#import "IAPShare.h"
#import "InAppPurchaseVC.h"

@import GoogleMobileAds;    

@interface FriendProfileVC ()

@property (weak,nonatomic) IBOutlet UIView *vwTitle;

@property (weak,nonatomic) IBOutlet UIView *vwButtons;
@property (weak,nonatomic) IBOutlet UIView *mutualFriendsPopup;
@property (weak,nonatomic) IBOutlet UIView *mutualFriendsBG;

@property (strong,atomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (weak,nonatomic) IBOutlet UIView *cards;
@property (weak,nonatomic) IBOutlet UILabel *lblNoMoreFriends;

@property (strong, nonatomic) IBOutlet UILabel *lblMutualFriends;
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;

@property (weak, nonatomic) IBOutlet UIView *vwMenu;

@property(weak,nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *lblMutualUnderline;

@property (weak,nonatomic) IBOutlet UIButton *btnlike;
@property (weak,nonatomic) IBOutlet UIButton *btndislike;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIView *vwDummyCard;
@end

@implementation FriendProfileVC{
    
    
    LNBRippleEffect *rippleEffect;
    Boolean flag,flgTwoCalls;
    ProfileView *tempDelegate;
    NSTimer *timer;
    
//    NSString *mylatitude;
//    NSString *mylongitude;
    
    NSInteger mutualFriendCount;
    NSArray *mutualFriendsFName;
    NSArray *mutualFriendsLName;
    NSArray *mutualFriendsProPic;
    
    int adCounter;
}


@synthesize allCards;// all the cards


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *str = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    
    
    self.lblMutualUnderline.backgroundColor = Theme_Color;
    
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    
    
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    
    
    if ([[appDelegate GetData:kAddsRemoved] isEqualToString:@"yes"]) {
    }
    else
    {
        GADRequest *request = [GADRequest request];
        //        self.interstitial=[[GADInterstitial alloc] initWithAdUnitID:KadMobVideoKey];
        self.interstitial=[[GADInterstitial alloc] initWithAdUnitID:[appDelegate GetData:KadMobVideoKey]];
        [self.interstitial loadRequest:request];
    }
    
    self.vwButtons.frame = CGRectMake(0,SCREEN_SIZE.height,SCREEN_SIZE.width,self.vwButtons.frame.size.height);
    
    [self localize];
    
    adCounter=0;
    
//    mylatitude=[[NSString alloc] init];
//    mylongitude=[[NSString alloc] init];
    
    [self ShowRippleEffect];
//    [LocationHelper sharedInstance].delegate=self;
//    [[LocationHelper sharedInstance] updateLocation];
    
    
    
    mutualFriendCount=0;
    mutualFriendsFName=[[NSArray alloc] init];
    mutualFriendsLName=[[NSArray alloc] init];
    mutualFriendsProPic=[[NSArray alloc] init];
    
    flag=YES;
    // Do any additional setup after loading the view.
    tempDelegate=[[ProfileView alloc] init];
    tempDelegate.delegate=self;
    
    [self.cards.layer setCornerRadius:5.0f];
    
    // drop shadow
    [self.cards.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.cards.layer setShadowOpacity:0.3];
    [self.cards.layer setShadowRadius:3.0];
    [self.cards.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    
    [self.mutualFriendsPopup addGestureRecognizer:singleTapGestureRecognizer];
    
    UINib *cellNib = [UINib nibWithNibName:@"MutualFriendsCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(80, 80)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    [appDelegate.loadedCards removeAllObjects];
    [appDelegate.allCards removeAllObjects];
    appDelegate.indexAllcards=0;
    appDelegate.cardsLoadedIndex=0;
    
    
    self.imgLogo.hidden=YES;
    [self.imgLogo sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kprofileimage]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
     {
         self.imgLogo.hidden=NO;
         if(image!=nil){
             self.imgLogo.image = image;
         }
         else{
             self.imgLogo.image = [UIImage imageNamed:@"TempProfile"];
         }
     }];
    
    if(![appDelegate.isAppConfigurationSaved isEqualToString:@"Saved"]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getAllConfiguration];
        });
        
    } else {
        if(![IAPShare sharedHelper].iap) {
            
            NSSet* dataSet = [[NSSet alloc] initWithObjects:[appDelegate GetData:kRemoveAddInAppPurchase], [appDelegate GetData:kChatSubscriptionInAppPurchase], [appDelegate GetData:kLocationInAppPurchase], [appDelegate GetData:kSuperLikeInAppPurchase], nil];
            
            [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
        }

        if(flag)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self GetAllUserData1:0];
                });
            });
            flag = NO;
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.width = SCREEN_SIZE.width;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    
    self.mutualFriendsPopup.frame=CGRectMake(0,-self.mutualFriendsPopup.frame.size.height,self.mutualFriendsPopup.frame.size.width , self.mutualFriendsPopup.frame.size.height);
    self.imgLogo.frame =CGRectMake(self.imgLogo.frame.origin.x,self.imgLogo.frame.origin.y ,self.imgLogo.frame.size.width, self.imgLogo.frame.size.width);
    rippleEffect.frame=self.imgLogo.frame;
    self.imgLogo.layer.cornerRadius = self.imgLogo.frame.size.width / 2;
    self.imgLogo.layer.borderWidth=2.0;
    self.imgLogo.layer.borderColor=[UIColor whiteColor].CGColor;
    self.imgLogo.layer.masksToBounds = YES;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.vwTitle.hidden = NO;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;
}
#pragma mark - Ripple Effect
-(void)ShowRippleEffect
{
    self.imgLogo.hidden=NO;
    self.imgLogo.frame = CGRectMake(self.imgLogo.frame.origin.x,self.imgLogo.frame.origin.y ,self.imgLogo.frame.size.width, self.imgLogo.frame.size.width);
    
    rippleEffect = [[LNBRippleEffect alloc]initWithImage:[UIImage imageNamed:@""] Frame:self.imgLogo.frame Color:[UIColor clearColor]  Target:@selector(btnAnimationClicked:) ID:self];
    rippleEffect.tag=12345;
    [rippleEffect setRippleColor:[UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:1]];
    [rippleEffect setRippleTrailColor:[UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:0.65]];
    [self.view addSubview:rippleEffect];
    
    rippleEffect.frame=self.imgLogo.frame;
    timer= [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(HideRippleEffect) userInfo:nil repeats:YES];
    
}
-(void)HideRippleEffect
{
    self.imgLogo.hidden=YES;
    [timer invalidate];
    [rippleEffect removeFromSuperview];
    
    if (appDelegate.allUsersDetails.count>0) {
        [UIView animateWithDuration:1.0 animations:^{
            
            BOOL flag = NO;
            if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
                
                switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                        
                    case 1136:
                        printf("iPhone 5 or 5S or 5C");
                        break;
                    case 1334:
                        printf("iPhone 6/6S/7/8");
                        break;
                    case 1920:
                        printf("iPhone 6+/6S+/7+/8+");
                        break;
                    case 2208:
                        printf("iPhone 6+/6S+/7+/8+");
                        break;
                    case 2436:
                        flag = YES;
                        printf("iPhone X");
                        break;
                    default:
                        printf("unknown");
                }
            }
            
            if (flag) {
                //iphone x
                self.vwButtons.frame = CGRectMake(0, SCREEN_SIZE.height - 64 - 30 - self.vwButtons.frame.size.height, SCREEN_SIZE.width, self.vwButtons.frame.size.height);
            } else {
                self.vwButtons.frame = CGRectMake(0, SCREEN_SIZE.height - 64 - self.vwButtons.frame.size.height, SCREEN_SIZE.width, self.vwButtons.frame.size.height);
            }
        }];
        
    }
    
    
    
    
}
-(IBAction)btnAnimationClicked:(id)sender
{
    
}

//#pragma mark - Location Delegate
///*!
// * @discussion Set Latitude and Longitude from delegate & Check users previous Latitude-Longitude is same or not. If not, Then Update User's Latitude- Longitude
// */
//- (void) LocationUpdated {
//
//    mylatitude= [NSString stringWithFormat:@"%.03f",[[LocationHelper sharedInstance].latitude floatValue]] ;
//    mylongitude= [NSString stringWithFormat:@"%.03f",[[LocationHelper sharedInstance].longitude floatValue]];
//
//    NSString *prevLat=[NSString stringWithFormat:@"%.03f",[[appDelegate GetData:klatitude] floatValue]];
//    NSString *prevLong=[NSString stringWithFormat:@"%.03f",[[appDelegate GetData:klongitude] floatValue]];
//
//
//    if(!([prevLat isEqualToString:mylatitude] && [prevLong isEqualToString:mylongitude])) {
//        //update user location
////        [appDelegate SetData:mylatitude value:klatitude];
////        [appDelegate SetData:mylongitude value:klongitude];
//        [self updateUserLocation];
//    }
//    else
//    {
//        if(flag)
//        {
//            [self GetAllUserData1:0];
//            flag = NO;
//        }
//    }
//    HIDE_PROGRESS;
//}

#pragma mark- ButtonsClick
/*!
 * @discussion Open Menu
 * @param sender For indentify sender
 */
- (IBAction)btnMenuClicked:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}
/*!
 * @discussion When User Dislike another User
 * @param sender For indentify sender
 */
- (IBAction)btnDislikeClicked:(id)sender {
    if(![[appDelegate GetData:kNewUser] isEqualToString:@"NO"]) {
        return;
    }
    
    if([appDelegate.loadedCards count]>0)
    {
        ProfileView *card = [appDelegate.loadedCards firstObject];
        [self swipeLeft];
        [self dislikeFriend:card.friendID];
    }
    else
    {
        ALERTVIEW([MCLocalization stringForKey:@"No Friend to Dislike!!"], self);
    }
}
/*!
 * @discussion When User Like another User
 * @param sender For indentify sender
 */
- (IBAction)btnLikeClicked:(id)sender {
    if(![[appDelegate GetData:kNewUser] isEqualToString:@"NO"]) {
        return;
    }
    if([appDelegate.loadedCards count] > 0) {
        
        ProfileView *card = [appDelegate.loadedCards firstObject];
        [self swipeRight];
        [self likeFriend:card.friendID];
    }
    else{
        ALERTVIEW([MCLocalization stringForKey:@"No Friend to Like!!"], self);
    }
}
/*!
 * @discussion When User Super Like another User
 * @param sender For indentify sender
 */
- (IBAction)btnSuperLikeClicked:(id)sender {
    if(![[appDelegate GetData:kNewUser] isEqualToString:@"NO"]) {
        return;
    }
//    if ([[appDelegate GetData:kOneSuperLikeDone] isEqualToString:@"yes"]) {
//        //TODO:- Superlike popup for inapppurchase
//        [self inAppPurchase];
//        return;
//    }

    if([appDelegate.loadedCards count] > 0) {
        
        ProfileView *card = [appDelegate.loadedCards firstObject];
        [self swipeUp];
        
        [self superLikeFriend:card.friendID];
    }
    else
    {
        ALERTVIEW([MCLocalization stringForKey:@"No Friend to Like!!"], self);
    }
}
/*!
 * @discussion When you hit the right button, this is called and substitutes the swipe
 */
-(void)swipeRight
{
    if([appDelegate.loadedCards count]>0){
        ProfileView *dragView = [appDelegate.loadedCards firstObject];
        dragView.overlayView.mode = GGOverlayViewModeRight;
        [UIView animateWithDuration:0.2 animations:^{
            dragView.overlayView.alpha = 1;
            
            [appDelegate.loadedCards removeObjectAtIndex:0];
            [self showhideButtons];
            [dragView rightClickAction];
            appDelegate.cardsLoadedIndex--;
            //enable swipe here
            
            ProfileView *dragView = [appDelegate.loadedCards firstObject];
            [dragView addGestureRecognizer:dragView.panGestureRecognizer];
            [dragView addGestureRecognizer:dragView.singleTapGestureRecognizer];
            
            [self CheckForAd];
        }];
    }
}
/*
 * @discussion When you hit the left button, this is called and substitutes the swipe
 */
-(void)swipeLeft
{
    if([appDelegate.loadedCards count]>0){
        ProfileView *dragView = [appDelegate.loadedCards firstObject];
        dragView.overlayView.mode = GGOverlayViewModeLeft;
        [UIView animateWithDuration:0.2 animations:^{
            dragView.overlayView.alpha = 1;
            [appDelegate.loadedCards removeObjectAtIndex:0];
            [self showhideButtons];
            [dragView leftClickAction];
            
            appDelegate.cardsLoadedIndex--;
            //enable swipe here
            
            ProfileView *dragView = [appDelegate.loadedCards firstObject];
            [dragView addGestureRecognizer:dragView.panGestureRecognizer];
            [dragView addGestureRecognizer:dragView.singleTapGestureRecognizer];
            
            [self CheckForAd];
            
        }];
    }
    
}
/*!
 * @discussion When you hit the right button, this is called and substitutes the swipe
 */
-(void)swipeUp
{
    if([appDelegate.loadedCards count]>0){
        ProfileView *dragView = [appDelegate.loadedCards firstObject];
        dragView.overlayView.mode = GGOverlayViewModeTop;
        [UIView animateWithDuration:0.2 animations:^{
            dragView.overlayView.alpha = 1;
//            [appDelegate.loadedCards removeObjectAtIndex:0];
            [self showhideButtons];
            [dragView superLikeClickAction];
//            appDelegate.cardsLoadedIndex--;
            //enable swipe here
            
//            ProfileView *dragView = [appDelegate.loadedCards firstObject];
//            [dragView addGestureRecognizer:dragView.panGestureRecognizer];
//            [dragView addGestureRecognizer:dragView.singleTapGestureRecognizer];
            
            
            [self CheckForAd];
            
        }];
    }
}

#pragma mark- Mutual Friends Collection View Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return 10;
    return mutualFriendsFName.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    MutualFriendsCell *cell = (MutualFriendsCell *) [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.imgProfile.layer.cornerRadius=(cell.imgProfile.frame.size.height/2);
    cell.imgProfile.layer.masksToBounds = YES;
    
    cell.lblName.text=[NSString stringWithFormat:@"%@ %@", [mutualFriendsFName objectAtIndex:indexPath.row], [mutualFriendsLName objectAtIndex:indexPath.row] ];
    
    NSString *temp=[[NSString alloc] init];
    if([[mutualFriendsProPic objectAtIndex:indexPath.row] isEqualToString:@""]) {
        temp=[NSString stringWithFormat:@"%@uploads/default.png",imageUrl];
    }else{
        temp=[NSString stringWithFormat:@"%@%@",imageUrl,[mutualFriendsProPic objectAtIndex:indexPath.row]];
    }
    
    [cell.imgProfile sd_setImageWithURL:[Util EncodedURL:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if(image!=nil){
            cell.imgProfile.image=image;
        }
        else{
            cell.imgProfile.image = [UIImage imageNamed:@"TempProfile"];
        }
    }];
    
    return cell;
}
#pragma - Mutual friend Popup

-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [UIView animateWithDuration:0.7 animations:^{
        
        self.mutualFriendsPopup.frame=CGRectMake(0,-(self.mutualFriendsPopup.frame.size.height),[UIScreen mainScreen].bounds.size.width,self.mutualFriendsPopup.frame.size.height);
    } completion:^(BOOL finished) {
        self.mutualFriendsBG.hidden = YES;
        
    }];
}
/*!
 * @discussion When user clicked No of mutual friend, All Mutual friends are displayed
 */
- (void)btnMutualFriendsClicked1 {
    
    [tempDelegate btnMutualFriendsClicked];
}
#pragma mark- delegate method
/*!
 * @discussion Show Pop-up with mutual Friends
 */
- (void) showPopup {
    [self GetMutualFriends];
    [UIView animateWithDuration:0.7 animations:^{
        self.mutualFriendsPopup.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.height-self.mutualFriendsPopup.frame.size.height,[UIScreen mainScreen].bounds.size.width,self.mutualFriendsPopup.frame.size.height);
        
    } completion:^(BOOL finished) {
        self.mutualFriendsBG.hidden = NO;
    }];
}
/*!
 * @discussion Show Friends profile Details
 */
-(void) showfriendDetail{
    SHOW_LOADER_ANIMTION();
    ProfileView *card = [appDelegate.loadedCards firstObject];
    FriendDetailsVC *vc=[[FriendDetailsVC alloc] initWithNibName:@"FriendDetailsVC" bundle:nil];
    vc.dictDetails=card.dictFriendDetail;
    vc.strFriendID = card.friendID ;
    [self.navigationController pushViewController:vc animated:YES];
}

/*!
 * @discussion LazyLoad call
 */
- (void) CallGetFriends
{
    [self GetAllUserData1:appDelegate.indexlazyload];
}

/*!
 * @discussion hide buttons
 */
- (void) showhideButtons
{
    NSLog(@"%lu", (unsigned long)appDelegate.allUsersDetails.count);
    if (appDelegate.allUsersDetails.count == 0) {
        self.vwButtons.hidden = true;
    } else {
        self.vwButtons.hidden = false;
    }
    
    //[self GetAllUserData1:appDelegate.indexlazyload];
}

/*!
 * @discussion Check If advertise should display or not
 */
- (void) CheckForAd
{
    if ([[appDelegate GetData:kAddsRemoved] isEqualToString:@"yes"]) {
    }
    else
    {
        adCounter++;
        if(adCounter==3){
            
            if(self.interstitial.isReady){
                [self.interstitial presentFromRootViewController:self];
                
                //                self.interstitial=[[GADInterstitial alloc] initWithAdUnitID:KadMobVideoKey];
                self.interstitial=[[GADInterstitial alloc] initWithAdUnitID:[appDelegate GetData:KadMobVideoKey]];
                GADRequest *request = [GADRequest request];
                [self.interstitial loadRequest:request];
            }
            adCounter=0;
            
        }
    }
}

#pragma mark - In app purchase view

- (void) inAppPurchase {
    if (![[appDelegate GetData:kPaidSuperLike] isEqualToString:@"yes"]  || [[appDelegate GetData:kSuperLikeInAppPurchase] isEqualToString:@""] || [[appDelegate GetData:kSuperLike] isEqualToString:@"yes"]) {
        return;
    }
    [appDelegate SetData:@"yes" value:kSuperLike];

    InAppPurchaseVC *vc = [[InAppPurchaseVC alloc] initWithNibName:@"InAppPurchaseVC" bundle:nil];
    self.definesPresentationContext = YES; //self is presenting view controller
    vc.view.backgroundColor = [UIColor clearColor];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.fromPage = 4;//for superlike
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Api Calls
/*!
 * @discussion Webservice call for getting users
 */
-(void)GetAllUserData1: (NSInteger) index
{
    NSInteger temp = 1;
    NSInteger calling_idex = 0;
    
    if(index == 0)
    {
        [appDelegate.allUsersDetails removeAllObjects];
        appDelegate.indexlazyload = 0;
        temp = 0;
        calling_idex = 1;
        bool flg = YES;
        for(UIView *v in [self.view subviews])
        {
            if (v.tag == 12345)
            {
                flg=NO;
            }
        }
        if (flg) {
            [self ShowRippleEffect];
        }
    }
    else
    {
        calling_idex=2;
    }
    
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else
         {
    
             if (!flgTwoCalls)
             {
                 flgTwoCalls = YES;
                 NSString *str = @"userfilter";
                 NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
                 [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
                 [dict setValue:[appDelegate GetData:klatitude] forKey:@"location_lat"];
                 [dict setValue:[appDelegate GetData:klongitude] forKey:@"location_long"];
                 [dict setValue:[NSString stringWithFormat:@"%ld",calling_idex] forKey:@"start"];
                 NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
                 
                 [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                     HIDE_PROGRESS;
                     if(success && [[dictionary valueForKey:@"error"] intValue] ==0 )
                     {
                         NSArray *arrtemp=[dictionary valueForKey:@"body"];
                         
                         for(int i=0;i<arrtemp.count;i++)
                         {
                             [appDelegate.allUsersDetails addObject:[arrtemp objectAtIndex:i]];
                         }
                         
                         //                         [appDelegate SetData:@"YES" value:kNewUser];
                         
                         NSLog(@"Newuser value:- %@",[appDelegate GetData:kNewUser]);
                         if(![[appDelegate GetData:kNewUser] isEqualToString:@"NO"]){
                             
                             [self createDummycard];
                         }
                         
                         [self loadCards:self.cards :temp :self.mutualFriendsPopup :self.mutualFriendsBG];
                         ProfileView *dragView = [appDelegate.loadedCards firstObject];
                         [dragView addGestureRecognizer:dragView.panGestureRecognizer];
                         [dragView addGestureRecognizer:dragView.singleTapGestureRecognizer];
                         
                         
                         
                         self.lblNoMoreFriends.hidden=NO;
                     }
                     else
                     {
                         
                         self.lblNoMoreFriends.hidden=NO;
                     }
                     
                     if (appDelegate.loadedCards.count == 0) {
                         self.vwButtons.hidden = true;
                     } else {
                         self.vwButtons.hidden = false;
                     }
                     
                     flgTwoCalls=NO;
                     [self HideRippleEffect];
                 }];
             }
         }
     }];
}
/*!
 * @discussion Webservice call for getting Mutual Friends
 */
-(void)GetMutualFriends
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
             
             NSString *str=@"mutualFriends";
             
             NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             ProfileView *temp=[appDelegate.loadedCards firstObject];
             [dict setValue:temp.friendID forKey:@"receive_user_id"];
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 HIDE_PROGRESS;
                 
                 if(success &&     [[dictionary valueForKey:@"error"] integerValue]==0 ){
                     
                     mutualFriendsFName=[[dictionary valueForKey:@"mutualFriendList"] valueForKey:@"fname"];
                     mutualFriendsLName=[[dictionary valueForKey:@"mutualFriendList"] valueForKey:@"lname"];
                     mutualFriendsProPic=[[dictionary valueForKey:@"mutualFriendList"] valueForKey:@"profile_image"];
                     [self.collectionView reloadData];
                 }
             }];
         }
     }];
}
/*!
 * @discussion Webservice call for Like Friend
 */
-(void)superLikeFriend:(NSString *)friendId
{
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"sendnotification";
             
             NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:friendId forKey:@"receive_user_id"];
             [dict setValue:@"1" forKey:@"status"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0 ) {
                     
                     [appDelegate SetData:@"yes" value:kOneSuperLikeDone];
                     ProfileView *dragView = [appDelegate.loadedCards firstObject];
                     [dragView removeCard];
                     [appDelegate.loadedCards removeObjectAtIndex:0];
                     [self showhideButtons];
                     appDelegate.cardsLoadedIndex--;
                     //enable swipe here
                     
                     dragView = [appDelegate.loadedCards firstObject];
                     [dragView addGestureRecognizer:dragView.panGestureRecognizer];
                     [dragView addGestureRecognizer:dragView.singleTapGestureRecognizer];
                     
                     [self CheckForAd];

                     if(appDelegate.cardsLoadedIndex<2) {
                         [self GetAllUserData1:appDelegate.indexlazyload];
                     }
                 } else if([[dictionary valueForKey:@"error_code"] intValue] == 502) {
                     [appDelegate SetData:@"yes" value:kOneSuperLikeDone];
                     
                     ProfileView *dragView = [appDelegate.loadedCards firstObject];

                     //TODO: Reload Page
                     [dragView getCardback];
                     [self inAppPurchase];
                 } else {
                     ProfileView *dragView = [appDelegate.loadedCards firstObject];
                     [dragView getCardbackForError];
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
             }];
         }
     }];
}

-(void)reloadPreviousPage {
    NSInteger count = appDelegate.allUsersDetails.count - appDelegate.loadedCards.count;
    
}
/*!
 * @discussion Webservice call for Like Friend
 */
-(void)likeFriend:(NSString *)friendId
{
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         
         if (responseObject == false)
         {
             
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"user_like";
             
             NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:friendId forKey:@"receive_user_id"];
             [dict setValue:@"1" forKey:@"status"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0 ){
                     
                     if(appDelegate.cardsLoadedIndex<2){
                         [self GetAllUserData1:appDelegate.indexlazyload];
                     }
                 }
                 
             }];
         }
     }];
}
/*!
 * @discussion Webservice call for Dislike Friend
 */
-(void)dislikeFriend:(NSString *)friendId
{
    
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         if (responseObject == false)
         {
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else
         {
             NSString *str=@"user_like";
             
             NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:friendId forKey:@"receive_user_id"];
             
             [dict setValue:@"0" forKey:@"status"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     if(appDelegate.cardsLoadedIndex<2){
                         
                         [self GetAllUserData1:appDelegate.indexlazyload];
                     }
                 }
             }];
         }
     }];
}
/*!
 * @discussion Webservice call for Updating user's Location
 */
-(void)updateUserLocation
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
                 [dict setValue:[appDelegate GetData:klatitude] forKey:@"location_lat"];
                 [dict setValue:[appDelegate GetData:klongitude] forKey:@"location_long"];
                 
                 NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
                 [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                     
                     
                     if(success && [[dictionary valueForKey:@"error"] intValue]==0 ){
                         
                         [appDelegate SetData:[dictionary valueForKey:@"latitude"] value:klatitude];
                         [appDelegate SetData:[dictionary valueForKey:@"longitude"]  value:klongitude];
                         
                         if(flag){
                             [self GetAllUserData1:0];
                             flag=NO;
                         }
                     }
                     
                 }];
             }
         }];
    });
    
}
/*!
 * @discussion Webservice call for getting app configuration
 */
-(void) getAllConfiguration
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         //SHOW_LOADER_ANIMTION();
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
                 
                 if(flag)
                 {
                     [self GetAllUserData1:0];
                     flag = NO;
                 }

                 if(success){
                     
                     [appDelegate SetData:[dictionary valueForKey:@"GOOGLE_PLACE_API_KEY"] value:GOOGLE_API_KEY];
                     [appDelegate SetData:[dictionary valueForKey:@"adMobKey"] value:KadMobKey];
                     [appDelegate SetData:[dictionary valueForKey:@"adMobVideoKey"] value:KadMobVideoKey];
                     
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

                     
                     

                     
                     [appDelegate SetData:[dictionary valueForKey:@"TermsAndConditionsUrl"] value:kTermsAndConditionsUrl];
                     [appDelegate SetData:[dictionary valueForKey:@"INSTAGRAM_CALLBACK_BASE"] value:INSTAGRAM_CALLBACK_BASE];
                     [appDelegate SetData:[dictionary valueForKey:@"INSTAGRAM_CLIENT_SECRET"] value:INSTAGRAM_CLIENT_SECRET];
                     [appDelegate SetData:[dictionary valueForKey:@"INSTAGRAM_CLIENT_ID"] value:INSTAGRAM_CLIENT_ID];
                     
                     [appDelegate SetData:[dictionary valueForKey:@"XMPP_ENABLE"] value:kXMPPEnabled];
                     
                     
                     [appDelegate SetData:[dictionary valueForKey:@"APP_XMPP_HOST"] value:kXMPPHostName];
                     [appDelegate SetData:[dictionary valueForKey:@"APP_XMPP_SERVER"] value:kXMPPPrefix];
                     [appDelegate SetData:[dictionary valueForKey:@"XMPP_DEFAULT_PASSWORD"] value:kUserPassword];
                     
                     [[ApiManager sharedInstance] RegisterLoginXMPP];
                     
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
                 
                 if(![IAPShare sharedHelper].iap) {
                     
                     NSSet* dataSet = [[NSSet alloc] initWithObjects:[appDelegate GetData:kRemoveAddInAppPurchase], [appDelegate GetData:kChatSubscriptionInAppPurchase], [appDelegate GetData:kLocationInAppPurchase], [appDelegate GetData:kSuperLikeInAppPurchase], nil];
                     
                     [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
                     
                 }
             }];
         }
     }];
}
#pragma mark - create profile

/*!
 * @discussion Load cards for users
 * @param parentVC For Indentifying Parent view
 * @param index For Indentifying Card loading index
 * @param mutualFriend For Indentifying View for display mutual friend
 * @param bgMutualFriend For Indentifying View for display mutual friend Background
 */
-(void)loadCards:(UIView*) parentVC : (NSInteger) index :(UIView*) mutualFriend :(UIView*) bgMutualFriend
{
    
    int i = 0;
    NSInteger temp=appDelegate.cardsLoadedIndex;
    if(index>0){
        temp=appDelegate.cardsLoadedIndex+index-1;
    }
    
    NSInteger temp2=appDelegate.indexlazyload;
    
    if([appDelegate.allUsersDetails count] > 0) {
        
        NSInteger numLoadedCardsCap = [appDelegate.allUsersDetails count];
        
        for ( i = 0; (i+temp2) < [appDelegate.allUsersDetails count] && i<5; i++) {
            ProfileView *newCard = [self createDraggableViewWithDataAtIndex:(i+temp2):parentVC:mutualFriend:bgMutualFriend];
            [appDelegate.allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                // adds a small number of cards to be loaded
                [appDelegate.loadedCards addObject:newCard];
            }
            appDelegate.indexlazyload++;
        }
        
        // displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        
        for ( i = 0;( i+temp2) <[appDelegate.allUsersDetails count] && i<5; i++) {
            if ((i+temp)>0) {
                
                [parentVC insertSubview:[appDelegate.loadedCards objectAtIndex:(i+temp)] belowSubview:[appDelegate.loadedCards objectAtIndex:(i-1+temp)                      ]];
            } else {
                
                [parentVC addSubview:[appDelegate.loadedCards objectAtIndex:i+temp]];
            }
            appDelegate.cardsLoadedIndex++; // we loaded a card into loaded cards, so we have to increment
            
        }
    }
}

/*!
 * @discussion Create Draggable Card
 * @param index For Indentifying Card loading index
 * @param parentVC For Indentifying Parent view
 * @param mutualFriend For Indentifying View for display mutual friend
 * @param bgMutualFriend For Indentifying View for display mutual friend Background
 */
-(ProfileView *)createDraggableViewWithDataAtIndex:(NSInteger)index :(UIView *) parentVC :(UIView*) mutualFriend :(UIView*) bgMutualFriend
{
    ProfileView *profileView = [[ProfileView alloc]initWithFrame:CGRectMake(0, 0, parentVC.frame.size.width, parentVC.frame.size.height)];
    
    profileView.images=[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"gallary"];
    [profileView updateScrl];
    
    NSString *strName = [NSString stringWithFormat:@"%@ %@, %@",
                         [[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"fname"],
                         [[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"lname"],
                         [[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"age"]];
    NSString *strEducation = [NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"education"] ];
    NSString *strProfession = [NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"profession"] ];
    
    if(strName.length > 41){
        strName = [strName substringToIndex:41];
    }
    if(strEducation.length > 100){
        strEducation = [strEducation substringToIndex:100];
    }
    if(strProfession.length > 100){
        strProfession = [strProfession substringToIndex:100];
    }
    
    profileView.name.text= strName;
    if([[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"distance"] floatValue] <1){
        profileView.distance.text=[MCLocalization stringForKey:@"Less than a mile away"];
    }
    else{
        profileView.distance.text=[NSString stringWithFormat:@"%0.2f %@",[[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"distance"] floatValue],[MCLocalization stringForKey:@"Miles away"]];
    }
    
    profileView.education.text = strEducation ;
    profileView.profession.text = strProfession;
    profileView.popup=mutualFriend;
    profileView.popup=bgMutualFriend;
    profileView.parent=parentVC;
    
    profileView.friendID=[NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"id"] ];
    profileView.lblConutMutualFriends.text=[NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"mutual_friend"] ];
    
    
    if([[[appDelegate.allUsersDetails objectAtIndex:index] valueForKey:@"mutual_friend"] intValue] >0){
        [profileView.btnMutualFriend addTarget:self action:@selector(btnMutualFriendsClicked1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    profileView.delegate=self;
    profileView.dictFriendDetail=[appDelegate.allUsersDetails objectAtIndex:index];
    
    index++;
    appDelegate.indexAllcards++;
    
    profileView.btnUp.hidden = YES;
    profileView.btnDown.hidden = YES;
    
    profileView.vwInfo.hidden = YES;
    
    return profileView;
}
/*!
 * @discussion Create dummy Draggable Card for new user guide
 */
-(void)createDummycard
{
    self.vwDummyCard.hidden = NO;
    ProfileView *profileView = [[ProfileView alloc]initWithFrame:CGRectMake(0, 0, self.vwDummyCard.frame.size.width, self.vwDummyCard.frame.size.height)];
    
    profileView.images=[[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"gallary"];
    
    if(profileView.images.count >= 2) {
        [profileView updateScrl];
    }
    else if (profileView.images.count == 0){
        UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, profileView.frame.size.width, profileView.scrl.frame.size.height )];
        img1.layer.cornerRadius=0;
        img1.contentMode =UIViewContentModeScaleAspectFill;
        img1.layer.masksToBounds=YES;
        img1.image = [UIImage imageNamed:@"dummy1"];
        [profileView.scrl addSubview:img1];
        
        UIImageView *img2=[[UIImageView alloc] initWithFrame:CGRectMake(0, profileView.scrl.frame.size.height, profileView.frame.size.width, profileView.scrl.frame.size.height )];
        img2.layer.cornerRadius=0;
        img2.contentMode =UIViewContentModeScaleAspectFill;
        img2.layer.masksToBounds=YES;
        img2.image = [UIImage imageNamed:@"dummy2"];
        [profileView.scrl addSubview:img2];
        profileView.scrl.contentSize=CGSizeMake(profileView.frame.size.width, profileView.scrl.frame.size.height * 2 );
        [profileView configureVerticalControllerWithTotalPages:2];
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [profileView.page updateStateForPageNumber:1];
            
        });
        profileView.page.numberOfPages = 2;
        profileView.page.hidden = NO;
    }
    else if (profileView.images.count == 1){
        [profileView updateScrl];
        
        UIImageView *img2=[[UIImageView alloc] initWithFrame:CGRectMake(0, profileView.scrl.frame.size.height, profileView.frame.size.width, profileView.scrl.frame.size.height )];
        img2.layer.cornerRadius=0;
        img2.contentMode =UIViewContentModeScaleAspectFill;
        img2.layer.masksToBounds=YES;
        img2.image = [UIImage imageNamed:@"dummy2"];
        [profileView.scrl addSubview:img2];
        profileView.scrl.contentSize=CGSizeMake(profileView.frame.size.width, profileView.scrl.frame.size.height * 2 );
        [profileView configureVerticalControllerWithTotalPages:2];
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [profileView.page updateStateForPageNumber:1];
            
        });
        profileView.page.numberOfPages = 2;
        profileView.page.hidden = NO;
    }
    
    
    
    NSString *strName = [NSString stringWithFormat:@"%@ %@, %@",
                         [[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"fname"],
                         [[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"lname"],
                         [[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"age"] ];
    NSString *strEducation = [NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"education"] ];
    NSString *strProfession = [NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"profession"] ];
    
    profileView.name.text = strName;
    
    if([[[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"distance"] floatValue] < 1) {
        profileView.distance.text=[MCLocalization stringForKey:@"Less than a mile away"];
    } else {
        profileView.distance.text = [NSString stringWithFormat:@"%0.2f %@",[[[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"distance"] floatValue],[MCLocalization stringForKey:@"Miles away"]];
    }
    
    profileView.education.text = strEducation ;
    profileView.profession.text = strProfession;
    
    profileView.friendID=[NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"id"] ];
    profileView.lblConutMutualFriends.text=[NSString stringWithFormat:@"%@",[[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"mutual_friend"] ];
    
    
    if([[[appDelegate.allUsersDetails objectAtIndex:0] valueForKey:@"mutual_friend"] intValue] > 0) {
        [profileView.btnMutualFriend addTarget:self action:@selector(btnMutualFriendsClicked1) forControlEvents:UIControlEventTouchUpInside];
    }
    
    profileView.delegate=self;
    profileView.dictFriendDetail=[appDelegate.allUsersDetails objectAtIndex:0];
    
    profileView.delegate=self;
    
    profileView.vwInfo.hidden = NO;
    profileView.btnUp.hidden = NO;
    profileView.btnDown.hidden = NO;
    profileView.btnDetails.hidden = NO;
    profileView.imgUpTap.hidden = NO;
    profileView.imgDownTap.hidden = NO;
    profileView.imgInfoTap.hidden = NO;
    profileView.lblUpText.hidden = NO;
    profileView.lblDownText.hidden = NO;
    profileView.lblUp.hidden = NO;
    profileView.lblDown.hidden = NO;
    
    
    // [profileView addGestureRecognizer:profileView.singleTapGestureRecognizer];
    
    [self.vwDummyCard addSubview:profileView];
}
/*!
 * @discussion remove Draggable Card for new user guide
 */
- (void) hideInfo{
    [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.vwDummyCard.hidden = YES; }
                     completion:^(BOOL finished){
                         
                     }];
    
}
#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblMutualFriends.text=[MCLocalization stringForKey:@"Mutual Friends"];
    self.lblNoMoreFriends.text=[MCLocalization stringForKey:@"No Friend matches your preferences !!"];
    self.lblTitle.text=[MCLocalization stringForKey:@"Start Playing"];
}
/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.imgLogo setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwButtons setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.cards setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwDummyCard setTransform:CGAffineTransformMakeScale(-1, 1)];
}
@end
