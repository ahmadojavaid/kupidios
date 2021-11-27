//
//  ItsAMatchVC.m
//  CupidLove
//
//  Created by Umesh on 11/14/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import "ItsAMatchVC.h"
#import "DoChatVC.h"
#import "FriendProfileVC.h"

@interface ItsAMatchVC ()
@property (weak,nonatomic) IBOutlet UIImageView *img1;
@property (weak,nonatomic) IBOutlet UILabel *lblName;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act1;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act2;
@property (weak,nonatomic) IBOutlet UIView *vwItsMatch;
@property (strong, nonatomic) IBOutlet UILabel *lblLikeeachOther;

@property (strong, nonatomic) IBOutlet UILabel *lblmatch;
@property (strong, nonatomic) IBOutlet UILabel *lblKeepPlaying;
@property (strong, nonatomic) IBOutlet UILabel *lblsendMessage;

@property (weak, nonatomic) IBOutlet UIView *vwSendMessage;
@property (weak, nonatomic) IBOutlet UIView *vwKeepPlaying;

@end

@implementation ItsAMatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
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
        
        self.vwItsMatch.frame=CGRectMake(self.vwItsMatch.frame.origin.x, self.vwItsMatch.frame.origin.y, self.vwItsMatch.frame.size.width, self.vwItsMatch.frame.size.height-50);
    }
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    self.act1.color = Theme_Color;
    self.act2.color = Theme_Color;
    self.lblmatch.textColor = Theme_Color;
    
    self.lblName.text=[NSString stringWithFormat:@"%@  &  %@",[MCLocalization stringForKey:@"You"],self.strFname];
    
    NSString *myString = self.lblName.text;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
    
    NSRange range = [myString rangeOfString:@"&"];
    [attString addAttribute:NSForegroundColorAttributeName value:Theme_Color range:range];
    self.lblName.attributedText = attString;

    dispatch_async(dispatch_get_main_queue(), ^{
        self.img1.frame=CGRectMake(self.img1.frame.origin.x, self.img1.frame.origin.y, self.img1.frame.size.height, self.img1.frame.size.height);
        self.img2.frame=CGRectMake(self.img2.frame.origin.x, self.img2.frame.origin.y, self.img2.frame.size.height, self.img2.frame.size.height);
    });
    
    
    [self.act1 startAnimating];
    NSString *strurl=[NSString stringWithFormat:@"%@",[appDelegate GetData:kprofileimage]];

    [self.img1 sd_setImageWithURL:[Util EncodedURL:strurl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
    {
        if(image != nil){
             self.img1.image=image;
        }
        else{
             self.img1.image = [UIImage imageNamed:@"TempProfile"];
        }       
        [self.act1 stopAnimating];
    }];
    
    [self.act2 startAnimating];
    [self.img2 sd_setImageWithURL:[Util EncodedURL:self.strImgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image!=nil){
            self.img2.image=image;
        }
        else{
            self.img2.image = [UIImage imageNamed:@"TempProfile"];
        }
        
        [self.act2 stopAnimating];
    }];
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
     [self localize];
    self.vwBannerView.frame=CGRectMake(0, SCREEN_SIZE.height-50, SCREEN_SIZE.width, 50);
    [super viewDidLayoutSubviews];
    self.img1.layer.cornerRadius=(self.img1.frame.size.height/2);
    self.img1.layer.masksToBounds = YES;
    UIColor *border=[UIColor whiteColor];
    self.img1.layer.borderColor=border.CGColor;
    [self.img1.layer setBorderWidth: 3.0];
    self.img2.layer.cornerRadius=(self.img2.frame.size.height/2);
    self.img2.layer.masksToBounds = YES;
    self.img2.layer.borderColor=border.CGColor;
    [self.img2.layer setBorderWidth: 3.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-btnClicks
/*!
 * @discussion Go to Chat Room
 * @param sender For indentify sender
 */
- (IBAction)btnSendMessageClicked:(id)sender
{
    DoChatVC *VC = [[DoChatVC alloc] initWithNibName:@"DoChatVC" bundle:nil];
    VC.strComeFrom=@"its Match";
    VC.strFriendId=self.strFid;
    VC.strChatName=[NSString stringWithFormat:@"%@ %@",self.strFname,self.strLname];
    VC.strImgUrl=self.strImgUrl;
//    NSString *strUserName=[NSString stringWithFormat:@"%@_%@%@",self.strFid,[self.strFname lowercaseString],Userpostfix];
//    NSString *strUserName=[NSString stringWithFormat:@"%@%@",self.strFid,Userpostfix];
//    VC.strJid=strUserName;
    VC.strJid=self.strJid;
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controllers = [NSArray arrayWithObject:VC];
    navigationController.viewControllers = controllers;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

}
/*!
 * @discussion Go to Home Page
 * @param sender For indentify sender
 */
- (IBAction)btnKeepPlayingClicked:(id)sender
{
    
    FriendProfileVC *VC = [[FriendProfileVC alloc] initWithNibName:@"FriendProfileVC" bundle:nil];
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controllers = [NSArray arrayWithObject:VC];
    navigationController.viewControllers = controllers;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

}

#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblKeepPlaying.text=[MCLocalization stringForKey:@"KEEP PLAYING"];
    self.lblLikeeachOther.text=[MCLocalization stringForKey:@"like each other"];
    self.lblsendMessage.text=[MCLocalization stringForKey:@"SEND A MESSAGE"];
    self.lblmatch.text=[MCLocalization stringForKey:@"It's a match"];
    
}

/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.vwKeepPlaying setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwSendMessage setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblKeepPlaying setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblsendMessage setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    self.lblKeepPlaying.textAlignment = NSTextAlignmentRight;
    self.lblsendMessage.textAlignment = NSTextAlignmentRight;

}

@end
