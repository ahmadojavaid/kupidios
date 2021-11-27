//
//  GalleryVC.m
//  CupidLove
//
//  Created by APPLE on 21/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "GalleryVC.h"
#import "ImageCell1.h"
#import "AppDelegate.h"
#import <Photos/Photos.h>


@interface GalleryVC ()
@property (strong,nonatomic) IBOutlet UICollectionView *colImages;
@property (strong,nonatomic) PHImageRequestOptions *requestOptions;
@property (strong,nonatomic) NSMutableArray *assets;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;

@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;

@property(weak,nonatomic) IBOutlet UIView *vwBack;
@property (weak,nonatomic) IBOutlet UIView *vwTitle;
@end

@implementation GalleryVC
{
    int imgCount;
    NSMutableArray *arrSelected;
    NSURL *imageName;
    int deselectedIdex;
    NSInteger cellIndex[6];//for numbering image labels
    int maxSelect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.colImages setTransform:CGAffineTransformMakeScale(-1, 1)];
    }
    
    if([appDelegate.editImageName isEqualToString:@"Name"])
    {
        //edit images
        maxSelect=1;
        appDelegate.editImageName=@"";
    }
    else{
        //import images
//        maxSelect=6;
        maxSelect=1;
        appDelegate.editImageName=@"";
        
        [appDelegate.selectedImages removeAllObjects];
    }
    
    deselectedIdex= -1; //none is deselecting
    imgCount=0;
   
    for (NSInteger i = 0; i < 6; i++){
        cellIndex[i]=-1;
    }
    
    arrSelected=[[NSMutableArray alloc]init];
    imageName=[[NSURL alloc]init];
   
    
    if ([PHPhotoLibrary authorizationStatus]==PHAuthorizationStatusNotDetermined)
    {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status==PHAuthorizationStatusAuthorized)
            {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    PHFetchOptions *allPhotosOptions = [PHFetchOptions new];
                    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
                    PHFetchResult *allPhotosResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
                    
                    self.requestOptions = [[PHImageRequestOptions alloc] init];
                    self.requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
                    self.requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
                    // this one is key
                    self.requestOptions.synchronous = true;
                    
                    self.assets = [[NSMutableArray alloc]init];
                    [self.colImages registerNib:[UINib nibWithNibName:@"ImageCell1" bundle:nil] forCellWithReuseIdentifier:@"ImageCell1"];
                    
                    // assets contains PHAsset objects.
                    
                    
                    [allPhotosResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
                        
                        [self.assets addObject:asset];
                        
                        [self.colImages reloadData];
                    }];

                });

            }
            else
            {
                ALERTVIEW([MCLocalization stringForKey:@"Please allow to import images from your device"],self);
            }
        }];
    }
    else if([PHPhotoLibrary authorizationStatus]==PHAuthorizationStatusAuthorized)
    {
        PHFetchOptions *allPhotosOptions = [PHFetchOptions new];
        allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *allPhotosResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
        
        self.requestOptions = [[PHImageRequestOptions alloc] init];
        self.requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
        self.requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        // this one is key
        self.requestOptions.synchronous = true;
        
        self.assets = [[NSMutableArray alloc]init];
        [self.colImages registerNib:[UINib nibWithNibName:@"ImageCell1" bundle:nil] forCellWithReuseIdentifier:@"ImageCell1"];
        
        // assets contains PHAsset objects.
        
        
        [allPhotosResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
            
            [self.assets addObject:asset];
            
            [self.colImages reloadData];
        }];

    }
    else if([PHPhotoLibrary authorizationStatus]==PHAuthorizationStatusDenied)
    {
        ALERTVIEW([MCLocalization stringForKey:@"Please allow acces photos to import images from your device,Please Goto Setting to enable"],appDelegate.window.rootViewController);
    }    
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.vwTitle.hidden = NO;
    
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
     [self localize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- btnClick
/*!
 * @discussion When back is clicked
 * @param sender For indentifying sender
 */
- (IBAction)btnBackClicked:(id)sender
{
 
    appDelegate.editImageName=@"";
    appDelegate.flag_next=@"back";
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*!
 * @discussion When Done with Select Images 
 * @param sender For indentifying sender
 */
- (IBAction)btnDoneClicked:(id)sender {
    if([appDelegate.selectedImages count]>0 || maxSelect==1){
        appDelegate.flag_next=@"next";
        
    }
    if(maxSelect==1 && [appDelegate.editImageName isEqualToString:@""]){
        ALERTVIEW([MCLocalization stringForKey:@"Please select Image or Go Back"], self);
         appDelegate.flag_next=@"back";
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}


#pragma mark - CollectionView Delegates

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.assets.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *indenti=@"ImageCell1";
    ImageCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
    
    if ([arrSelected containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
    {
        //selected images
        cell.selectionLabel.hidden=NO;
        cell.boarderImage.hidden=NO;
        
        for(int i=0;i<imgCount;i++){
            if(indexPath.row==cellIndex[i]){
                cell.selectionLabel.text =[NSString stringWithFormat:@"%d", i+1];
            }
        }

    }
    else
    {
        //images which are not selected
        cell.selectionLabel.hidden=YES;
        cell.boarderImage.hidden=YES;
    }
    
    //set image from gallery
    PHAsset *asset=[self.assets objectAtIndex:indexPath.row];
 PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestImageForAsset:asset
                       targetSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height)
                      contentMode:PHImageContentModeAspectFill
                          options:self.requestOptions
                    resultHandler:^void(UIImage *image, NSDictionary *info) {
                        cell.galleryImage.image=image;
                        
                    }];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset=[self.assets objectAtIndex:indexPath.row];
 
    ImageCell1 *selectedCell = (ImageCell1 *) [collectionView cellForItemAtIndexPath:indexPath];
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0 && [asset isKindOfClass:[PHAsset class]]) {
        
        [asset requestContentEditingInputWithOptions:nil completionHandler:^(PHContentEditingInput * _Nullable contentEditingInput, NSDictionary * _Nonnull info) {
            imageName = contentEditingInput.fullSizeImageURL;
            
            if ([arrSelected containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
            {
                //deselect image
                [arrSelected removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];

                [self.colImages reloadData];
                
                selectedCell.selectionLabel.hidden=YES;
                selectedCell.boarderImage.hidden=YES;
            
                if(maxSelect==1){
                    
                    imgCount--;
                    appDelegate.editImageName=@"";
                }
                else{
                    //deleting from selected index
                    for(int i=0;i<imgCount;i++){
                        if([imageName.absoluteString isEqualToString:[appDelegate.selectedImages objectAtIndex:i]]){
                            [appDelegate.selectedImagesAssets removeObjectAtIndex:i];

                            [appDelegate.selectedImages removeObjectAtIndex:i];
                            
                            deselectedIdex = i;
                            for(int j=i;j<imgCount;j++){
                                cellIndex[j]=cellIndex[j+1];
                            }
                            cellIndex[imgCount]=-1;
                            
                            imgCount--;
                           
                            if(arrSelected.count==5){
                                maxSelect=6;
                            }
                            break;
                            
                        }
                    }
                }
            }
            else
            {
                //select image
                if(imgCount<maxSelect)
                {
                   
                    cellIndex[imgCount]= indexPath.row;
                    
                    imgCount++;
                    [arrSelected addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
                    
                    selectedCell.boarderImage.hidden=NO;
                    selectedCell.selectionLabel.hidden=NO;
                    selectedCell.selectionLabel.text=[NSString stringWithFormat:@"%ld",(unsigned long)arrSelected.count ];
                   
                    [appDelegate.selectedImagesAssets addObject:asset];
                    [appDelegate.selectedImages addObject:imageName.absoluteString];
                    
                    if(maxSelect==1){
                        appDelegate.asset=asset;
                        appDelegate.editImageName=imageName.absoluteString;
                        
                        //TODO: check here
                        appDelegate.flag_next=@"next";
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                  
                }
                else{
                    NSString *msg=[[NSString alloc] init];
                    if(maxSelect==1){
                        msg=[MCLocalization stringForKey:@"You can select only one image."];
                    }
                    else{
                        msg=[MCLocalization stringForKey:@"You can select maximum 6 images."];
                    }
                    
                    ALERTVIEW(msg, self);
                }
            }
        }];
    }

}
-(void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((([UIScreen mainScreen].bounds.size.width-30)/3)-5,(([UIScreen mainScreen].bounds.size.width-30)/3)-5);
}

#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblTitle.text=[MCLocalization stringForKey:@"GALLERY"];
    
    [self.btnDone setTitle:[MCLocalization stringForKey:@"DONE"] forState:UIControlStateNormal];
    
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
}

@end
