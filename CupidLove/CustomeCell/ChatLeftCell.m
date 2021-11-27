//
//  ChatLeftCell.m
//  CupidLove
//
//  Created by potenza on 08/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "ChatLeftCell.h"

@implementation ChatLeftCell
@synthesize lblMessage = lblMessage;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lblTime.textColor = Theme_Color;
    self.vwBoarder.layer.cornerRadius=5.0;
    self.vwBoarder.layer.masksToBounds = YES;
    UIColor *border=Theme_Color;
    self.vwBoarder.layer.borderColor=border.CGColor;
    [self.vwBoarder.layer setBorderWidth: 5.0];

    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.lblTime setTransform:CGAffineTransformMakeScale(-1, 1)];
        [self.lblMessage setTransform:CGAffineTransformMakeScale(-1, 1)];
        self.lblTime.textAlignment = NSTextAlignmentRight;
        self.lblMessage.textAlignment = NSTextAlignmentRight;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
