//
//  ImageCell1.m
//  CupidLove
//
//  Created by APPLE on 22/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "ImageCell1.h"

@implementation ImageCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.act.color = Theme_Color;
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.selectionLabel setTransform:CGAffineTransformMakeScale(-1, 1)];
    }
}

@end
