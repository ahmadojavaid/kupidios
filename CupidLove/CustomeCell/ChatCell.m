//
//  ChatCell.m
//  CupidLove
//
//  Created by APPLE on 29/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell
@synthesize imgProfile=_imgProfile;
@synthesize nameLabel=_nameLabel;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.actProfilePic.color = Theme_Color;
   // self.lblUnReadCount = Theme_Color;
   if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
       [self.lblLastMsg setTransform:CGAffineTransformMakeScale(-1, 1)];
       [self.lblUnReadCount setTransform:CGAffineTransformMakeScale(-1, 1)];
       [self.nameLabel setTransform:CGAffineTransformMakeScale(-1, 1)];
       self.nameLabel.textAlignment = NSTextAlignmentRight;
       self.lblLastMsg.textAlignment = NSTextAlignmentRight;
       
   }
}
-(void) layoutSubviews{

    [super layoutSubviews];
    self.vwCounter.frame = CGRectMake(self.vwCounter.frame.origin.x, (self.frame.size.height- self.vwCounter.frame.size.height)/2, self.vwCounter.frame.size.height, self.vwCounter.frame.size.height);
    self.vwCounter.layer.borderColor = Theme_Color.CGColor;
    self.vwCounter.layer.borderWidth = 2.0;
    self.vwCounter.layer.cornerRadius = self.vwCounter.frame.size.height/2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
