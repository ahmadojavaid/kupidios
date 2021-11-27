//
//  ImageUploadVC.m
//  CupidLove
//
//  Created by APPLE on 11/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "ImageUploadVC.h"
#import "GalleryVC.h"
#import "DatePreferencesVC.h"
#import "FacebookImageGalleryVC.h"
#import <Photos/Photos.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "TOCropViewController.h"

@interface ImageUploadVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,TOCropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *vw1;
@property (weak, nonatomic) IBOutlet UIView *vw2;
@property (weak, nonatomic) IBOutlet UIView *vw3;
@property (weak, nonatomic) IBOutlet UIView *vw4;
@property (weak, nonatomic) IBOutlet UIView *vw5;
@property (weak, nonatomic) IBOutlet UIView *vw6;

@property (weak, nonatomic) IBOutlet UIView *vwFb;
@property (weak, nonatomic) IBOutlet UIView *vwGallery;

@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
//images

@property (strong,nonatomic) IBOutlet UIImageView *img1;
@property (strong,nonatomic) IBOutlet UIImageView *img2;
@property (strong,nonatomic) IBOutlet UIImageView *img3;
@property (strong,nonatomic) IBOutlet UIImageView *img4;
@property (strong,nonatomic) IBOutlet UIImageView *img5;
@property (strong,nonatomic) IBOutlet UIImageView *img6;
//numbering images
@property (strong,nonatomic) IBOutlet UIImageView *image1;
@property (strong,nonatomic) IBOutlet UIImageView *image2;
@property (strong,nonatomic) IBOutlet UIImageView *image3;
@property (strong,nonatomic) IBOutlet UIImageView *image4;
@property (strong,nonatomic) IBOutlet UIImageView *image5;
@property (strong,nonatomic) IBOutlet UIImageView *image6;

@property (weak,nonatomic) IBOutlet UIView *bottomImportView;
@property (weak,nonatomic) IBOutlet UIView *bottomNextView;
@property (weak,nonatomic) IBOutlet UIView *view1;
@property (weak,nonatomic) IBOutlet UIView *view2;
//buttons for editing
@property (weak,nonatomic) IBOutlet UIButton *edit1;
@property (weak,nonatomic) IBOutlet UIButton *edit2;
@property (weak,nonatomic) IBOutlet UIButton *edit3;
@property (weak,nonatomic) IBOutlet UIButton *edit4;
@property (weak,nonatomic) IBOutlet UIButton *edit5;
@property (weak,nonatomic) IBOutlet UIButton *edit6;
//edit icon
@property (weak,nonatomic) IBOutlet UIImageView *editimg1;
@property (weak,nonatomic) IBOutlet UIImageView *editimg2;
@property (weak,nonatomic) IBOutlet UIImageView *editimg3;
@property (weak,nonatomic) IBOutlet UIImageView *editimg4;
@property (weak,nonatomic) IBOutlet UIImageView *editimg5;
@property (weak,nonatomic) IBOutlet UIImageView *editimg6;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblInfo2;
@property (strong, nonatomic) IBOutlet UILabel *lblImport1;
@property (strong, nonatomic) IBOutlet UILabel *lblImport2;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;

@property(weak,nonatomic) IBOutlet UIView *vwBack;

@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *act1;
@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *act2;
@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *act3;
@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *act4;
@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *act5;
@property(weak,nonatomic) IBOutlet UIActivityIndicatorView *act6;

@property (weak, nonatomic) IBOutlet UIImageView *imgInfo;

@property (weak, nonatomic) IBOutlet UIImageView *imgInfo2;

@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;

@end

@implementation ImageUploadVC
{
    NSMutableArray *img;
    BOOL cameraEdit, galleryImport;
    NSMutableArray *arrDeletedImages;
    
    Boolean flagForCropper, flagUploadImage1, flagUploadImage2, flagUploadImage3, flagUploadImage4, flagUploadImage5, flagUploadImage6;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    flagForCropper = true;
    
    cameraEdit=false;
    galleryImport= false;
    
    arrDeletedImages = [[NSMutableArray alloc] init];
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    [appDelegate.selectedImages removeAllObjects];
    [appDelegate.selectedFbImages removeAllObjects];
    [appDelegate.selectedImagesAssets removeAllObjects];
    
    if([[appDelegate GetData:@"flagBack"] isEqualToString:@"hide"]){
        //hide back button
        self.vwBack.hidden = YES;
       // flag_left = false;
    }
    else{
    //    flag_left = true;
    }
    
    self.act1.color = Theme_Color;
    self.act2.color = Theme_Color;
    self.act3.color = Theme_Color;
    self.act4.color = Theme_Color;
    self.act5.color = Theme_Color;
    self.act6.color = Theme_Color;
    
    //set gallery images -- if already uploaded
    if(![[appDelegate GetData:kimg1] isEqualToString:@"Key Not Found"]){
        
        [self.act1 startAnimating];
        [self.img1 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg1]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image!=nil){
                self.img1.image=image;
                self.img1.hidden = NO;
                self.image1.hidden = YES;
                [self hideshowSetUp];
            }
//            else{
//                self.img1.image = [UIImage imageNamed:@"TempProfile"];
//            }
            
            [self.act1 stopAnimating];
        }];
    }
    else{
        [self.act1 stopAnimating];
    }
    
    if(![[appDelegate GetData:kimg2] isEqualToString:@"Key Not Found"]){
        [self.act2 startAnimating];
        [self.img2 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg2]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img2.image=image;
                self.img2.hidden = NO;
                self.image2.hidden = YES;
                [self hideshowSetUp];
            }
//            else{
//                self.img2.image=[UIImage imageNamed:@"NoPlaceFound"];
//            }
            
            [self.act2 stopAnimating];
        }];
    }
    else{
        [self.act2 stopAnimating];
    }
    if(![[appDelegate GetData:kimg3] isEqualToString:@"Key Not Found"]){
        [self.act3 startAnimating];
        [self.img3 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg3]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img3.image=image;
                self.img3.hidden = NO;
                self.image3.hidden = YES;
                [self hideshowSetUp];
            }
