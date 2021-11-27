//
//  ItsAMatchVC.h
//  CupidLove
//
//  Created by Umesh on 11/14/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@import GoogleMobileAds;
@class GADBannerView;
@interface ItsAMatchVC : UIViewController

@property (weak,nonatomic) IBOutlet UIImageView *img2;
@property (strong,nonatomic) NSString *strFid;
@property (strong,nonatomic) NSString *strFname;
@property (strong,nonatomic) NSString *strLname;
@property (strong,nonatomic) NSString *strImgUrl;
@property(strong,nonatomic) NSString *strJid;

@property(nonatomic, weak) IBOutlet GADBannerView *vwBannerView;
@end




