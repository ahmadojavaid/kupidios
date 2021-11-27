//
//  ApiManager.h
//  CupidLove
//
//  Created by APPLE on 06/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ApiManager : NSObject

typedef void (^DictionaryResponse) (BOOL success, NSString *message, NSDictionary *dictionary);
typedef void (^CompletionBlock) (BOOL responseObject);

#pragma mark create instance of file

+ (instancetype)sharedInstance;

#pragma mark Check Internet Connection

- (void)CheckReachibilty :(CompletionBlock)completionBlock;

#pragma mark append string with url


+ (NSString *)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary;

#pragma mark Replace % from string

+ (NSString *)urlEscapeString:(NSString *)unencodedString;

#pragma mark - api calls
-(void)apiCallWithPost:(NSString *)_urlString parameterDict:(NSDictionary *)_parameterDict  CompletionBlock :(DictionaryResponse) completionBlock;
-(void)apiCall:(NSString *)urlString postDictionary:(NSDictionary *)postDictionary CompletionBlock:(DictionaryResponse) completionBlock;
-(void)apiCallWithImage:(NSString *)_urlString parameterDict:(NSDictionary *)_parameterDict imageDataDictionary:(NSDictionary *)_imageDatadictionary CompletionBlock :(DictionaryResponse) completionBlock;


-(void)RegisterLoginXMPP;


@end
