//
//  NotificationVC.m
//  CupidLove
//
//  Created by APPLE on 14/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "NotificationVC.h"
#import "NotificationCell.h"
#import "ItsAMatchVC.h"
#import "UIImageView+WebCache.h"
#import "FriendDetailsVC.h"


@interface NotificationVC ()<UITextFieldDelegate,GADBannerViewDelegate>
@property (weak,nonatomic) IBOutlet UITableView *tblNotification;
@property(nonatomic) UIScrollViewIndicatorStyle indicatorStyle;
@property (weak,nonatomic) IBOutlet UITextField *txtSearch;
@property (weak,nonatomic) IBOutlet UIView *vwSearch;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;

@property (weak,nonatomic) IBOutlet UIView *vwSearchIcon;
@property (weak,nonatomic) IBOutlet UIView *vwMenu;
@property (weak,nonatomic) IBOutlet UIView *vwTitle;

@end

@implementation NotificationVC
{
    NSMutableArray *notifications;
    NSArray *arrSearchNotification;
    BOOL flgSearch;

}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar addSubview:self.vwSearch];
    [self.navigationController.navigationBar addSubview:self.vwTitle];

    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppear:) name:kRefresh object:nil];
    UIColor *color = [UIColor whiteColor];
    UIFont *font=[UIFont fontWithName:@"Lato-Regular" size:14];
    self.txtSearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Search"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    
    
    if([[appDelegate GetData:kAddsRemoved] isEqualToString:@"yes"]){
        self.vwBannerView.hidden=YES;
    }
    else{
        
        //admob
//        self.vwBannerView.adUnitID = KadMobKey;
            self.vwBannerView.adUnitID = [appDelegate GetData:KadMobKey];
        self.vwBannerView.rootViewController = self;
        
        GADRequest *request = [GADRequest request];
        
        [self.vwBannerView loadRequest:request];
        
        self.tblNotification.frame=CGRectMake(self.tblNotification.frame.origin.x, self.tblNotification.frame.origin.y, self.tblNotification.frame.size.width, self.tblNotification.frame.size.height-50);
    }
    
    if ([[appDelegate GetData:KadMobKey] isEqualToString:@""] || [[appDelegate GetData:KadMobKey] isEqualToString:@"Key Not Found"]) {
        self.vwBannerView.hidden = YES;
    }
    else {
        self.vwBannerView.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.vwTitle.hidden = NO;
    
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    
    self.vwSearch.hidden = NO;
    
    [notifications removeAllObjects];
    appDelegate.strPageName=@"NotificationPage";
    [self localize];
    self.txtSearch.delegate=self;
    arrSearchNotification =[[NSMutableArray alloc]init];
    notifications=[[NSMutableArray alloc] init];
    self.tblNotification.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    NSIndexPath *tableSelection = [self.tblNotification indexPathForSelectedRow];
    [self.tblNotification deselectRowAtIndexPath:tableSelection animated:NO];
    [self getNotifications];
    
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.vwSearch.frame = CGRectMake(SCREEN_SIZE.width,self.vwSearch.frame.origin.y,SCREEN_SIZE.width,self.navigationController.navigationBar.frame.size.height);
    self.vwBannerView.frame=CGRectMake(0, SCREEN_SIZE.height-50, SCREEN_SIZE.width, 50);
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.width = SCREEN_SIZE.width;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    
}
-(void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    appDelegate.strPageName=@"";
    self.vwSearch.hidden = YES;
    self.vwTitle.hidden = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - btnClicked
/*!
 * @discussion Open Menu
 * @param sender For indentify sender
 */
- (IBAction)btnMenuClicked:(id)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];
}

/*!
 * @discussion Called when User Like another User, Users become friends and It's a match will Display
 * @param sender For indentify sender
 */
- (IBAction)btnLikeClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    [self approveNotification:btn.tag];
    
}
/*!
 * @discussion Called when User Dislike another User, Disliked user will removed from notification list
 * @param sender For indentify sender
 */
- (IBAction)btnDislikeClicked:(id)sender
{
   
    UIButton *btn=(UIButton *)sender;
    if(flgSearch)
    {
        [self disapproveNotification:[[arrSearchNotification objectAtIndex:btn.tag] valueForKey:@"send_user_id"]];
    }
    else
    {
        [self disapproveNotification:[[notifications objectAtIndex:btn.tag] valueForKey:@"send_user_id"]];
    }
}
/*!
 * @discussion Called when search is cancelled, Hide Search Box
 * @param sender For indentify sender
 */
