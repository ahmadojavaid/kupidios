//
//  FaceBookHelper.m
//  CupidLove
//
//  Created by potenza on 16/03/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "FaceBookHelper.h"

@implementation FaceBookHelper

/*!
 * @discussion Create shared Instance for FacebookHelper
 */
+(FaceBookHelper *)shareInstance
{
    static FaceBookHelper * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FaceBookHelper alloc] init];
    });
    return instance;
}

/*!
 * @discussion Initialization for permissions and Facebook details
 */
-(FaceBookHelper *)init
{

    self.arrPermissions=[[NSMutableArray alloc]initWithObjects:@"public_profile", @"email",   @"user_photos",@"email",@"user_location",@"user_birthday",@"user_hometown",@"user_about_me",@"user_education_history",@"user_work_history", nil];
    
    self.dictFbDetails=[[NSMutableDictionary alloc]init];
    return self;
}
/*!
 * @discussion Use for login with Facebook
 */
-(void)LoginWithFaceBook
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login setLoginBehavior:FBSDKLoginBehaviorWeb];
    [login logInWithReadPermissions: self.arrPermissions fromViewController:appDelegate.window.rootViewController handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            HIDE_PROGRESS;
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            HIDE_PROGRESS;
           
        } else {
            
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture, email, id,first_name, last_name, birthday, about ,location,education,work,interested_in, gender"}]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 
                 if (!error) {
                     
                     self.dictFbDetails=result;
                     if(_FacebookLogin)
                     {
                         _FacebookLogin(self.dictFbDetails);
                     }
                     
                     
                 }
             }];

        }
    }];

}

/*!
 * @discussion Get details from Facebook
 */
-(void)GetDetialsFromFacebook:(FaceBookLoginBlock)FacebookLogin
{
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture, email, id,first_name, last_name, birthday, about ,location,education,work,interested_in, gender"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             
             if (!error) {
                 
                 self.dictFbDetails=result;
                 if(_FacebookLogin)
                 {
                     _FacebookLogin(self.dictFbDetails);
                 }
                 
                 
             }
         }];
    }
    else
    {
        [self LoginWithFaceBook];
    }
 

}
@end
