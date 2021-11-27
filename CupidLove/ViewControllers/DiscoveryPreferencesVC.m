//
//  DiscoveryPreferencesVC.m
//  CupidLove
//
//  Created by APPLE on 15/11/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "DiscoveryPreferencesVC.h"
#import "FriendProfileVC.h"
#import "NotificationVC.h"
#import "REDRangeSlider.h"
#import "LocationHelper.h"
#import "NMRangeSlider.h"
#import "NumbersCell.h"
#import "KTCenterFlowLayout.h"

@interface DiscoveryPreferencesVC ()<LocationUpdateDelegate>{
    NSString *location;

}
@property (strong, nonatomic) REDRangeSlider *rangeSlider;

- (void)rangeSliderValueChanged:(id)sender;

@property (strong, nonatomic) REDRangeSlider *rangeSlider2;
- (void)updateSliderLabels2;

@property (strong,nonatomic) IBOutlet UIImageView *imgMaleCheck;
@property (strong,nonatomic) IBOutlet UIImageView *imgFemaleCheck;
@property (strong,nonatomic) IBOutlet UIImageView *imgMale;
@property (strong,nonatomic) IBOutlet UIImageView *ImgFemale;
@property (strong,nonatomic) IBOutlet UIImageView *locationCheck;

@property (weak, nonatomic) IBOutlet UILabel *leftValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightValueLabel;
@property (weak,nonatomic) IBOutlet UIView *ageSlider;
@property (weak,nonatomic) IBOutlet UIView *leftTag;
@property (weak,nonatomic) IBOutlet UIView *rightTag;
@property (weak, nonatomic) IBOutlet UILabel *leftDistance;
@property (weak, nonatomic) IBOutlet UILabel *rightDistance;
@property (weak,nonatomic) IBOutlet UIView *distanceSlider;
@property (weak,nonatomic) IBOutlet UIView *leftTagDistance;
@property (weak,nonatomic) IBOutlet UIView *rightTagDistance;

@property (weak,nonatomic) IBOutlet UILabel *lblOffset;
@property (weak, nonatomic) IBOutlet NMRangeSlider *labelSlider;
@property (weak, nonatomic) IBOutlet NMRangeSlider *distSlider;

@property (weak,nonatomic) IBOutlet UIView *vwbtnBack;
@property (weak,nonatomic) IBOutlet UIView *vwSubmit;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblInterestedIn;
@property (strong, nonatomic) IBOutlet UILabel *lblAgePref;
@property (strong, nonatomic) IBOutlet UILabel *lblDistancePref;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;

@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblAgeUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblDistanceUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblInsteredInUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgVerticalline;
@property (weak,nonatomic) IBOutlet UIView *vwTitle;

@property (weak,nonatomic) IBOutlet UIView *vwReligion;
@property (weak,nonatomic) IBOutlet UIView *vwEthnicity;

@property (weak, nonatomic) IBOutlet UICollectionView *colReligion;
@property (weak, nonatomic) IBOutlet UICollectionView *colEthnicity;

@property(weak,nonatomic) IBOutlet UILabel *lblReligionUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblEthnicityUnderline;

@property (strong, nonatomic) IBOutlet UILabel *lblReligion;
@property (strong, nonatomic) IBOutlet UILabel *lblNotPrefertosay1;
@property (strong, nonatomic) IBOutlet UILabel *lblEthnicity;
@property (strong, nonatomic) IBOutlet UILabel *lblNotPrefertosay2;

@property (strong,nonatomic) IBOutlet UIImageView *imgNotSay1;
@property (strong,nonatomic) IBOutlet UIImageView *imgNotSay2;

@property (weak,nonatomic) IBOutlet UIScrollView *scrl;

@property (strong, nonatomic) KTCenterFlowLayout *layout;
@property (strong, nonatomic) KTCenterFlowLayout *layout1;

@end