- (IBAction)btnSearchCancelClicked:(id)sender
{
    flgSearch=NO;
    
    self.txtSearch.text=@"";
    [self.txtSearch resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        self.vwSearch.frame = CGRectMake(SCREEN_SIZE.width,self.vwSearch.frame.origin.y,SCREEN_SIZE.width,self.navigationController.navigationBar.frame.size.height);
        self.vwTitle.frame = CGRectMake(0, self.vwTitle.frame.origin.y, self.vwTitle.frame.size.width, self.vwTitle.frame.size.height);
    }];
    [self.tblNotification reloadData];
}
/*!
 * @discussion Called when Search Icon is Clicked, Display TextField for Entering Text to Search
 * @param sender For indentify sender
 */
- (IBAction)btnSearchClicked:(id)sender
{
    flgSearch=YES;
   
    [self.txtSearch becomeFirstResponder];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.vwSearch.frame = CGRectMake(0, self.vwSearch.frame.origin.y, SCREEN_SIZE.width, self.navigationController.navigationBar.frame.size.height);
        self.vwTitle.frame = CGRectMake(-SCREEN_SIZE.width, self.vwTitle.frame.origin.y, self.vwTitle.frame.size.width, self.vwTitle.frame.size.height);
    }];
    arrSearchNotification = [notifications mutableCopy];
    [self.tblNotification reloadData];
}


#pragma mark - UITextFieldDelegate
/*!
 * @discussion Called when textField's value is changed
 * @param sender For indentify sender
 */
- (IBAction)txtSearchChanges:(id)sender
{
    
    if (self.txtSearch.text.length==0) {
        arrSearchNotification = [notifications mutableCopy];
        [self.tblNotification reloadData];
        
    }
    else
    {
        NSPredicate *exists = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@  OR %K CONTAINS[c] %@", @"fname", self.txtSearch.text, @"lname", self.txtSearch.text];
        arrSearchNotification = [notifications filteredArrayUsingPredicate:exists];
        [self.tblNotification reloadData];
        
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}


#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (flgSearch)
    {
       return  arrSearchNotification.count;
    }
   return [notifications count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"NotificationCell";
    
    NotificationCell *cell = (NotificationCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NotificationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (flgSearch)
    {
        
        cell.nameLabel.text=[NSString stringWithFormat:@"%@ %@",[[arrSearchNotification objectAtIndex:indexPath.row] valueForKey:@"fname"],[[arrSearchNotification objectAtIndex:indexPath.row] valueForKey:@"lname"]];
        NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[arrSearchNotification objectAtIndex:indexPath.row] valueForKey:@"profile_image"] ];
        if([temp isEqualToString:imageUrl]){
            temp=[NSString stringWithFormat:@"%@uploads/default.png",imageUrl];
        }
        [cell.actProfilePic startAnimating];
        [cell.profileImage sd_setImageWithURL:[Util EncodedURL:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image != nil){
                cell.profileImage.image=image;
            }
            else{
                cell.profileImage.image = [UIImage imageNamed:@"TempProfile"];
            }
            
            [cell.actProfilePic stopAnimating];
        }];
        if([[[arrSearchNotification objectAtIndex:indexPath.row] valueForKey:@"distance"] floatValue] <1 ){
            cell.lblDistance.text=[MCLocalization stringForKey:@"Less than a mile away"];
        }
        else{
            cell.lblDistance.text= [NSString stringWithFormat:@"%0.2f %@",[[[arrSearchNotification objectAtIndex:indexPath.row] valueForKey:@"distance"] floatValue],[MCLocalization stringForKey:@"Miles away"]];
        }
        
        [cell.likeButton addTarget:self
                            action:@selector(btnLikeClicked:)
                  forControlEvents:UIControlEventTouchUpInside];
        cell.likeButton.tag=indexPath.row;
        [cell.dislikeButton addTarget:self
                               action:@selector(btnDislikeClicked:)
                     forControlEvents:UIControlEventTouchUpInside];
        cell.dislikeButton.tag=indexPath.row;

    }
    else
    {
        cell.nameLabel.text=[NSString stringWithFormat:@"%@ %@",[[notifications objectAtIndex:indexPath.row] valueForKey:@"fname"],[[notifications objectAtIndex:indexPath.row] valueForKey:@"lname"]];
        NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[notifications objectAtIndex:indexPath.row] valueForKey:@"profile_image"] ];
        if([temp isEqualToString:imageUrl]){
            temp=[NSString stringWithFormat:@"%@uploads/default.png",imageUrl];
        }
        [cell.actProfilePic startAnimating];
        [cell.profileImage sd_setImageWithURL:[Util EncodedURL:temp]   completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image != nil){
                cell.profileImage.image=image;
            }
            else{
                cell.profileImage.image = [UIImage imageNamed:@"TempProfile"];
            }
            [cell.actProfilePic stopAnimating];
        }];
        
        if([[[notifications objectAtIndex:indexPath.row] valueForKey:@"distance"] floatValue] <1 ){
            cell.lblDistance.text=[MCLocalization stringForKey:@"Less than a mile away"];
        }
        else{
            cell.lblDistance.text= [NSString stringWithFormat:@"%0.2f %@",[[[notifications objectAtIndex:indexPath.row] valueForKey:@"distance"] floatValue],[MCLocalization stringForKey:@"Miles away"]];
        }
        
        
        [cell.likeButton addTarget:self
                            action:@selector(btnLikeClicked:)
                  forControlEvents:UIControlEventTouchUpInside];
        cell.likeButton.tag=indexPath.row;
        
        [cell.dislikeButton addTarget:self
                               action:@selector(btnDislikeClicked:)
                     forControlEvents:UIControlEventTouchUpInside];
        cell.dislikeButton.tag=indexPath.row;

    }
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (flgSearch)
    {
        [self getUserDetails:[[arrSearchNotification objectAtIndex:indexPath.row] valueForKey:@"send_user_id"]];

    }
    else{
        [self getUserDetails:[[notifications objectAtIndex:indexPath.row] valueForKey:@"send_user_id"]];
    }
    //friends story page after api call
    
    
}
#pragma mark- scrollviewDelegates
-(void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    //get refrence of vertical indicator
        UIImageView *verticalIndicator = ((UIImageView *)[self.tblNotification.subviews objectAtIndex:(self.tblNotification.subviews.count-1)]);
    //    //set color to vertical indicator
    [verticalIndicator setBackgroundColor:Theme_Color];
    
}
#pragma mark - api call
/*!
 * @discussion Webservice call for getting List of users who liked the login user
 */