//            else{
//                self.img3.image=[UIImage imageNamed:@"NoPlaceFound"];
//            }
//
            [self.act3 stopAnimating];
        }];
    }
    else{
        [self.act3 stopAnimating];
    }
    if(![[appDelegate GetData:kimg4] isEqualToString:@"Key Not Found"]){
        [self.act4 startAnimating];
        [self.img4 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg4]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img4.image=image;
                self.img4.hidden = NO;
                self.image4.hidden = YES;
                [self hideshowSetUp];
            }
//            else{
//                self.img4.image=[UIImage imageNamed:@"NoPlaceFound"];
//            }
            
            [self.act4 stopAnimating];
        }];
    }
    else{
        [self.act4 stopAnimating];
    }
    if(![[appDelegate GetData:kimg5] isEqualToString:@"Key Not Found"]){
        [self.act5 startAnimating];
        [self.img5 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg5]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img5.image=image;
                self.img5.hidden = NO;
                self.image5.hidden = YES;
                [self hideshowSetUp];
            }
//            else{
//                self.img5.image=[UIImage imageNamed:@"NoPlaceFound"];
//            }
            
            [self.act5 stopAnimating];
            
        }];
    }
    else{
        [self.act5 stopAnimating];
    }
    if(![[appDelegate GetData:kimg6] isEqualToString:@"Key Not Found"]){
        [self.act6 startAnimating];
        [self.img6 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg6]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img6.image=image;
                self.img6.hidden = NO;
                self.image6.hidden = YES;
                [self hideshowSetUp];
            }
//            else{
//                self.img6.image = [UIImage imageNamed:@"NoPlaceFound"];
//            }
            
            [self.act6 stopAnimating];
        }];
    }
    else{
        [self.act6 stopAnimating];
    }
    
    //TODO: Test
