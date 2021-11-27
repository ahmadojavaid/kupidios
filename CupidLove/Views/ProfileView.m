//
//  ProfileView.m
//  CupidLove
//
//  Created by APPLE on 06/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#define ACTION_MARGIN 120 // distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 // how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 // upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 // the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 // strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8

#import "ProfileView.h"
#import "FriendProfileVC.h"
#import "QuartzCore/QuartzCore.h"
#import "InAppPurchaseVC.h"

@interface ProfileView()

@property UIButton *btnReportUser;
@property UIImageView *imgReportUser;
@property UIImageView *imgDistanceLogo;
@property UIImageView *imgCollegeLogo;
@property UIImageView *imgDegreeLogo;
@property UIView *mutualFriends;
@property UIImageView *img;

@end

@implementation ProfileView {
    CGFloat xFromCenter;
    CGFloat yFromCenter;
}

@synthesize panGestureRecognizer;
@synthesize singleTapGestureRecognizer;
@synthesize lblConutMutualFriends;
@synthesize overlayView;
@synthesize scrl;
@synthesize name;
@synthesize distance;
@synthesize education;
@synthesize profession;
@synthesize page;
@synthesize btnMutualFriend;

@synthesize btnUp;
@synthesize btnDown;
@synthesize btnDetails;
@synthesize vwInfo;
@synthesize imgUpTap;
@synthesize imgDownTap;
@synthesize imgInfoTap;
@synthesize lblUpText;
@synthesize lblDownText;
@synthesize lblUp;
@synthesize lblDown;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        //report user button
        self.btnReportUser=[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-40*SCREEN_SIZE.width/375, 4*SCREEN_SIZE.height/667, 32*SCREEN_SIZE.width/375, 32*SCREEN_SIZE.width/375)];
        self.imgReportUser=[[UIImageView alloc] initWithFrame:self.btnReportUser.frame];
        self.imgReportUser.image=[UIImage imageNamed:@"3Dots"];
        self.imgReportUser.contentMode=UIViewContentModeScaleAspectFit;
        
        [self.btnReportUser addTarget:self action:@selector(btnReportUserClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.btnReportUser.clipsToBounds=YES;
        
        
        // ui designing
      self.img=[[UIImageView alloc]init];
      // img.frame=CGRectMake(-40*SCREEN_SIZE.width/375,0,self.frame.size.width+80*SCREEN_SIZE.width/375, self.frame.size.height+82*SCREEN_SIZE.height/812);
    

        self.img.frame=CGRectMake(-33*SCREEN_SIZE.width/375,-25,self.frame.size.width+65*SCREEN_SIZE.width/375, self.frame.size.height+85*SCREEN_SIZE.height/812);
        self.img.image = [UIImage imageNamed:@"FriendProfileBackGround"];
     
        [self addSubview:self.img];
        self.img.contentMode=UIViewContentModeScaleToFill;

        //image slider
        scrl=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 100)];
        scrl.contentSize=CGSizeMake(self.frame.size.width, scrl.frame.size.height * [self.images count]);
        scrl.pagingEnabled=YES;
        scrl.delegate=self;
        scrl.showsVerticalScrollIndicator = NO;
        scrl.bounces=NO;
        scrl.backgroundColor=[UIColor clearColor];
        scrl.userInteractionEnabled = NO;
        [self addSubview:scrl];
        
//        page=[[HHPageView alloc]initWithFrame:CGRectMake(scrl.frame.size.width-20,0,20,scrl.frame.size.height )];
//        page.transform = CGAffineTransformMakeRotation(M_PI_2);
//        page.numberOfPages = [self.images count];
//        page.currentPage = 0;
        
        page = [[HHPageView alloc] initWithFrame:CGRectMake(scrl.frame.size.width-32, 0, 32, scrl.frame.size.height)];
      //  page.userInteractionEnabled = NO;
        [page setDelegate:self];
        [page setHHPageViewType:HHPageViewVerticalType];
//        [page setImageActiveState:[UIImage  imageNamed:@"selected.png"] InActiveState:[UIImage  imageNamed:@"unselected.png"]];
     //   [page setNumberOfPages:numberOfPages];
      //  [page setCurrentPage:3];
       // [page load];
        
        // page.pageIndicatorTintColor = [UIColor whiteColor];
        //        page.currentPageIndicatorTintColor = Theme_Color;
