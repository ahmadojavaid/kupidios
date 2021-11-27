//
//  DoChatVC.h
//  CupidLove
//
//  Created by APPLE on 29/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"

@interface DoChatVC : UIViewController <UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property (strong, nonatomic) CKCalendarView *viewController;
@property(strong,nonatomic) NSString *strComeFrom;
@property(strong,nonatomic) NSString *strOnlineOffline;
@property(strong,nonatomic) NSString *strid;
@property(strong,nonatomic) NSString *strJid;
@property(strong,nonatomic) NSString *strImgUrl;
@property(strong,nonatomic) NSString *strChatName;
@property(strong,nonatomic) NSString *strFriendId;
@property (nonatomic, retain) CLLocationManager *locationManager;

-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;

@end
