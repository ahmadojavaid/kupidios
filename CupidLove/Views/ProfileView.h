//
//  ProfileView.h
//  CupidLove
//
//  Created by APPLE on 06/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LikeDislikeView.h"
#import "UIImageView+WebCache.h"
#import "HHPageView.h"

// Protocol definition starts here
@protocol mutualFriendsDelegate <NSObject>
@required
- (void) showPopup;
- (void) showfriendDetail;
- (void) CallGetFriends;
- (void) CheckForAd;
- (void) showhideButtons;
- (void) hideInfo;
- (void) inAppPurchase;
@end
// Protocol Definition ends here

@interface ProfileView : UIView <UIScrollViewDelegate, HHPageViewDelegate>
{
    // Delegate to respond back
    id <mutualFriendsDelegate> _delegate;
}

@property (nonatomic,strong) id delegate;

@property (nonatomic, strong) UIButton *btnMutualFriend;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UITapGestureRecognizer *singleTapGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic, strong) LikeDislikeView* overlayView;


@property (nonatomic, strong)UILabel* name;
@property (nonatomic, strong)UILabel* distance;
@property (nonatomic, strong)UILabel* education;
@property (nonatomic, strong)UILabel* profession;
@property (nonatomic, strong)UILabel* lblConutMutualFriends;

@property (nonatomic, strong) HHPageView* page;

@property(nonatomic, strong) UIView *popup;
@property(nonatomic, strong) UIView *popupBg;
@property(nonatomic, strong) UIView *parent;

@property(nonatomic,  strong) UIScrollView *scrl;

@property(nonatomic, strong) NSMutableDictionary *images;

@property(nonatomic,strong) NSString * friendID;
@property(nonatomic,strong) NSDictionary *dictFriendDetail;

-(void)leftClickAction;
-(void)rightClickAction;
-(void)superLikeClickAction;

-(void)removeCard;
-(void)getCardback;
-(void)getCardbackForError;

- (void) updateScrl;
- (void) btnMutualFriendsClicked; //instance method for delegate call
- (void) configureVerticalControllerWithTotalPages:(NSInteger)totalPages;

-(void)topAction;

@property(nonatomic,strong) UIButton *btnUp;
@property(nonatomic,strong) UIButton *btnDown;
@property(nonatomic,strong) UIButton *btnDetails;

@property(nonatomic,strong) UIView *vwInfo;

@property(nonatomic,strong) UIImageView *imgUpTap;
@property(nonatomic,strong) UIImageView *imgDownTap;
@property(nonatomic,strong) UIImageView *imgInfoTap;

@property(nonatomic,strong) UILabel *lblUpText;
@property(nonatomic,strong) UILabel *lblDownText;
@property(nonatomic,strong) UILabel *lblUp;
@property(nonatomic,strong) UILabel *lblDown;

@end