//        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnEditProfileImageClicked:)];
//        [self.edit1 addGestureRecognizer:singleTapGestureRecognizer];
    
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self localize];
    
    self.vwBack.center = CGPointMake(30, self.lblTitle.center.y);
    
    self.vw1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    self.vw2.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    self.vw3.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    self.vw4.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    self.vw5.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    self.vw6.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    
    UIColor *bgSelect=Theme_Color;
    
    self.bottomImportView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"RectButton"]];

    [self.img1.layer setBorderColor:[bgSelect CGColor]];
    [self.img1.layer setBorderWidth: 1.0];
    [self.img2.layer setBorderColor:[bgSelect CGColor]];
    [self.img2.layer setBorderWidth: 1.0];
    [self.img3.layer setBorderColor:[bgSelect CGColor]];
    [self.img3.layer setBorderWidth: 1.0];
    [self.img4.layer setBorderColor:[bgSelect CGColor]];
    [self.img4.layer setBorderWidth: 1.0];
    [self.img5.layer setBorderColor:[bgSelect CGColor]];
    [self.img5.layer setBorderWidth: 1.0];
    [self.img6.layer setBorderColor:[bgSelect CGColor]];
    [self.img6.layer setBorderWidth: 1.0];
    
}
-(void) hideshowSetUp{
    //edit buttons
    self.edit1.hidden=NO;
    self.edit2.hidden=NO;
    self.edit3.hidden=NO;
    self.edit4.hidden=NO;
    self.edit5.hidden=NO;
    self.edit6.hidden=NO;
    
    //edit icons
    self.editimg1.hidden=NO;
    self.editimg2.hidden=NO;
    self.editimg3.hidden=NO;
    self.editimg4.hidden=NO;
    self.editimg5.hidden=NO;
    self.editimg6.hidden=NO;
    
    self.view1.hidden=YES;
    self.view2.hidden=NO;
    self.bottomImportView.hidden=YES;
    self.bottomNextView.hidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
     [self.vw1 bringSubviewToFront:self.edit1];
    
    if([appDelegate.flag_next isEqualToString:@"next_fb"]){
        
        //coming back from facebook import
        
        //button for edit
        self.edit1.hidden=NO;
        self.edit2.hidden=NO;
        self.edit3.hidden=NO;
        self.edit4.hidden=NO;
        self.edit5.hidden=NO;
        self.edit6.hidden=NO;
        
        //edit icon
        self.editimg1.hidden=NO;
        self.editimg2.hidden=NO;
        self.editimg3.hidden=NO;
        self.editimg4.hidden=NO;
        self.editimg5.hidden=NO;
        self.editimg6.hidden=NO;
        self.view1.hidden=YES;
        self.view2.hidden=NO;
        self.bottomImportView.hidden=YES;
        self.bottomNextView.hidden=NO;
        
        int editedImage= appDelegate.editImage.intValue;
        if([arrDeletedImages containsObject:[NSString stringWithFormat:@"%d", editedImage]]){
            [arrDeletedImages removeObject:[NSString stringWithFormat:@"%d", editedImage]];
        }
        NSLog(@"Deleted images: %@",arrDeletedImages);
        if(editedImage>0 && (! [appDelegate.editImageName isEqualToString:@""])){
            
            //when editing image
            
            UIImageView *temp=[[UIImageView alloc] init];
            [temp sd_setImageWithURL: [Util EncodedURL:appDelegate.editImageName] completed:^(UIImage * _Nullable result1, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if(flagForCropper){
                    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:result1];
                    cropController.delegate = self;
                    cropController.customAspectRatio = CGSizeMake(1, 1);
                    cropController.aspectRatioLockEnabled = YES;
                    cropController.rotateButtonsHidden = YES;
                    cropController.rotateClockwiseButtonHidden = YES;
                    cropController.aspectRatioPickerButtonHidden = YES;
                    cropController.resetAspectRatioEnabled = NO;
                    [self presentViewController:cropController animated:YES completion:nil];
                    flagForCropper = false;
                }
                else{
                    appDelegate.editImageName=@"";
                }
                
//                                switch (editedImage) {
//                                    case 1:
//                                        self.img1.image=result1;
//                                        self.image1.hidden=YES;
//                                        if([appDelegate.selectedFbImages count]>0){
//                                            [appDelegate.selectedFbImages replaceObjectAtIndex:0 withObject:appDelegate.editImageName];
//                                        }else{
//                                            [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
//                                        }
//
//                                        break;
//                                    case 2:
//                                        self.img2.image=result1;
//                                        if([appDelegate.selectedFbImages count]>1){
//                                            [appDelegate.selectedFbImages replaceObjectAtIndex:1 withObject:appDelegate.editImageName];
//                                        }else{
//                                            NSString *asset1 = [[NSString alloc] init];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
//                                        }
//                                        self.image2.hidden=YES;
//                                        break;
//                                    case 3:
//                                        self.img3.image=result1;
//                                        self.image3.hidden=YES;
//                                        if([appDelegate.selectedFbImages count]>2){
//                                            [appDelegate.selectedFbImages replaceObjectAtIndex:2 withObject:appDelegate.editImageName];
//                                        }else{
//                                            NSString *asset1 = [[NSString alloc] init];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
//                                        }
//                                        break;
//                                    case 4:
//                                        self.img4.image=result1;
//                                        self.image4.hidden=YES;
//                                        if([appDelegate.selectedFbImages count]>3){
//                                            [appDelegate.selectedFbImages replaceObjectAtIndex:3 withObject:appDelegate.editImageName];
//                                        }else{
//                                            NSString *asset1 = [[NSString alloc] init];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
//                                        }
//                                        break;
//                                    case 5:
//                                        self.img5.image=result1;
//                                        self.image5.hidden=YES;
//                                        if([appDelegate.selectedFbImages count]>4){
//                                            [appDelegate.selectedFbImages replaceObjectAtIndex:4 withObject:appDelegate.editImageName];
//                                        }else{
//                                            NSString *asset1 = [[NSString alloc] init];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
//                                        }
//                                        break;
//                                    case 6:
//                                        self.img6.image=result1;
//                                        self.image6.hidden=YES;
//                                        if([appDelegate.selectedFbImages count]>5){
//                                            [appDelegate.selectedFbImages replaceObjectAtIndex:5 withObject:appDelegate.editImageName];
//                                        }else{
//                                            NSString *asset1 = [[NSString alloc] init];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedFbImages addObject:asset1];
//                                            [appDelegate.selectedImages addObject:appDelegate.editImageName];
//                                        }
//                                        break;
//
//                                    default:
//                                        break;
//                                }
                           }];
            
//            appDelegate.editImageName=@"";
//            editedImage=-1;
            
        }
//        else{
//            for(int i=0;i<appDelegate.selectedFbImages.count;i++){
//
//                //import images from facebook, first time
//
//                UIImageView *temp=[[UIImageView alloc] init];
//                [temp sd_setImageWithURL: [Util EncodedURL :[appDelegate.selectedFbImages objectAtIndex:i]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//                    switch (i) {
//                        case 0:
//                            self.img1.image=image;
//                            self.image1.hidden=YES;
//                            break;
//                        case 1:
//                            self.img2.image=image;
//                            self.image2.hidden=YES;
//                            break;
//                        case 2:
//                            self.img3.image=image;
//                            self.image3.hidden=YES;
//                            break;
//                        case 3:
//                            self.img4.image=image;
//                            self.image4.hidden=YES;
//                            break;
//                        case 4:
//                            self.img5.image=image;
//                            self.image5.hidden=YES;
//                            break;
//                        case 5:
//                            self.img6.image=image;
//                            self.image6.hidden=YES;
//                            break;
//                        default:
//                            break;
//                    }
//                }];
//            }
//            NSString *asset = [[NSString alloc] init];
//            while(appDelegate.selectedFbImages.count<6){
//                [appDelegate.selectedFbImages addObject:asset];
//            }
//
//        }
    }
    
    
    if([appDelegate.flag_next isEqualToString:@"next"]){
        //coming back from gallery
//        self.edit1.hidden=NO;
//        self.edit2.hidden=NO;
//        self.edit3.hidden=NO;
//        self.edit4.hidden=NO;
//        self.edit5.hidden=NO;
//        self.edit6.hidden=NO;
//        self.editimg1.hidden=NO;
//        self.editimg2.hidden=NO;
//        self.editimg3.hidden=NO;
//        self.editimg4.hidden=NO;
//        self.editimg5.hidden=NO;
//        self.editimg6.hidden=NO;
//
        int editedImage= appDelegate.editImage.intValue;
        if(editedImage>0 && (! [appDelegate.editImageName isEqualToString:@""])){
            
            //editing image
            PHImageManager *manager = [PHImageManager defaultManager];
            PHAsset *asset = appDelegate.asset;


//            [manager requestImageForAsset:asset
//                               targetSize:CGSizeMake(300,300)
//                              contentMode:PHImageContentModeAspectFit
//                                  options:nil
//                            resultHandler:^(UIImage * _Nullable result1, NSDictionary * _Nullable info) {
//
//                                .
//
//                            }];
            
            [manager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                
                UIImage *image = [UIImage imageWithData:imageData];
                
                if(flagForCropper){
                    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:image];
                    cropController.delegate = self;
                    cropController.customAspectRatio = CGSizeMake(1, 1);
                    cropController.aspectRatioLockEnabled = YES;
                    cropController.rotateButtonsHidden = YES;
                    cropController.rotateClockwiseButtonHidden = YES;
                    cropController.aspectRatioPickerButtonHidden = YES;
                    cropController.resetAspectRatioEnabled = NO;
                    [self presentViewController:cropController animated:YES completion:nil];
                    flagForCropper = false;
                }
                else{
                    appDelegate.editImageName=@"";
                }

            }];

            
            
        }
