//
//  ProfileDetails.h
//  CupidLove
//
//  Created by APPLE on 19/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileView.h"


@interface ProfileDetails : NSObject 


+ (instancetype)sharedInstance;

-(void)loadCards:(UIView*) parentVC : (NSInteger) index :(UIView*) mutualFriend :(UIView*) bgMutualFriend;


@end
