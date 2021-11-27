//
//  ApiManager.m
//  CupidLove
//
//  Created by APPLE on 06/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "ApiManager.h"
#import "Util.h"

@implementation ApiManager

#pragma mark
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

#pragma mark
#pragma mark Check Internet Connection

- (void)CheckReachibilty :(CompletionBlock)completionBlock
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        
        if ([AFStringFromNetworkReachabilityStatus(status) isEqualToString:@"Not Reachable"]) {
            completionBlock (false);
        }
        else {
            completionBlock (true);
        }
        
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
}

#pragma mark
#pragma mark append string with url


+ (NSString *)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary  {
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:urlString];
    
    for (id key in dictionary) {
        NSString *keyString = [key description];
        NSString *valueString = [[dictionary objectForKey:key] description];
        
        if ([urlWithQuerystring rangeOfString:@"?"].location == NSNotFound) {
            
            [urlWithQuerystring appendFormat:@"?%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        }
        else {
            [urlWithQuerystring appendFormat:@"&%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        }
    }
    return urlWithQuerystring;
}

#pragma mark
#pragma mark Replace % from string

+ (NSString *)urlEscapeString:(NSString *)unencodedString {
    
    CFStringRef originalStringRef = (__bridge_retained CFStringRef)unencodedString;
    NSString *ss=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, originalStringRef, NULL);
    CFRelease(originalStringRef);
    return ss;
    
}


#pragma mark
#pragma mark Api call
-(void)apiCallWithPost:(NSString *)_urlString parameterDict:(NSDictionary *)_parameterDict  CompletionBlock :(DictionaryResponse) completionBlock
{
    NSMutableDictionary *dictParam=[_parameterDict mutableCopy];
    if ((![[appDelegate GetData:kauthToken] isEqualToString:@"Key Not Found"]) &&  (![[appDelegate GetData:kauthToken] isEqualToString:@""]))
    {
        [dictParam setValue:[appDelegate GetData:kauthToken] forKey:@"AuthToken"];
        NSLog(@"AuthToken:-%@",[appDelegate GetData:kauthToken]);
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:_urlString parameters:dictParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
    } error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        HIDE_ACTIVITE_INDICATOR;
        if (error) {
            
            NSLog(@"Error: %@", error.localizedDescription);
            completionBlock(false, error.localizedDescription,nil);
            
        } else {
            //clear all data and logout
            
            NSDictionary *tempDict=[Util cleanJsonToObject:responseObject];
            
            if([[tempDict valueForKey:@"error"] intValue]==1 && [[tempDict valueForKey:@"error_code"] intValue]==101 && [[tempDict valueForKey:@"message"] isEqualToString:@"session expired"]){
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self Logout];
                });
                //session expired--logout
                ALERTVIEW([MCLocalization stringForKey:@"Your session is expired!! Please login again!!"], appDelegate.window.rootViewController);
                
                
            }
            
            completionBlock(true, @"Api Response",[Util cleanJsonToObject:responseObject]);
        }
    }];
    [dataTask resume];
    
    
}
-(void)apiCall:(NSString *)urlString postDictionary:(NSDictionary *)postDictionary CompletionBlock:(DictionaryResponse) completionBlock {
    
    // SHOW_ACTIVITE_INDICATOR;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *newstring = [ApiManager addQueryStringToUrlString:urlString withDictionary:postDictionary];
    
    //  NSString *string = [newstring stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *string = [newstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        HIDE_ACTIVITE_INDICATOR;
        if (error) {
            
            NSLog(@"Error: %@", error.localizedDescription);
            completionBlock(false, error.localizedDescription,nil);
            
        } else {
            
            completionBlock(true, @"Api Response",[Util cleanJsonToObject:responseObject]);
        }
    }];
    [dataTask resume];
    
}


#pragma mark
#pragma mark Multipart Request