//        else if(appDelegate.selectedImages.count>0 && [appDelegate.flag_next isEqualToString:@"next"] ){
//            //import from gallery
//            for(int i=0;i<appDelegate.selectedImages.count;i++){
//
//                PHImageManager *manager = [PHImageManager defaultManager];
//                PHAsset *asset = [appDelegate.selectedImagesAssets objectAtIndex:i];
//
//                [manager requestImageForAsset:asset
//                                   targetSize:CGSizeMake(300,300)
//                                  contentMode:PHImageContentModeAspectFit
//                                      options:nil
//                                resultHandler:^(UIImage * _Nullable result1, NSDictionary * _Nullable info) {
//
//                                    switch (i) {
//                                        case 0:
//                                            self.img1.image=result1;
//                                            self.image1.hidden=YES;
//                                            break;
//                                        case 1:
//                                            self.img2.image=result1;
//                                            self.image2.hidden=YES;
//                                            break;
//                                        case 2:
//                                            self.img3.image=result1;
//                                            self.image3.hidden=YES;
//                                            break;
//                                        case 3:
//                                            self.img4.image=result1;
//                                            self.image4.hidden=YES;
//                                            break;
//                                        case 4:
//                                            self.img5.image=result1;
//                                            self.image5.hidden=YES;
//                                            break;
//                                        case 5:
//                                            self.img6.image=result1;
//                                            self.image6.hidden=YES;
//                                            break;
//                                        default:
//                                            break;
//                                    }
//
//                                }];
//
//
//
//            }
//            PHAsset *asset = [[PHAsset alloc] init];
//            while(appDelegate.selectedImages.count<6){
//                [appDelegate.selectedImages addObject:asset];
//            }
//
//        }
//        self.view1.hidden=YES;
//        self.view2.hidden=NO;
//        self.bottomImportView.hidden=YES;
//        self.bottomNextView.hidden=NO;
        
    }
    
}

#pragma mark - btnClicked
/*!
 * @discussion Called when back button is clicked
 * @param sender For indentifying sender
 */
- (IBAction)btnBackClicked:(id)sender
{
    appDelegate.flag_next=@"back";
    [self.navigationController popViewControllerAnimated:YES];
}
/*!
 * @discussion When Import images from Gallery is selected
 * @param sender For identifying Sender
 */
- (IBAction)btnImportGalleryClicked:(id)sender {
    
    //ask for gallery or camera
    
    flagForCropper = true;
    galleryImport =  true;
//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:[MCLocalization stringForKey:@"Import From"] preferredStyle:UIAlertControllerStyleActionSheet];
//
//    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//
//        [self dismissViewControllerAnimated:YES completion:^{
//
//        }];
//    }]];
//
//
//    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Gallery"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        //import from gallery
    
        appDelegate.editImage = @"1";
        appDelegate.editImageName=@"Name";
        
        GalleryVC *vc=[[GalleryVC alloc] initWithNibName:@"GalleryVC" bundle:nil];
       
        UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:vc];
        
        //now present this navigation controller modally
        [self presentViewController:navigationController
                           animated:YES
                         completion:^{
                             
                         }];
        
        
//    }]];
//    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Camera"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//
//        //open camera
//        appDelegate.editImage = @"1";
//      //  appDelegate.editImageName=@"Name";
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//
//        [self presentViewController:picker animated:YES completion:NULL];
//    }]];
//    // Present action sheet.
//    [self presentViewController:actionSheet animated:YES completion:nil];

    
}
/*!
 * @discussion When Image is selected for Editting
 * @param sender For identifying Sender
 */
- (IBAction)btnEditClicked:(id)sender {
    
    //check which image should be edited
    flagForCropper = true;
    UIButton *btn=(UIButton *)sender;

    switch (btn.tag) {
        case 1:
            appDelegate.editImage=@"1";
            break;
        case 2:
            appDelegate.editImage=@"2";
            break;
        case 3:
            appDelegate.editImage=@"3";
            break;
        case 4:
            appDelegate.editImage=@"4";
            break;
        case 5:
            appDelegate.editImage=@"5";
            break;
        case 6:
            appDelegate.editImage=@"6";
            break;
        default:
            break;
    }
    
    appDelegate.editImageName=@"Name";
    
    //option for editing image
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:[MCLocalization stringForKey:@"Select Image From"] preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
//    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Facebook"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//
//        FacebookImageGalleryVC *vc=[[FacebookImageGalleryVC alloc] initWithNibName:@"FacebookImageGalleryVC" bundle:nil];
//
//        UINavigationController *navigationController =
//        [[UINavigationController alloc] initWithRootViewController:vc];
//
//        //now present this navigation controller modally
//        [self presentViewController:navigationController
//                           animated:YES
//                         completion:^{
//
//                         }];
//
//    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Gallery"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        GalleryVC *vc=[[GalleryVC alloc] initWithNibName:@"GalleryVC" bundle:nil];

        UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:vc];
        
        //now present this navigation controller modally
        [self presentViewController:navigationController
                           animated:YES
                         completion:^{
                             
                         }];
        

    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Camera"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //open camera
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }]];
    
//    if(btn.tag != 1){
    
        [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Delete"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            //delete image
            [arrDeletedImages addObject:[NSString stringWithFormat:@"%ld", (long)btn.tag]];
            NSLog(@"Deleted images: %@",arrDeletedImages);
            switch (btn.tag) {

                case 2:
                    self.img2.image = nil;
                    self.image2.hidden = NO;
                    break;
                case 3:
                    self.img3.image = nil;
                    self.image3.hidden = NO;
                    break;
                case 4:
                    self.img4.image = nil;
                    self.image4.hidden = NO;
                    break;
                case 5:
                    self.img5.image = nil;
                    self.image5.hidden = NO;
                    break;
                case 6:
                    self.img6.image = nil;
                    self.image6.hidden = NO;
                    break;
                default:
                    break;
            }
            [self deleteImages];
            
        }]];
