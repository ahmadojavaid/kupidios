//
//  AppDelegate.h
//  CupidLove
//
//  Created by APPLE on 10/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcomeVC.h"
#import <Photos/Photos.h>
#import <MapKit/MapKit.h>
#import <UserNotifications/UserNotifications.h>

#include <GoogleMapsBase/GoogleMapsBase.h>
#include <GooglePlaces/GooglePlaces.h>
@import GoogleMapsBase;
@import GooglePlaces;

#import <GoogleMobileAds/GoogleMobileAds.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nav;

//for images selection
@property (strong,nonatomic) NSMutableArray *selectedImagesAssets,*arrChats;
@property (strong,nonatomic) NSMutableArray *selectedImages;
@property (strong,nonatomic) NSString *flag_next;
@property (strong, nonatomic) NSString *editImage;
@property (strong, nonatomic) NSString *editImageName;
@property (strong, nonatomic) PHAsset *asset;
@property (strong, nonatomic) NSString *fbImage;
@property (strong, nonatomic) NSMutableArray *selectedFbImages,*selectedFbImagesIds;

//@property (strong, nonatomic) NSInteger loadedcards;
@property (strong, nonatomic) NSMutableArray *allUsersDetails;
@property (strong, nonatomic) NSMutableArray *loadedCards;
@property (strong, nonatomic) NSMutableArray *allCards;
@property (strong, nonatomic) NSMutableArray *LoaderImages;
@property (strong, nonatomic) NSString *strPageName;
@property (strong, nonatomic) NSString *isAppConfigurationSaved;
@property(nonatomic) NSInteger cardsLoadedIndex,indexAllcards,indexlazyload;

@property (strong, nonatomic) NSMutableDictionary *dictLastDraggedCardDetail;

-(AppDelegate*) appobj;
-(void)ChangeViewController;
-(void)SetData:(NSString *)strValue value:(NSString *)strKey;
-(NSString *)GetData:(NSString *)strKey;
-(void)RemoveData:(NSString *)strKey;




@end