//        UIImageView *tempImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 7)];
//        tempImage.contentMode = UIViewContentModeScaleAspectFill;
//      UIImage *image =[UIImage imageNamed:@"PageDeselect"];
//        page.pageIndicatorTintColor = [UIColor colorWithPatternImage:image];
//
//        image =[UIImage imageNamed:@"PageSelect"];
//        page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:image];

        
        /*
         float shadowSize = 5.0f;
         UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake( -( shadowSize / 2),
         - (shadowSize / 2),
         cell.frame.size.width + shadowSize,
         cell.frame.size.height + shadowSize)];
         cell.layer.shadowPath = shadowPath.CGPath;
         [cell.layer setShadowOffset:CGSizeMake(0,0)];
         
         [cell.layer setShadowColor:[[UIColor blackColor] CGColor]];
         [cell.layer setShadowOpacity:btnShadow];
        */
       // page.enabled=NO;
        [self addSubview:page];
        [self addSubview:self.imgReportUser];
        [self addSubview:self.btnReportUser];
        //for details-name, distance, education, profession
//        name=[[UILabel alloc] initWithFrame:CGRectMake(10*SCREEN_SIZE.width/375, scrl.frame.size.height+ 5, 164, 24)];
         name=[[UILabel alloc] initWithFrame:CGRectMake(10*SCREEN_SIZE.width/375, scrl.frame.size.height+ 5, self.frame.size.width - 20*SCREEN_SIZE.width/375 , 24)];
        name.textColor=[UIColor whiteColor];
        [name setFont:[UIFont fontWithName:@"Lato-Semibold" size:18.0]];
        [self addSubview:name];
        
        
        self.imgDistanceLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10*SCREEN_SIZE.width/375, name.frame.origin.y+24+5+1, 14, 14)];
        self.imgDistanceLogo.image=[UIImage imageNamed:@"iconLocation"];
        [self addSubview:self.imgDistanceLogo];
        
        
        distance=[[UILabel alloc] initWithFrame:CGRectMake(10*SCREEN_SIZE.width/375+20, name.frame.origin.y+24+5, 152, 15)];
        [distance setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0]];
        distance.textColor=[UIColor whiteColor];
        [self addSubview:distance];
        
        self.imgCollegeLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10*SCREEN_SIZE.width/375, distance.frame.origin.y+15+5+1, 14, 14)];
        self.imgCollegeLogo.image=[UIImage imageNamed:@"iconCollegeWhite"];
        [self addSubview:self.imgCollegeLogo];
        
        education=[[UILabel alloc] initWithFrame:CGRectMake(10*SCREEN_SIZE.width/375+20, distance.frame.origin.y+15+5, 152, 15)];
        [education setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0]];
        education.textColor=[UIColor whiteColor];
        [self addSubview:education];
        
        self.imgDegreeLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10*SCREEN_SIZE.width/375, education.frame.origin.y+15+5+1, 14, 14)];
        self.imgDegreeLogo.image=[UIImage imageNamed:@"IconProfessionWhite"];
        [self addSubview:self.imgDegreeLogo];

        profession=[[UILabel alloc] initWithFrame:CGRectMake(10*SCREEN_SIZE.width/375+20, education.frame.origin.y+15+5, 152, 15)];
        [profession setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0]];
        profession.textColor=[UIColor whiteColor];
        [self addSubview:profession];
        
        //mutual friend displaying
        self.mutualFriends=[[UIView alloc] initWithFrame:CGRectMake( self.frame.size.width- 90, name.frame.origin.y+24, 85, 65)];
        UIImageView *bgImage=[[UIImageView alloc] initWithFrame:CGRectMake((self.mutualFriends.frame.size.width-37)/2,0,37,37)];
        bgImage.image =[UIImage imageNamed:@"LikeBg"] ;
        
        distance.frame = CGRectMake(distance.frame.origin.x, distance.frame.origin.y, self.mutualFriends.frame.origin.x - distance.frame.origin.x + bgImage.frame.origin.x - 5  , distance.frame.size.height);

        education.frame = CGRectMake(education.frame.origin.x, education.frame.origin.y, self.mutualFriends.frame.origin.x - education.frame.origin.x + bgImage.frame.origin.x - 5  , education.frame.size.height);

        profession.frame = CGRectMake(profession.frame.origin.x, profession.frame.origin.y, self.mutualFriends.frame.origin.x - profession.frame.origin.x -5 , profession.frame.size.height);
        
        [self.mutualFriends addSubview:bgImage];
        
        
        lblConutMutualFriends=[[UILabel alloc] initWithFrame:CGRectMake(bgImage.frame.origin.x+(bgImage.frame.size.width-15)/2-3, (bgImage.frame.origin.y+bgImage.frame.size.height-15)/2 -5, 15, 23)];
        lblConutMutualFriends.text=@"4";
        [lblConutMutualFriends setFont:[UIFont fontWithName:@"Lato-Black" size:23]];
        lblConutMutualFriends.textColor=Theme_Color;
        lblConutMutualFriends.textAlignment=NSTextAlignmentCenter;
        [self.mutualFriends addSubview:lblConutMutualFriends];
        
        btnMutualFriend=[[UIButton alloc] initWithFrame:CGRectMake(bgImage.frame.origin.x,bgImage.frame.origin.y,bgImage.frame.size.width,bgImage.frame.size.height)];
        btnMutualFriend.backgroundColor=[UIColor clearColor];

        [self.mutualFriends addSubview:btnMutualFriend];
        
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, btnMutualFriend.frame.origin.y+37+3, self.mutualFriends.frame.size.width, 15)];
        lbl.text=[MCLocalization stringForKey:@"Mutual Friends"];
        [lbl setFont:[UIFont fontWithName:@"Lato-Regular" size:12.0]];
        lbl.textColor=[UIColor whiteColor];
        lbl.textAlignment=NSTextAlignmentCenter;
        [self.mutualFriends addSubview:lbl];
        [self addSubview:self.mutualFriends];
        
        //for swipeing cards
        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
        
        overlayView = [[LikeDislikeView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-100, 0, 100, 100)];
        overlayView.alpha = 0;
        [self addSubview:overlayView];
        self.clipsToBounds=NO;
        
    }
    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    
    vwInfo = [[UIView alloc] init];
    vwInfo.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    vwInfo.backgroundColor = [UIColor blackColor];
    vwInfo.alpha = 0.90;
    vwInfo.hidden = YES;
    [self addSubview:self.vwInfo];
    [self bringSubviewToFront:self.vwInfo];

    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.vwInfo.bounds;
    [self.vwInfo addSubview:visualEffectView];

    lblUp = [[UILabel alloc] init];
    lblUp.frame = CGRectMake(0, (self.scrl.frame.size.height/2) - 5, self.scrl.frame.size.width, 10);
    lblUp.text = @"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
    [lblUp setTextAlignment:NSTextAlignmentCenter];
    lblUp.hidden = YES;
    lblUp.font = [UIFont fontWithName:@"Lato-Bold" size:20.0];
    lblUp.textColor = [UIColor whiteColor];
    [self addSubview:lblUp];
    [self bringSubviewToFront:lblUp];
    
    lblDown = [[UILabel alloc] init];
    lblDown.frame = CGRectMake(0, self.scrl.frame.size.height, self.scrl.frame.size.width, 10);
    lblDown.text = @"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
    [lblDown setTextAlignment:NSTextAlignmentCenter];
    lblDown.hidden = YES;
    lblDown.font = [UIFont fontWithName:@"Lato-Bold" size:20.0];
    lblDown.textColor = [UIColor whiteColor];
    [self addSubview:lblDown];
    [self bringSubviewToFront:lblDown];


    imgUpTap = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width/2) - 40, 25, 80, 80)];
    imgUpTap.image = [UIImage imageNamed:@"iconTap"];
    imgUpTap.hidden = YES;
    [self addSubview:imgUpTap];
    [self bringSubviewToFront:self.imgUpTap];
    
    imgDownTap = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width/2) - 40, lblUp.frame.origin.y + 30, 80, 80)];;
    imgDownTap.image = [UIImage imageNamed:@"iconTap"];
    imgDownTap.hidden = YES;
    [self addSubview:imgDownTap];
    [self bringSubviewToFront:self.imgDownTap];

    lblUpText = [[UILabel alloc] init];
    lblUpText.frame = CGRectMake(10, imgUpTap.frame.size.height + 30, self.frame.size.width-20, 30);
    lblUpText.text = [MCLocalization stringForKey:@"LAST PHOTO"];
    lblUpText.textAlignment = NSTextAlignmentCenter;
    lblUpText.font = [UIFont fontWithName:@"Lato-Bold" size:18.0];
    lblUpText.textColor = [UIColor whiteColor];
    lblUpText.hidden = YES;
    [self addSubview:lblUpText];
    [self bringSubviewToFront:lblUpText];

    lblDownText = [[UILabel alloc] init];
    lblDownText.frame = CGRectMake(10, imgDownTap.frame.origin.y + imgDownTap.frame.size.height + 5, self.frame.size.width-20, 30);
    lblDownText.text = [MCLocalization stringForKey:@"NEXT PHOTO"];
    lblDownText.textAlignment = NSTextAlignmentCenter;
    lblDownText.font = [UIFont fontWithName:@"Lato-Bold" size:18.0];
    lblDownText.textColor = [UIColor whiteColor];
    lblDownText.hidden = YES;
    [self addSubview:lblDownText];
    [self bringSubviewToFront:lblDownText];

    
    btnUp = [[UIButton alloc] init];