@implementation DiscoveryPreferencesVC{
    NSString *genderPref;
    NSString *mylatitude;
    NSString *mylongitude;
    
    NSString *religion;
    NSString *ethinicity;
    
    NSMutableArray *arrEthnicity, *arrReligion, *arrReligionIDs, *arrEthnicityIDs, *arrSelectedReligionIds,*arrSelectedEthnicityIds;

    UIColor *bgDeselect, *bgSelect;
    Boolean flagNotSay1;
    Boolean flagNotSay2;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
    
    bgDeselect=[UIColor lightTextColor];
    bgSelect=  Theme_Color ;
    flagNotSay1=false;
    flagNotSay2=false;

    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    
    if( [[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    UIColor *underline_color = [UIColor whiteColor];
    
    self.lblTitleUnderline.backgroundColor = underline_color;
    self.lblAgeUnderline.backgroundColor = underline_color;
    self.lblDistanceUnderline.backgroundColor = underline_color;
    self.lblInsteredInUnderline.backgroundColor = underline_color;
    self.lblEthnicityUnderline.backgroundColor = underline_color;
    self.lblReligionUnderline.backgroundColor = underline_color;

    Boolean flag_left;
    flag_left = true;
    
    if([[appDelegate GetData:@"flagBack"] isEqualToString:@"hide"]){
        //hide back button
        self.vwbtnBack.hidden=YES;
        flag_left = false;
    }
    else{
        flag_left = true;
    }
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    // gender pref setting
    if([[appDelegate GetData:kgenderPref] isEqualToString:@"female"]){
        genderPref=@"female";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.imgMale.image=[UIImage imageNamed:@"MaleGray"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Check"];
        self.ImgFemale.image=[UIImage imageNamed:@"Female"];
    }
    else{
        genderPref=@"male";
    }
    
    //set default value for lat long
    location=@"NotAllow";
    mylatitude=@"00.00";
    mylongitude=@"00.00";
    
    self.layout = [[KTCenterFlowLayout alloc] init];
    self.layout1 = [[KTCenterFlowLayout alloc] init];
    
    self.colReligion.collectionViewLayout = self.layout;
    self.colEthnicity.collectionViewLayout = self.layout1;

    [self.colReligion registerClass:[NumbersCell class] forCellWithReuseIdentifier:@"NumbersCell"];
    [self.colReligion registerNib:[UINib nibWithNibName:@"NumbersCell" bundle: nil]forCellWithReuseIdentifier:@"NumbersCell"];
    
    [self.colEthnicity registerClass:[NumbersCell class] forCellWithReuseIdentifier:@"NumbersCell"];
    [self.colEthnicity registerNib:[UINib nibWithNibName:@"NumbersCell" bundle: nil]forCellWithReuseIdentifier:@"NumbersCell"];

    [self getEthnicityAndReligionAndQuestions];
}
-(void) viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    self.imgVerticalline.frame = CGRectMake(self.imgVerticalline.frame.origin.x, self.vwbtnBack.frame.size.height, 1, self.vwSubmit.frame.origin.y - self.vwbtnBack.frame.size.height);
//    [self configureLabelSlider];
//    [self configureDistanceSlider];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self updateSliderLabels];
//
//    });
//    [self updateSliderLabels2];
    
    self.scrl.contentSize = CGSizeMake(self.scrl.frame.size.width, self.vwReligion.frame.origin.y + self.vwReligion.frame.size.height);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Turn off the location manager to save power.
    self.vwTitle.hidden = YES;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.vwTitle.hidden = NO;
    [self localize];
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self configureLabelSlider];
    self.labelSlider.lowerValue = 18;
    [self configureDistanceSlider];
    [self updateSliderLabels];
    [self updateSliderLabels2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) configureLabelSlider
{
    self.labelSlider.minimumValue = 18;
    self.labelSlider.maximumValue = 60;
    
    self.labelSlider.lowerValue = 18;
    self.labelSlider.upperValue = 60;
    
    
    self.labelSlider.minimumRange = 5;
    
    self.labelSlider.trackImage=[UIImage imageNamed:@"SliderTrack"];
    
    CGPoint lowerCenter,upperCenter;
    
    if (SCREEN_SIZE.width == 375) {
        lowerCenter.x = 50 ;
        lowerCenter.y = 43 ;
        upperCenter.x = 335 ;
    } else if (SCREEN_SIZE.width >= 414) {
        lowerCenter.x = 50;
        lowerCenter.y = 49;
        upperCenter.x = 375;
    } else {
        lowerCenter.x = 50;
        lowerCenter.y = 35;
        upperCenter.x = 280;
    }
    
    upperCenter.y = lowerCenter.y ;
    self.leftTag.center = lowerCenter;
    self.rightTag.center = upperCenter;
    
}
- (void) configureDistanceSlider
{
    self.distSlider.minimumValue = 0;
    self.distSlider.maximumValue = 200;
    
    self.distSlider.lowerValue = 0;
    self.distSlider.upperValue = 200;
    
    
    self.distSlider.minimumRange = 20;
    
    self.distSlider.trackImage=[UIImage imageNamed:@"SliderTrack"];
    
    CGPoint lowerCenter,upperCenter;
    
    if (SCREEN_SIZE.width == 375) {
        lowerCenter.x = 50 ;
        lowerCenter.y = 43 ;
        upperCenter.x = 335 ;
    } else if (SCREEN_SIZE.width >= 414) {
        lowerCenter.x = 50;
        lowerCenter.y = 49;
        upperCenter.x = 375;
    } else {
        lowerCenter.x = 50;
        lowerCenter.y = 35;
        upperCenter.x = 280;
    }
    
    upperCenter.y = lowerCenter.y ;
    self.leftTagDistance.center = lowerCenter;
    self.rightTagDistance.center = upperCenter;
    
}


#pragma mark - btnClicked

/*!
 * @discussion Add religion to already added religion
 * @param sender For Identifying sender
 */
- (IBAction)btnNotSay1Clicked:(id)sender {
    //change image and set string
    if(flagNotSay1){
        self.imgNotSay1.image=[UIImage imageNamed:@"UntickCircle"];
        flagNotSay1=false;
    }
    else{
        self.imgNotSay1.image=[UIImage imageNamed:@"CircleGreen"];
        flagNotSay1=true;
    }
    
    [arrSelectedReligionIds removeAllObjects];
    [self.colReligion reloadData];
    
}
/*!
 * @discussion Set Ethnicity to prefer not to say
 * @param sender For Identifying sender
 */
- (IBAction)btnNotSay2Clicked:(id)sender {
    //change image and set string
    [arrSelectedEthnicityIds removeAllObjects];
    if(flagNotSay2){
        self.imgNotSay2.image=[UIImage imageNamed:@"UntickCircle"];
        flagNotSay2=false;
    }
    else{
        self.imgNotSay2.image=[UIImage imageNamed:@"CircleGreen"];
        flagNotSay2=true;
    }
    
    [self.colEthnicity reloadData];
    
}

- (IBAction)btnLocationAllow:(id)sender {

    if([location isEqualToString:@"NotAllow"]){
        self.locationCheck.image=[UIImage imageNamed:@"Check"];
        location=@"Allow";
     
        [LocationHelper sharedInstance].delegate=self;
        [[LocationHelper sharedInstance] updateLocation];
    }
    else{
        self.locationCheck.image=[UIImage imageNamed:@"Uncheck"];
        location=@"NotAllow";
        mylatitude=@"00.00";
        mylongitude=@"00.00";
    }
}
/*!
 * @discussion Called when back button is clicked
 * @param sender For indentify sender
 */
- (IBAction)btnBackClicked:(id)sender
{
    
    appDelegate.flag_next=@"back";
    [self.navigationController popViewControllerAnimated:YES];
}
/*!
 * @discussion Called when Male is selected for gender preference
 * @param sender For indentify sender
 */
- (IBAction)btnMaleClicked:(id)sender {
    if([genderPref isEqualToString:@"male"])
    {
        genderPref=@"female";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.imgMale.image=[UIImage imageNamed:@"MaleGray"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Check"];
        self.ImgFemale.image=[UIImage imageNamed:@"Female"];
    } else {
        genderPref=@"male";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Check"];
        self.imgMale.image=[UIImage imageNamed:@"Male"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.ImgFemale.image=[UIImage imageNamed:@"FemaleGray"];
    }
}
/*!
 * @discussion Called when Female is selected for gender preference
 * @param sender For indentify sender
 */
- (IBAction)btnFemaleClicked:(id)sender {
    if([genderPref isEqualToString:@"male"])
    {
        genderPref=@"female";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.imgMale.image=[UIImage imageNamed:@"MaleGray"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Check"];
        self.ImgFemale.image=[UIImage imageNamed:@"Female"];
    } else {
        genderPref=@"male";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Check"];
        self.imgMale.image=[UIImage imageNamed:@"Male"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.ImgFemale.image=[UIImage imageNamed:@"FemaleGray"];
    }
}
/*!
 * @discussion Called when submit is clicked
 * @param sender For indentify sender
 */
- (IBAction)btnSubmitClicked:(id)sender {
    //registration
    [self updateDiscPref];
    
}

#pragma mark - custom Delegate
/*!
 * @discussion Called from location helper and set latitude, longitude
 */
- (void) LocationUpdated{
    mylatitude=[LocationHelper sharedInstance].latitude;
    mylongitude=[LocationHelper sharedInstance].longitude;
}
#pragma mark - Slider actions
/*!
 * @discussion Called when sliders value is changed
 * @param sender For indentify sender
 */
- (IBAction)labelSliderChanged:(NMRangeSlider*)sender
{
    UIButton *btn=(UIButton *)sender;
    
    if(btn.tag==101){
        //change age slider
        [self updateSliderLabels];
    }
    else if(btn.tag==102){
        //change distance slider
        [self updateSliderLabels2];
    }
    
}
/*!
 * @discussion Update value and UI of age slider
 */
-(void) updateSliderLabels
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.labelSlider.lowerCenter.x + self.labelSlider.frame.origin.x);
    lowerCenter.y = (self.labelSlider.center.y - 35.0f);
    
    if (SCREEN_SIZE.width == 375) {
        lowerCenter.y = (self.labelSlider.center.y - 32.0f);
    } else if (SCREEN_SIZE.width >= 414) {
        lowerCenter.y = (self.labelSlider.center.y - 36.0f);
    } else {
        lowerCenter.y = (self.labelSlider.center.y - 27.0f);
    }
    
    
    self.leftValueLabel.text = [NSString stringWithFormat:@"%d", (int)self.labelSlider.lowerValue];
    
    self.leftTag.center=lowerCenter;
    
    CGPoint upperCenter;
    upperCenter.x = (self.labelSlider.upperCenter.x + self.labelSlider.frame.origin.x);
    
    if (SCREEN_SIZE.width == 375) {
        upperCenter.y = (self.labelSlider.center.y - 32.0f);
    } else if (SCREEN_SIZE.width >= 414) {
        upperCenter.y = (self.labelSlider.center.y - 36.0f);
    } else {
        upperCenter.y = (self.labelSlider.center.y - 27.0f);
    }
    
    self.rightValueLabel.text = [NSString stringWithFormat:@"%d", (int)self.labelSlider.upperValue];
    
    self.rightTag.center=upperCenter;
}

/*!
 * @discussion Update value and UI of Distance slider
 */
-(void) updateSliderLabels2
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.distSlider.lowerCenter.x + self.distSlider.frame.origin.x);
    lowerCenter.y = (self.distSlider.center.y - 35.0f);
    
    if (SCREEN_SIZE.width == 375) {
        lowerCenter.y = (self.distSlider.center.y - 32.0f);
    } else if (SCREEN_SIZE.width >= 414) {
        lowerCenter.y = (self.distSlider.center.y - 36.0f);
    } else {
        lowerCenter.y = (self.distSlider.center.y - 27.0f);
    }
    
    
    self.leftDistance.text = [NSString stringWithFormat:@"%d", (int)self.distSlider.lowerValue];
    
    self.leftTagDistance.center=lowerCenter;
    
    CGPoint upperCenter;
    upperCenter.x = (self.distSlider.upperCenter.x + self.distSlider.frame.origin.x);
    
    if (SCREEN_SIZE.width == 375) {
        upperCenter.y = (self.distSlider.center.y - 32.0f);
    } else if (SCREEN_SIZE.width >= 414) {
        upperCenter.y = (self.distSlider.center.y - 36.0f);
    } else {
        upperCenter.y = (self.distSlider.center.y - 27.0f);
    }
    
    self.rightDistance.text = [NSString stringWithFormat:@"%d", (int)self.distSlider.upperValue];
    self.rightTagDistance.center=upperCenter;
}

-(void)rangeSliderValueChanged:(id)sender {
    
}
#pragma mark- collectionView delegates
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if(collectionView.tag==101)
    {
        return arrReligion.count;
    }
    else if(collectionView.tag==102)
    {
        return arrEthnicity.count;
    }
    else
    {
        return 0;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if(collectionView.tag==101)
    {
        static NSString *indenti=@"NumbersCell";
        NumbersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
        [cell.lblNumber setFont:[UIFont fontWithName:@"Lato-Semibold" size:12]];
        
        cell.lblNumber.text = [arrReligion objectAtIndex:indexPath.row];
        
        if([arrSelectedReligionIds containsObject:[arrReligionIDs objectAtIndex:indexPath.row]])
        {
            cell.backgroundColor = bgSelect;
        }
        else
        {
            cell.backgroundColor = bgDeselect;
        }
        
        return cell;
        
    }
    else if(collectionView.tag==102) {
        
        static NSString *indenti=@"NumbersCell";
        NumbersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
        [cell.lblNumber setFont:[UIFont fontWithName:@"Lato-Semibold" size:12]];
        
        cell.lblNumber.text = [arrEthnicity objectAtIndex:indexPath.row];
        
        if([arrSelectedEthnicityIds containsObject:[arrEthnicityIDs objectAtIndex:indexPath.row]])
        {
            cell.backgroundColor = bgSelect;
        }
        else
        {
            cell.backgroundColor = bgDeselect;
        }
        
        return cell;
        
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(collectionView.tag==101){
        self.imgNotSay1.image=[UIImage imageNamed:@"UntickCircle"];
        flagNotSay1=false;
        if([arrSelectedReligionIds containsObject:[arrReligionIDs objectAtIndex:indexPath.row]]){
            [arrSelectedReligionIds removeObject:[arrReligionIDs objectAtIndex:indexPath.row]];
        }
        else{
            [arrSelectedReligionIds addObject:[arrReligionIDs objectAtIndex:indexPath.row]];
        }
        [collectionView reloadData];
    }
    else if(collectionView.tag==102){
        self.imgNotSay2.image=[UIImage imageNamed:@"UntickCircle"];
        flagNotSay2=false;
        if([arrSelectedEthnicityIds containsObject:[arrEthnicityIDs objectAtIndex:indexPath.row]]){
            [arrSelectedEthnicityIds removeObject:[arrEthnicityIDs objectAtIndex:indexPath.row]];
        }
        else{
            [arrSelectedEthnicityIds addObject:[arrEthnicityIDs objectAtIndex:indexPath.row]];
        }
        [collectionView reloadData];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 101) {
        return CGSizeMake((collectionView.frame.size.width/3)-7, 25);
    }
    else if (collectionView.tag == 102){
        
        return CGSizeMake((collectionView.frame.size.width/2)-7, 25);
    }
    else {
        return CGSizeMake(0, 0);
    }
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    return layoutAttributes;
}

#pragma mark - Api Calls
/*!
 * @discussion Webservice call for preferece update
 */
-(void)updateDiscPref
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         SHOW_LOADER_ANIMTION();
         
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"userPrefencesUpdate";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:[appDelegate GetData:kabout] forKey:@"about"];
             [dict setValue:[appDelegate GetData:kdatePref] forKey:@"date_pref"];
             [dict setValue:genderPref forKey:@"gender_pref"];
             [dict setValue:self.leftValueLabel.text forKey:@"min_age_pref"];
             [dict setValue:self.rightValueLabel.text forKey:@"max_age_pref"];
             [dict setValue:self.leftDistance.text forKey:@"min_dist_pref"];
             [dict setValue:self.rightDistance.text forKey:@"max_dist_pref"];
             
             [dict setValue:[appDelegate GetData:kheight] forKey:@"height"];
             [dict setValue:[appDelegate GetData:kreligion] forKey:@"religion"];
             [dict setValue:[appDelegate GetData:kethnicity] forKey:@"ethnicity"];
             [dict setValue:[appDelegate GetData:kno_of_kids] forKey:@"kids"];
             [dict setValue:[appDelegate GetData:kquestionID] forKey:@"que_id"];
             [dict setValue:[appDelegate GetData:kanswer] forKey:@"que_ans"];
             
             if(arrSelectedReligionIds.count==0) {
                 religion=@"0";
             } else {
                 religion=[NSString stringWithFormat:@"%@",[arrSelectedReligionIds objectAtIndex:0]];
                 for(int i = 1;i < arrSelectedReligionIds.count;i++) {
                     religion=[NSString stringWithFormat:@"%@,%@",religion,[arrSelectedReligionIds objectAtIndex:i]];
                 }
             }
             [dict setValue:religion forKey:@"religion_pref"];
             if(arrSelectedEthnicityIds.count==0) {
                 ethinicity=@"0";
             }
             else {
                 ethinicity=[NSString stringWithFormat:@"%@",[arrSelectedEthnicityIds objectAtIndex:0]];
                 for(int i = 1;i < arrSelectedEthnicityIds.count;i++) {
                     ethinicity=[NSString stringWithFormat:@"%@,%@", ethinicity, [arrSelectedEthnicityIds objectAtIndex:i]];
                 }
             }
             [dict setValue:ethinicity forKey:@"ethnicity_pref"];

             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     [appDelegate SetData:self.leftDistance.text value:kMinDistance];
                     [appDelegate SetData:self.rightDistance.text value:kmaxDistance];
                     [appDelegate SetData:genderPref value:kgenderPref];
                     [appDelegate SetData:self.leftValueLabel.text value:kminAgePref];
                     [appDelegate SetData:self.rightValueLabel.text value:kmaxAgePref];
                     
                     NSString *str1=@"userUpdateLatLong";
                     NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
                     [dict1 setValue:[appDelegate GetData:kuserid] forKey:@"id"];
                     [dict1 setValue:mylatitude forKey:@"location_lat"];
                     [dict1 setValue:mylongitude forKey:@"location_long"];
                     
                     NSString *_url1 = [NSString stringWithFormat:@"%@%@",appURL,str1];

                     [[ApiManager sharedInstance] apiCallWithPost:_url1 parameterDict:dict1  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary1) {
                         
                         if(success && [[dictionary1 valueForKey:@"error"] intValue]==0){
                             
                             [appDelegate SetData:[dictionary1 valueForKey:@"latitude"] value:klatitude];
                             [appDelegate SetData:[dictionary1 valueForKey:@"longitude"] value:klongitude];
                             [appDelegate RemoveData:@"Page"];

                             [appDelegate RemoveData:@"flagBack"];
                             
                             [appDelegate SetData:@"Yes" value:kNewUser];
                             
                             [appDelegate ChangeViewController];
                         }
                         else
                         {
                             ALERTVIEW([dictionary1 valueForKey:@"message"], self);
                         }
                     }];
                 }
                 else
                 {
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
                 
             }];
         }
     }];
}
/*!
 * @discussion Webservice call for get ethnicity and religion list
 */
