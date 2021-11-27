//
//  NotificationCell.m
//  CupidLove
//
//  Created by APPLE on 14/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "NotificationCell.h"


@implementation NotificationCell
@synthesize nameLabel = _nameLabel;
@synthesize likeButton = _likeButton;
@synthesize profileImage = _profileImage;
@synthesize lblDistance = _lblDistance;
@synthesize dislikeButton = _dislikeButton;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.actProfilePic.color = Theme_Color;
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.lblDistance setTransform:CGAffineTransformMakeScale(-1, 1)];
        
        [self.nameLabel setTransform:CGAffineTransformMakeScale(-1, 1)];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        self.lblDistance.textAlignment = NSTextAlignmentRight;
        
    }
    
}
-(void) layoutSubviews{

    //make profile image round
    self.profileImage.layer.cornerRadius=(self.profileImage.frame.size.height/2);
    self.profileImage.layer.masksToBounds = YES;
    UIColor *border = [UIColor whiteColor];  //[UIColor colorWithRed:250/255.0 green:180/255.0 blue:53/255.0 alpha:1.0f];
    self.profileImage.layer.borderColor=border.CGColor;
    [self.profileImage.layer setBorderWidth: 2.0];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

