//
//  SSLastOnline.m
//  CupidLove
//
//  Created by potenza on 27/01/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "SSLastOnline.h"

@implementation SSLastOnline
+(SSLastOnline *)shareInstance
{
    static SSLastOnline * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SSLastOnline alloc] init];
    });
    return instance;
}

-(void)getLastOnline:(NSString *)Username getdata:(SSLastOnlineblock)ssblock
{
    _ssblock = ssblock;
    if([[Reachability sharedReachability] internetConnectionStatus]==NotReachable)
    {
        if (ssblock)
        {
            ssblock(SSResponce(kInternetAlertMessage,kFailed,@""));
        }
    }
    else
    {
        
        
        XMPPJID *touse= [XMPPJID jidWithString:Username];
        XMPPIQ *iq = [XMPPIQ iqWithType:@"get" to:touse];
        [iq addAttributeWithName:@"id" stringValue:@"last"];
        //[iq addAttributeWithName:@"from" stringValue:@"sumeet@app.kinkey.com.au"];
        [iq addAttributeWithName:@"from" stringValue:[[SSConnectionClasses shareInstance].xmppStream myJID].full];
        NSXMLElement *query = [NSXMLElement elementWithName:@"query"];
        [query addAttributeWithName:@"xmlns" stringValue:@"jabber:iq:last"];
        [iq addChild:query];
        
        [[[SSConnectionClasses shareInstance] xmppStream] removeDelegate:self delegateQueue:dispatch_get_main_queue()];
        [[[SSConnectionClasses shareInstance] xmppStream] addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [[SSConnectionClasses shareInstance].xmppStream sendElement:iq];
    }

}
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{

    NSError *errors = nil;
    NSDictionary *data = [XMLReader dictionaryForXMLString:iq.XMLString error:&errors];
    if (errors==nil)
    {

        
        
        if ([[[data valueForKey:@"iq"] valueForKey:@"id"] isEqualToString:@"last"])
        {
            
            
            if([[[[data valueForKey:@"iq"]valueForKey:@"error"]valueForKey:@"code"] isEqualToString:@"407"] || [[[[data valueForKey:@"iq"]valueForKey:@"error"]valueForKey:@"code"] isEqualToString:@"503"] || [[[[data valueForKey:@"iq"]valueForKey:@"error"]valueForKey:@"code"] isEqualToString:@"403"])
            {
                _ssblock(SSResponce(@"No Subscrition Found",kFailed,@""));
            }
            else
            {
                
                NSDictionary *LastseenDict=@{@"userId":[iq from].user,@"lastSeenSec":[[iq childElement] attributeStringValueForName:@"seconds"]};
                
                if(_ssblock)
                {
                    _ssblock(SSResponce(@"success",kSuccess,LastseenDict));
                }
            }
            
        }
        else
        {
            _ssblock(SSResponce(@"No able to get",kFailed,@""));
            
        }
        [[[SSConnectionClasses shareInstance] xmppStream] removeDelegate:self delegateQueue:dispatch_get_main_queue()];

        
        }



    return YES;
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(NSXMLElement *)error
{
    if(_ssblock)
    {
        _ssblock(SSResponce(@"No able to get",kFailed,@""));
    }
}

- (void)xmppStream:(XMPPStream *)sender didFailToSendIQ:(XMPPIQ *)iq error:(NSError *)error
{
    if(_ssblock)
    {
        _ssblock(SSResponce(@"No able to get",kFailed,@""));
    }
}




@end
