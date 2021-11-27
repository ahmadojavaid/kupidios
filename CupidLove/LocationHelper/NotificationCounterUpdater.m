//
//  CountryHelper.m
//  CupidLove
//
//  Created by potenza on 18/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "NotificationCounterUpdater.h"

@implementation NotificationCounterUpdater
{
    NSMutableArray *arrCountry,*arrRegion,*arrArea;
}
#pragma mark create instance of file

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        

    });
    return sharedInstance;
}

#pragma mark - --------Start Updating Token
-(void)StartUpdating
{
    if ([[appDelegate GetData:kuserid] isEqualToString:@"Key Not Found"])
    {
        
    }
    else
    {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:120.0f target:self selector:@selector(UpdateNotificationCounter) userInfo:nil repeats:YES];
    }
}
#pragma mark - --------Stop Updating Token

-(void)StopUpdating
{
    [self.timer invalidate];
}
#pragma mark - --------Update Token

-(void)UpdateNotificationCounter
{
    
    if ([[appDelegate GetData:kuserid] isEqualToString:@"Key Not Found"])
    {
        [self.timer invalidate];
    }
    else
    {
        
        [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
         {
             if (responseObject == false)
             {
                 
                 HIDE_PROGRESS;
                 return ;
             }
             else {
                 NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
                 
                 [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
                  [dict setValue:[NSString stringWithFormat:@"%ld",(long)[SSConnectionClasses shareInstance].totalUnReadMsgcount] forKey:@"counter"];
                 NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,@"updatenotification"];
                 [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                     HIDE_PROGRESS;
                     
                     if([dictionary count]>0)
                     {
                         if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                         {
                             //TODO: testing
                            // [UIApplication sharedApplication].applicationIconBadgeNumber = [SSConnectionClasses shareInstance].totalUnReadMsgcount;
                             [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                         }
                         else
                         {
                             ALERTVIEW([dictionary valueForKey:@"message"], appDelegate.window.rootViewController);
                         }
                     }
                 }];

             }
         }];
        

    }


}

-(NSURL *)EncodedURL:(NSString *)strURL
{

    return [NSURL URLWithString:[strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
}

@end
