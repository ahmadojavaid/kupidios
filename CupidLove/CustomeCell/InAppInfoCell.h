//
//  InAppInfoCell.h
//  CupidLove
//
//  Created by Kaushal PC on 02/07/18.
//  Copyright © 2018 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InAppInfoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
