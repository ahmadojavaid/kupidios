//
//  FacebookImageGalleryVC.m
//  CupidLove
//
//  Created by APPLE on 26/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "FacebookImageGalleryVC.h"
#import "ImageCell1.h"

@interface FacebookImageGalleryVC ()
@property (strong,atomic) IBOutlet UICollectionView *collFBView;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
@property(weak,nonatomic) IBOutlet UIView *vwBack;
@property (weak,nonatomic) IBOutlet UIView *vwTitle;
@end

@implementation FacebookImageGalleryVC
{
    
    NSMutableArray *assets,*arrIds;
    int imgCount;
    NSMutableArray *arrSelected;
    NSURL *imageName;
    int deselectedIdex;
    NSInteger cellIndex[6];//for labeling number
    int maxSelect;
    NSString *nextPageURL;//for next page

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:[UIImage imageNamed:@"FBRectangle"]]];
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self.collFBView setTransform:CGAffineTransformMakeScale(-1, 1)];
    }
    
    arrSelected=[[NSMutableArray alloc]init];
    assets = [[NSMutableArray alloc]init];
    arrIds = [[NSMutableArray alloc]init];
    
    [self.collFBView registerNib:[UINib nibWithNibName:@"ImageCell1" bundle:nil] forCellWithReuseIdentifier:@"ImageCell1"];
    if([appDelegate.editImageName isEqualToString:@"Name"])
    {
        //edit image
        maxSelect=1;
        appDelegate.editImageName=@"";
    }
    else{
        //import image
        
        maxSelect=1;
        appDelegate.editImageName=@"";
        
        [appDelegate.selectedFbImages removeAllObjects];

//        maxSelect=6;
    }
    [appDelegate.selectedFbImagesIds removeAllObjects];

    deselectedIdex= -1;
    imgCount=0;
    for (NSInteger i = 0; i < 6; i++){
        cellIndex[i]=-1;
    }

    assets=[[NSMutableArray alloc]init];

    [self getImageFromFacebook];
    
    [self.collFBView registerNib:[UINib nibWithNibName:@"ImageCell1" bundle:nil] forCellWithReuseIdentifier:@"ImageCell1"];
    
    UIEdgeInsets collectionViewInsets = UIEdgeInsetsMake(10.0, 8.0, 10.0, 8.0);
    self.collFBView.contentInset = collectionViewInsets;
    self.collFBView.scrollIndicatorInsets = UIEdgeInsetsMake(collectionViewInsets.top, 0, collectionViewInsets.bottom, 0);
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.vwTitle.hidden = NO;
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
     [self localize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get Image from Facebook

-(void)getImageFromFacebook
{
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    if ([FBSDKAccessToken currentAccessToken]) {
        [self FBImages:@"me/photos/uploaded"];
        HIDE_PROGRESS;
    } else  {
        SHOW_LOADER_ANIMTION();
        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login setLoginBehavior:FBSDKLoginBehaviorWeb];

        login.loginBehavior = FBSDKLoginBehaviorSystemAccount;

        [login logInWithReadPermissions: @[@"public_profile", @"user_photos"]fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
        {
            
            if (error) {
                 // Process error
            } else if (result.isCancelled) {
                 // Handle cancellations
            } else {
                 // If you ask for multiple permissions at once, you should check if specific permissions missing
            }
            [self FBImages:@"me/photos/uploaded"];

            HIDE_PROGRESS;
        }];
    }
}
- (void)FBImages :(NSString*)url{
    //get fb images
    if ([FBSDKAccessToken currentAccessToken])
    {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            SHOW_LOADER_ANIMTION();
        });
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:url parameters:@{ @"fields" : @"picture.width(1024).height(1024)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                
                NSString *imageStringOfLoginUser;
                
                [arrIds removeAllObjects];
                [assets removeAllObjects];
                
                
                nextPageURL = [[result objectForKey:@"paging"] valueForKey:@"next"];
                
                NSArray *responseArray = [result objectForKey:@"data"];
                
                for (result in responseArray) {
                    
                    imageStringOfLoginUser=[result valueForKey:@"picture"];
                    NSURL *url = [NSURL URLWithString:imageStringOfLoginUser];
                    [arrIds addObject:[result valueForKey:@"id"]];
                    [assets addObject:url];
                    
                    
                }
                if(arrIds.count == 0 ){
                    HIDE_PROGRESS;
                    ALERTVIEW([MCLocalization stringForKey:@"No image to Show"], self);
                }
                __block int  counter=0;
                
                for (int temp=0;temp<arrIds.count;temp++)
                {
                    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                                  initWithGraphPath:[arrIds objectAtIndex:temp]
                                                  parameters:@{ @"fields": @"images",}
                                                  HTTPMethod:@"GET"];
                    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                        
                        
                        [assets replaceObjectAtIndex:temp withObject:[[[result valueForKey:@"images"] objectAtIndex:0] valueForKey:@"source"]];
                        
                        if (counter==arrIds.count-1) {
                            HIDE_PROGRESS;
                       
                            [self.collFBView reloadData];
                        }
                        
                        counter++;
                        
                    }];
                    
                }
            
            }
        }];
    }
}
-(void)nextPageFBImage:(NSString*)request1
{
    SHOW_LOADER_ANIMTION();
    
    NSURL *url = [NSURL URLWithString:request1];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSMutableDictionary *result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSString *imageStringOfLoginUser;
    
    nextPageURL = [[result objectForKey:@"paging"] valueForKey:@"next"];
    
    NSArray *responseArray = [result objectForKey:@"data"];
    
    for (result in responseArray) {
        
        imageStringOfLoginUser=[result valueForKey:@"picture"];
        [arrIds addObject:[result valueForKey:@"id"]];
        [assets addObject:url];
        
        
    }
    if(arrIds.count == 0 ){
        HIDE_PROGRESS;
        ALERTVIEW([MCLocalization stringForKey:@"No image to Show"], self);
    }
    __block int  counter=0;
    
    for (int temp=0;temp<arrIds.count;temp++)
    {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:[arrIds objectAtIndex:temp]
                                      parameters:@{ @"fields": @"images",}
                                      HTTPMethod:@"GET"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            
            [assets replaceObjectAtIndex:temp withObject:[[[result valueForKey:@"images"] objectAtIndex:0] valueForKey:@"source"]];
            
         
            if (counter==arrIds.count-1) {
                HIDE_PROGRESS;
                
                [self.collFBView reloadData];
            }
            
            counter++;
            
        }];
        
    }
    HIDE_PROGRESS;
}




