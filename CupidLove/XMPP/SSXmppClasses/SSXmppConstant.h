//
//  SSXmppConstant.h
//  SSXmpp
//
//  Created by Jitendra on 17/10/15.
//  Copyright (c) 2015 Jitendra. All rights reserved.
//


// <!--change here-->
//#define HostName @"YOUR_SERVER" //Server
//#define Userpostfix @"YOUR_POSTFIX" //from server
//#define HostName @"13.59.86.207" //Server
//#define Userpostfix @"@ec2-13-59-86-207.us-east-2.compute.amazonaws.com" //from server

//#define HostName @"13.59.86.207" //Server
//#define Userpostfix @"@ec2-13-59-86-207.us-east-2.compute.amazonaws.com" //from server

#define HostPort 5222

#define UserJid                             @"UserJid"
#define Grouppostfix                        @"@ssxmpp.canopus-pc"
//#define UserPassword                        @"cupidlove2018"

#define kStatus                             @"status"
#define kMessage                            @"message"
#define kData                               @"data"

#define kSuccess                            @"Success"
#define kFailed                             @"Failed"
#define kInternetAlertMessage               @"Internet connection not available."
#define kServiceError                       @"Internal server error code \"500\"."

#define kUserExist                          @"This user already exist code \"409\"."
#define kUserRagistered                     @"User ragister successfully."
#define kUserNotRagistered                  @"User not ragister"
#define kUserUnRagistered                   @"User unragister successfully."
#define kUserLogin                          @"User login successfully."
#define kUserLoginInvalid                   @"Invalid username."

#define kAllUser                            @"Server all user"
#define kAllUserFailled                     @"Server all user request failed."

#define kUserFriend                         @"User friends"
#define kUserFriendNotFound                 @"User friend not found."
#define kUserFriendFailled                  @"User friend request failed."

#define kAddFriendSuccess                  @"User friend added successfully."
#define kAddFriendFailled                  @"User friend request failed."


#define SSResponce(Message,Status,data)     @{@"message":Message,@"status":Status,@"data":data}

#define ShowAlert(Title,Message,Target) [[[UIAlertView alloc] initWithTitle:Title message:Message delegate:Target cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "GCDAsyncSocket.h"
#import "XMPP.h"
#import "XMPPLogging.h"
#import "XMPPReconnect.h"
#import "XMPPCapabilitiesCoreDataStorage.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPvCardAvatarModule.h"
#import "XMPPvCardCoreDataStorage.h"
#import "XMPPStream.h"
#import "XMPPvCardTemp.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "XMPPRoomOccupant.h"
#import <CFNetwork/CFNetwork.h>
#import "XMPPMessageArchivingCoreDataStorage.h"
#import "XMPPLastActivity.h"
#import "Reachability.h"
#import "XMLReader.h"
#import "SSUserVcard.h"
#import "SSLogin.h"
#import "SSXmppBlocks.h"
#import "SSXmppCommonClass.h"
#import "SSConnectionClasses.h"
#import "XMPPAutoPing.h"
#import "SSRagistraion.h"
#import "SSAddFriend.h"
#import "SSOnlineOfflineFriends.h"
#import "SSMessageControl.h"
#import "SSLastOnline.h"