//    }
//    else{
//
//    }
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];

}
/*!
 * @discussion When Profile Image is selected for Editting
 * @param sender For identifying Sender
 */
- (IBAction)btnEditProfileImageClicked:(id)sender {
    
    //check which image should be edited
    
//    UIButton *btn=(UIButton *)sender;
    flagForCropper = true;
    appDelegate.editImage=@"1";
    appDelegate.editImageName=@"Name";
    
    //option for editing image
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:[MCLocalization stringForKey:@"Select Image From"] preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
//    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Facebook"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//
//        FacebookImageGalleryVC *vc=[[FacebookImageGalleryVC alloc] initWithNibName:@"FacebookImageGalleryVC" bundle:nil];
//
//        UINavigationController *navigationController =
//        [[UINavigationController alloc] initWithRootViewController:vc];
//
//        //now present this navigation controller modally
//        [self presentViewController:navigationController
//                           animated:YES
//                         completion:^{
//
//                         }];
//
//    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Gallery"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        GalleryVC *vc=[[GalleryVC alloc] initWithNibName:@"GalleryVC" bundle:nil];
        
        UINavigationController *navigationController =
        [[UINavigationController alloc] initWithRootViewController:vc];
        
        //now present this navigation controller modally
        [self presentViewController:navigationController
                           animated:YES
                         completion:^{
                             
                         }];
        
        
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Camera"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //open camera
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }]];
    
  
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
/*!
 * @discussion When Next is Clicked, Upload images and Go to next Step of registration process
 * @param sender For identifying Sender
 */