//    [btnUp.titleLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:20.0]];
//    [btnUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btnUp setTitle:@"LAST PHOTO" forState:UIControlStateNormal];
    [btnUp addTarget:self action:@selector(swipeUp:) forControlEvents:UIControlEventTouchUpInside];
    btnUp.frame = CGRectMake(10 ,15, self.frame.size.width-20, self.scrl.frame.size.height/2 - 30);
//    btnUp.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
     btnUp.hidden = YES;
    btnUp.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    btnUp.titleLabel.numberOfLines = 0;
    btnUp.layer.shadowColor = [UIColor whiteColor].CGColor;
    //btnUp.imageView.image = [UIImage imageNamed:@"iconTap"];
//    [btnUp setImage:[UIImage imageNamed:@"iconTap"] forState:UIControlStateNormal];
    [self addSubview:btnUp];
    [self bringSubviewToFront:self.btnUp];
    
    btnDown = [[UIButton alloc] init];
//    [btnDown.titleLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:20.0]];
//    [btnDown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btnDown setTitle:@"NEXT PHOTO" forState:UIControlStateNormal];
    [btnDown addTarget:self action:@selector(swipeDown:) forControlEvents:UIControlEventTouchUpInside];
    btnDown.frame = CGRectMake(10 ,self.scrl.frame.size.height/2 + 15, self.frame.size.width-20, self.scrl.frame.size.height/2 - 30 );
