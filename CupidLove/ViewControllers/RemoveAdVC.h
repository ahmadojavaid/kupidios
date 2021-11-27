//
//  RemoveAdVC.h
//  CupidLove
//
//  Created by APPLE on 22/02/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface RemoveAdVC : UIViewController

@property (strong, nonatomic) SKProduct *detailProduct;

- (IBAction)btnPurchaseProduct:(id)sender;

@end