- (IBAction)btnNextClicked:(id)sender {
    
    //upload images
//    [self updateImages];

    [appDelegate SetData:@"DatePref" value:@"Page"];
    [appDelegate RemoveData:@"flagBack"];
    DatePreferencesVC *vc=[[DatePreferencesVC alloc] initWithNibName:@"DatePreferencesVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
/*!
 * @discussion When Import images from Facebook is selected
 * @param sender For identifying Sender
 */
- (IBAction)btnFaceboookImportClicked:(id)sender {
    
    flagForCropper = true;
  
    //open camera
    appDelegate.editImage = @"1";
    appDelegate.editImageName=@"Name";
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
//    appDelegate.editImage = @"1";
//
//    if ([FBSDKAccessToken currentAccessToken]) {
//        FacebookImageGalleryVC *vc=[[FacebookImageGalleryVC alloc] initWithNibName:@"FacebookImageGalleryVC" bundle:nil];
//        UINavigationController *navigationController =
//        [[UINavigationController alloc] initWithRootViewController:vc];
//
//        //now present this navigation controller modally
//        [self presentViewController:navigationController
//                           animated:YES
//                         completion:^{
//
//                         }];
//    } else  {
//        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//        [login setLoginBehavior:FBSDKLoginBehaviorWeb];
//
//        [login logInWithReadPermissions: @[@"public_profile", @"user_photos"]fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//            if (error) {
//                // Process error
//            } else if (result.isCancelled) {
//                // Handle cancellations
//            } else {
//
//
//
//
//                FacebookImageGalleryVC *vc=[[FacebookImageGalleryVC alloc] initWithNibName:@"FacebookImageGalleryVC" bundle:nil];
//
//                UINavigationController *navigationController =
//                [[UINavigationController alloc] initWithRootViewController:vc];
//
//                //now present this navigation controller modally
//                [self presentViewController:navigationController
//                                   animated:YES
//                                 completion:^{
//
//                                 }];
//            }
//        }];
//    }
  
}
#pragma mark- image picker delegate
/*!
 * @discussion When Images is Taken from Camera
 * @param picker For identifying picker
 * @param info Contain information about Image taken from Camera
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
//    int editedImage= appDelegate.editImage.intValue;
    
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:chosenImage];
    cropController.delegate = self;
    cropController.customAspectRatio = CGSizeMake(1, 1);
    cropController.aspectRatioLockEnabled = YES;
    cropController.rotateButtonsHidden = YES;
    cropController.rotateClockwiseButtonHidden = YES;
    cropController.aspectRatioPickerButtonHidden = YES;
    cropController.resetAspectRatioEnabled = NO;
  //  [self presentViewController:cropController animated:YES completion:nil];
    
//    if([appDelegate.flag_next isEqualToString:@"next_fb"] || cameraEdit || [appDelegate.flag_next isEqualToString:@"next"] || editedImage>0){
//
//        //image should be edited
//        if(editedImage>0){
//            if([arrDeletedImages containsObject:[NSString stringWithFormat:@"%d", editedImage]]){
//                [arrDeletedImages removeObject:[NSString stringWithFormat:@"%d", editedImage]];
//            }
//            NSLog(@"Deleted images: %@",arrDeletedImages);
//            switch (editedImage) {
//                case 1:
//                    self.img1.image=chosenImage;
//                    self.image1.hidden=YES;
//                    break;
//                case 2:
//                    self.img2.image=chosenImage;
//                    self.image2.hidden=YES;
//                    break;
//                case 3:
//                    self.img3.image=chosenImage;
//                    self.image3.hidden=YES;
//                    break;
//                case 4:
//                    self.img4.image=chosenImage;
//                    self.image4.hidden=YES;
//                    break;
//                case 5:
//                    self.img5.image=chosenImage;
//                    self.image5.hidden=YES;
//                    break;
//                case 6:
//                    self.img6.image=chosenImage;
//                    self.image6.hidden=YES;
//                    break;
//                default:
//                    break;
//            }
//            appDelegate.editImage=@"";
//            appDelegate.editImageName=@"";
//            editedImage=-1;
//        }
//    }
//    else{
    
        //set first image-->import from camera
//        self.img1.image=chosenImage;
        cameraEdit=YES;
        
//        //edit buttons
//        self.edit1.hidden=NO;
//        self.edit2.hidden=NO;
//        self.edit3.hidden=NO;
//        self.edit4.hidden=NO;
//        self.edit5.hidden=NO;
//        self.edit6.hidden=NO;
//
//        //edit icons
//        self.editimg1.hidden=NO;
//        self.editimg2.hidden=NO;
//        self.editimg3.hidden=NO;
//        self.editimg4.hidden=NO;
//        self.editimg5.hidden=NO;
//        self.editimg6.hidden=NO;
//
//        //numbering images
//        self.image1.hidden=YES;
//
//        self.view1.hidden=YES;
//        self.view2.hidden=NO;
//        self.bottomImportView.hidden=YES;
//        self.bottomNextView.hidden=NO;
////    }
//    appDelegate.flag_next=@"back";
  
//    [picker dismissViewControllerAnimated:YES completion:NULL];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:cropController animated:YES completion:nil];
        //[self.navigationController pushViewController:cropController animated:YES];
    }];
    
}
/*!
 * @discussion When Camera is Cancelled
 * @param picker For identifying picker
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    appDelegate.flag_next=@"back";
    appDelegate.editImage=@"";
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - Api Calls
///*!
// * @discussion WebService call for Image uploading
// */
//-(void) updateImages
//{
//    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
//     {
//         SHOW_LOADER_ANIMTION();
//
//         if (responseObject == false)
//         {
//             HIDE_PROGRESS;
//             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
//             return ;
//         }
//         else {
//             //image uploading
//             NSString *str1=@"edit_gallery_images";
//             NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
//             NSMutableDictionary *dict2=[[NSMutableDictionary alloc] init];
//
//             [dict1 setValue:[appDelegate GetData:kuserid] forKey:@"id"];
//
//             if (self.img1.image!=nil ) {
//                 NSData *imaagedata1=UIImageJPEGRepresentation(self.img1.image, 0.80);
//                 [dict2 setValue:imaagedata1 forKey:@"img1"];
//
//                 if(self.img2.image!=nil){
//                     NSData *imaagedata2=[[NSData alloc] init];
//                     imaagedata2=UIImageJPEGRepresentation(self.img2.image, 0.80);
//                     [dict2 setValue:imaagedata2 forKey:@"img2"];
//                 }
//                 else{
//                     [dict2 setValue:nil forKey:@"img2"];
//                 }
//
//
//                 if(self.img3.image!=nil){
//                     NSData *imaagedata3=[[NSData alloc] init];
//                     imaagedata3=UIImageJPEGRepresentation(self.img3.image, 0.80);
//                     [dict2 setValue:imaagedata3 forKey:@"img3"];
//                 }
//                 else{
//
//                     [dict2 setValue:nil forKey:@"img3"];
//                 }
//
//
//                 if(self.img4.image!=nil){
//                     NSData *imaagedata4=[[NSData alloc] init];
//                     imaagedata4=UIImageJPEGRepresentation(self.img4.image, 0.80);
//                     [dict2 setValue:imaagedata4 forKey:@"img4"];
//                 }
//                 else{
//                     [dict2 setValue:nil forKey:@"img4"];
//                 }
//
//                 if(self.img5.image!=nil){
//                     NSData *imaagedata5=[[NSData alloc] init];
//                     imaagedata5=UIImageJPEGRepresentation(self.img5.image, 0.80);
//                     [dict2 setValue:imaagedata5 forKey:@"img5"];
//                 }
//                 else{
//                     [dict2 setValue:nil forKey:@"img5"];
//                 }
//
//                 if(self.img6.image!=nil){
//                     NSData *imaagedata6=UIImageJPEGRepresentation(self.img6.image, 0.80);
//                     [dict2 setValue:imaagedata6 forKey:@"img6"];
//                 }
//                 else{
//
//                     [dict2 setValue:nil forKey:@"img6"];
//                 }
//
//
//             }
//
//
//             NSString *_url1 = [NSString stringWithFormat:@"%@%@",appURL,str1];
//             [[ApiManager sharedInstance] apiCallWithImage:_url1 parameterDict:dict1 imageDataDictionary:dict2 CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
//                 //code
//
//
//                 if(success && [[dictionary valueForKey:@"error"] intValue]==0)
//                 {
//
//                     [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img1"]] value:kimg1];
//                     [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img1"]] value:kprofileimage];
//                     if(self.img2.image!=nil){
//                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img2"]] value:kimg2];
//                     }
//
//                     if(self.img3.image!=nil){
//                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img3"]] value:kimg3];
//                     }
//                     if(self.img4.image!=nil){
//                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img4"]] value:kimg4];
//                     }
//                     if(self.img5.image!=nil){
//                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img5"]] value:kimg5];
//                     }
//                     if(self.img6.image!=nil){
//                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img6"]] value:kimg6];
//                     }
//
//
//                     HIDE_PROGRESS;
//                     [appDelegate SetData:@"DatePref" value:@"Page"];
//                     [appDelegate RemoveData:@"flagBack"];
//                     DatePreferencesVC *vc=[[DatePreferencesVC alloc] initWithNibName:@"DatePreferencesVC" bundle:nil];
//                     [self.navigationController pushViewController:vc animated:YES];
//                 }
//
//             }];
//         }
//     }];
//}
/*!
 * @discussion Webservice call for updating gallery images
 */
-(void) updateImages{
    
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else
         {
             NSString *str1=@"edit_gallery_images";
             NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
             NSMutableDictionary *dict2=[[NSMutableDictionary alloc] init];
             
             [dict1 setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             
             if (flagUploadImage1) {
                 
                 NSData *imaagedata1=UIImageJPEGRepresentation(self.img1.image, 0.80);
                 [dict2 setValue:imaagedata1 forKey:@"img1"];
             }
             else
             {
                 [dict2 setValue:nil forKey:@"img1"];
             }
             if(!flagUploadImage2){
                 [dict2 setValue:nil forKey:@"img2"];
             }
             else{
                 NSData *imaagedata2=UIImageJPEGRepresentation(self.img2.image, 0.80);
                 [dict2 setValue:imaagedata2 forKey:@"img2"];
             }
             
             if(flagUploadImage3){
                 NSData *imaagedata3=UIImageJPEGRepresentation(self.img3.image, 0.80);
                 [dict2 setValue:imaagedata3 forKey:@"img3"];
             }
             else{
                 [dict2 setValue:nil forKey:@"img3"];
             }
             
             if(flagUploadImage4){
                 NSData *imaagedata4=UIImageJPEGRepresentation(self.img4.image, 0.80);
                 [dict2 setValue:imaagedata4 forKey:@"img4"];
             }
             else{
                 [dict2 setValue:nil forKey:@"img4"];
             }
             if(flagUploadImage5){
                 NSData *imaagedata5=UIImageJPEGRepresentation(self.img5.image, 0.80);
                 [dict2 setValue:imaagedata5 forKey:@"img5"];
             }
             else{
                 [dict2 setValue:nil forKey:@"img5"];
             }
             if(flagUploadImage6){
                 NSData *imaagedata6=UIImageJPEGRepresentation(self.img6.image, 0.80);
                 [dict2 setValue:imaagedata6 forKey:@"img6"];
             }
             else{
                 [dict2 setValue:nil forKey:@"img6"];
             }
             
             
             NSString *_url1 = [NSString stringWithFormat:@"%@%@",appURL,str1];
             [[ApiManager sharedInstance] apiCallWithImage:_url1 parameterDict:dict1 imageDataDictionary:dict2 CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 if(success &&  [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     if(flagUploadImage1)
                     {
                         flagUploadImage1=false;
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img1"]] value:kimg1];
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img1"]] value:kprofileimage];
                     }
                     if(flagUploadImage2)
                     {
                         flagUploadImage2=false;
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img2"]] value:kimg2];
                     }
                     if(flagUploadImage3)
                     {
                         flagUploadImage3=false;
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img3"]] value:kimg3];
                     }
                     if(flagUploadImage4)
                     {
                         flagUploadImage4=false;
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img4"]] value:kimg4];
                     }
                     if(flagUploadImage5)
                     {
                         flagUploadImage5=false;
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img5"]] value:kimg5];
                     }
                     if(flagUploadImage6)
                     {
                         flagUploadImage6=false;
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[dictionary valueForKey:@"gallary"] valueForKey:@"img6"]] value:kimg6];
                     }
                 }
                 
             }];
         }
     }];
}
/*!
 * @discussion Webservice call for deleting gallery images
 */
