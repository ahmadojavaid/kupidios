//
//  InAppPurchaseVC.m
//  CupidLove
//
//  Created by Kaushal PC on 02/07/18.
//  Copyright © 2018 Potenza. All rights reserved.
//

#import "InAppPurchaseVC.h"
#import "InAppInfoCell.h"
#import "IAPShare.h"
#import "RightMenuVC.h"
#import "FriendProfileVC.h"

@interface InAppPurchaseVC ()

@property (weak, nonatomic) IBOutlet UICollectionView *colInfoSlider;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property (weak, nonatomic) IBOutlet UIView *vwBottom;

@property (weak, nonatomic) IBOutlet UILabel *lblCupidPlus;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@property (weak, nonatomic) IBOutlet UIButton *btnNoThanks;

@end

@implementation InAppPurchaseVC {
    NSArray *_products;
}
@synthesize fromPage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self checkAvailableInAppPurchase];
    
    [self.colInfoSlider registerNib:[UINib nibWithNibName:@"InAppInfoCell" bundle:nil] forCellWithReuseIdentifier:@"InAppInfoCell"];
    
    [self localize];
}


-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.colInfoSlider reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Check for available InAppPurchases

-(void)checkAvailableInAppPurchase {
    _products = nil;
    SHOW_LOADER_ANIMTION2(self);
    
    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest* request,SKProductsResponse* response)
     {
         HIDE_PROGRESS2(self);
         if(response > 0 ) {

             NSMutableArray *arrproductData = [[NSMutableArray alloc] initWithArray:[IAPShare sharedHelper].iap.products];
             if ([[appDelegate GetData:kAddsRemoved] isEqualToString:@"yes"]) {
                 for (int i = 0; i < arrproductData.count; i++) {
                     SKProduct* product =[arrproductData objectAtIndex:i];
                     if ([product.productIdentifier isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]]) {
                         [arrproductData removeObjectAtIndex:i];
                         break;
                     }
                 }
             }
             if ([[appDelegate GetData:kChatSubscription] isEqualToString:@"yes"]) {
                 for (int i = 0; i < arrproductData.count; i++) {
                     SKProduct* product =[arrproductData objectAtIndex:i];
                     if ([product.productIdentifier isEqualToString:[appDelegate GetData:kChatSubscriptionInAppPurchase]]) {
                         [arrproductData removeObjectAtIndex:i];
                         break;
                     }
                 }
             }
             if ([[appDelegate GetData:kLocationService] isEqualToString:@"yes"]) {
                 for (int i = 0; i < arrproductData.count; i++) {
                     SKProduct* product =[arrproductData objectAtIndex:i];
                     if ([product.productIdentifier isEqualToString:[appDelegate GetData:kLocationInAppPurchase]]) {
                         [arrproductData removeObjectAtIndex:i];
                         break;
                     }
                 }
             }
             if ([[appDelegate GetData:kSuperLike] isEqualToString:@"yes"]) {
                 for (int i = 0; i < arrproductData.count; i++) {
                     SKProduct* product =[arrproductData objectAtIndex:i];
                     if ([product.productIdentifier isEqualToString:[appDelegate GetData:kSuperLikeInAppPurchase]]) {
                         [arrproductData removeObjectAtIndex:i];
                         break;
                     }
                 }
             }
             _products = arrproductData;
             int flag = 0;
             for(int i = 0; i < _products.count; i++)
             {
                 SKProduct* product =[_products objectAtIndex:i];
                 NSLog(@"Price: %@",[[IAPShare sharedHelper].iap getLocalePrice:product]);
                 NSLog(@"Title: %@",product.localizedTitle);
                 
                 // 1 remove ad
                 // 2 Chat
                 // 3 Location
                 // 4 Superlike
                 
                 flag = i;
                 if (fromPage == 1 && [product.productIdentifier isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]])
                 {
                     //Remove ad
                     self.lblTitle.text = product.localizedTitle;
                     self.lblDesc.text = product.localizedDescription;
                     self.lblPrice.text = [[IAPShare sharedHelper].iap getLocalePrice:product];
                     break;
                 }
                 else if (fromPage == 2 && [product.productIdentifier isEqualToString:[appDelegate GetData:kChatSubscriptionInAppPurchase]])
                 {
                     //Chat
                     self.lblTitle.text = product.localizedTitle;
                     self.lblDesc.text = product.localizedDescription;
                     self.lblPrice.text = [[IAPShare sharedHelper].iap getLocalePrice:product];
                     break;
                 }
                 else if (fromPage == 3 && [product.productIdentifier isEqualToString:[appDelegate GetData:kLocationInAppPurchase]])
                 {
                     //Location
                     self.lblTitle.text = product.localizedTitle;
                     self.lblDesc.text = product.localizedDescription;
                     self.lblPrice.text = [[IAPShare sharedHelper].iap getLocalePrice:product];
                     break;
                 }
                 else if (fromPage == 4 && [product.productIdentifier isEqualToString:[appDelegate GetData:kSuperLikeInAppPurchase]])
                 {
                     //superlike
                     self.lblTitle.text = product.localizedTitle;
                     self.lblDesc.text = product.localizedDescription;
                     self.lblPrice.text = [[IAPShare sharedHelper].iap getLocalePrice:product];
                     break;
                 }
             }
             [self.colInfoSlider reloadData];
             
             self.pageController.numberOfPages = _products.count;
             [self.colInfoSlider scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:flag inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
             self.pageController.currentPage = flag;
             
         } else {
             ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Try Again"], self);
         }
     }];
}

