//
//  SSOnlineOfflineFriends.h
//  SSXmpp
//
//  Created by Jitendra on 20/10/15.
//  Copyright (c) 2015 Jitendra. All rights reserved.
//

#import "SSXmppConstant.h"
@protocol SSOnlineOfflineFriendsDelegate <NSObject>
@optional
- (void)shouldReloadTable:(NSMutableArray*)data;
@end

@interface SSOnlineOfflineFriends : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) SSOnOfflineblock ssblock;
@property(nonatomic, assign) id <SSOnlineOfflineFriendsDelegate> delegate;
@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController1;
@property (nonatomic,strong) NSMutableArray *arrOnLineUsers;
+ (SSOnlineOfflineFriends *)shareInstance;
- (void)setSSOnlineOfflineFriendsDelegate;
- (void)fetchedResultsControllerOnlineOfflineFriends;

@end
