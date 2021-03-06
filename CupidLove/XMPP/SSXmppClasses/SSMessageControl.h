//
//  SSMessageControl.h
//  SSXmpp
//
//  Created by Jitendra on 02/11/15.
//  Copyright (c) 2015 Jitendra. All rights reserved.
//

#import "SSXmppConstant.h"

@protocol SSMessageDelegate <NSObject>
@optional
- (void)shouldReloadTable1:(NSMutableArray*)data;
- (void)chatStatus:(NSString*)status;
@end

@interface SSMessageControl : NSObject<NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSFetchedResultsController*fetchedResultsController;
@property(nonatomic, assign) id <SSMessageDelegate> delegate;
@property (nonatomic,strong) NSString * otherjid;
@property (nonatomic) int count;
+(SSMessageControl *)shareInstance;

- (void)setSSMessageDelegate;
- (void)sendMessage:(NSString *)messageString to:(NSString *)name;
- (void)fetchedObjectsController;
- (void)fetchedObjectsController:(int)limit offset:(int)offset;
- (void)sendActiveChatToUser;
- (void)sendInactiveChatToUser;

- (void)sendComposingChatToUser:(NSString *)jid;
- (void)sendPausedChatToUser:(NSString *)jid;
- (void)sendExitChatToUser;


@end