-(void) getEthnicityAndReligionAndQuestions
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         SHOW_LOADER_ANIMTION();
         
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             
             NSString *str=@"get_all_static";
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             NSString *strSelectedLanguage=[appDelegate GetData:@"SelectedLanguage"];
             [dict setValue:strSelectedLanguage forKey:@"language"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     arrReligion = [[NSMutableArray alloc] init];
                     arrEthnicity = [[NSMutableArray alloc] init];
                     arrReligionIDs = [[NSMutableArray alloc] init];
                     arrEthnicityIDs = [[NSMutableArray alloc] init];
                     arrSelectedReligionIds = [[NSMutableArray alloc] init];
                     arrSelectedEthnicityIds = [[NSMutableArray alloc] init];

                     NSArray *arr1=[dictionary valueForKey:@"religion"];
                     for (int i=0; i<arr1.count; i++)
                     {
                         NSData *data = [[[arr1 objectAtIndex:i] valueForKey:strSelectedLanguage] dataUsingEncoding:NSUTF16StringEncoding];
                         NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
                         [arrReligion addObject:decodevalue];
                     }
                     arrReligionIDs=[[[dictionary valueForKey:@"religion"] valueForKey:@"id"] mutableCopy];
                     
                     
                     NSArray *arr2=[dictionary valueForKey:@"ethnicity"];
                     for (int i=0; i<arr2.count; i++)
                     {
                         NSData *data = [[[arr2 objectAtIndex:i] valueForKey:strSelectedLanguage] dataUsingEncoding:NSUTF16StringEncoding];
                         NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
                         [arrEthnicity addObject:decodevalue];
                     }
                     arrEthnicityIDs=[[[dictionary valueForKey:@"ethnicity"] valueForKey:@"id"] mutableCopy];
                     
                     [self.colReligion reloadData];
                     [self.colEthnicity reloadData];
                     [self setFrames];
                 }
                 else
                 {
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
                 
             }];
         }
     }];
}
/*!
 * @discussion Setup Ui
 */