//    btnDown.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    btnDown.hidden =YES;
    btnDown.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    btnDown.titleLabel.numberOfLines = 0;
    btnDown.layer.shadowColor = [UIColor whiteColor].CGColor;
//    [btnDown setImage:[UIImage imageNamed:@"iconTap"] forState:UIControlStateNormal];
    


//    btnDown.imageEdgeInsets = UIEdgeInsetsMake(0, self.btnDown.frame.size.width/2, self.btnDown.frame.size.height/4, 0);
//    btnDown.titleEdgeInsets = UIEdgeInsetsMake(self.btnDown.frame.size.height/4, 0, 0, 0);
    
    [self addSubview:btnDown];
    [self bringSubviewToFront:self.btnDown];
    
    imgInfoTap= [[UIImageView alloc] initWithFrame:CGRectMake(10 ,self.scrl.frame.size.height + 15, self.frame.size.height - self.scrl.frame.size.height - 30, self.frame.size.height - self.scrl.frame.size.height - 30)];
    imgInfoTap.image = [UIImage imageNamed:@"iconTap"];
    imgInfoTap.hidden = YES;
    [self addSubview:imgInfoTap];
    [self bringSubviewToFront:self.imgInfoTap];
    
    
    btnDetails = [[UIButton alloc] init];
    [btnDetails.titleLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:18.0]];
    [btnDetails setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDetails setTitle:[MCLocalization stringForKey:@"OPEN PROFILE"] forState:UIControlStateNormal];
    [btnDetails addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    btnDetails.frame = CGRectMake(10 ,self.scrl.frame.size.height + 15, self.frame.size.width-20, self.frame.size.height - self.scrl.frame.size.height - 30);
    btnDetails.backgroundColor = [UIColor clearColor];
    btnDetails.hidden = YES;
    btnDetails.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    btnDetails.titleLabel.numberOfLines = 0;
    btnDetails.layer.shadowColor = [UIColor whiteColor].CGColor;
//    [btnDetails setImage:[UIImage imageNamed:@"iconTap"] forState:UIControlStateNormal];
    [self addSubview:btnDetails];
    [self bringSubviewToFront:self.btnDetails];


    if( [[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self setUpRTLUi];
    }
    
   return self;
}
/*!
 * @discussion Setup view
 */
-(void)setupView
{
    self.layer.cornerRadius = 4;
    //self.layer.shadowOffset =
}

#pragma  mark - drag gesture
// called when you move your finger across the screen.

-(void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    xFromCenter = [gestureRecognizer translationInView:self].x;
    yFromCenter = [gestureRecognizer translationInView:self].y;
    //checks what state the gesture is in. (are you just starting, letting go, or in the middle of a swipe?)
    switch (gestureRecognizer.state) {
    
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
        
        // in the middle of a swipe
        case UIGestureRecognizerStateChanged:{
            
            CGFloat rotationStrength =MIN(xFromCenter/ROTATION_STRENGTH, ROTATION_MAX);
            // degree change in radians
            CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
            
            // amount the height changes when you move the card up to a certain point
            CGFloat scale = MAX(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
            
            // move the object's center by center + gesture coordinate
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);
            
            // rotate by certain amount
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            
            // scale by certain amount
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            
            // apply transformations
            self.transform = scaleTransform;
            
            if (xFromCenter > 30 || xFromCenter < -30 ) {
                [self updateOverlay:xFromCenter top:NO];
            } else if (yFromCenter < -30) {
                [self updateOverlay:yFromCenter top:YES];
            } else {
                [self updateOverlay:xFromCenter top:NO];
            }
            break;
        };
            // let go of the card
        case UIGestureRecognizerStateEnded: {
            [self afterSwipeAction];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}
#pragma mark - tap gesture
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer{

    CGPoint touchPoint = [tapGestureRecognizer locationInView: self];
    if(touchPoint.y > (self.scrl.frame.size.height+self.scrl.frame.origin.y)){
        [self.delegate showfriendDetail];
    }
    else{
        if(touchPoint.y > self.scrl.frame.size.height/2){
            double y = self.scrl.contentOffset.y + self.scrl.frame.size.height;
            if(y < self.scrl.contentSize.height) {
                [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.scrl.contentOffset = CGPointMake(self.scrl.contentOffset.x, y); }
                                 completion:NULL];
            }
        }
        else{
            double y = self.scrl.contentOffset.y - self.scrl.frame.size.height;
            if(y >= 0) {
                [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.scrl.contentOffset = CGPointMake(self.scrl.contentOffset.x, y); }
                                 completion:NULL];
               // self.scrl.contentOffset = CGPointMake(self.scrl.contentOffset.x, y);
            }
        }
        [self scrollViewDidEndDecelerating:self.scrl];
    }
    

}
#pragma mark- methods
/*!
 * @discussion checks to see if you are moving right or left and applies the correct overlay image
 * @param distance1 Distance from central point
 */
-(void)updateOverlay:(CGFloat)distance1 top:(BOOL)top
{
    if (distance1 > 0)
    {
        overlayView.mode = GGOverlayViewModeRight;
    }
    else
    {
        overlayView.mode = GGOverlayViewModeLeft;
    }
    if (top && distance1 < -30)
    {
        overlayView.mode = GGOverlayViewModeTop;
    }
    overlayView.alpha = MIN(fabs(distance1)/100, 0.4);
}
/*!
 * @discussion called when the card is let go
 */
- (void)afterSwipeAction
{
    if (xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    } else if (xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    } else if (yFromCenter < -ACTION_MARGIN) {
//        if ([[appDelegate GetData:kOneSuperLikeDone] isEqualToString:@"yes"]) {
//            //TODO:- Superlike popup for inapppurchase
//
//            if (self.delegate != nil) {
//                [self.delegate inAppPurchase];
//            }
//            [UIView animateWithDuration:0.5
//                             animations:^{
//                                 self.center = self.originalPoint;
//                                 self.transform = CGAffineTransformMakeRotation(0);
//                                 overlayView.alpha = 0;
//                             }];
//            return;
//        }
       [self topAction];
    } else { // resets the card
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             overlayView.alpha = 0;
                         }];
    }
}
/*!
 * @discussion Call webservice for getting movre users
 */