#pragma mark - Scroll View Delegates

//method to manage tab bar show and hide

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    if (scrollView.tag == 103)
    {
        //        if (scrollView.contentOffset.x >= (self.colInfoSlider.frame.size.width * (_products.count - 1)) + 50)
        //        {
        //            [self.colInfoSlider scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        //            self.pageController.currentPage = 0;
        //        }
        //        if (scrollView.contentOffset.x <= 0 - 50)
        //        {
        //            self.pageController.currentPage = _products.count - 1;
        //            [self.colInfoSlider scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.pageController.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        ////            [self.colInfoSlider setContentOffset:CGPointMake(self.pageController.currentPage * self.colInfoSlider.frame.size.width, 0.0) animated:YES];
        //        }
    }
}

-(void) setLabel {
    SKProduct* product =[_products objectAtIndex:self.pageController.currentPage];
    
    self.lblTitle.text = product.localizedTitle;
    self.lblDesc.text = product.localizedDescription;
    self.lblPrice.text = [[IAPShare sharedHelper].iap getLocalePrice:product];
    
    // 1 remove ad
    // 2 Chat
    // 3 Location
    // 4 Superlike
    if ([product.productIdentifier isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]]) {
        fromPage = 1;
    } else if ([product.productIdentifier isEqualToString:[appDelegate GetData:kChatSubscriptionInAppPurchase]]) {
        fromPage = 2;
    } else if ([product.productIdentifier isEqualToString:[appDelegate GetData:kLocationInAppPurchase]]) {
        fromPage = 3;
    } else if ([product.productIdentifier isEqualToString:[appDelegate GetData:kSuperLikeInAppPurchase]]) {
        fromPage = 4;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.colInfoSlider)
    {
        self.pageController.currentPage = floorf(scrollView.contentOffset.x/scrollView.frame.size.width);
        [self setLabel];
    }
}


#pragma mark - Button clicks