-(void) setFrames{
    
    self.colEthnicity.frame=CGRectMake(self.colEthnicity.frame.origin.x, self.colEthnicity.frame.origin.y, self.colEthnicity.frame.size.width, 35*(ceil(arrEthnicity.count/2.0)));
    self.vwEthnicity.frame=CGRectMake(self.vwEthnicity.frame.origin.x, self.vwEthnicity.frame.origin.y, self.vwEthnicity.frame.size.width, self.colEthnicity.frame.size.height+self.colEthnicity.frame.origin.y);
    
    self.colReligion.frame=CGRectMake(self.colReligion.frame.origin.x, self.colReligion.frame.origin.y, self.colReligion.frame.size.width, 35*(ceil(arrReligion.count/3.0)));
    self.vwReligion.frame=CGRectMake(self.vwReligion.frame.origin.x, self.vwEthnicity.frame.origin.y + self.vwEthnicity.frame.size.height, self.vwReligion.frame.size.width, self.colReligion.frame.size.height + self.colReligion.frame.origin.y);

    
    self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.vwReligion.frame.origin.y+self.vwReligion.frame.size.height);
    
}
#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblTitle.text=[MCLocalization stringForKey:@"Discovery Preferences"];
    
    self.lblEthnicity.text=[MCLocalization stringForKey:@"Ethnicity"];
    self.lblReligion.text=[MCLocalization stringForKey:@"Religion"];
    self.lblNotPrefertosay1.text=[MCLocalization stringForKey:@"Doesn't matter"];
    self.lblNotPrefertosay2.text=[MCLocalization stringForKey:@"Doesn't matter"];

    self.lblInterestedIn.text=[MCLocalization stringForKey:@"Intrested In"];
    self.lblAgePref.text=[MCLocalization stringForKey:@"Age Preferences"];
    self.lblDistancePref.text=[MCLocalization stringForKey:@"Distance Preferences (miles)"];
    
    [self.btnSubmit setTitle:[MCLocalization stringForKey:@"SUBMIT"] forState:UIControlStateNormal];

    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
    
    [self.lblAgePref sizeToFit];
    self.lblAgeUnderline.frame=CGRectMake(self.lblAgePref.frame.origin.x, self.lblAgeUnderline.frame.origin.y, self.lblAgePref.frame.size.width, 1);
    
    [self.lblDistancePref sizeToFit];
    self.lblDistanceUnderline.frame=CGRectMake(self.lblDistancePref.frame.origin.x, self.lblDistanceUnderline.frame.origin.y, self.lblDistancePref.frame.size.width, 1);
    
    [self.lblInterestedIn sizeToFit];
    self.lblInsteredInUnderline.frame = CGRectMake(self.lblInterestedIn.frame.origin.x, self.lblInsteredInUnderline.frame.origin.y, self.lblInterestedIn.frame.size.width, 1);
    
    [self.lblReligion sizeToFit];
    self.lblReligionUnderline.frame=CGRectMake(self.lblReligion.frame.origin.x, self.lblReligionUnderline.frame.origin.y, self.lblReligion.frame.size.width, 1);

    [self.lblEthnicity sizeToFit];
    self.lblEthnicityUnderline.frame=CGRectMake(self.lblEthnicity.frame.origin.x, self.lblEthnicityUnderline.frame.origin.y, self.lblEthnicity.frame.size.width, 1);

    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self setRTL];
    }
    
}