-(void)CallWhenLikeDisliked
{
    [self.delegate CallGetFriends];

}

/*!
 * @discussion called when a swipe exceeds the ACTION_MARGIN to the right
 */
-(void)rightAction
{
    //webservice call like
    [self likeFriend:self.friendID];
    
    
    CGPoint finishPoint = CGPointMake(500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
}

/*!
 * @discussion called when a swip exceeds the ACTION_MARGIN to the left
 */
-(void)leftAction
{
    //webservice call dislike
    [self dislikeFriend:self.friendID];
    
    
    CGPoint finishPoint = CGPointMake(2*xFromCenter +self.originalPoint.x, -500);
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
}
/*!
  * @discussion called when a swip exceeds the ACTION_MARGIN to the left
  */
-(void)topAction
{
    //webservice call dislike
    [self superLikeFriend:self.friendID];
    
    
    CGPoint finishPoint = CGPointMake(self.center.x, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
//                         [self removeFromSuperview];
                     }];
}

/*!
 * @discussion Show mutual friend's pop up
 */
- (void)btnMutualFriendsClicked
{
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self.delegate
                                   selector:@selector(showPopup) userInfo:nil repeats:NO];

}

/*!
 * @discussion called when card is swiped right
 */
-(void)rightClickAction
{
    //called from both profileView and friendsprofile
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
 }
/*!
 * @discussion called when card is swiped left
 */
-(void)leftClickAction
{
    //called from both profileView and friendsprofile
    CGPoint finishPoint = CGPointMake(-600, self.center.y);
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    
}
/*!
 * @discussion called when card is swiped top
 */
-(void)superLikeClickAction
{
    //called from both profileView and friendsprofile
    CGPoint finishPoint = CGPointMake(self.center.x, -50);
//    self.transform = CGAffineTransformMakeRotation(-0.2);

    self.originalPoint = self.center;
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = finishPoint;
//                         self.transform = CGAffineTransformMakeRotation(-1);
                     }completion:^(BOOL complete){
//                         [self removeFromSuperview];
                     }];
    
    
}
-(void)removeCard {
    [self removeFromSuperview];
}

-(void)getCardback {
    //    CGPoint finishPoint = CGPointMake(self.center.x, -50);
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.center = self.originalPoint;
                         self.transform = CGAffineTransformMakeRotation(0);
                         overlayView.alpha = 0;
                     }];
}
-(void)getCardbackForError {
    self.center = self.originalPoint;
    self.transform = CGAffineTransformMakeRotation(0);
    overlayView.alpha = 0;
}