-(IBAction)btnCloseCLicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)btnContinueClicked:(id)sender {
    //In app purchase code
    
    if (_products.count == 0) {
        return;
    }
    //    _products = nil;
    //    SHOW_LOADER_ANIMTION2(self);
    //
    //    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest* request,SKProductsResponse* response)
    //     {
    //         HIDE_PROGRESS2(self);
    //         if(response > 0 ) {
    //
    //    NSString *strTitle = @"";
    //    NSString *strDesc = @"";
    //             for(int i = 0; i < [IAPShare sharedHelper].iap.products.count; i++)
    //             {
    //                 SKProduct* product =[_products objectAtIndex:i];
    //                 NSLog(@"Price: %@",[[IAPShare sharedHelper].iap getLocalePrice:product]);
    //                 NSLog(@"Title: %@",product.localizedTitle);
    //                 strTitle = product.localizedTitle;
    //
    //             }
    //             _products = [IAPShare sharedHelper].iap.products;
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:self.lblTitle.text
                                 message:self.lblDesc.text
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
                                             
                                             if (fromPage == 1 && [product.productIdentifier isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]])
                                             {
                                                 //Remove ad
                                                 [self purchase:product];
                                                 break;
                                             }
                                             else if (fromPage == 2 && [product.productIdentifier isEqualToString:[appDelegate GetData:kChatSubscriptionInAppPurchase]])
                                             {
                                                 //Chat
                                                 [self purchase:product];
                                                 break;
                                             }
                                             else if (fromPage == 3 && [product.productIdentifier isEqualToString:[appDelegate GetData:kLocationInAppPurchase]])
                                             {
                                                 //Location
                                                 [self purchase:product];
                                                 break;
                                             }
                                             else if (fromPage == 4 && [product.productIdentifier isEqualToString:[appDelegate GetData:kSuperLikeInAppPurchase]])
                                             {
                                                 //superlike
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
    //         }
    //     }];
}

#pragma mark - CollectionView Delegates

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _products.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *indenti=@"InAppInfoCell";
    
    InAppInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
    
    SKProduct* product =[_products objectAtIndex:indexPath.row];
    cell.lblTitle.text = product.localizedTitle;
    cell.lblDesc.text = product.localizedDescription;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*) collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *) indexPath
{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

#pragma mark - Purchase delegate methods

-(void)purchase:(SKProduct*)product
{
    SHOW_LOADER_ANIMTION2(self);
    
    [[IAPShare sharedHelper].iap buyProduct:product onCompletion:^(SKPaymentTransaction* trans){
        
        HIDE_PROGRESS2(self);
        if(trans.error)
        {
            NSLog(@"Fail %@",[trans.error localizedDescription]);
            ALERTVIEW([trans.error localizedDescription], self);
        }
        else if(trans.transactionState == SKPaymentTransactionStatePurchased)
        {
            NSLog(@"SUCCESS");
            if (fromPage == 1 && [trans.payment.productIdentifier isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]])
            {
                //Remove ad
                [appDelegate SetData:@"yes" value:kAddsRemoved];
                [self InAppPurchaseAPI:[appDelegate GetData:kRemoveAddInAppPurchase]];
            }
            else if (fromPage == 2 && [trans.payment.productIdentifier isEqualToString:[appDelegate GetData:kChatSubscriptionInAppPurchase]])
            {
                //Chat
                [appDelegate SetData:@"yes" value:kChatSubscription];
                [self InAppPurchaseAPI:[appDelegate GetData:kChatSubscriptionInAppPurchase]];
            }
            else if (fromPage == 3 && [trans.payment.productIdentifier isEqualToString:[appDelegate GetData:kLocationInAppPurchase]])
            {
                //Location
                [appDelegate SetData:@"yes" value:kLocationService];
                [self InAppPurchaseAPI:[appDelegate GetData:kLocationInAppPurchase]];
            }
            else if (fromPage == 4 && [trans.payment.productIdentifier isEqualToString:[appDelegate GetData:kSuperLikeInAppPurchase]])
            {
                //superlike
                //superlike api call
                [appDelegate SetData:@"yes" value:kSuperLike];
                [self InAppPurchaseAPI:[appDelegate GetData:kSuperLikeInAppPurchase]];
            }
        }
        else if(trans.transactionState == SKPaymentTransactionStateFailed)
        {
            NSLog(@"Fail");
            ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Try Again"], self);
        }
    }];
}