/*!
 * @discussion set RTL UI
 */
- (void)setRTL{
    
    float x = 40 * SCREEN_SIZE.width/375;
    
    self.lblInterestedIn.frame = CGRectMake(x, self.lblInterestedIn.frame.origin.y, self.lblInterestedIn.frame.size.width, self.lblInterestedIn.frame.size.height);
    self.lblInsteredInUnderline.frame = CGRectMake(self.lblInterestedIn.frame.origin.x, self.lblInsteredInUnderline.frame.origin.y, self.lblInterestedIn.frame.size.width, 1);
    self.lblAgePref.frame = CGRectMake(x, self.lblAgePref.frame.origin.y, self.lblAgePref.frame.size.width, self.lblAgePref.frame.size.height);
    self.lblAgeUnderline.frame=CGRectMake(self.lblAgePref.frame.origin.x, self.lblAgeUnderline.frame.origin.y, self.lblAgePref.frame.size.width, 1);
    self.lblDistancePref.frame = CGRectMake(x, self.lblDistancePref.frame.origin.y, self.lblDistancePref.frame.size.width, self.lblDistancePref.frame.size.height);
    self.lblDistanceUnderline.frame=CGRectMake(self.lblDistancePref.frame.origin.x, self.lblDistanceUnderline.frame.origin.y, self.lblDistancePref.frame.size.width, 1);
    
    self.lblReligion.frame = CGRectMake(x, self.lblReligion.frame.origin.y, self.lblReligion.frame.size.width, self.lblReligion.frame.size.height);
    self.colReligion.frame = CGRectMake(x, self.colReligion.frame.origin.y, self.colReligion.frame.size.width, self.colReligion.frame.size.height);

    self.lblEthnicity.frame = CGRectMake(x, self.lblEthnicity.frame.origin.y, self.lblEthnicity.frame.size.width, self.lblEthnicity.frame.size.height);
    self.colEthnicity.frame = CGRectMake(x, self.colEthnicity.frame.origin.y, self.colEthnicity.frame.size.width, self.colEthnicity.frame.size.height);

    self.lblReligionUnderline.frame = CGRectMake(x, self.lblReligionUnderline.frame.origin.y, self.lblReligionUnderline.frame.size.width, 1);
    self.lblEthnicityUnderline.frame = CGRectMake(x, self.lblEthnicityUnderline.frame.origin.y, self.lblEthnicityUnderline.frame.size.width, 1);

    self.lblNotPrefertosay1.textAlignment = NSTextAlignmentLeft;
    self.lblNotPrefertosay2.textAlignment = NSTextAlignmentLeft;
}
/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.view setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwSubmit setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblInterestedIn setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblInterestedIn.textAlignment = NSTextAlignmentRight;
    
    [self.lblAgePref setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblAgePref.textAlignment = NSTextAlignmentRight;
    [self.leftValueLabel setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.rightValueLabel setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblDistancePref setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblDistancePref.textAlignment = NSTextAlignmentRight;
    [self.leftDistance setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.rightDistance setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblEthnicity setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblReligion setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblNotPrefertosay1 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblNotPrefertosay2 setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.colReligion setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.colEthnicity setTransform:CGAffineTransformMakeScale(-1, 1)];

}

@end
