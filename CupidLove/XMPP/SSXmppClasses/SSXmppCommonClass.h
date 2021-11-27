//
//  SSXmppCommonClass.h
//  SSXmpp
//
//  Created by Jitendra on 19/10/15.
//  Copyright (c) 2015 Jitendra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSXmppCommonClass : NSObject

+(SSXmppCommonClass *)shareInstance;

+(NSString *)removeSpacialCharecter:(NSString *)stringvalue;

@end
