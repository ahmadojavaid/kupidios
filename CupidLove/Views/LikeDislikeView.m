//
//  LikeDislikeView.m
//  CupidLove
//
//  Created by APPLE on 06/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "LikeDislikeView.h"

@implementation LikeDislikeView

@synthesize imageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DisLikeIcon"]];
        [self addSubview:imageView];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = CGRectMake(50, 160, 100, 100);
}

/*!
 * @discussion Set overlay mode
 * @param mode Mode to be set to overlay
 */
-(void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) {
        return;
    }
    _mode = mode;
    
    if(mode == GGOverlayViewModeLeft) {
        imageView.image = [UIImage imageNamed:@"DisLikeIcon"];
    } else if(mode == GGOverlayViewModeRight) {
        imageView.image = [UIImage imageNamed:@"LikeIcon"];
    } else if(mode == GGOverlayViewModeTop) {
        imageView.image = [UIImage imageNamed:@"SuperLikeIcon"];
    }
}
@end
