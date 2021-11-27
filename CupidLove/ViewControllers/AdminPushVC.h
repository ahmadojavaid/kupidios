//
//  AdminPushVC.h
//  CupidLove
//
//  Created by potenza on 24/03/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminPushVC : UIViewController
@property (strong,nonatomic) IBOutlet UIView *vwPopup;
@property (strong,nonatomic) IBOutlet UIView *vwPopupInner;
@property (strong,nonatomic) IBOutlet UIView *vwPopupBG;
@property (strong,nonatomic) IBOutlet UITextView *lblMessgae;
@property (strong,nonatomic) NSString *strMessage;
@property (strong,nonatomic) IBOutlet UIButton *btnOk;;
@end
