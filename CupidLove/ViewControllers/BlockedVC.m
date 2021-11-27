//
//  BlockedVC.m
//  CupidLove
//
//  Created by potenza on 24/02/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "BlockedVC.h"
#import <MessageUI/MessageUI.h>
@interface BlockedVC ()<MFMailComposeViewControllerDelegate>
@property(weak,nonatomic) IBOutlet UILabel *lblBlocked;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblContactUs;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
@property (weak,nonatomic) IBOutlet UIView *vwMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnContactUs;
@property (weak, nonatomic) IBOutlet UIView *vwContact;

@property (weak,nonatomic) IBOutlet UIView *vwTitle;
@end

@implementation BlockedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.lblBlocked.text=[MCLocalization stringForKey:@"You have been Blocked By the ADMIN of CupidLove.Please Contact Admin for Unblocked."];
    
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.vwContact setTransform:CGAffineTransformMakeScale(-1, 1)];
        [self.lblContactUs setTransform:CGAffineTransformMakeScale(-1, 1)];
        self.lblContactUs.textAlignment = NSTextAlignmentRight ;
    }
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
    self.vwTitle.hidden = NO;

}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self localize];
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;
}


#pragma mark - btnClicked
/*!
 * @discussion Open Menu
 * @param sender For indetifying sender
 */
- (IBAction)btnMenuClicked:(id)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];
    
}

/*!
 * @discussion Called when user clicked "contact us" amd Open mail for contacting
 * @param sender For indetifying sender
 */
- (IBAction)btnContactUsClicked:(id)sender
{
    NSString *emailTitle = @"Blocked Report";
    // Email Content
    NSString *messageBody = @"Application for UnBlock User";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"ContactUs@CupidLove.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    if ([MFMailComposeViewController canSendMail]) {
        //Place your code here to create the controller and present
        [self presentViewController:mc animated:YES completion:NULL];
        
    }

}
#pragma mark - MFMailComposeViewControllerDelegate
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{

    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblTitle.text=[MCLocalization stringForKey:@"Blocked"];
    self.lblContactUs.text=[MCLocalization stringForKey:@"Contact Us"];
    
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        self.lblContactUs.frame = CGRectMake( 128 * SCREEN_SIZE.width/375, self.lblContactUs.frame.origin.y, self.lblContactUs.frame.size.width, self.lblContactUs.frame.size.height);
    }
}


@end
