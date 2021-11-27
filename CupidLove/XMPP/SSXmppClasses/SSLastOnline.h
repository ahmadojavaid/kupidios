//
//  SSLastOnline.h
//  CupidLove
//
//  Created by potenza on 27/01/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSXmppConstant.h"


@interface SSLastOnline : NSObject
+(SSLastOnline *)shareInstance;
@property (nonatomic, strong) SSLastOnlineblock ssblock;

-(void)getLastOnline:(NSString *)Username getdata:(SSLastOnlineblock)ssblock;

@end
