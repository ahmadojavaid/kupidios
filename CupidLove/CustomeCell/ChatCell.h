//
//  ChatCell.h
//  CupidLove
//
//  Created by APPLE on 29/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *actProfilePic;
@property (weak,nonatomic) IBOutlet UIImageView *imgProfile;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *lblLastMsg;
@property (nonatomic, weak) IBOutlet UILabel *lblUnReadCount;
@property (weak,nonatomic) IBOutlet UIView *vwCounter;
@property (weak,nonatomic) IBOutlet UIView *vwOnlineOffline;

@end