- (void)restoreTapped
{
    SHOW_LOADER_ANIMTION2(self);
    [[IAPShare sharedHelper].iap restoreProductsWithCompletion:^(SKPaymentQueue *payment, NSError *error) {
        HIDE_PROGRESS2(self);
        
        // number of restore count
        //        int numberOfTransactions = payment.transactions.count;
        for (SKPaymentTransaction *transaction in payment.transactions)
        {
            NSString *purchased = transaction.payment.productIdentifier;
            
            if (fromPage == 1 && [purchased isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]])
            {
                //Remove ad
                [appDelegate SetData:@"yes" value:kAddsRemoved];
                [self InAppPurchaseAPI:[appDelegate GetData:kRemoveAddInAppPurchase]];
                break;
            }
            else if (fromPage == 2 && [purchased isEqualToString:[appDelegate GetData:kChatSubscriptionInAppPurchase]])
            {
                //Chat
                [appDelegate SetData:@"yes" value:kChatSubscription];
                [self InAppPurchaseAPI:[appDelegate GetData:kChatSubscriptionInAppPurchase]];
                break;
            }
            else if (fromPage == 3 && [purchased isEqualToString:[appDelegate GetData:kLocationInAppPurchase]])
            {
                //Location
                [appDelegate SetData:@"yes" value:kLocationService];
                [self InAppPurchaseAPI:[appDelegate GetData:kLocationInAppPurchase]];
                break;
            }
            else if (fromPage == 4 && [purchased isEqualToString:[appDelegate GetData:kSuperLikeInAppPurchase]])
            {
                //superlike
                //superlike api call
                [appDelegate SetData:@"yes" value:kSuperLike];
                [self InAppPurchaseAPI:[appDelegate GetData:kSuperLikeInAppPurchase]];
                break;
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

//                     [self dismissViewControllerAnimated:YES completion:^{
//
//                     }];
                 }
                 else
                 {
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Try Again"], self);
                 }
             }];
         }
     }];
}

/*!
 * @discussion Webservice call for removeAd
 */
-(void)InAppPurchaseAPI:(NSString*)product
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         SHOW_LOADER_ANIMTION2(self);
         
         if (responseObject == false)
         {
             HIDE_PROGRESS2(self);
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"user_purchase";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             if ([product isEqualToString:[appDelegate GetData:kChatSubscriptionInAppPurchase]])
             {
                 [dict setValue:kPaidChat forKey:@"purchasekey"];
             }
             else if ([product isEqualToString:[appDelegate GetData:kLocationInAppPurchase]])
             {
                 [dict setValue:kPaidLocation forKey:@"purchasekey"];
             }
             else if ([product isEqualToString:[appDelegate GetData:kSuperLikeInAppPurchase]])
             {
                 [dict setValue:kPaidSuperLike forKey:@"purchasekey"];
             }
             else if ([product isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]])
             {
                 [dict setValue:kPaidAd forKey:@"purchasekey"];
             }

             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 HIDE_PROGRESS2(self);
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     //purchase done code
                     if ([product isEqualToString:[appDelegate GetData:kRemoveAddInAppPurchase]])
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
                     else
                     {
                         [self dismissViewControllerAnimated:YES completion:nil];
                     }
                 }
                 else
                 {
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
    self.lblCupidPlus.text = [MCLocalization stringForKey:@"Get CupidLove Plus"];
    [self.btnContinue setTitle:[MCLocalization stringForKey:@"CONTINUE"] forState:UIControlStateNormal];
    
    //create an underlined attributed string
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"NO THANKS"] attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
    
    //use the setAttributedTitle method
    [self.btnNoThanks setAttributedTitle:titleString forState:UIControlStateNormal];
}

@end
