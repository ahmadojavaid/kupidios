//
//  SSSetUserVcard.h
//  SSXmpp
//
//  Created by Jitendra on 02/12/15.
//  Copyright © 2015 Jitendra. All rights reserved.
//

#import "SSXmppConstant.h"
#import "SSXmppBlocks.h"


@interface SSUserVcard : NSObject <XMPPvCardTempModuleDelegate>

@property (nonatomic, strong) SSUserVcardblock aSSUserVcardblock;

+(SSUserVcard *)shareInstance;
-(void)setVcardOfUser:(NSString *)username imageData:(NSData*)data complition:(SSUserVcardblock)ssblock;
-(void)getVcardOfUser:(SSUserVcardblock)ssblock;

@end