-(void) deleteImages
{
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         
         if (responseObject == false)
         {
             //HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             
             NSString *str=@"delete_galleryimage"; //userid, url
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"user_id"];
             NSString *strKey = [[NSString alloc] init];
             strKey = [NSString stringWithFormat:@"img%@",arrDeletedImages[0]];
             //[appDelegate RemoveData:[NSString stringWithFormat:@"kimg%@", arrDeletedImages[0]]];
             for(int i=1;i<arrDeletedImages.count;i++){
                 strKey = [NSString stringWithFormat:@"%@,img%@",strKey,arrDeletedImages[i]];
                 // [appDelegate RemoveData:[NSString stringWithFormat:@"kimg%@", arrDeletedImages[i]]];
             }
             [dict setValue:strKey forKey:@"key"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     [arrDeletedImages removeAllObjects];
                 }
                 else
                 {
                     
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
                 //                 if(flagUploadImage1||flagUploadImage2||flagUploadImage3||flagUploadImage4||flagUploadImage5||flagUploadImage6){
                 //                     [self updateImages];
                 //                 }
             }];
         }
     }];
}
#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblTitle.text=[MCLocalization stringForKey:@"UPLOAD PHOTOS"];
    
    self.lblInfo.text=[MCLocalization stringForKey:@"Profile with photos get 10 times as many responses."];
    self.lblInfo2.text=[MCLocalization stringForKey:@"Tap on Photo to Change"];
    self.lblImport1.text=[MCLocalization stringForKey:@"Camera"];
    self.lblImport2.text=[MCLocalization stringForKey:@"Import"];
    
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, self.lblTitle.frame.size.width, 1);
    
    [self.btnNext setTitle:[MCLocalization stringForKey:@"NEXT"] forState:UIControlStateNormal];
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self setRTL];
    }
    
//    [self.lblInfo sizeToFit];
//    self.lblInfo.frame = CGRectMake((SCREEN_SIZE.width - self.lblInfo.frame.size.width + 10 + self.imgInfo.frame.size.width)/2, self.lblInfo.frame.origin.y, self.lblInfo.frame.size.width, self.lblInfo.frame.size.height);
//    self.imgInfo.frame = CGRectMake(self.lblInfo.frame.origin.x - self.imgInfo.frame.size.width - 5 , self.lblInfo.frame.origin.y, self.imgInfo.frame.size.width, self.imgInfo.frame.size
//                                    .height);
//    [self.lblInfo2 sizeToFit];
//    self.lblInfo2.frame = CGRectMake((SCREEN_SIZE.width - self.lblInfo2.frame.size.width + 10 - self.imgInfo2.frame.size.width)/2, self.lblInfo2.frame.origin.y, self.lblInfo2.frame.size.width, self.lblInfo2.frame.size.height);
//    self.imgInfo2.frame = CGRectMake(self.lblInfo2.frame.origin.x - self.imgInfo2.frame.size.width - 5 , self.lblInfo2.frame.origin.y, self.imgInfo2.frame.size.width, self.imgInfo2.frame.size
//                                    .height);
    
}
/*!
 * @discussion set RTL UI
 */
