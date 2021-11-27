//
//  LikeDislikeView.h
//  CupidLove
//
//  Created by APPLE on 06/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , GGOverlayViewMode) {
    GGOverlayViewModeLeft,
    GGOverlayViewModeRight,
    GGOverlayViewModeTop
};

@interface LikeDislikeView : UIView

@property (nonatomic) GGOverlayViewMode mode;
@property (nonatomic, strong) UIImageView *imageView;


@end