-(void)apiCallWithImage:(NSString *)_urlString parameterDict:(NSDictionary *)_parameterDict imageDataDictionary:(NSDictionary *)_imageDatadictionary CompletionBlock :(DictionaryResponse) completionBlock
{
    
    //SHOW_ACTIVITE_INDICATOR;
    MRProgressOverlayView *hud;
    if (_imageDatadictionary.count>0)
    {
        //  hud         = [MRProgressOverlayView showOverlayAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
        //  hud.mode    = MRProgressOverlayViewModeDeterminateHorizontalBar;
        // hud.titleLabelText =[MCLocalization stringForKey: @"Uploading.."];
        
    }
    else
    {
        
    }
    
    
    NSMutableDictionary *dictParam=[_parameterDict mutableCopy];
    if ((![[appDelegate GetData:kauthToken] isEqualToString:@"Key Not Found"]) &&  (![[appDelegate GetData:kauthToken] isEqualToString:@""]))
    {
        [dictParam setValue:[appDelegate GetData:kauthToken] forKey:@"AuthToken"];
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:_urlString parameters:dictParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString* key in _imageDatadictionary){
            NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            
            //-(NSString *) randomStringWithLength: (int) len {
            
            NSMutableString *randomString = [NSMutableString stringWithCapacity: 10];
            
            for (int i=0; i<10; i++) {
                [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
            }
            
            
            //  return randomString;
            // }
            NSString *fileName1 = [NSString stringWithFormat:@"%@%@.jpg",randomString,key];
            [formData appendPartWithFileData:[_imageDatadictionary objectForKey:key] name:key fileName:fileName1 mimeType:@"image/jpeg"];
            
        }
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          
                          [hud setProgress:uploadProgress.fractionCompleted animated:YES];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                      HIDE_ACTIVITE_INDICATOR;
                      [MRProgressOverlayView dismissOverlayForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
                      
                      if (error) {
                          
                          NSLog(@"Error: %@", error.localizedDescription);
                          completionBlock(false, error.localizedDescription,nil);
                          
                      } else {
                          
                          completionBlock(true, @"Api Response",[Util cleanJsonToObject:responseObject]);
                      }
                  }];
    [uploadTask resume];
}
#pragma mark
#pragma mark
#pragma mark
#pragma mark ApiCallingWays


-(void)RegisterLoginXMPP
{
    
    BOOL i = true;
    if (i) {
        return;
    }
    //   NSString *strUserName=[NSString stringWithFormat:@"%@_%@",[appDelegate GetData:kuserid],[[appDelegate GetData:kUserName] lowercaseString]];
    NSString *strUserName=[appDelegate GetData:kejID];
    
    NSLog(@"%@",[appDelegate GetData:kXMPPEnabled]);
    
    
    if ([[appDelegate GetData:kXMPPEnabled] isEqualToString:@"true"])
    {
        if ([[appDelegate GetData:kXmppUserRegister] isEqualToString:@"yes"])
        {
            [[SSLogin shareInstance]login:strUserName complition:^(NSDictionary *result) {
                
                if ([[result valueForKey:@"status"] isEqualToString:@"Success"])
                {
                    NSLog(@"Login Successfully");
                }
                else if ([[result valueForKey:@"message"] isEqualToString:kUserLoginInvalid])
                {
                    [appDelegate SetData:@"no" value:kXmppUserRegister];
                    [self RegisterLoginXMPP];
                }
            }];
        }
        else
        {
            [[SSRagistraion shareInstance] registration:strUserName complition:^(NSDictionary *result)
             {
                 if ([[result valueForKey:@"status"] isEqualToString:@"Success"])
                 {
                     NSLog(@"Register Successfully");
                     [appDelegate SetData:@"yes" value:kXmppUserRegister];
                     [[SSLogin shareInstance]login:strUserName complition:^(NSDictionary *result) {
                         
                         if ([[result valueForKey:@"status"] isEqualToString:@"Success"])
                         {
                             NSLog(@"Login Successfully");
                         }
                     }];
                 }
                 else if ([[result valueForKey:@"message"] isEqualToString:kUserExist])
                 {
                     [appDelegate SetData:@"yes" value:kXmppUserRegister];
                     [[SSLogin shareInstance]login:strUserName complition:^(NSDictionary *result) {
                         
                         if ([[result valueForKey:@"status"] isEqualToString:@"Success"])
                         {
                             NSLog(@"Login Successfully");
                         }
                     }];
                     
                 }
                 else
                 {
                     [appDelegate SetData:@"no" value:kXmppUserRegister];
                 }
             }];
        }
    }
    
    
    
}