- (void)setRTL{

    self.lblInfo.textAlignment = NSTextAlignmentRight;
    self.lblInfo2.textAlignment = NSTextAlignmentRight;
}
/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.view setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblTitle setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.img1 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img2 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img3 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img4 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img5 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img6 setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.image1 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.image2 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.image3 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.image4 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.image5 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.image6 setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblInfo setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblInfo2 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwFb setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwGallery setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.bottomNextView setTransform:CGAffineTransformMakeScale(-1, 1)];
    
}
#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)updateImageViewWithImage:(UIImage *)result1 fromCropViewController:(TOCropViewController *)cropViewController
{
    PHAsset *asset = appDelegate.asset;
    int editedImage= appDelegate.editImage.intValue;
    switch (editedImage) {
        case 1:
            flagUploadImage1 = true;
            self.img1.image=result1;
            self.image1.hidden=YES;
            break;
        case 2:
            flagUploadImage2 = true;
            self.img2.image=result1;
            self.image2.hidden=YES;
            break;
        case 3:
            flagUploadImage3 = true;
            self.img3.image=result1;
            self.image3.hidden=YES;
            break;
        case 4:
            flagUploadImage4 = true;
            self.img4.image=result1;
            self.image4.hidden=YES;
            break;
        case 5:
            flagUploadImage5 = true;
            self.img5.image=result1;
            self.image5.hidden=YES;
            break;
        case 6:
            flagUploadImage6 = true;
            self.img6.image=result1;
            self.image6.hidden=YES;
            break;
            
        default:
            break;
    }
    
    if([appDelegate.flag_next isEqualToString:@"next"]){
    
        switch (editedImage) {
            case 1:
                if([appDelegate.selectedImages count]>0){
                    [appDelegate.selectedImages replaceObjectAtIndex:0 withObject:asset];
                }else{
                    [appDelegate.selectedImages addObject:asset];
                }
                
                break;
            case 2:
                if([appDelegate.selectedImages count]>1){
                    [appDelegate.selectedImages replaceObjectAtIndex:1 withObject:asset];
                }else{
                    PHAsset *asset1 = [[PHAsset alloc] init];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset];
                }
                break;
            case 3:
                if([appDelegate.selectedImages count]>2){
                    [appDelegate.selectedImages replaceObjectAtIndex:2 withObject:asset];
                }else{
                    PHAsset *asset1 = [[PHAsset alloc] init];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset];
                }
                break;
            case 4:
                if([appDelegate.selectedImages count]>3){
                    [appDelegate.selectedImages replaceObjectAtIndex:3 withObject:asset];
                }else{
                    PHAsset *asset1 = [[PHAsset alloc] init];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset];
                }
                break;
            case 5:
                if([appDelegate.selectedImages count]>4){
                    [appDelegate.selectedImages replaceObjectAtIndex:4 withObject:asset];
                }else{
                    PHAsset *asset1 = [[PHAsset alloc] init];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset];
                }
                break;
            case 6:
                if([appDelegate.selectedImages count]>5){
                    [appDelegate.selectedImages replaceObjectAtIndex:5 withObject:asset];
                }else{
                    PHAsset *asset1 = [[PHAsset alloc] init];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset1];
                    [appDelegate.selectedImages addObject:asset];
                }
                break;
                
            default:
                break;
        }
    
    }
    

    if([appDelegate.flag_next isEqualToString:@"next_fb"]){
        switch (editedImage) {
            case 1:
                if([appDelegate.selectedFbImages count]>0){
                    [appDelegate.selectedFbImages replaceObjectAtIndex:0 withObject:appDelegate.editImageName];
                }else{
                    [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
                }
                
                break;
            case 2:

                if([appDelegate.selectedFbImages count]>1){
                    [appDelegate.selectedFbImages replaceObjectAtIndex:1 withObject:appDelegate.editImageName];
                }else{
                    NSString *asset1 = [[NSString alloc] init];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
                }
                break;
            case 3:

                if([appDelegate.selectedFbImages count]>2){
                    [appDelegate.selectedFbImages replaceObjectAtIndex:2 withObject:appDelegate.editImageName];
                }else{
                    NSString *asset1 = [[NSString alloc] init];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
                }
                break;
            case 4:

                if([appDelegate.selectedFbImages count]>3){
                    [appDelegate.selectedFbImages replaceObjectAtIndex:3 withObject:appDelegate.editImageName];
                }else{
                    NSString *asset1 = [[NSString alloc] init];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
                }
                break;
            case 5:

                if([appDelegate.selectedFbImages count]>4){
                    [appDelegate.selectedFbImages replaceObjectAtIndex:4 withObject:appDelegate.editImageName];
                }else{
                    NSString *asset1 = [[NSString alloc] init];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:appDelegate.editImageName];
                }
                break;
            case 6:

                if([appDelegate.selectedFbImages count]>5){
                    [appDelegate.selectedFbImages replaceObjectAtIndex:5 withObject:appDelegate.editImageName];
                }else{
                    NSString *asset1 = [[NSString alloc] init];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedFbImages addObject:asset1];
                    [appDelegate.selectedImages addObject:appDelegate.editImageName];
                }
                break;
                
            default:
                break;
        }
   
    }
    
    if(cameraEdit || galleryImport){
        //edit buttons
        self.edit1.hidden=NO;
        self.edit2.hidden=NO;
        self.edit3.hidden=NO;
        self.edit4.hidden=NO;
        self.edit5.hidden=NO;
        self.edit6.hidden=NO;
        
        //edit icons
        self.editimg1.hidden=NO;
        self.editimg2.hidden=NO;
        self.editimg3.hidden=NO;
        self.editimg4.hidden=NO;
        self.editimg5.hidden=NO;
        self.editimg6.hidden=NO;
        
        //numbering images
        self.image1.hidden=YES;
        
        self.view1.hidden=YES;
        self.view2.hidden=NO;
        self.bottomImportView.hidden=YES;
        self.bottomNextView.hidden=NO;
        //    }
        appDelegate.flag_next=@"back";
    }
    
    appDelegate.editImageName=@"";
    editedImage=-1;
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        [self updateImages];
    }];

}
@end
