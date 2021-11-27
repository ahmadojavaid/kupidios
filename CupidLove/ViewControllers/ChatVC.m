//
//  ChatVC.m
//  CupidLove
//
//  Created by APPLE on 29/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "ChatVC.h"
#import "ChatCell.h"
#import "DoChatVC.h"

@interface ChatVC ()<SSOnlineOfflineFriendsDelegate,UITextFieldDelegate>
@property (weak,nonatomic) IBOutlet UITableView *tblChat;
@property (weak,nonatomic) IBOutlet UITextField *txtSearch;
@property (weak,nonatomic) IBOutlet UIView *vwSearch;
@property (strong, nonatomic) IBOutlet UILabel *lblChat;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;

@property (weak,nonatomic) IBOutlet UIView *vwSearchIcon;
@property (weak,nonatomic) IBOutlet UIView *vwMenu;

@property (weak,nonatomic) IBOutlet UIView *vwTitle;

@end

@implementation ChatVC{
    NSMutableArray *chats;
    NSMutableArray *arrOnline,*arrJidsXmpp,*arrJids;
    NSArray *arrSearchOnline;
    NSMutableDictionary *dictLastMsg;
    BOOL flgSearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    
    [SSOnlineOfflineFriends shareInstance].delegate=self;
    [[SSOnlineOfflineFriends shareInstance] setSSOnlineOfflineFriendsDelegate ];
    
    [self.navigationController.navigationBar addSubview:self.vwSearch];
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    

    UIColor *color = [UIColor whiteColor];
    UIFont *font=[UIFont fontWithName:@"Lato-Regular" size:14];
    self.txtSearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Search"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];

    self.txtSearch.delegate=self;
    arrJidsXmpp=[[NSMutableArray alloc]init];
    arrJids=[[NSMutableArray alloc]init];
    arrOnline=[[NSMutableArray alloc]init];
    arrSearchOnline=[[NSArray alloc]init];
    chats=[[NSMutableArray alloc]init]; //for storing chat data
    dictLastMsg=[[NSMutableDictionary alloc]init];
    self.tblChat.backgroundColor=[UIColor clearColor];
    self.tblChat.indicatorStyle = UIScrollViewIndicatorStyleWhite;
   
    [self.tblChat setSeparatorColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dividerNotiifcation"]]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppear:) name:kRefresh object:nil];
    
    
    if([[appDelegate GetData:kAddsRemoved] isEqualToString:@"yes"])
    {
        self.vwBannerView.hidden=YES;
    }
    else{
        
        //admob
        
        self.vwBannerView.adUnitID = [appDelegate GetData:KadMobKey];
        
        self.vwBannerView.rootViewController = self;
        
        GADRequest *request = [GADRequest request];
  
        [self.vwBannerView loadRequest:request];
        
        if ([[appDelegate GetData:KadMobKey] isEqualToString:@""] || [[appDelegate GetData:KadMobKey] isEqualToString:@"key not found"]) {
            self.tblChat.frame=CGRectMake(self.tblChat.frame.origin.x, self.tblChat.frame.origin.y, self.tblChat.frame.size.width, self.tblChat.frame.size.height);
            self.vwBannerView.hidden = YES;
            
        } else {
             self.tblChat.frame=CGRectMake(self.tblChat.frame.origin.x, self.tblChat.frame.origin.y, self.tblChat.frame.size.width, self.tblChat.frame.size.height-50);
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{

//    [SSOnlineOfflineFriends shareInstance].delegate=nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.strJid=@"";
    [SSOnlineOfflineFriends shareInstance].delegate=nil;
    appDelegate.strPageName=@"";
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.vwSearch.hidden = YES;
    self.vwTitle.hidden = YES;
  
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}
-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    
    self.vwSearch.hidden = NO;
    self.vwTitle.hidden = NO;
    
    appDelegate.strPageName=@"ChatPage";
    [self localize];
    [self getChats];
    
    [SSOnlineOfflineFriends shareInstance].delegate=self;
    [[SSOnlineOfflineFriends shareInstance] setSSOnlineOfflineFriendsDelegate ];

    NSIndexPath *tableSelection = [self.tblChat indexPathForSelectedRow];
    [self.tblChat deselectRowAtIndexPath:tableSelection animated:NO];
    
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.vwSearch.frame=CGRectMake(SCREEN_SIZE.width,self.vwSearch.frame.origin.y,SCREEN_SIZE.width,self.navigationController.navigationBar.frame.size.height);
    self.vwBannerView.frame=CGRectMake(0, SCREEN_SIZE.height-50, SCREEN_SIZE.width, 50);
    
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.width = SCREEN_SIZE.width;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;

}


#pragma mark - UITextFieldDelegate
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

/*!
 * @discussion Called when textField's value is changed
 * @param sender For indentify sender
 */
- (IBAction)txtSearchChanges:(id)sender
{
    
    if (self.txtSearch.text.length==0) {
        arrSearchOnline = [chats mutableCopy];
        [self.tblChat reloadData];

    }
    else
    {
        NSPredicate *exists = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@  OR %K CONTAINS[c] %@", @"fname", self.txtSearch.text, @"lname", self.txtSearch.text];
        
        
        arrSearchOnline = [chats filteredArrayUsingPredicate:exists];
        [self.tblChat reloadData];

    }
}

#pragma mark- btnClick

/*!
 * @discussion Called when menu button is clicked
 * @param sender For indentify sender
 */
- (IBAction)btnMenuClicked:(id)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];
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
    [self.tblChat reloadData];
}

/*!
 * @discussion Called when search icon is clicked, Display TextField for Entering Text to Search
 * @param sender For indentify sender
 */
- (IBAction)btnSearchClicked:(id)sender
{

    flgSearch=YES;
    [self.txtSearch becomeFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
    self.vwSearch.frame=CGRectMake(0,self.vwSearch.frame.origin.y,SCREEN_SIZE.width,self.navigationController.navigationBar.frame.size.height);
        self.vwTitle.frame = CGRectMake(-SCREEN_SIZE.width, self.vwTitle.frame.origin.y, self.vwTitle.frame.size.width, self.vwTitle.frame.size.height);
    }];
    arrSearchOnline = [chats mutableCopy];
    [self.tblChat reloadData];

}
#pragma mark - tableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flgSearch) {
        return  arrSearchOnline.count;
    }
    return [chats count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ChatCell";
    
    ChatCell *cell = (ChatCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor=[UIColor clearColor];
    
    cell.vwOnlineOffline.layer.cornerRadius=(cell.vwOnlineOffline.frame.size.height/2);

    cell.vwOnlineOffline.backgroundColor = [UIColor whiteColor];
    
    if (flgSearch)
    {
        cell.nameLabel.text=[NSString stringWithFormat:@"%@ %@",[[arrSearchOnline objectAtIndex:indexPath.row] valueForKey:@"fname"],[[arrSearchOnline objectAtIndex:indexPath.row] valueForKey:@"lname"]];
        NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[arrSearchOnline objectAtIndex:indexPath.row] valueForKey:@"profile_image"] ];
        
        if([temp isEqualToString:imageUrl]){
            temp=[NSString stringWithFormat:@"%@uploadg/default.png",imageUrl];
        }
        [cell.actProfilePic startAnimating];
        [cell.imgProfile sd_setImageWithURL:[Util EncodedURL:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image != nil){
                cell.imgProfile.image=image;
            }
            else{
                cell.imgProfile.image = [UIImage imageNamed:@"TempProfile"];
            }
            
            [cell.actProfilePic stopAnimating];
        }];
        
        
        
        cell.imgProfile.layer.cornerRadius=(cell.imgProfile.frame.size.height/2);
        cell.imgProfile.layer.masksToBounds = YES;
        [cell.imgProfile.layer setBorderWidth: 2.0];

        NSString *strUserName=[NSString stringWithFormat:@"%@%@",[[[arrSearchOnline objectAtIndex:indexPath.row] valueForKey:@"ejuser"]lowercaseString],Userpostfix];
        
        cell.vwCounter.hidden=YES;
        if ([[[SSConnectionClasses shareInstance] getUnreadMessageCountFor:strUserName] intValue]==0) {
            cell.vwCounter.hidden=YES;
        }
        else
        {
            cell.vwCounter.hidden=NO;
            cell.lblUnReadCount.text=[[SSConnectionClasses shareInstance] getUnreadMessageCountFor:strUserName];
        }
        
        NSData *data1 = [[dictLastMsg valueForKey:strUserName] dataUsingEncoding:NSUTF16StringEncoding];
        NSString *decodevalue = [[NSString alloc] initWithData:data1 encoding:NSUTF16StringEncoding];
        
        cell.lblLastMsg.text=decodevalue;
        UIColor *border=[UIColor whiteColor];
        for (int i = 0; i < [SSOnlineOfflineFriends shareInstance].arrOnLineUsers.count; i++)
        {
            NSArray *substrings = [[[SSOnlineOfflineFriends shareInstance].arrOnLineUsers objectAtIndex:i] componentsSeparatedByString:@"@"];
            NSString *first = [substrings objectAtIndex:0];
            
            NSString *strUser = [[arrSearchOnline objectAtIndex:indexPath.row] valueForKey:@"ejuser"];
            
            if ([strUser.lowercaseString isEqualToString:first.lowercaseString])
            {
                //online
                cell.vwOnlineOffline.backgroundColor = [UIColor greenColor];
                border=[UIColor greenColor];
            }
        }
        cell.imgProfile.layer.borderColor=border.CGColor;

    }
    else
    {

        cell.nameLabel.text=[NSString stringWithFormat:@"%@ %@",[[chats objectAtIndex:indexPath.row] valueForKey:@"fname"],[[chats objectAtIndex:indexPath.row] valueForKey:@"lname"]];
        NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[chats objectAtIndex:indexPath.row] valueForKey:@"profile_image"] ];
        
        if([temp isEqualToString:imageUrl]){
            temp=[NSString stringWithFormat:@"%@uploadg/default.png",imageUrl];
        }
        [cell.actProfilePic startAnimating];
        [cell.imgProfile sd_setImageWithURL:[Util EncodedURL:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image != nil){
                cell.imgProfile.image=image;
            }
            else{
                cell.imgProfile.image = [UIImage imageNamed:@"TempProfile"];
            }
            [cell.actProfilePic stopAnimating];
        }];
        
        cell.imgProfile.layer.cornerRadius=(cell.imgProfile.frame.size.height/2);
        cell.imgProfile.layer.masksToBounds = YES;
        [cell.imgProfile.layer setBorderWidth: 2.0];
        NSString *strUserName=[NSString stringWithFormat:@"%@%@",[[[chats objectAtIndex:indexPath.row] valueForKey:@"ejuser"]lowercaseString],Userpostfix];
        
        
        cell.vwCounter.hidden=YES;
        if ([[[SSConnectionClasses shareInstance] getUnreadMessageCountFor:strUserName] intValue]==0) {
            cell.vwCounter.hidden=YES;
        }
        else
        {
            cell.vwCounter.hidden=NO;
            cell.lblUnReadCount.text=[[SSConnectionClasses shareInstance] getUnreadMessageCountFor:strUserName];
        }
        NSData *data1 = [[dictLastMsg valueForKey:strUserName] dataUsingEncoding:NSUTF16StringEncoding];
        NSString *decodevalue = [[NSString alloc] initWithData:data1 encoding:NSUTF16StringEncoding];
        
        cell.lblLastMsg.text=decodevalue;
        
         UIColor *border=[UIColor whiteColor];
        for (int i = 0; i < [SSOnlineOfflineFriends shareInstance].arrOnLineUsers.count; i++)
        {
            NSArray *substrings = [[[SSOnlineOfflineFriends shareInstance].arrOnLineUsers objectAtIndex:i] componentsSeparatedByString:@"@"];
            NSString *first = [substrings objectAtIndex:0];
            
            NSString *strUser = [[chats objectAtIndex:indexPath.row] valueForKey:@"ejuser"];
            
            if ([strUser.lowercaseString isEqualToString:first.lowercaseString])
            {
                //online
                cell.vwOnlineOffline.backgroundColor = [UIColor greenColor];
                border=[UIColor greenColor];
            }
        }

        cell.imgProfile.layer.borderColor=border.CGColor;

    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (flgSearch)
    {
        
        DoChatVC *vc=[[DoChatVC alloc]initWithNibName:@"DoChatVC" bundle:nil];
        NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[arrSearchOnline objectAtIndex:indexPath.row] valueForKey:@"profile_image"]];
        if([temp isEqualToString:imageUrl]){
            temp=[NSString stringWithFormat:@"%@uploadg/default.png",imageUrl];
        }
        vc.strChatName=[NSString stringWithFormat:@"%@ %@",[[arrSearchOnline objectAtIndex:indexPath.row] valueForKey:@"fname"],[[arrSearchOnline objectAtIndex:indexPath.row] valueForKey:@"lname"]];
        vc.strImgUrl=temp;
        
        vc.strFriendId=[[arrSearchOnline objectAtIndex:indexPath.row] valueForKey:@"fid"];
        
        NSString *strUserName=[NSString stringWithFormat:@"%@%@",[[chats objectAtIndex:indexPath.row] valueForKey:@"ejuser"],Userpostfix];
        
        if ([[SSOnlineOfflineFriends shareInstance].arrOnLineUsers containsObject:strUserName])
        {
            vc.strOnlineOffline=@"Online";
        }
        else
        {
            vc.strOnlineOffline=@"Offline";
        }
        vc.strJid=strUserName;
        
        [self.navigationController pushViewController:vc animated:YES];

    }
    else
    {
        DoChatVC *vc=[[DoChatVC alloc]initWithNibName:@"DoChatVC" bundle:nil];
        NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[chats objectAtIndex:indexPath.row] valueForKey:@"profile_image"]];
        if([temp isEqualToString:imageUrl]){
            temp=[NSString stringWithFormat:@"%@uploadg/default.png",imageUrl];
        }
        vc.strChatName=[NSString stringWithFormat:@"%@ %@",[[chats objectAtIndex:indexPath.row] valueForKey:@"fname"],[[chats objectAtIndex:indexPath.row] valueForKey:@"lname"]];
        vc.strImgUrl=temp;

        NSString *strUserName=[NSString stringWithFormat:@"%@%@",[[chats objectAtIndex:indexPath.row] valueForKey:@"ejuser"],Userpostfix];

        if ([[SSOnlineOfflineFriends shareInstance].arrOnLineUsers containsObject:strUserName])
        {
            vc.strOnlineOffline=@"Online";
        }
        else
        {
            vc.strOnlineOffline=@"Offline";
        }
        vc.strJid=strUserName;
        
        vc.strFriendId=[[chats objectAtIndex:indexPath.row] valueForKey:@"fid"];
        [self.navigationController pushViewController:vc animated:YES];

    }
    
}

