//
//  ImageCell1.h
//  CupidLove
//
//  Created by APPLE on 22/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell1 : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *galleryImage;
@property (strong, nonatomic) IBOutlet UIImageView *boarderImage;
@property (strong, nonatomic) IBOutlet UILabel *selectionLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *act;
@end
