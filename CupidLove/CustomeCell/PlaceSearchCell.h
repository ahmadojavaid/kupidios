//
//  PlaceSearchCell.h
//  CupidLove
//
//  Created by Umesh on 12/9/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceSearchCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UIImageView *img;
@property (weak,nonatomic) IBOutlet UILabel *lblTitle;
@property (weak,nonatomic) IBOutlet UILabel *lblDistance;
@property (weak,nonatomic) IBOutlet UILabel *lblColor;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act;

@end
