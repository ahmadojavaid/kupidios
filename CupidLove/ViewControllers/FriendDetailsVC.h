//
//  FriendDetailsVC.h
//  CupidLove
//
//  Created by Umesh on 9/13/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;
@class GADBannerView;

@interface FriendDetailsVC : UIViewController

@property (nonatomic) NSDictionary *dictDetails;
@property (nonatomic) NSString *strFriendID;
@property(nonatomic, weak) IBOutlet GADBannerView *vwBannerView;
@end