#pragma mark - Api Calls for logout

-(void)Logout
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         SHOW_LOADER_ANIMTION();
         //SHOW_PROGRESS([MCLocalization stringForKey:@"Please Wait.."]);
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], appDelegate.window.rootViewController);
             return ;
         }
         else {
             NSString *str=@"session_expired";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kdeviceToken] forKey:@"device_token"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 HIDE_PROGRESS;
                 
                 //                 if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                 //                 {
                 [[SSConnectionClasses shareInstance] disconnect];
                 [appDelegate RemoveData:kauthToken];
                 [appDelegate.selectedImages removeAllObjects];
                 appDelegate.flag_next=@"";
                 [appDelegate RemoveData:kimg1];
                 [appDelegate RemoveData:kimg2];
                 [appDelegate RemoveData:kimg3];
                 [appDelegate RemoveData:kimg4];
                 [appDelegate RemoveData:kimg5];
                 [appDelegate RemoveData:kimg6];
                 [appDelegate RemoveData:kuserid];
                 [appDelegate RemoveData:kdatePref];
                 [appDelegate RemoveData:kgenderPref];
                 [appDelegate RemoveData:kminAgePref];
                 [appDelegate RemoveData:kmaxAgePref];
                 [appDelegate RemoveData:kMinDistance];
                 [appDelegate RemoveData:kmaxDistance];
                 [appDelegate RemoveData:kabout];
                 [appDelegate RemoveData:kuserid];
                 [appDelegate RemoveData:kLname];
                 [appDelegate RemoveData:kUserName];
                 [appDelegate RemoveData:klatitude];
                 [appDelegate RemoveData:klongitude];
                 [appDelegate RemoveData:kprofileimage];
                 [appDelegate RemoveData:kheight];
                 [appDelegate RemoveData:kreligion];
                 [appDelegate RemoveData:kethnicity];
                 [appDelegate RemoveData:kno_of_kids];
                 [appDelegate RemoveData:kquestionID];
                 [appDelegate RemoveData:kanswer];
                 [appDelegate RemoveData:kBlocked];
                 
                 [appDelegate RemoveData:kejID];
                 
                 [appDelegate RemoveData:kinstaAuth];
                 [appDelegate SetData:@"no" value:kAddsRemoved];
                 NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                 for (NSHTTPCookie *each in cookieStorage.cookies) {
                     [cookieStorage deleteCookie:each];
                 }
                 
                 [FBSDKAccessToken setCurrentAccessToken:nil];
                 [FBSDKProfile setCurrentProfile:nil];
                 
                 
                 
                 [appDelegate RemoveData:kXmppUserLogin];
                 [appDelegate RemoveData:kXmppUserRegister];
                 //TODO: testing
                 [SSConnectionClasses shareInstance].totalUnReadMsgcount = 0;
                 [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
                 
                 WelcomeVC *VC = [[WelcomeVC alloc] initWithNibName:@"WelcomeVC" bundle:nil];
                 UINavigationController *navigationController = appDelegate.window.rootViewController.menuContainerViewController.centerViewController;
                 NSArray *controllers = [NSArray arrayWithObject:VC];
                 navigationController.viewControllers = controllers;
                 [navigationController setNavigationBarHidden:YES animated:NO];
                 [appDelegate.window.rootViewController.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                 
                 //                 }
                 //                 else
                 //                 {
                 //                     ALERTVIEW([dictionary valueForKey:@"message"], appDelegate.window.rootViewController);
                 //                 }
                 
             }];
         }
     }];
}


@end
