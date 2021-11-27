//
//  FriendProfileVC.h
//  CupidLove
//
//  Created by Umesh on 11/11/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileView.h"



@interface FriendProfileVC : UIViewController <mutualFriendsDelegate>

@property (retain,nonatomic)NSMutableArray* allCards; // the labels the cards
-(void)loadCards:(UIView*) parentVC : (NSInteger) index :(UIView*) mutualFriend :(UIView*) bgMutualFriend;
-(void)GetAllUserData1:(NSInteger) index;
@end



