//
//  Ragistraion.h
//  SSXmpp
//
//  Created by Jitendra on 17/10/15.
//  Copyright (c) 2015 Jitendra. All rights reserved.
//


#import "SSXmppConstant.h"

@interface SSRagistraion : NSObject

@property (nonatomic, strong) SSRegistrationblock aSSRegistrationblock;
@property (nonatomic, strong) SSUnRegistrationblock aSSUnRegistrationblock;
+(SSRagistraion *)shareInstance;

-(void)registration:(NSString*)username complition:(SSRegistrationblock)ssblock;
-(void)Unregistration:(NSString*)username complition:(SSUnRegistrationblock)ssblock;
@end