#pragma mark :- CollectionView Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return arrIds.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(4, 4, 4, 4);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
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
        //not selected images
        cell.selectionLabel.hidden=YES;
        cell.boarderImage.hidden=YES;
    }

    [cell.act startAnimating];
    [cell.galleryImage sd_setImageWithURL:[assets objectAtIndex:indexPath.row ] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        cell.galleryImage.image=image;
        [cell.act stopAnimating];
    }];
    
    NSInteger lastSectionIndex = [collectionView numberOfSections] - 1;
    NSInteger lastRowIndex = [collectionView numberOfItemsInSection:lastSectionIndex] - 1;
    
    // Now just construct the index path
    NSIndexPath *pathToLastRow = [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
    
    if (indexPath == pathToLastRow) {
       
        if (nextPageURL != nil) {
            [self nextPageFBImage:nextPageURL];
        }
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((([UIScreen mainScreen].bounds.size.width-30)/3)-5,(([UIScreen mainScreen].bounds.size.width-30)/3)-5);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell1 *selectedCell = (ImageCell1 *) [collectionView cellForItemAtIndexPath:indexPath];
    imageName=[NSURL URLWithString:[assets objectAtIndex:indexPath.row]];
    NSString *strId=[arrIds objectAtIndex:indexPath.row];
    if ([arrSelected containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
    {
        
        //deselect image
        [arrSelected removeObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        [self.collFBView reloadData];
        
        selectedCell.selectionLabel.hidden=YES;
        selectedCell.boarderImage.hidden=YES;
        
        if(maxSelect==1){
            [appDelegate.selectedFbImagesIds removeAllObjects];
            appDelegate.editImageName=@"";
            imgCount--;
        }
        else{
            //deleting from selected index
            for(int i=0;i<imgCount;i++){
                if([imageName.absoluteString isEqualToString:[appDelegate.selectedFbImages objectAtIndex:i]]){
                    
                    [appDelegate.selectedFbImages removeObjectAtIndex:i];
                    [appDelegate.selectedFbImagesIds removeObjectAtIndex:i];
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
    else{
        //selet images
        if(imgCount<maxSelect)
        {
            if(maxSelect==1){
                
                appDelegate.editImageName = imageName.absoluteString;
            }
            
            cellIndex[imgCount]= indexPath.row;
            
            imgCount++;
            [arrSelected addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            
            selectedCell.boarderImage.hidden=NO;
            selectedCell.selectionLabel.hidden=NO;
            selectedCell.selectionLabel.text=[NSString stringWithFormat:@"%ld",arrSelected.count ];
            
            [appDelegate.selectedFbImages addObject:imageName.absoluteString];
            [appDelegate.selectedFbImagesIds addObject:strId];
            
                   }
        else{
            NSString *msg=[[NSString alloc] init];
            if(maxSelect==1){
                msg=[MCLocalization stringForKey:@"You can select only one image."];
            }
            else{
                msg=[MCLocalization stringForKey:@"You can select maximum 6 images."];
            }
            
            ALERTVIEW(msg, appDelegate.window.rootViewController);
            
        }
    }
    
    
    
}
#pragma mark-btn clicks
/*!
 * @discussion When back is clicked
 * @param sender For indentifying sender
 */
- (IBAction)btnBackClicked:(id)sender {

    appDelegate.editImageName=@"";
    
    appDelegate.flag_next=@"back";
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/*!
 * @discussion When Done with Select Images
 * @param sender For indentifying sender
 */
- (IBAction)btnDoneClicked:(id)sender {
    if([appDelegate.selectedFbImages count]>0 || maxSelect==1){
        appDelegate.flag_next=@"next_fb";
    }
    if(maxSelect==1 && [appDelegate.editImageName isEqualToString:@""])
    {
        ALERTVIEW([MCLocalization stringForKey:@"Please select Image or Go Back"], self);
        appDelegate.flag_next=@"back";
    }
    else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}
#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblTitle.text=[MCLocalization stringForKey:@"FACEBOOK IMAGES"];
    
    [self.btnDone setTitle:[MCLocalization stringForKey:@"DONE"] forState:UIControlStateNormal];
    
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
}


@end
