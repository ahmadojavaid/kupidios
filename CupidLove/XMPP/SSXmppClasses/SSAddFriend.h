//
//  SSAddFriend.h
//  SSXmpp
//
//  Created by Jitendra on 20/10/15.
//  Copyright (c) 2015 Jitendra. All rights reserved.
//

#import "SSXmppConstant.h"

@interface SSAddFriend : NSObject

@property (nonatomic, strong) SSAddFriendsblock ssblock;

+(SSAddFriend *)shareInstance;

-(void)addFriendWithJid:(NSString *)friendname complition:(SSAddFriendsblock)ssblock;
-(void)deleteFriendWithJid:(NSString *)friendname;

//added by vibhuti
-(void)addFriendWithJid:(NSString *)friendname nickname:(NSString *)nickname complition:(SSAddFriendsblock)ssblock;

@end
