//
//  LoaderVC.m
//  EverAfter
//
//  Created by potenza on 28/07/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "LoaderVC.h"

@interface LoaderVC ()
@property(strong,nonatomic) IBOutlet UIImageView *img;
@end

@implementation LoaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.img setTransform:CGAffineTransformMakeScale(-1, 1)];
    }
    
    self.img.animationImages = appDelegate.LoaderImages;
    self.img.animationDuration = 4.0;
    [self.img startAnimating];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.img stopAnimating];
}



@end
