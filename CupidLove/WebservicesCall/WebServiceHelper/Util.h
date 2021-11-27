//
//  Util.h
//  CupidLove
//
//  Created by APPLE on 06/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Util : NSObject

#pragma mark -emailValidation

+(BOOL)ValidateEmailString:(NSString *)str;

#pragma mark - showAlertview

+ (void)showalert:(NSString *)_msg onView:(UIViewController *)controlr;

#pragma mark removeNullFromDictionary

+(NSMutableDictionary*)removeNull:(NSMutableDictionary*)dictionary;

#pragma mark  -encode decode Image BAse64

+ (NSString *)encodeToBase64String:(UIImage *)image;
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

#pragma mark

+ (BOOL) checkIfSuccessResponse : (NSDictionary *) responseDict;

#pragma mark a
+(CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) addressStr;

+ (CGFloat)getLabelHeight:(UILabel*)label;

+ (id)cleanJsonToObject:(id)data;


+(UIColor*)colorWithHexString:(NSString*)hex;
+(NSURL *)EncodedURL:(NSString *)strURL;

+(void)ShowLoader;
+(void)hide;
+(void)ShowLoaderData:(UIViewController*)view;
+(void)hideData:(UIViewController*)view;

+(NSString *)GetXMPPHostName;
+(NSString *)GetXMPPPostfix;
+(NSString *)GetXMPPPassword;


@end
