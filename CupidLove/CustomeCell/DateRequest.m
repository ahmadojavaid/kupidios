//
//  DateRequest.m
//  CupidLove
//
//  Created by APPLE on 15/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "DateRequest.h"
@implementation DateRequest

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.vwBoarder.layer.cornerRadius=5.0;
    self.vwBoarder.layer.masksToBounds = YES;
    UIColor *border=Theme_Color;
    self.vwBoarder.layer.borderColor=border.CGColor;
    [self.vwBoarder.layer setBorderWidth: 5.0];
    
    self.dateTime.layer.cornerRadius=3.0;
    self.dateTime.layer.masksToBounds=YES;
    self.lblTime.textColor = Theme_Color;
    
    self.vwPlace.layer.shadowOffset = CGSizeMake(5,5);
    self.vwPlace.layer.shadowRadius = 5;
    self.vwPlace.layer.shadowOpacity = 0.5;
    
    self.lblDateReq.text=[MCLocalization stringForKey:@"Date Request"];
    self.act.color = Theme_Color;
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.lblTime setTransform:CGAffineTransformMakeScale(-1, 1)];
        self.lblTime.textAlignment = NSTextAlignmentLeft;
        
        [self.lblRequest setTransform:CGAffineTransformMakeScale(-1, 1)];
        [self.lblDateReq setTransform:CGAffineTransformMakeScale(-1, 1)];
        [self.imgPlace setTransform:CGAffineTransformMakeScale(-1, 1)];
        [self.dateTime setTransform:CGAffineTransformMakeScale(-1, 1)];
        
        [self.lblTitle setTransform:CGAffineTransformMakeScale(-1, 1)];
        self.lblTitle.textAlignment = NSTextAlignmentRight;
        [self.lblDistance setTransform:CGAffineTransformMakeScale(-1, 1)];
        self.lblDistance.textAlignment = NSTextAlignmentRight;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
