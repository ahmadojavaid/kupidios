//
//  PlaceSearchCell.m
//  CupidLove
//
//  Created by Umesh on 12/9/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import "PlaceSearchCell.h"

@implementation PlaceSearchCell

@synthesize img=_img;
@synthesize lblTitle=_lblTitle;
@synthesize lblDistance=_lblDistance;
@synthesize lblColor=_lblColor;
@synthesize act=_act;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.act.color = Theme_Color;
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
        [self.img setTransform:CGAffineTransformMakeScale(-1, 1)];
        
        [self.lblTitle setTransform:CGAffineTransformMakeScale(-1, 1)];
        [self.lblDistance setTransform:CGAffineTransformMakeScale(-1, 1)];
        self.lblTitle.textAlignment = NSTextAlignmentRight;
        self.lblDistance.textAlignment = NSTextAlignmentRight;
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
