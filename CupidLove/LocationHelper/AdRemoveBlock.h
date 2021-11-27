//
//  CountryHelper.h
//  CupidLove
//
//  Created by potenza on 18/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdRemoveBlock : NSObject

@property(strong,nonatomic) NSTimer *timer;
+ (instancetype)sharedInstance;
@property (strong, nonatomic) UINavigationController *nav;

#pragma mark Start Updating Token
-(void)StartUpdating;
#pragma mark Stop Updating Token
-(void)StopUpdating;
#pragma mark Updating Token
-(void)CheckBlockRemoveAds;


@end
