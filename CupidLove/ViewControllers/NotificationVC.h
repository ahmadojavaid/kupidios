//
//  NotificationVC.h
//  CupidLove
//
//  Created by APPLE on 14/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;
@class GADBannerView;

@interface NotificationVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property(nonatomic, weak) IBOutlet GADBannerView *vwBannerView;

@end
