//
//  NotificationCell.h
//  CupidLove
//
//  Created by APPLE on 14/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIButton *likeButton;
@property (nonatomic, weak) IBOutlet UIButton *dislikeButton;
@property (nonatomic, weak) IBOutlet UIImageView *profileImage;
@property (nonatomic, weak) IBOutlet UILabel *lblDistance;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *actProfilePic;

@property (weak, nonatomic) IBOutlet UIImageView *imgLike;
@property (weak, nonatomic) IBOutlet UIImageView *imgdislike;


//@property(nonatomic,strong) NSString * friendID;
@end