#pragma mark - scrollview delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // page.currentPage= (int)scrollView.contentOffset.y/(scrollView.frame.size.height) + 1 ;
    int p = (int) (scrollView.contentOffset.y/scrollView.frame.size.height) +1;
    [page updateStateForPageNumber:p];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView:(UIScrollView *)scrollView
//{
//    // page.currentPage= (int)scrollView.contentOffset.y/(scrollView.frame.size.height) + 1 ;
//    int p = (ceil (scrollView.contentOffset.y/scrollView.frame.size.height)) +1;
//    [page updateStateForPageNumber:p];
//}
/*!
 * @discussion UPdate scrollview UI
 */
- (void) updateScrl{
    
    scrl.contentSize=CGSizeMake(self.frame.size.width, scrl.frame.size.height * [self.images count]);
    NSString *strImg;
    if([self.images count]==0){
        
        page.hidden = YES;
        
        UIImageView *profilePhoto;
        
        profilePhoto=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,scrl.frame.size.height )];

        profilePhoto.layer.cornerRadius=0;
        profilePhoto.contentMode =UIViewContentModeScaleAspectFill;
        profilePhoto.layer.masksToBounds=YES;
        NSString *temp=[NSString stringWithFormat:@"%@default.png",imageUrl];
        
        [profilePhoto sd_setImageWithURL:[NSURL URLWithString:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image!=nil){
                profilePhoto.image = image;
            }
            else{
                profilePhoto.image = [UIImage imageNamed:@"TempProfile"];
            }
            
            [self.scrl addSubview:profilePhoto];
            
        }];
    }
    else{
        UIImageView *profilePhoto;
        UIActivityIndicatorView *act;
        
        page.numberOfPages = [self.images count];

        if([self.images count] == 1){
            page.hidden = YES;
        }
        else{
            page.hidden = NO;
            [self configureVerticalControllerWithTotalPages:self.images.count];
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //[self.pageController sizeToFit];
                //self.pageController.frame = CGRectMake((SCREEN_SIZE.width - self.pageController.frame.size.width)/2, self.scrlSlider.frame.origin.y + self.scrlSlider.frame.size.height - self.pageController.frame.size.height, self.pageController.frame.size.width, self.pageController.frame.size.height);
                [self.page updateStateForPageNumber:1];
                
            });
        }
        
        if([self.images count]> 6){
            scrl.contentSize=CGSizeMake(self.frame.size.width, scrl.frame.size.height * 6 );
            page.numberOfPages = 6;
        }
        
     
        for(int i=0,index=1;(i<[self.images count] && i<6);index++){
            
            profilePhoto=[[UIImageView alloc] initWithFrame:CGRectMake(0, scrl.frame.size.height*i, self.frame.size.width,scrl.frame.size.height )];
            
            profilePhoto.layer.cornerRadius=0;
            
            profilePhoto.contentMode =UIViewContentModeScaleAspectFill;
            profilePhoto.layer.masksToBounds=YES;
           
           
            strImg=[NSString stringWithFormat:@"img%d",index];
                
            NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[self.images valueForKey:strImg]];
            
            
            while(![self.images valueForKey:strImg]){
                index++;
                strImg=[NSString stringWithFormat:@"img%d",index];
                temp=[NSString stringWithFormat:@"%@%@",imageUrl,[self.images valueForKey:strImg]];
            }

            
            act=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(profilePhoto.frame.size.width/2-15,profilePhoto.frame.size.height/2-15+profilePhoto.frame.origin.y, 30, 30)];
            act.hidesWhenStopped=YES;
           
            act.color=Theme_Color;
            [self.scrl addSubview:act];
            [self.scrl addSubview:profilePhoto];
            
            [act startAnimating];
            
            [profilePhoto sd_setImageWithURL:[NSURL URLWithString:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image!=nil){
                    profilePhoto.image = image;
                }
                else{
                    profilePhoto.image = [UIImage imageNamed:@"TempProfile"];
                }

                [act stopAnimating];
                
            }];

            i++;
            
        }
        
        page.currentPage=0;

    }
}
#pragma mark- API call]
/*!
 * @discussion Web service call for like friend
 */