-(void) getNotifications
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
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
             NSString *str=@"getnotification";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;


                 if( success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {

                     NSArray *arr=[dictionary valueForKey:@"body"];
                     [notifications removeAllObjects];
                     for (int i = 0; i < arr.count; i++) {
                         [notifications addObject: [[dictionary valueForKey:@"body"] objectAtIndex:i]];
                     }

                     [self.tblNotification reloadData];
                 }
             }];
         }
     }];
        
    });

}
/*!
 * @discussion Webservice call for approve notification
 */
-(void) approveNotification:(NSInteger) index
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
             NSString *str=@"approvenotification";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             if (flgSearch)
             {
                 [dict setValue:[[arrSearchNotification objectAtIndex:index] valueForKey:@"send_user_id"] forKey:@"send_user_id"];
                 [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
                 
                 
                 [dict setValue:@"1" forKey:@"approved"];
                 
             }
             else
             {
                 
                 [dict setValue:[[notifications objectAtIndex:index] valueForKey:@"send_user_id"] forKey:@"send_user_id"];
                 [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
                 
                 [dict setValue:@"1" forKey:@"approved"];
                 
             }
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 HIDE_PROGRESS;
                 
                 //                 NSString *strUsername=[NSString stringWithFormat:@"%@_%@",[[notifications objectAtIndex:index] valueForKey:@"send_user_id"],[[notifications objectAtIndex:index] valueForKey:@"fname"]];
                 //
                 //
                 //                 [[SSAddFriend shareInstance] addFriendWithJid:strUsername complition:^(NSDictionary *result)
                 //                 {
                 //
                 //                 }];
                 //
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     //TODO: testing
                     [SSConnectionClasses shareInstance].totalUnReadMsgcount--;
                     // badge_count-- ;
                     //    [UIApplication sharedApplication].applicationIconBadgeNumber = [SSConnectionClasses shareInstance].totalUnReadMsgcount;
                     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                     
                     ItsAMatchVC *vc=[[ItsAMatchVC alloc]initWithNibName:@"ItsAMatchVC" bundle:nil];
                     
                     if (flgSearch)
                     {
                         NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[arrSearchNotification objectAtIndex:index] valueForKey:@"profile_image"] ];
                         if([temp isEqualToString:imageUrl]){
                             temp=[NSString stringWithFormat:@"%@uploads/default.png",imageUrl];
                         }
                         
                         NSString *strUsername=[[NSString stringWithFormat:@"%@",[[arrSearchNotification objectAtIndex:index] valueForKey:@"ejuser"]] lowercaseString];
                         
                         
                         [[SSAddFriend shareInstance] addFriendWithJid:strUsername nickname:[[arrSearchNotification objectAtIndex:index] valueForKey:@"fname"] complition:^(NSDictionary *result)
                          {
                              
                          }];
                         
                         
                         vc.strFname=[[arrSearchNotification objectAtIndex:index] valueForKey:@"fname"] ;
                         vc.strLname=[[arrSearchNotification objectAtIndex:index] valueForKey:@"lname"] ;
                         vc.strImgUrl=temp;
                         vc.strFid=[[arrSearchNotification objectAtIndex:index] valueForKey:@"send_user_id"];
                         
                         vc.strJid=[[arrSearchNotification objectAtIndex:index] valueForKey:@"ejuser"];
                         
                     }
                     else
                     {
                         NSString *strUsername=[[NSString stringWithFormat:@"%@",[[notifications objectAtIndex:index] valueForKey:@"ejuser"]] lowercaseString];
                         
                         //                         [[SSAddFriend shareInstance] addFriendWithJid:[[arrJids objectAtIndex:i] lowercaseString] nickname:[[chats objectAtIndex:i] valueForKey:@"fname"] complition:^(NSDictionary *result)
                         //                          {
                         
                         
                         [[SSAddFriend shareInstance] addFriendWithJid:strUsername nickname:[[notifications objectAtIndex:index] valueForKey:@"fname"] complition:^(NSDictionary *result)
                          {
                              
                          }];
                         
                         NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[notifications objectAtIndex:index] valueForKey:@"profile_image"] ];
                         if([temp isEqualToString:imageUrl]){
                             temp=[NSString stringWithFormat:@"%@uploads/default.png",imageUrl];
                         }
                         
                         vc.strFname=[[notifications objectAtIndex:index] valueForKey:@"fname"] ;
                         vc.strLname=[[notifications objectAtIndex:index] valueForKey:@"lname"] ;
                         vc.strImgUrl=temp;
                         vc.strFid=[[notifications objectAtIndex:index] valueForKey:@"send_user_id"];
                         vc.strJid=[[notifications objectAtIndex:index] valueForKey:@"ejuser"];
                         
                     }
                     [self.navigationController pushViewController:vc animated:YES];
                 }
             }];
         }
     }];
}
/*!
 * @discussion Webservice call for Disapprove notificatio
 */
-(void) disapproveNotification:(NSString *) friendID
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
             NSString *str=@"approvenotification";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:friendID forKey:@"send_user_id"];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:@"0" forKey:@"approved"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                   
                     //TODO: testing
                     [SSConnectionClasses shareInstance].totalUnReadMsgcount--;
                     // badge_count-- ;
                 //    [UIApplication sharedApplication].applicationIconBadgeNumber = [SSConnectionClasses shareInstance].totalUnReadMsgcount;
                     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                     
                     [self getNotifications];
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
 * @discussion Webservice call for getting users details
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
                     [self.navigationController setNavigationBarHidden:YES animated:NO];
                     [self.navigationController pushViewController:vc animated:YES];
                     
                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Please try again!!"], self);
                     [self.tblNotification reloadData];
                 }
             }];
         }
     }];
}


#pragma mark - AdMob Delegate   
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    
}
#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblTitle.text=[MCLocalization stringForKey:@"Notification"];
    
    [self.btnCancel setTitle:[MCLocalization stringForKey:@"Cancel"] forState:UIControlStateNormal];
    
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
}

/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.tblNotification setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.vwSearch setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtSearch setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.btnCancel setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    self.txtSearch.textAlignment = NSTextAlignmentRight;
    
    
}
@end