#pragma mark- scrollview Delegates
-(void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    //get refrence of vertical indicator
    UIImageView *verticalIndicator = ((UIImageView *)[self.tblChat.subviews objectAtIndex:(self.tblChat.subviews.count-1)]);
    //    //set color to vertical indicator
    [verticalIndicator setBackgroundColor:Theme_Color];
    
    
}

#pragma mark - api call
/*!
 * @discussion Web service call for getting users in chat list
 */
-(void) getChats
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
             NSString *str=@"chat";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if([dictionary count]>0){
                     
                     if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                         [chats removeAllObjects];
                         [appDelegate.arrChats removeAllObjects];
                         NSArray *arr=[dictionary valueForKey:@"body"];
                         
                         for (int i = 0; i < arr.count; i++)
                         {
                             if ([[[[dictionary valueForKey:@"body"] objectAtIndex:i] valueForKey:@"ejuser"] isEqualToString:@""]) {
                                 continue;
                             }
                             [chats addObject: [[dictionary valueForKey:@"body"] objectAtIndex:i]];
                             //TODO: == add ejid from api===
                             NSString *strUserName=[NSString stringWithFormat:@"%@%@",[[[dictionary valueForKey:@"body"] objectAtIndex:i] valueForKey:@"ejuser"],Userpostfix];
                             
                             if(![arrJids containsObject:strUserName])
                             {
                                 [arrJids addObject:strUserName];
                             }
                             if ([self.strJid isEqualToString:strUserName])

                             {
                                 DoChatVC *vc=[[DoChatVC alloc]initWithNibName:@"DoChatVC" bundle:nil];
                                 NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[[chats objectAtIndex:i] valueForKey:@"profile_image"]];
                                 if([temp isEqualToString:imageUrl]){
                                     temp=[NSString stringWithFormat:@"%@uploads/default.png",imageUrl];
                                 }
                                 vc.strChatName=[NSString stringWithFormat:@"%@ %@",[[chats objectAtIndex:i] valueForKey:@"fname"],[[chats objectAtIndex:i] valueForKey:@"lname"]];
                                 vc.strImgUrl=temp;
                                 NSString *strUserName=[NSString stringWithFormat:@"%@%@",[[[chats objectAtIndex:i] valueForKey:@"ejuser"]lowercaseString],Userpostfix];
                                 vc.strJid=strUserName;
                                 vc.strFriendId = [[[dictionary valueForKey:@"body"] objectAtIndex:i] valueForKey:@"fid"];
                                 [self.navigationController pushViewController:vc animated:YES];
                             }
                             
                         }
                         appDelegate.arrChats=[chats mutableCopy];
                         [self AddFriends];
                         
                         [self.tblChat reloadData];
                     }
                 }
             }];
         }
     }];
    });
}


