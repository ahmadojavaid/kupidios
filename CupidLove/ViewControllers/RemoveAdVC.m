//
//  RemoveAdVC.m
//  CupidLove
//
//  Created by APPLE on 22/02/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "RemoveAdVC.h"
#import "RightMenuVC.h"
#import "FriendProfileVC.h"
#import "IAPShare.h"


@interface RemoveAdVC ()
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnPurchase;
@property (strong, nonatomic) IBOutlet UILabel *lblInfo;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
@property (weak,nonatomic) IBOutlet UIView *vwMenu;

@property (weak,nonatomic) IBOutlet UIView *vwTitle;

@end

@implementation RemoveAdVC{
    NSArray *_products;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;
}
#pragma mark - Button Clicks
/*!
 * @discussion Opens Menu
 * @param sender For indetifying sender
 */
- (IBAction)btnMenuClicked:(id)sender {

    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];
}
/*!
 * @discussion Display option for remove advertisement 
 * @param sender For indetifying sender
 */
-(IBAction)btnPurchaseProduct:(id)sender
{
    _products = nil;
    SHOW_LOADER_ANIMTION();
    
    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest* request,SKProductsResponse* response)
     {
         HIDE_PROGRESS;
         if(response > 0 ) {
             
             for(int i = 0; i < [IAPShare sharedHelper].iap.products.count; i++)
             {
                 SKProduct* product =[[IAPShare sharedHelper].iap.products objectAtIndex:i];
                 NSLog(@"Price: %@",[[IAPShare sharedHelper].iap getLocalePrice:product]);
                 NSLog(@"Title: %@",product.localizedTitle);
             }
             _products = [IAPShare sharedHelper].iap.products;
             
             UIAlertController * alert = [UIAlertController
                                          alertControllerWithTitle:[MCLocalization stringForKey:@"InAppPurchase"]
                                          message:[MCLocalization stringForKey:@"Do you want to remove ads from application?"]
                                          preferredStyle:UIAlertControllerStyleAlert];

             //Add Buttons
             
             UIAlertAction* cancelButton = [UIAlertAction
                                            actionWithTitle:[MCLocalization stringForKey:@"Cancel"]
                                            style:UIAlertActionStyleDefault
                                            handler:nil];
             
             UIAlertAction* restoreButton = [UIAlertAction
                                             actionWithTitle:[MCLocalization stringForKey:@"Restore"]
                                             style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * action) {
                                                 //Handle your yes please button action here
                                                 [self restoreTapped];
                                             }];
             
             UIAlertAction* purchaseButton = [UIAlertAction
                                              actionWithTitle:[MCLocalization stringForKey:@"Purchase"]
                                              style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction * action) {
                                                  //Handle no, thanks button
                                                  for (int i = 0; i < _products.count; i++) {
                                                      SKProduct *product = _products[i];
                                                      if ([product.productIdentifier isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]])
                                                      {
                                                          [self purchase:product];
                                                          break;
                                                      }
                                                  }
                                              }];
             
             //Add your buttons to alert controller
             
             [alert addAction:purchaseButton];
             [alert addAction:restoreButton];
             [alert addAction:cancelButton];
             
             [self presentViewController:alert animated:YES completion:nil];
         }
     }];
    HIDE_PROGRESS;
    
}

-(void)purchase:(SKProduct*)product
{
    SHOW_LOADER_ANIMTION();
    
    [[IAPShare sharedHelper].iap buyProduct:product onCompletion:^(SKPaymentTransaction* trans){
        
        HIDE_PROGRESS;
        if(trans.error)
        {
            NSLog(@"Fail %@",[trans.error localizedDescription]);
        }
        else if(trans.transactionState == SKPaymentTransactionStatePurchased)
        {
            NSLog(@"SUCCESS");
            
            [self AddRemoved];
            [appDelegate SetData:@"yes" value:kAddsRemoved];
            HIDE_PROGRESS;
        }
        else if(trans.transactionState == SKPaymentTransactionStateFailed)
        {
            NSLog(@"Fail");
        }
    }];
}

- (void)restoreTapped
{
    SHOW_LOADER_ANIMTION();
    [[IAPShare sharedHelper].iap restoreProductsWithCompletion:^(SKPaymentQueue *payment, NSError *error) {
        HIDE_PROGRESS;
        
        // number of restore count
        // int numberOfTransactions = payment.transactions.count;
        for (SKPaymentTransaction *transaction in payment.transactions)
        {
            NSString *purchased = transaction.payment.productIdentifier;
            if([purchased isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]])
            {
                //enable the prodcut here
                HIDE_PROGRESS;

                [self AddRemoved];
                [appDelegate SetData:@"yes" value:kAddsRemoved];
            }
        }
    }];
}

#pragma mark - Api Calls
/*!
 * @discussion Webservice call for removeAd 
 */
-(void)AddRemoved
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
             NSString *str=@"enableadd";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:@"0" forKey:@"enableadd"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     [appDelegate SetData:[NSString stringWithFormat:@"1"] value:kSelecttion];
                     RightMenuVC *Rightvc=[[RightMenuVC alloc]initWithNibName:@"RightMenuVC" bundle:nil];
                     FriendProfileVC *vc=[[FriendProfileVC alloc]initWithNibName:@"FriendProfileVC" bundle:nil];
                     appDelegate.nav=[[UINavigationController alloc]initWithRootViewController:vc];
                
                     [appDelegate.nav setNavigationBarHidden:NO animated:NO];

                     MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController                                                                                  containerWithCenterViewController:appDelegate.nav leftMenuViewController:Rightvc rightMenuViewController:nil];
                     
                     container.panMode=MFSideMenuPanModeNone;
                     
                     
                     appDelegate.window.rootViewController=container;
                     [appDelegate.window makeKeyAndVisible];;

                 }
                 else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Try Again"], self);
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
    self.lblTitle.text=[MCLocalization stringForKey:@"Remove Ads"];
    
    self.lblInfo.text=[MCLocalization stringForKey:@"All Ads will be removed from your application."];
    
    [self.btnPurchase setTitle:[MCLocalization stringForKey:@"Purchase"] forState:UIControlStateNormal];
    
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;

}

@end
