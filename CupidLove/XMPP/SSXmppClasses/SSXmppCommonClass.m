//
//  SSXmppCommonClass.m
//  SSXmpp
//
//  Created by Jitendra on 19/10/15.
//  Copyright (c) 2015 Jitendra. All rights reserved.
//

#import "SSXmppCommonClass.h"

@implementation SSXmppCommonClass

+(SSXmppCommonClass *)shareInstance
{
    static SSXmppCommonClass * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SSXmppCommonClass alloc] init];
    });
    return instance;
}

+(NSString *)removeSpacialCharecter:(NSString *)stringvalue
{
    NSArray *data = [stringvalue componentsSeparatedByString:@"@"];
    
    if([data count]==2)
    {
        
        NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"!@#$%^&*()_+* -'.,~ "];
        NSString *result = [[[data firstObject] componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
        return [NSString stringWithFormat:@"%@@%@",result,[data lastObject]];
    }
    else
    {
        NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"!@#$%^&*()_+* -'.,~ "];
        NSString *result = [[[data firstObject] componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
        return result;
    }
}

@end