#pragma mark - Chat Data
/*!
 * @discussion Check if table should reload or not
 * @param data List of users in chat
 */
-(void)shouldReloadTable:(NSMutableArray *)data
{
    [dictLastMsg removeAllObjects];
//    [arrOnline removeAllObjects];
    for (int i=0;i<data.count;i++)
    {
        if([[[data objectAtIndex:i]valueForKey:@"mostRecentMessageBody"]  hasPrefix:@"$***$"])
        {
            [dictLastMsg setValue:[MCLocalization stringForKey:@"Date Request...."] forKey:[[data objectAtIndex:i]valueForKey:@"jidStr"]];
        }
        else
        {
            [dictLastMsg setValue:[[data objectAtIndex:i]valueForKey:@"mostRecentMessageBody"] forKey:[[data objectAtIndex:i]valueForKey:@"jidStr"]];
        }
        if(![arrJidsXmpp containsObject:[[data objectAtIndex:i]valueForKey:@"jidStr"]])
        {
            [arrJidsXmpp addObject:[[data objectAtIndex:i]valueForKey:@"jidStr"]];
        }
    }
    
    [self.tblChat reloadData];
}

/*!
 * @discussion Add friends to xmpp
 */
-(void)AddFriends
{
    
    for (int i=0;i<arrJids.count;i++)
    {
        if (![arrJidsXmpp containsObject:[[arrJids objectAtIndex:i] lowercaseString]])
        {
            [[SSAddFriend shareInstance] addFriendWithJid:[[arrJids objectAtIndex:i] lowercaseString] nickname:[[chats objectAtIndex:i] valueForKey:@"fname"] complition:^(NSDictionary *result)
             {
                 //friend added
             }];
        }
    }
}
#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblChat.text=[MCLocalization stringForKey:@"Chat"];
       
    [self.btnCancel setTitle:[MCLocalization stringForKey:@"Cancel"] forState:UIControlStateNormal];
    
    self.lblTitleUnderline.frame=CGRectMake(self.lblChat.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
    
  
}

/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.tblChat setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.vwSearch setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtSearch setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.btnCancel setTransform:CGAffineTransformMakeScale(-1, 1)];

    self.txtSearch.textAlignment = NSTextAlignmentRight;

    
}
@end