-(void)likeFriend:(NSString *)friendId
{
    
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         if (responseObject == false)
         {
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], appDelegate.window.rootViewController);
             return ;
         }
         else {
             NSString *str=@"user_like";
             
             NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:friendId forKey:@"receive_user_id"];
             
             [dict setValue:@"1" forKey:@"status"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                
                 HIDE_PROGRESS;
                 if([[dictionary valueForKey:@"error"] intValue]==0 && success){
                     
                     if([appDelegate.loadedCards count]>0){
                         [appDelegate.loadedCards removeObjectAtIndex:0];
                         [self.delegate showhideButtons];
                         appDelegate.cardsLoadedIndex--;
                          //enable swipe here
                         ProfileView *dragView = [appDelegate.loadedCards firstObject];
                         [dragView addGestureRecognizer:dragView.panGestureRecognizer];
                         [dragView addGestureRecognizer:dragView.singleTapGestureRecognizer];
                         
                         [self.delegate CheckForAd];
                         if(appDelegate.cardsLoadedIndex<2)
                         {
                             
                             [self CallWhenLikeDisliked];
                             

                         }
                         
                     }

                 }
                 
                 
             }];
         }
     }];
}
/*!
 * @discussion Web service call for dislike friend
 */
-(void)superLikeFriend:(NSString *)friendId
{
    
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         
         
         if (responseObject == false)
         {
             
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], appDelegate.window.rootViewController);
             return ;
         }
         else {
             
             
             NSString *str=@"sendnotification";
             
             NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:friendId forKey:@"receive_user_id"];
             
             [dict setValue:@"0" forKey:@"status"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
                 while (topVC.presentedViewController)
                 {
                     topVC = topVC.presentedViewController;
                 }
                 if (success && [[dictionary valueForKey:@"error"] intValue] == 0) {
                     [appDelegate SetData:@"yes" value:kOneSuperLikeDone];

                     if ([appDelegate.loadedCards count] > 0) {
                         [self removeFromSuperview];
                         [appDelegate.loadedCards removeObjectAtIndex:0];
                         
                         [self.delegate showhideButtons];
                         
                         appDelegate.cardsLoadedIndex--;
                         //enable swipe here
                         ProfileView *dragView = [appDelegate.loadedCards firstObject];
                         [dragView addGestureRecognizer:dragView.panGestureRecognizer];
                         [dragView addGestureRecognizer:dragView.singleTapGestureRecognizer];
                         
                         [self.delegate CheckForAd];
                         
                         if (appDelegate.cardsLoadedIndex < 2) {
                             [self CallWhenLikeDisliked];
                         }
                     }
                 } else if([[dictionary valueForKey:@"error_code"] intValue] == 502) {
                     [appDelegate SetData:@"yes" value:kOneSuperLikeDone];
                     
                     [UIView animateWithDuration:0.5
                                      animations:^{
                                          self.center = self.originalPoint;
                                          self.transform = CGAffineTransformMakeRotation(0);
                                          overlayView.alpha = 0;
                                      }];
                     
                     [self inAppPurchase];
                     //TODO: Reload Page
                 } else {
                     [self getCardbackForError];
                     ALERTVIEW([dictionary valueForKey:@"message"], topVC);
                 }
             }];
         }
     }];
}
- (void) inAppPurchase {
    if (![[appDelegate GetData:kPaidSuperLike] isEqualToString:@"yes"]  || [[appDelegate GetData:kSuperLikeInAppPurchase] isEqualToString:@""] || [[appDelegate GetData:kSuperLike] isEqualToString:@"yes"]) {
        return;
    }

    InAppPurchaseVC *vc = [[InAppPurchaseVC alloc] initWithNibName:@"InAppPurchaseVC" bundle:nil];
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }

    topVC.definesPresentationContext = YES; //self is presenting view controller
    vc.view.backgroundColor = [UIColor clearColor];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.fromPage = 4; // from superlike purchase
    [topVC presentViewController:vc animated:YES completion:nil];
}

/*!
 * @discussion Web service call for dislike friend
 */
-(void)dislikeFriend:(NSString *)friendId
{
    
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         if (responseObject == false)
         {
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], appDelegate.window.rootViewController);
             return ;
         }
         else {
             NSString *str=@"user_like";
             
             NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:friendId forKey:@"receive_user_id"];
             
             [dict setValue:@"0" forKey:@"status"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if (success && [[dictionary valueForKey:@"error"] intValue] == 0) {
                     if ([appDelegate.loadedCards count] > 0) {
                         [appDelegate.loadedCards removeObjectAtIndex:0];
                         
                         [self.delegate showhideButtons];
                         
                         appDelegate.cardsLoadedIndex--;
                         //enable swipe here
                         ProfileView *dragView = [appDelegate.loadedCards firstObject];
                         [dragView addGestureRecognizer:dragView.panGestureRecognizer];
                         [dragView addGestureRecognizer:dragView.singleTapGestureRecognizer];
                         
                         [self.delegate CheckForAd];
                         
                         if (appDelegate.cardsLoadedIndex < 2) {
                             [self CallWhenLikeDisliked];
                         }
                     }
                 }
             }];
         }
     }];
}
/*!
 * @discussion WebService call for Report friend
 * @param friendID Friend's Id
 */
