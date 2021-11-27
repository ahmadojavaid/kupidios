//
//  ChatRightCell.h
//  CupidLove
//
//  Created by potenza on 08/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRightCell : UITableViewCell
@property(weak,nonatomic) IBOutlet UIView *vw;
@property(weak,nonatomic) IBOutlet UIView *vwBoarder;
@property(weak,nonatomic) IBOutlet UILabel *lblMessage;
@property(weak,nonatomic) IBOutlet UILabel *lblTime;
@end
