//
//  CountryHelper.m
//  CupidLove
//
//  Created by potenza on 18/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "AdRemoveBlock.h"
#import "BlockedVC.h"
#import "RightMenuVC.h"
@implementation AdRemoveBlock
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
        self.timer=[NSTimer scheduledTimerWithTimeInterval:120.0f target:self selector:@selector(CheckBlockAndRemoveAds) userInfo:nil repeats:YES];
    }
}
#pragma mark - --------Stop Updating Token

-(void)StopUpdating
{
    [self.timer invalidate];
}
#pragma mark - --------Update Token

-(void)CheckBlockAndRemoveAds
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
                 NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,@"getblockstatus"];
                 [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                     HIDE_PROGRESS;
                    
                     if([dictionary count]>0)
                     {
                         if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                         {
                             if([[dictionary valueForKey:@"status"] intValue]==1){
                                 [appDelegate SetData:@"yes" value:kBlocked];
                                 RightMenuVC *Rightvc=[[RightMenuVC alloc]initWithNibName:@"RightMenuVC" bundle:nil];
                                 BlockedVC *vc=[[BlockedVC alloc]initWithNibName:@"BlockedVC" bundle:nil];
                                 self.nav=[[UINavigationController alloc]initWithRootViewController:vc];
                            //     [self.nav setNavigationBarHidden:YES animated:NO];
//                                 MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
//                                                                                 containerWithCenterViewController:self.nav
//                                                                                 leftMenuViewController:nil
//                                                                                 rightMenuViewController:Rightvc];
                                 MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController                                                                                  containerWithCenterViewController:self.nav leftMenuViewController:Rightvc rightMenuViewController:nil];
                                 container.panMode=MFSideMenuPanModeNone;
                                 appDelegate.window.rootViewController=container;
                                 [appDelegate.window makeKeyAndVisible];

                             }
                             else{
                                 [appDelegate SetData:@"no" value:kBlocked];
                             }
                             if([[dictionary valueForKey:@"all_account_ad"] intValue]==0)
                             {
                                 [appDelegate SetData:@"yes" value:kAddsRemoved];
                             }
                             else{
                                 if([[dictionary valueForKey:@"user_add"] intValue]==0)
                                 {
                                     [appDelegate SetData:@"yes" value:kAddsRemoved];
                                 }
                                 else{
                                     
                                     [appDelegate SetData:@"no" value:kAddsRemoved];
                                 }
                             }
                            
                         }
                     }
                 }];

             }
         }];
        

    }


}


@end
