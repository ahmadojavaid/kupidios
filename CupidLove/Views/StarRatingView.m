//
//  StarRatingView.m
//  CupidLove
//
//  Created by APPLE on 06/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "StarRatingView.h"
#define kLeftPadding 5.0f

@interface StarRatingView()
@property (nonatomic) int userRating;
@property (nonatomic) int maxrating;
@property (nonatomic) int rating;
@property (nonatomic) BOOL animated;
@property (nonatomic) float kLabelAllowance;
@property (nonatomic,strong) NSTimer* timer;
@property (nonatomic,strong) UILabel* label;
@property (nonatomic,strong) CALayer* tintLayer;

@end

@implementation StarRatingView
@synthesize timer;
@synthesize kLabelAllowance;
@synthesize tintLayer;
- (id)initWithFrame:(CGRect)frame andRating:(int)rating withLabel:(BOOL)label animated:(BOOL)animated
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        
        _maxrating = rating;
        self.animated = animated;
        
        
        if (label) {
            self.kLabelAllowance = 50.0f;
            self.label = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-kLabelAllowance , 0,kLabelAllowance, frame.size.height)];
            
            self.label.font = [UIFont systemFontOfSize:18.0f];
            self.label.text = [NSString stringWithFormat:@"%d%%",rating];
            self.label.textAlignment = NSTextAlignmentRight;
            self.label.textColor = [UIColor blackColor];
            self.label.backgroundColor = [UIColor clearColor];
            [self addSubview:self.label];
        }else{
            self.kLabelAllowance = 0.0f;
        }
        
        
        
        CGRect newrect = CGRectMake(0, 0, self.bounds.size.width-kLabelAllowance, self.bounds.size.height);
        
        
        CALayer* starBackground = [CALayer layer];
        starBackground.contents = (__bridge id)([UIImage imageNamed:@"5starsgray"].CGImage);
        starBackground.frame = newrect;
        [self.layer addSublayer:starBackground];
        
        tintLayer = [CALayer layer];
        tintLayer.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
        if (self.userRating >=20.0f) {
            [tintLayer setBackgroundColor:[UIColor yellowColor].CGColor];
        }else{
            [tintLayer setBackgroundColor:[UIColor yellowColor].CGColor];
        }
        
        [self.layer addSublayer:tintLayer];
        CALayer* starMask = [CALayer layer];
        starMask.contents = (__bridge id)([UIImage imageNamed:@"5starsgray"].CGImage);
        starMask.frame = newrect;
        [self.layer addSublayer:starMask];
        tintLayer.mask = starMask;
        
        
        if (self.animated) {
            _rating = 0;

            if (self.userRating < 20.0f) {
                [self.tintLayer setBackgroundColor:[UIColor yellowColor].CGColor];
                float barWitdhPercentage = (_maxrating/100.0f) *  (self.bounds.size.width-kLabelAllowance);
                self.tintLayer.frame = CGRectMake(0, 0, barWitdhPercentage, self.frame.size.height);
            }else{
                [self.tintLayer setBackgroundColor:[UIColor yellowColor].CGColor];
                float barWitdhPercentage = (_rating/100.0f) *  (self.bounds.size.width-kLabelAllowance);
                self.tintLayer.frame = CGRectMake(0, 0, barWitdhPercentage, self.frame.size.height);
            }

        }else{
            _rating = _maxrating;
           
        }
    }
    return self;
}

/*!
 * @discussion Increse star rating
 */
-(void)increaseRating
{
    
    if (_rating<_maxrating) {
        _rating = _rating + 1;
        if (self.label) {
            self.label.text = [NSString stringWithFormat:@"%d%%",self.rating];
        }
    }else{
        [timer invalidate];
    }
}
/*!
 * @discussion called after rating is changed
 */
-(void)ratingDidChange
{
    if (self.userRating < 20.0f) {
        [self.tintLayer setBackgroundColor:[UIColor yellowColor].CGColor];
        float barWitdhPercentage = (_maxrating/100.0f) *  (self.bounds.size.width-kLabelAllowance);
        self.tintLayer.frame = CGRectMake(0, 0, barWitdhPercentage, self.frame.size.height);
    }else{
        [self.tintLayer setBackgroundColor:[UIColor yellowColor].CGColor];
        float barWitdhPercentage = (_rating/100.0f) *  (self.bounds.size.width-kLabelAllowance);
        self.tintLayer.frame = CGRectMake(0, 0, barWitdhPercentage, self.frame.size.height);
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}


@end
