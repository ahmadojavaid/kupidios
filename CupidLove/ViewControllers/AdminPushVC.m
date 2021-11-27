//
//  AdminPushVC.m
//  CupidLove
//
//  Created by potenza on 24/03/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "AdminPushVC.h"

@interface AdminPushVC ()

@property (strong, nonatomic) IBOutlet UILabel *lblMsg;
@end

@implementation AdminPushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.lblMessgae.textColor = Theme_Color;
    
    [self localize];
    self.lblMessgae.text = self.strMessage;
    self.vwPopupBG.hidden = YES;
    self.vwPopup.hidden = YES;
    self.vwPopupBG.alpha = 0.0;
    
    self.vwPopupInner.layer.cornerRadius = 5;
    self.vwPopupInner.layer.masksToBounds = YES;
    self.vwPopup.layer.cornerRadius = 5;
    self.vwPopup.layer.masksToBounds = YES;

    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HidePopUp)];
    [self.vwPopupBG addGestureRecognizer:tapRecognizer];
    
    
    self.vwPopupBG.hidden = NO;
    self.vwPopup.hidden = NO;
    self.vwPopup.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.4 animations:^{
        
        self.vwPopupBG.alpha = 0.75;
        self.vwPopup.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 * @discussion Called when okay clicked and hide pop-up
 * @param sender For identifing sender
 */
- (IBAction)btnOKClicked:(id)sender
{
    
    [self HidePopUp];
}


/*!
 * @discussion Hide pop-up of admin message
 */
-(void)HidePopUp
{
    self.vwPopup.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.vwPopup.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.vwPopupBG.alpha=0.0;
    } completion:^(BOOL finished){
        self.vwPopup.hidden = YES;
        self.vwPopupBG.hidden = YES;
        
        [self removeFromParentViewController];
        
    }];
    
}
#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblMsg.text=[MCLocalization stringForKey:@"Message From Admin"];
    
    [self.btnOk setTitle:[MCLocalization stringForKey:@"OK"] forState:UIControlStateNormal];
    
}
@end
