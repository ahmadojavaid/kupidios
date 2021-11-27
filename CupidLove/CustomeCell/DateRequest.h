//
//  DateRequest.h
//  CupidLove
//
//  Created by APPLE on 15/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateRequest : UITableViewCell
@property(weak,nonatomic) IBOutlet UIView *vwBoarder;
@property(weak,nonatomic) IBOutlet UIView *vwPlace;
@property(weak,nonatomic) IBOutlet UIButton *dateTime;
@property(weak,nonatomic) IBOutlet UIView *vw;
@property(weak,nonatomic) IBOutlet UIImageView *imgPlace;
@property(weak,nonatomic) IBOutlet UILabel *lblColor;
@property(weak,nonatomic) IBOutlet UILabel *lblTitle;
@property(weak,nonatomic) IBOutlet UILabel *lblDistance;
@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *act;
@property(weak,nonatomic) IBOutlet UILabel *lblTime;
@property(weak,nonatomic) IBOutlet UILabel *lblRequest;

@property(weak,nonatomic) IBOutlet UILabel *lblDateReq;
@end
