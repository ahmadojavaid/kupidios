//
//  SSPopUpView.h
//  SSXmpp
//
//  Created by Jitendra on 24/11/15.
//  Copyright © 2015 Jitendra. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SSPopUpBlock) (int index);

@interface SSPopUpView : UIView 

@property (nonatomic,strong) SSPopUpBlock blok;

+(SSPopUpView*)shareInstance;

-(void)showSSPopUp:(NSString *)imageFirst secondimage:(NSString *)imageSecond complition:(SSPopUpBlock)complition;

@end