-(void)reportUser:(NSString *) friendID
{
    
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         SHOW_LOADER_ANIMTION();
         
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], appDelegate.window.rootViewController);
             return ;
         } else {
             NSString *str=@"reporteuser";
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:friendID forKey:@"report_to_id"];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 if( success && [[dictionary valueForKey:@"error"] intValue]==0) {
                     
                 } else {
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Please try again!!"], appDelegate.window.rootViewController);
                 }
             }];
         }
     }];
}
#pragma mark- report user
- (IBAction)btnReportUserClicked:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:appNAME message:[MCLocalization stringForKey:@"Are you Sure Want to report this User ?"] delegate:self cancelButtonTitle:[MCLocalization stringForKey:@"Cancel"] otherButtonTitles:[MCLocalization stringForKey:@"Yes"],nil];
    [alert show];
}

#pragma mark - Alert view action handle
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //Code for cancel button
    }
    if (buttonIndex == 1)
    {
        //Code for Yes button
        [self reportUser:self.friendID];
    }
}
#pragma mark -  RTL
/*!
 * @discussion Setup RTL ui
 */
-(void)setUpRTLUi {
    
    [self.name setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.distance setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.education setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.profession setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblConutMutualFriends setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    self.name.textAlignment=NSTextAlignmentRight;
    
    self.distance.textAlignment=NSTextAlignmentRight;
    self.education.textAlignment=NSTextAlignmentRight;
    self.profession.textAlignment=NSTextAlignmentRight;
    
    [self.btnDown setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.btnUp setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.vwInfo setTransform:CGAffineTransformMakeScale(-1, 1)];

}

#pragma mark - configure page slider

- (void) configureVerticalControllerWithTotalPages:(NSInteger)totalPages {
    
    //Set delegate to the HHPageView object. To handle page change event.
    [page setDelegate:self];
    
    //Note: You don't need to set baseScrollView if there's only one HHPageView per view controller.
    [page setBaseScrollView:scrl];
    
    //Set HHPageView Type: Horizontal or Vertical
    [page setHHPageViewType:HHPageViewVerticalType];
    
    //Set Images for Active and Inactive state.
    [page setImageActiveState:[UIImage  imageNamed:@"PageSelect"] InActiveState:[UIImage  imageNamed:@"PageDeselect"]];
    
    //Tell HHPageView, the number of pages you want to show.
    [page setNumberOfPages:totalPages];
    
    //Tell HHPageView to show page from this page index.
    [page setCurrentPage:1];
    
    //Show when you ready!
    [page load];
}
#pragma mark - HHPageController Delegate
- (void) HHPageView:(HHPageView *)pageView currentIndex:(NSInteger)currentIndex {
    UIScrollView *baseScrollView = (UIScrollView *) [pageView baseScrollView];
    if(baseScrollView) {
        // if(baseScrollView.tag == HORIZONTAL_SCROLLVIEW_TAG) {
        //horizontal
        [baseScrollView setContentOffset:CGPointMake(0, currentIndex * self.scrl.frame.size.height) animated:YES];
        //        } else {
        //            //vertical
        //            [baseScrollView setContentOffset:CGPointMake(0, currentIndex * scrollViewVertical.frame.size.height) animated:YES];
        //        }
    } else {
        //If you've only single HHPageController for any of the view then no need to set baseScrollView.
        NSLog(@"You forgot to set baseScrollView for the HHPageView object!");
    }
}
#pragma mark - For dummy card
-(void) swipeUp:(id)sender{
    
    self.vwInfo.hidden =  YES;
    self.btnDown.hidden =  YES;
    self.btnUp.hidden = YES;
    self.btnDetails.hidden = YES;
    [self.delegate hideInfo];
//    self.btnDown.hidden =  NO;
//    self.btnUp.hidden = YES;
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.scrl.contentOffset = CGPointMake(self.scrl.contentOffset.x, 0);
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scrl];
        [self.delegate hideInfo];
    }];
    [appDelegate SetData:@"NO" value:kNewUser];
}
-(void)swipeDown:(id)sender {
    
    self.vwInfo.hidden =  YES;
    self.btnDown.hidden =  YES;
    self.btnUp.hidden = YES;
    self.btnDetails.hidden = YES;
    [self.delegate hideInfo];
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.scrl.contentOffset = CGPointMake(self.scrl.contentOffset.x, self.scrl.contentOffset.y + self.scrl.frame.size.height);
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scrl];
    }];
    [appDelegate SetData:@"NO" value:kNewUser];
}

-(void)showDetails:(id)sender {
    
    [self.delegate showfriendDetail];
    
    self.vwInfo.hidden =  YES;
    self.btnDown.hidden =  YES;
    self.btnUp.hidden = YES;
    self.btnDetails.hidden = YES;
    [self.delegate hideInfo];
    [appDelegate SetData:@"NO" value:kNewUser];
}
@end
