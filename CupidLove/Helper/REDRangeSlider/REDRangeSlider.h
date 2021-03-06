//
//  REDRangeSlider.h
//
//
//  Created by Red Davis on 24/10/2012.
//  Copyright (c) 2013 Red Davis. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface REDRangeSlider : UIControl

@property (assign, nonatomic) NSInteger minValue;
@property (assign, nonatomic) NSInteger maxValue;
@property (assign, nonatomic) NSInteger leftValue;
@property (assign, nonatomic) NSInteger rightValue;

@property (strong, nonatomic) UIImage *handleImage;
@property (strong, nonatomic) UIImage *leftHandleImage;
@property (strong, nonatomic) UIImage *rightHandleImage;

@property (strong, nonatomic) UIImage *handleHighlightedImage;
@property (strong, nonatomic) UIImage *leftHandleHighlightedImage;
@property (strong, nonatomic) UIImage *rightHandleHighlightedImage;

@property (strong, nonatomic) UIImage *trackBackgroundImage;
@property (strong, nonatomic) UIImage *trackFillImage;

@property (assign, nonatomic) CGFloat stepValue;
@property (assign, nonatomic) CGFloat minimumSpacing;

@property (assign, nonatomic) NSInteger leftOrigin;
@property (assign, nonatomic) NSInteger rightOrigin;

@property (strong, nonatomic) UIImageView *sliderFillBackground;


@end
