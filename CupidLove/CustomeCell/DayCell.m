//
//  DayCell.m
//  CupidLove
//
//  Created by potenza on 27/01/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "DayCell.h"

@implementation DayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.vw.backgroundColor = Theme_Color;
    self.vw.layer.cornerRadius=self.vw.frame.size.height/2;
    self.vw.layer.masksToBounds = YES;

    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.lblDate setTransform:CGAffineTransformMakeScale(-1, 1)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
