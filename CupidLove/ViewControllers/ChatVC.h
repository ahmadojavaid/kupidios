//
//  ChatVC.h
//  CupidLove
//
//  Created by APPLE on 29/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;
@class GADBannerView;

@interface ChatVC : UIViewController <UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property(strong,nonatomic) NSString *strJid;

@property(nonatomic, weak) IBOutlet GADBannerView *vwBannerView;

@end
