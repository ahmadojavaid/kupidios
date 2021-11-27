//
//  FriendDetailsVC.m
//  CupidLove
//
//  Created by Umesh on 9/13/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "FriendDetailsVC.h"
#import "NumbersCell.h"
#import "KTCenterFlowLayout.h"
#import "ImageCell1.h"
#import "HHPageView.h"

@interface FriendDetailsVC () <UIScrollViewDelegate,HHPageViewDelegate>

@property(weak,nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet HHPageView *pageController;

@property (weak, nonatomic) IBOutlet UIImageView *imgCircle1;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle2;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle3;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle4;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle5;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle6;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle7;


@property (strong,atomic) IBOutlet UICollectionView *colInstaImages;
@property (strong,atomic) IBOutlet UIView *vwInsta;
@property (strong,atomic) IBOutlet UILabel *lblInsta;
@property (strong,atomic) IBOutlet UILabel *lblInstaLine;
@property (strong,atomic) IBOutlet UIView *vwInstaNotConnected;
@property (strong,atomic) IBOutlet UILabel *lblInstaNotConnected;

@property (strong,nonatomic) IBOutlet UIView *vwNavBar;

@property (strong,nonatomic) IBOutlet UIScrollView *scrl;
@property (strong,nonatomic) IBOutlet UIScrollView *scrlSlider;

@property (strong,nonatomic) IBOutlet UIView *vwProfilePic;
@property (strong,nonatomic) IBOutlet UIView *vwQuate;
@property (strong,nonatomic) IBOutlet UIView *vwBasicInfo;
@property (strong,nonatomic) IBOutlet UIView *vwReligion;
@property (strong,nonatomic) IBOutlet UIView *vwEthnicity;
@property (strong,nonatomic) IBOutlet UIView *vwKids;
@property (strong,nonatomic) IBOutlet UIView *vwPhotos;

@property (strong,nonatomic) IBOutlet UICollectionView *colReligion;
@property (strong,nonatomic) IBOutlet UICollectionView *colEthnicity;

@property (strong,nonatomic) IBOutlet UIImageView *imgProfilePic;

@property (strong,nonatomic) IBOutlet UIImageView *imgOne;
@property (strong,nonatomic) IBOutlet UIImageView *imgTwo;
@property (strong,nonatomic) IBOutlet UIImageView *imgThree;
@property (strong,nonatomic) IBOutlet UIImageView *imgFour;
@property (strong,nonatomic) IBOutlet UIImageView *imgFive;

@property (strong,nonatomic) IBOutlet UIImageView *imgBackArrow;
@property (strong,nonatomic) IBOutlet UIView *vwBack;

@property (strong,nonatomic) IBOutlet UIImageView *imgQuateIcon;

@property (strong,nonatomic) IBOutlet UILabel *lblProfilePic;

@property (strong,nonatomic) IBOutlet UITextView *txtAnswers;

@property (strong,nonatomic) IBOutlet UILabel *lblQuate;
@property (strong,nonatomic) IBOutlet UILabel *lblQuestion;
@property (strong,nonatomic) IBOutlet UILabel *lblBasicInfo;
@property (strong,nonatomic) IBOutlet UILabel *lblReligion;
@property (strong,nonatomic) IBOutlet UILabel *lblEthnicity;
@property (strong,nonatomic) IBOutlet UILabel *lblPhoto;

@property (strong,nonatomic) IBOutlet UILabel *lblAge;
@property (strong,nonatomic) IBOutlet UILabel *lblHeight;
@property (strong,nonatomic) IBOutlet UILabel *lblDegree;
@property (strong,nonatomic) IBOutlet UILabel *lblJob;

@property (strong,nonatomic) IBOutlet UILabel *lblKids;

@property (strong,nonatomic) IBOutlet UIImageView *imgCircleEthnicity;
@property (strong,nonatomic) IBOutlet UIImageView *imgAge;
@property (strong,nonatomic) IBOutlet UIImageView *imgHeight;
@property (strong,nonatomic) IBOutlet UIImageView *imgDegree;
@property (strong,nonatomic) IBOutlet UIImageView *imgJob;
@property (strong,nonatomic) IBOutlet UIImageView *imgKids;

@property (strong,nonatomic) IBOutlet UILabel *lblLine;

@property (strong,nonatomic) IBOutlet UIActivityIndicatorView *actProfile;
@property (strong,nonatomic) IBOutlet UIActivityIndicatorView *actOne;
@property (strong,nonatomic) IBOutlet UIActivityIndicatorView *actTwo;
@property (strong,nonatomic) IBOutlet UIActivityIndicatorView *actThree;
@property (strong,nonatomic) IBOutlet UIActivityIndicatorView *actFour;
@property (strong,nonatomic) IBOutlet UIActivityIndicatorView *actFive;
@property (strong,nonatomic) IBOutlet UIActivityIndicatorView *actSix;

@property (strong,nonatomic) IBOutlet UILabel *lblProfileline;
@property (strong,nonatomic) IBOutlet UILabel *lblQuoteline;
@property (strong,nonatomic) IBOutlet UILabel *lblBasicInfoline;
@property (strong,nonatomic) IBOutlet UILabel *lblReligionline;
@property (strong,nonatomic) IBOutlet UILabel *lblEthnicityline;
@property (strong,nonatomic) IBOutlet UILabel *lblKidsline;
@property (strong,nonatomic) IBOutlet UILabel *lblPhotoline;
@property (strong,nonatomic) IBOutlet UILabel *lblAboutmeline;

@property (strong, nonatomic) KTCenterFlowLayout *layout;
@property (strong, nonatomic) KTCenterFlowLayout *layout1;

@property (strong,nonatomic) IBOutlet UIView *vwAboutMe;
@property (strong,nonatomic) IBOutlet UITextView *txtAboutMe;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblAboutme;
@property (strong, nonatomic) IBOutlet UILabel *lblKidstext;

@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgVerticalline;

@property(weak,nonatomic) IBOutlet UIImageView *img1;
@property(weak,nonatomic) IBOutlet UIImageView *img2;
@property(weak,nonatomic) IBOutlet UIImageView *img3;
@property(weak,nonatomic) IBOutlet UIImageView *img4;
@property(weak,nonatomic) IBOutlet UIImageView *img5;
@property(weak,nonatomic) IBOutlet UIImageView *img6;
@property(weak,nonatomic) IBOutlet UIPageControl *page;


@property (strong,atomic) IBOutlet UIView *vwPreferencesText;
@property (strong,atomic) IBOutlet UIView *vwPreferences;

@property(weak,nonatomic) IBOutlet UIImageView *imgPref1;
@property(weak,nonatomic) IBOutlet UIImageView *imgPref2;
@property(weak,nonatomic) IBOutlet UIImageView *imgPref3;
@property(weak,nonatomic) IBOutlet UIImageView *imgPref4;
@property(weak,nonatomic) IBOutlet UILabel *lblPref1;
@property(weak,nonatomic) IBOutlet UILabel *lblPref2;
@property(weak,nonatomic) IBOutlet UILabel *lblPref3;
@property(weak,nonatomic) IBOutlet UILabel *lblPref4;

@property (strong,nonatomic) IBOutlet UILabel *lblPreferences;
@property (strong,nonatomic) IBOutlet UILabel *lblPreferenceLine;

//@property(weak,nonatomic) IBOutlet HHPageView *pageController;
//@property(weak,nonatomic) IBOutlet HHPageView *pageControllerVertical;
//
//@property(weak,nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FriendDetailsVC
{
    Boolean flag1;
    CGFloat totalCellWidth;
    
    NSMutableArray *imageGallary;
    NSString *mylatitude, *mylongitude;
    NSInteger que;
    NSString *answer, *question, *height, *kidsDetail, *profession, *education, *age, *age1, *profilephoto, *profilepic,*aboutMe;
    NSMutableArray *gallary;
    
    NSString *qu_id;
    
    NSMutableArray *arrEthnicity, *arrReligion, *arrReligionIDs, *arrEthnicityIDs, *arrSelectedReligionIds,*arrSelectedEthnicityIds, *arrQuestionIds,*arrQues;
    
    CGRect cachedImage;
    
    NSMutableArray *assets;
    
    //for setting icon according to user preferences
    NSString *pref1;
    NSString *pref2;
    NSString *pref3;
    NSString *pref4;
    
}@synthesize dictDetails,strFriendID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    assets = [[NSMutableArray alloc] init];
    self.page.enabled=NO;
    
    UIColor *underline_color = [UIColor whiteColor];
    
    UIColor *verticalline = [UIColor whiteColor];
    self.lblLine.backgroundColor = verticalline;
    
    self.lblTitleUnderline.backgroundColor = underline_color;
    self.lblProfileline.backgroundColor = underline_color;
    self.lblQuoteline.backgroundColor = underline_color;
    self.lblBasicInfoline.backgroundColor = underline_color;
    self.lblAboutmeline.backgroundColor = underline_color;
    self.lblReligionline.backgroundColor = underline_color;
    self.lblEthnicityline.backgroundColor = underline_color;
    self.lblPhotoline.backgroundColor = underline_color;
    self.lblInstaLine.backgroundColor = underline_color;
    
    self.layout = [[KTCenterFlowLayout alloc] init];
    self.layout1 = [[KTCenterFlowLayout alloc] init];
    
    self.colReligion.collectionViewLayout = self.layout;
    self.colEthnicity.collectionViewLayout = self.layout1;
    
    self.actOne.color = Theme_Color;
    self.actTwo.color = Theme_Color;
    self.actThree.color = Theme_Color;
    self.actFour.color = Theme_Color;
    self.actFive.color = Theme_Color;
    self.actSix.color = Theme_Color;
    
    if([[appDelegate GetData:kAddsRemoved] isEqualToString:@"yes"]){
        self.vwBannerView.hidden=YES;
    }
    else {
        
        //admob
        
        // Replace this ad unit ID with your own ad unit ID.
//        self.vwBannerView.adUnitID = KadMobKey;
            self.vwBannerView.adUnitID = [appDelegate GetData:KadMobKey];
        self.vwBannerView.rootViewController = self;
        
        GADRequest *request = [GADRequest request];
        
        [self.vwBannerView loadRequest:request];
        
        if ([[appDelegate GetData:KadMobKey] isEqualToString:@""] || [[appDelegate GetData:KadMobKey] isEqualToString:@"key not found"]) {
            
            self.scrl.frame=CGRectMake(self.scrl.frame.origin.x, self.scrl.frame.origin.y, self.scrl.frame.size.width, self.scrl.frame.size.height);
            self.vwBannerView.hidden = YES;
            
        } else {
            
            self.scrl.frame=CGRectMake(self.scrl.frame.origin.x, self.scrl.frame.origin.y, self.scrl.frame.size.width, self.scrl.frame.size.height-50);
            
            self.vwBannerView.frame=CGRectMake(0, SCREEN_SIZE.height-50, SCREEN_SIZE.width, 50);
        }
        
    }
    
    arrReligion=[[NSMutableArray alloc] init];
    arrEthnicity=[[NSMutableArray alloc] init];
    
    arrReligionIDs=[[NSMutableArray alloc] init];
    arrEthnicityIDs=[[NSMutableArray alloc] init];
    
    arrQues=[[NSMutableArray alloc] init];
    arrQuestionIds=[[NSMutableArray alloc] init];
    qu_id=@"0";
    
    arrSelectedReligionIds=[[NSMutableArray alloc] init];
    arrSelectedEthnicityIds=[[NSMutableArray alloc] init];
    
    
    [self getEthnicityAndReligionAndQuestions];
    
    self.scrl.delegate=self;
    
    if ([self.dictDetails count] == 0) {
        
        self.scrl.hidden = YES;
        ALERTVIEW([MCLocalization stringForKey:@"No Data Found"], self);
    }
    
    [self.colReligion registerClass:[NumbersCell class] forCellWithReuseIdentifier:@"NumbersCell"];
    [self.colReligion registerNib:[UINib nibWithNibName:@"NumbersCell" bundle: nil]forCellWithReuseIdentifier:@"NumbersCell"];
    
    [self.colEthnicity registerClass:[NumbersCell class] forCellWithReuseIdentifier:@"NumbersCell"];
    [self.colEthnicity registerNib:[UINib nibWithNibName:@"NumbersCell" bundle: nil]forCellWithReuseIdentifier:@"NumbersCell"];
    
    self.colReligion.tag = 101;
    self.colEthnicity.tag = 102;
    [self.colInstaImages registerNib:[UINib nibWithNibName:@"ImageCell1" bundle:nil] forCellWithReuseIdentifier:@"ImageCell1"];
    UIEdgeInsets collectionViewInsets = UIEdgeInsetsMake(10.0, 8.0, 10.0, 8.0);
    self.colInstaImages.contentInset = collectionViewInsets;
    self.colInstaImages.scrollIndicatorInsets = UIEdgeInsetsMake(collectionViewInsets.top, 0, collectionViewInsets.bottom, 0);
    totalCellWidth = 0;
    flag1 = YES;
    
    aboutMe=[dictDetails valueForKey:@"about"];
    
    que = [[dictDetails valueForKey:@"que_id"] integerValue];
    answer = [dictDetails valueForKey:@"que_ans"];
    
    height = [dictDetails valueForKey:@"height"];
    kidsDetail = [dictDetails valueForKey:@"kids"];
    
    
    
    profession = [dictDetails valueForKey:@"profession"];
    
    if(profession.length >100){
        profession = [profession substringToIndex:100];
    }
    
    education = [dictDetails valueForKey:@"education"];
    if(education.length >100){
        education = [education substringToIndex:100];
    }
    
    age1 = [dictDetails valueForKey:@"age"];
    
    gallary = [dictDetails valueForKey:@"gallary"];
    profilephoto = [dictDetails valueForKey:@"profile_img"];
    
    profilepic = [NSString stringWithFormat:@"%@%@",imageUrl,profilephoto];
    
    self.txtAnswers.text = answer;
    self.txtAboutMe.text=aboutMe;
    self.lblHeight.text = height;
    self.lblDegree.text = education;
    self.lblJob.text = profession;
    self.lblKids.text = kidsDetail;
    
    self.page.currentPageIndicatorTintColor = Theme_Color;
    self.page.numberOfPages = [gallary count];
    
    NSString *str = [NSString stringWithFormat:@"%@ %@", [[dictDetails valueForKey:@"fname"] capitalizedString], [[dictDetails valueForKey:@"lname"] capitalizedString]];
    
    NSMutableAttributedString * mutableAttriStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSShadow * shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowBlurRadius = 4.0;
    shadow.shadowOffset = CGSizeMake(1.0, 1.0);
    NSDictionary * attris = @{NSShadowAttributeName:shadow};
    [mutableAttriStr setAttributes:attris range:NSMakeRange(0,mutableAttriStr.length)];
    self.lblName.attributedText = mutableAttriStr;
    
    [self setPreferences];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    int image_no=1;
    
    if(gallary.count > 1){
        self.page.hidden = NO;
    }
    else{
        self.page.hidden = YES;
    }
    
    for(int i=0,index=1;i<[gallary count] && index<=6;index++){
        
        NSString *strImg=[NSString stringWithFormat:@"img%d",index];
        
        NSString *temp=[NSString stringWithFormat:@"%@%@",imageUrl,[gallary valueForKey:strImg]];
        
        
        while(![gallary valueForKey:strImg]){
            index++;
            strImg=[NSString stringWithFormat:@"img%d",index];
            temp=[NSString stringWithFormat:@"%@%@",imageUrl,[gallary valueForKey:strImg]];
        }
        
        if(image_no == 1) {
            
            [self.actOne startAnimating];
            [self.img1 sd_setImageWithURL:[NSURL URLWithString:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image!=nil){
                    self.img1.image = image;
                }
                else{
                    self.img1.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actOne stopAnimating];
                
            }];
            image_no++;
        }
        else if(image_no == 2){
            [self.actTwo startAnimating];
            [self.img2 sd_setImageWithURL:[NSURL URLWithString:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image!=nil){
                    self.img2.image = image;
                }
                else{
                    self.img2.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actTwo stopAnimating];
                
            }];
            image_no++;
        }
        else if(image_no == 3){
            [self.actThree startAnimating];
            [self.img3 sd_setImageWithURL:[NSURL URLWithString:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image!=nil){
                    self.img3.image = image;
                }
                else{
                    self.img3.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actThree stopAnimating];
                
            }];
            image_no++;
        }
        else if(image_no == 4){
            [self.actFour startAnimating];
            [self.img4 sd_setImageWithURL:[NSURL URLWithString:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image!=nil){
                    self.img4.image = image;
                }
                else{
                    self.img4.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actFour stopAnimating];
                
            }];
            image_no++;
        }
        else if(image_no == 5){
            [self.actFive startAnimating];
            [self.img5 sd_setImageWithURL:[NSURL URLWithString:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image!=nil){
                    self.img5.image = image;
                }
                else{
                    self.img5.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actFive stopAnimating];
                
            }];
            image_no++;
        }
        else if(image_no == 6){
            [self.actSix startAnimating];
            [self.img6 sd_setImageWithURL:[NSURL URLWithString:temp] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image!=nil){
                    self.img6.image = image;
                }
                else{
                    self.img6.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actSix stopAnimating];
                
            }];
            image_no++;
        }
        else{
            
        }
        
        i++;
        
    }
    
    self.scrlSlider.contentSize = CGSizeMake([gallary count]*SCREEN_SIZE.width, self.scrlSlider.frame.size.height);
    if(gallary.count > 1){
        self.pageController.hidden = NO;
        
        [self configureHorizontalControllerWithTotalPages:[gallary count]];
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //[self.pageController sizeToFit];
            //self.pageController.frame = CGRectMake((SCREEN_SIZE.width - self.pageController.frame.size.width)/2, self.scrlSlider.frame.origin.y + self.scrlSlider.frame.size.height - self.pageController.frame.size.height, self.pageController.frame.size.width, self.pageController.frame.size.height);
            [self.pageController updateStateForPageNumber:1];
            
            
        });
        
        
    }
    else{
        self.pageController.hidden = NO;
        
    }
    // self.page.numberOfPages = [gallary count];
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if(gallary.count > 1){
        self.pageController.frame = CGRectMake(0, self.scrlSlider.frame.origin.y + self.scrlSlider.frame.size.height - self.pageController.frame.size.height , SCREEN_SIZE.width, self.pageController.frame.size.height);
    }
    else{
        self.pageController.frame = CGRectMake(0, self.scrlSlider.frame.origin.y + self.scrlSlider.frame.size.height - self.pageController.frame.size.height , SCREEN_SIZE.width, 5);
    }
    
    [self.lblName sizeToFit];
    self.lblName.frame = CGRectMake((SCREEN_SIZE.width - self.lblName.frame.size.width )/2, self.scrlSlider.frame.origin.y + self.scrlSlider.frame.size.height - self.lblName.frame.size.height - self.pageController.frame.size.height , self.lblName.frame.size.width, self.lblName.frame.size.height);
    
    
    if([assets count] > 0)
    {
        self.vwInstaNotConnected.hidden = YES;
        self.colInstaImages.hidden = NO;
        self.colInstaImages.frame = CGRectMake(self.colInstaImages.frame.origin.x, self.colInstaImages.frame.origin.y, self.colInstaImages.frame.size.width, (self.colInstaImages.frame.size.width/3)*2+20);
        self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwInsta.frame.origin.y, self.vwInsta.frame.size.width, self.colInstaImages.frame.origin.y+self.colInstaImages.frame.size.height+10);
    }
    else{
        
        
        self.vwInstaNotConnected.hidden = NO;
        self.colInstaImages.hidden = YES;
        self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwInsta.frame.origin.y, self.vwInsta.frame.size.width, self.vwInstaNotConnected.frame.origin.y+self.vwInstaNotConnected.frame.size.height+15);
    }
    
    
    self.scrlSlider.showsHorizontalScrollIndicator = NO;
    self.img1.frame=CGRectMake(0, 0, SCREEN_SIZE.width, self.scrlSlider.frame.size.height);
    self.img2.frame=CGRectMake(SCREEN_SIZE.width, 0, SCREEN_SIZE.width, self.scrlSlider.frame.size.height);
    self.img3.frame=CGRectMake(SCREEN_SIZE.width*2, 0, SCREEN_SIZE.width, self.scrlSlider.frame.size.height);
    self.img4.frame=CGRectMake(SCREEN_SIZE.width*3, 0, SCREEN_SIZE.width, self.scrlSlider.frame.size.height);
    self.img5.frame=CGRectMake(SCREEN_SIZE.width*4, 0, SCREEN_SIZE.width, self.scrlSlider.frame.size.height);
    self.img6.frame=CGRectMake(SCREEN_SIZE.width*5, 0, SCREEN_SIZE.width, self.scrlSlider.frame.size.height);
    
    cachedImage = self.img1.frame;
    
    [self localize];
    
    [appDelegate GetData:KadMobKey];
    
    self.vwBannerView.frame=CGRectMake(0, SCREEN_SIZE.height-50, SCREEN_SIZE.width, 50);
  
    
    [self.lblProfilePic sizeToFit];
    [self.lblQuate sizeToFit];
    [self.lblBasicInfo sizeToFit];
    [self.lblReligion sizeToFit];
    [self.lblEthnicity sizeToFit];
    [self.lblPhoto sizeToFit];
    [self.lblAge sizeToFit];
    [self.lblHeight sizeToFit];
    [self.lblDegree sizeToFit];
    [self.lblJob sizeToFit];
    [self.lblKids sizeToFit];
    [self.lblPreferences sizeToFit];
    
    self.lblProfileline.frame = CGRectMake(self.lblProfilePic.frame.origin.x, self.lblProfilePic.frame.origin.y + self.lblProfilePic.frame.size.height + 2, self.lblProfilePic.frame.size.width, self.lblProfileline.frame.size.height);
    self.lblQuoteline.frame = CGRectMake(self.lblQuate.frame.origin.x, self.lblQuate.frame.origin.y + self.lblQuate.frame.size.height + 2, self.lblQuate.frame.size.width, self.lblQuoteline.frame.size.height);
    self.lblBasicInfoline.frame = CGRectMake(self.lblBasicInfo.frame.origin.x, self.lblBasicInfo.frame.origin.y + self.lblBasicInfo.frame.size.height + 2, self.lblBasicInfo.frame.size.width, self.lblBasicInfoline.frame.size.height);
    self.lblPreferenceLine.frame = CGRectMake(self.lblPreferences.frame.origin.x, self.lblPreferences.frame.origin.y + self.lblPreferences.frame.size.height + 2, self.lblPreferences.frame.size.width, self.lblPreferenceLine.frame.size.height);
    
    self.vwProfilePic.frame=CGRectMake(0, 0, self.vwProfilePic.frame.size.width, self.vwProfilePic.frame.size.height);
    
    self.actProfile.frame = CGRectMake(self.imgProfilePic.frame.origin.x + (self.imgProfilePic.frame.size.width/2) - 10, self.imgProfilePic.frame.origin.y + (self.imgProfilePic.frame.size.height/2) - 10, self.actProfile.frame.size.width, self.actProfile.frame.size.width);
    
    self.vwQuate.frame=CGRectMake(0, self.vwProfilePic.frame.origin.y + self.vwProfilePic.frame.size.height + 15, self.vwQuate.frame.size.width, self.imgQuateIcon.frame.origin.y + self.imgQuateIcon.frame.size.height);
    
    if (que==0) {
        self.vwQuate.frame=CGRectMake(0, self.vwProfilePic.frame.origin.y + self.vwProfilePic.frame.size.height + 15, self.vwQuate.frame.size.width, 0);
        
        self.lblQuestion.frame = CGRectMake(self.lblQuestion.frame.origin.x, self.vwQuate.frame.origin.y + self.vwQuate.frame.size.height + 8, self.lblQuestion.frame.size.width, 0);
        
        self.txtAnswers.frame=CGRectMake(self.txtAnswers.frame.origin.x, self.lblQuestion.frame.origin.y + self.lblQuestion.frame.size.height + 8, self.txtAnswers.frame.size.width, 0);
    }
    else
    {
        
        self.lblQuestion.frame = CGRectMake(self.lblQuestion.frame.origin.x, self.vwQuate.frame.origin.y + self.vwQuate.frame.size.height + 8, self.lblQuestion.frame.size.width, self.lblQuestion.frame.size.height);
        
        CGFloat fixedWidth = self.txtAnswers.frame.size.width;
        CGSize newSize = [self.txtAnswers sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = self.txtAnswers.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        self.txtAnswers.frame = newFrame;
        
        self.txtAnswers.frame=CGRectMake(self.txtAnswers.frame.origin.x, self.lblQuestion.frame.origin.y + self.lblQuestion.frame.size.height + 8, self.txtAnswers.frame.size.width, self.txtAnswers.frame.size.height);
        
        CGFloat maxHeight = 130;
        CGFloat textViewHeight = self.txtAnswers.frame.size.height;
        self.txtAnswers.scrollEnabled = NO;
        if (textViewHeight > maxHeight)
        {
            self.txtAnswers.frame=CGRectMake(self.txtAnswers.frame.origin.x, self.lblQuestion.frame.origin.y + self.lblQuestion.frame.size.height + 8, self.txtAnswers.frame.size.width, 130.0);
            self.txtAnswers.scrollEnabled = YES;
        }
    }
    
    
    if ([[NSString stringWithFormat:@"%@",age1] isEqualToString:@"-"]|| age1 == nil) {
        
        self.imgHeight.frame=CGRectMake(self.imgAge.frame.origin.x, self.imgHeight.frame.origin.y, self.imgHeight.frame.size.width,self.imgHeight.frame.size.height);
        self.lblHeight.frame=CGRectMake(self.imgHeight.frame.origin.x + self.imgHeight.frame.size.width + 8, self.lblHeight.frame.origin.y, self.lblHeight.frame.size.width,self.lblHeight.frame.size.height);
        
        self.imgAge.hidden = YES;
        self.lblAge.hidden = YES;
    }
    else{
        age = [[dictDetails valueForKey:@"age"] stringValue];
        self.lblAge.text = age;
        
        if ([strFriendID isEqualToString:@""] || strFriendID == nil) {
            //TODO:  remove this comment
            [appDelegate SetData:age value:kAge];
        }

        self.lblAge.frame = CGRectMake(self.imgAge.frame.origin.x + self.imgAge.frame.size.width + 8, self.lblAge.frame.origin.y, self.lblAge.frame.size.width, self.lblAge.frame.size.height);
        
        self.imgHeight.frame=CGRectMake(self.lblAge.frame.origin.x + self.lblAge.frame.size.width + 20, self.imgHeight.frame.origin.y, self.imgHeight.frame.size.width,self.imgHeight.frame.size.height);
        
        self.lblHeight.frame=CGRectMake(self.imgHeight.frame.origin.x + self.imgHeight.frame.size.width + 8, self.lblHeight.frame.origin.y, self.lblHeight.frame.size.width,self.lblHeight.frame.size.height);
    }
    
    if([self.lblDegree.text  isEqualToString: @"-"])
    {
        if ([self.lblJob.text isEqualToString:@"-"]) {
            self.imgJob.frame = CGRectMake(self.imgJob.frame.origin.x, self.imgDegree.frame.origin.y, self.imgJob.frame.size.width, self.imgJob.frame.size.height);
            
            self.lblJob.frame = CGRectMake(self.imgJob.frame.origin.x + self.imgJob.frame.size.width + 8, self.lblDegree.frame.origin.y, self.lblJob.frame.size.width, self.lblJob.frame.size.height);
            
            self.imgKids.frame = CGRectMake(self.imgJob.frame.origin.x, self.imgJob.frame.origin.y, self.imgKids.frame.size.width, self.imgKids.frame.size.height);
            
            self.lblKids.frame = CGRectMake(self.imgKids.frame.origin.x + self.imgKids.frame.size.width + 8, self.lblJob.frame.origin.y, self.lblKids.frame.size.width, self.lblKids.frame.size.height);
            
            self.imgJob.hidden = YES;
            self.lblJob.hidden = YES;
        }
        else
        {
            self.imgJob.frame = CGRectMake(self.imgJob.frame.origin.x, self.imgDegree.frame.origin.y, self.imgJob.frame.size.width, self.imgJob.frame.size.height);
            
            self.lblJob.frame = CGRectMake(self.imgJob.frame.origin.x + self.imgJob.frame.size.width + 8, self.lblDegree.frame.origin.y, self.lblJob.frame.size.width, self.lblJob.frame.size.height);
            //ORIGINAL
            if(self.lblJob.frame.size.width > (SCREEN_SIZE.width - self.lblJob.frame.origin.x - 150))
            {
                self.lblJob.frame = CGRectMake(self.imgJob.frame.origin.x + self.imgJob.frame.size.width + 8, self.lblDegree.frame.origin.y, SCREEN_SIZE.width - self.lblJob.frame.origin.x - 150, self.lblJob.frame.size.height);
            }
            self.imgKids.frame = CGRectMake(self.lblJob.frame.origin.x + self.lblJob.frame.size.width + 8, self.imgJob.frame.origin.y, self.imgKids.frame.size.width, self.imgKids.frame.size.height);
            
            self.lblKids.frame = CGRectMake(self.imgKids.frame.origin.x + self.imgKids.frame.size.width + 8, self.lblJob.frame.origin.y, self.lblKids.frame.size.width, self.lblKids.frame.size.height);
            
        }
        self.imgDegree.hidden = YES;
        self.lblDegree.hidden = YES;
    }
    else
    {
        self.lblDegree.frame = CGRectMake(self.imgDegree.frame.origin.x + self.imgDegree.frame.size.width + 8, self.lblDegree.frame.origin.y, self.lblDegree.frame.size.width, self.imgDegree.frame.size.height);
        //TODO: testing
        
        if(self.lblDegree.frame.size.width > (SCREEN_SIZE.width - self.lblDegree.frame.origin.x - 15))
        {
            self.lblDegree.frame = CGRectMake(self.imgDegree.frame.origin.x + self.imgDegree.frame.size.width + 8, self.lblDegree.frame.origin.y, SCREEN_SIZE.width - self.lblDegree.frame.origin.x - 15, self.imgDegree.frame.size.height);
        }
        
        //ORIGINAL
        //        if(self.lblDegree.frame.size.width > (SCREEN_SIZE.width - self.lblDegree.frame.origin.x - 50))
        //        {
        //            self.lblDegree.frame = CGRectMake(self.imgDegree.frame.origin.x + self.imgDegree.frame.size.width + 8, self.lblDegree.frame.origin.y, SCREEN_SIZE.width - self.lblDegree.frame.origin.x - 50, self.imgDegree.frame.size.height);
        //        }
        
        if ([self.lblJob.text isEqualToString:@"-"]) {
            self.imgJob.frame = CGRectMake(self.imgJob.frame.origin.x, self.imgJob.frame.origin.y, self.imgJob.frame.size.width, self.imgJob.frame.size.height);
            
            self.lblJob.frame = CGRectMake(self.imgJob.frame.origin.x + self.imgJob.frame.size.width + 8, self.lblJob.frame.origin.y, self.lblJob.frame.size.width, self.lblJob.frame.size.height);
            
            self.imgKids.frame = CGRectMake(self.imgJob.frame.origin.x, self.imgJob.frame.origin.y, self.imgKids.frame.size.width, self.imgKids.frame.size.height);
            
            self.lblKids.frame = CGRectMake(self.imgKids.frame.origin.x + self.imgKids.frame.size.width + 8, self.lblJob.frame.origin.y, self.lblKids.frame.size.width, self.lblKids.frame.size.height);
            
            self.imgJob.hidden = YES;
            self.lblJob.hidden = YES;
        }
        else
        {
            self.imgJob.frame = CGRectMake(self.imgJob.frame.origin.x, self.imgJob.frame.origin.y, self.imgJob.frame.size.width, self.imgJob.frame.size.height);
            
            //ORIGINAL
            if(self.lblJob.frame.size.width > (SCREEN_SIZE.width - self.lblJob.frame.origin.x - 150))
            {
                self.lblJob.frame = CGRectMake(self.imgJob.frame.origin.x, self.imgJob.frame.origin.y, SCREEN_SIZE.width - self.lblJob.frame.origin.x - 150, self.lblJob.frame.size.height);
            }
            
            self.lblJob.frame = CGRectMake(self.imgJob.frame.origin.x + self.imgJob.frame.size.width + 8, self.lblJob.frame.origin.y, self.lblJob.frame.size.width, self.lblJob.frame.size.height);
            
            self.imgKids.frame = CGRectMake(self.lblJob.frame.origin.x + self.lblJob.frame.size.width + 8, self.imgJob.frame.origin.y, self.imgKids.frame.size.width, self.imgKids.frame.size.height);
            
            self.lblKids.frame = CGRectMake(self.imgKids.frame.origin.x + self.imgKids.frame.size.width + 8, self.lblJob.frame.origin.y, self.lblKids.frame.size.width, self.lblKids.frame.size.height);
            
        }
    }
    
    if([self.txtAboutMe.text isEqualToString:@""]){
        self.vwAboutMe.frame = CGRectMake(0, self.txtAnswers.frame.origin.y + self.txtAnswers.frame.size.height + 12, self.vwAboutMe.frame.size.width, 0);
    }
    else{
        CGFloat fixedWidth = self.txtAboutMe.frame.size.width;
        CGSize newSize = [self.txtAboutMe sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = self.txtAboutMe.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        self.txtAboutMe.frame = newFrame;
        
        self.txtAboutMe.frame=CGRectMake(self.txtAboutMe.frame.origin.x, 26, self.txtAboutMe.frame.size.width, self.txtAboutMe.frame.size.height);
        
        CGFloat maxHeight = 130;
        CGFloat textViewHeight = self.txtAboutMe.frame.size.height;
        self.txtAboutMe.scrollEnabled = NO;
        if (textViewHeight > maxHeight)
        {
            self.txtAboutMe.frame=CGRectMake(self.txtAboutMe.frame.origin.x, 26, self.txtAnswers.frame.size.width, 130.0);
            self.txtAboutMe.scrollEnabled = YES;
        }
        self.vwAboutMe.frame = CGRectMake(0, self.txtAnswers.frame.origin.y + self.txtAnswers.frame.size.height + 12, self.vwAboutMe.frame.size.width, self.txtAboutMe.frame.size.height+self.txtAboutMe.frame.origin.y);
    }
    
    self.vwPreferencesText.frame=CGRectMake(0, self.vwAboutMe.frame.origin.y + self.vwAboutMe.frame.size.height + 15, self.vwPreferencesText.frame.size.width, self.vwPreferencesText.frame.size.height);
    
    self.vwPreferences.frame=CGRectMake(self.vwPreferences.frame.origin.x, self.vwPreferencesText.frame.origin.y + self.vwPreferencesText.frame.size.height + 15, self.vwPreferences.frame.size.width, self.vwPreferences.frame.size.height);
    
    self.vwBasicInfo.frame = CGRectMake(0, self.vwPreferences.frame.origin.y + self.vwPreferences.frame.size.height + 12, self.vwBasicInfo.frame.size.width, self.imgKids.frame.origin.y + self.imgKids.frame.size.height + 15);
    
    if(arrSelectedReligionIds.count>0) {
        self.vwReligion.frame = CGRectMake(0, self.vwBasicInfo.frame.origin.y + self.vwBasicInfo.frame.size.height + 8, self.vwReligion.frame.size.width, self.colReligion.frame.origin.y + self.colReligion.frame.size.height + 8);
    }
    else{
        self.vwReligion.frame = CGRectMake(0, self.vwBasicInfo.frame.origin.y + self.vwBasicInfo.frame.size.height + 8, self.vwReligion.frame.size.width, 0);
    }
    
    
    self.lblReligion.frame = CGRectMake(self.lblReligion.frame.origin.x, 0, self.lblReligion.frame.size.width, self.lblReligion.frame.size.height);
    
    self.lblReligionline.frame = CGRectMake(self.lblReligion.frame.origin.x, self.lblReligion.frame.origin.y + self.lblReligion.frame.size.height + 2, self.lblReligion.frame.size.width, self.lblReligionline.frame.size.height);
    
    self.colReligion.frame = CGRectMake(self.colReligion.frame.origin.x, self.lblReligion.frame.origin.y + self.lblReligion.frame.size.height + 15, self.colReligion.frame.size.width, self.colReligion.frame.size.height);
    
    if(arrSelectedReligionIds.count>0){
        self.vwReligion.frame = CGRectMake(0, self.vwBasicInfo.frame.origin.y + self.vwBasicInfo.frame.size.height + 8, self.vwReligion.frame.size.width, self.colReligion.frame.origin.y + self.colReligion.frame.size.height + 8);
    }
    else{
        self.vwReligion.frame = CGRectMake(0, self.vwBasicInfo.frame.origin.y + self.vwBasicInfo.frame.size.height + 8, self.vwReligion.frame.size.width, 0);
    }
    
    
    self.lblReligion.frame = CGRectMake(self.lblReligion.frame.origin.x, 0, self.lblReligion.frame.size.width, self.lblReligion.frame.size.height);
    
    self.lblReligionline.frame = CGRectMake(self.lblReligion.frame.origin.x, self.lblReligion.frame.origin.y + self.lblReligion.frame.size.height + 2, self.lblReligion.frame.size.width, self.lblReligionline.frame.size.height);
    
    if(arrSelectedEthnicityIds.count>0){
        self.vwEthnicity.frame = CGRectMake(0, self.vwReligion.frame.origin.y + self.vwReligion.frame.size.height, self.vwEthnicity.frame.size.width, self.colEthnicity.frame.origin.y + self.colEthnicity.frame.size.height + 8);
    }
    else{
        self.vwEthnicity.frame = CGRectMake(0, self.vwReligion.frame.origin.y + self.vwReligion.frame.size.height, self.vwEthnicity.frame.size.width, 0);
    }
    
    
    
    self.lblPhoto.frame = CGRectMake(self.lblPhoto.frame.origin.x, 10*SCREEN_SIZE.height/667, self.lblPhoto.frame.size.width, self.lblPhoto.frame.size.height);
    self.lblPhotoline.frame = CGRectMake(self.lblPhoto.frame.origin.x, self.lblPhoto.frame.origin.y + self.lblPhoto.frame.size.height + 2, self.lblPhoto.frame.size.width, self.lblPhotoline.frame.size.height);
    
    self.lblEthnicity.frame = CGRectMake(self.lblEthnicity.frame.origin.x, 0, self.lblEthnicity.frame.size.width, self.lblEthnicity.frame.size.height);
    
    self.lblEthnicityline.frame = CGRectMake(self.lblEthnicity.frame.origin.x, self.lblEthnicity.frame.origin.y + self.lblEthnicity.frame.size.height + 2, self.lblEthnicity.frame.size.width, self.lblEthnicityline.frame.size.height);
    
    self.colEthnicity.frame = CGRectMake(self.colEthnicity.frame.origin.x, self.lblEthnicity.frame.origin.y + self.lblEthnicity.frame.size.height + 15, self.colEthnicity.frame.size.width, self.colEthnicity.frame.size.height);
    
    if(arrSelectedEthnicityIds.count>0){
        self.vwEthnicity.frame = CGRectMake(0, self.vwReligion.frame.origin.y + self.vwReligion.frame.size.height, self.vwEthnicity.frame.size.width, self.colEthnicity.frame.origin.y + self.colEthnicity.frame.size.height + 2);
    }
    else{
        self.vwEthnicity.frame = CGRectMake(0, self.vwReligion.frame.origin.y + self.vwReligion.frame.size.height, self.vwEthnicity.frame.size.width, 0);
    }
    
    
    
    self.lblEthnicity.frame = CGRectMake(self.lblReligion.frame.origin.x, 0, self.lblEthnicity.frame.size.width, self.lblEthnicity.frame.size.height);
    
    self.lblEthnicityline.frame = CGRectMake(self.lblEthnicity.frame.origin.x, self.lblEthnicity.frame.origin.y + self.lblEthnicity.frame.size.height + 2, self.lblEthnicity.frame.size.width, self.lblEthnicityline.frame.size.height);
    
    self.colEthnicity.frame = CGRectMake(self.colEthnicity.frame.origin.x, self.lblEthnicity.frame.origin.y + self.lblEthnicity.frame.size.height + 15, self.colEthnicity.frame.size.width, self.colEthnicity.frame.size.height);
    
    
    self.vwKids.frame = CGRectMake(0, self.vwEthnicity.frame.origin.y + self.vwEthnicity.frame.size.height, self.vwKids.frame.size.width,0);
    
    
    //manage Gallary images
    if([gallary count] == 0)
    {
        NSString *tempprofilepic = [NSString stringWithFormat:@"%@uploads/default.png",imageUrl];
        NSURL *tempurlProfile = [Util EncodedURL:tempprofilepic];
        
        [self.actProfile startAnimating];
        [self.imgProfilePic sd_setImageWithURL:tempurlProfile completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if(image != nil){
                self.imgProfilePic.image = image;
            }
            else{
                self.imgProfilePic.image = [UIImage imageNamed:@"TempProfile"];
            }
            
            [self.actProfile stopAnimating];
        }];
        
        self.vwPhotos.frame = CGRectMake(0, self.vwKids.frame.origin.y + self.vwKids.frame.size.height, self.vwPhotos.frame.size.width, 0);
        self.imgOne.frame = CGRectMake(self.imgOne.frame.origin.x, self.vwPhotos.frame.origin.y + self.vwPhotos.frame.size.height, self.imgOne.frame.size.width, 0);
        self.imgTwo.frame = CGRectMake(self.imgTwo.frame.origin.x, self.imgOne.frame.origin.y + self.imgOne.frame.size.height, self.imgTwo.frame.size.width, 0);
        self.imgThree.frame = CGRectMake(self.imgThree.frame.origin.x, self.imgTwo.frame.origin.y + self.imgTwo.frame.size.height, self.imgThree.frame.size.width, 0);
        self.imgFour.frame = CGRectMake(self.imgFour.frame.origin.x, self.imgThree.frame.origin.y + self.imgThree.frame.size.height, self.imgFour.frame.size.width, 0);
        self.imgFive.frame = CGRectMake(self.imgFive.frame.origin.x, self.imgFour.frame.origin.y + self.imgFour.frame.size.height, self.imgFive.frame.size.width, 0);
    }
    else
    {
        
        
        if([gallary valueForKey:@"img1"] != nil)
        {
            
            //            NSString *img11 =  [gallary valueForKey:@"img1"];
            
            NSString *img1 = [NSString stringWithFormat:@"%@%@",imageUrl,[gallary valueForKey:@"img1"]];
            NSURL *urlProfile = [Util EncodedURL:img1];
            
            NSString *tempprofilepic = [NSString stringWithFormat:@"%@uploads/default.png",imageUrl];
            NSURL *tempurlProfile = [Util EncodedURL:tempprofilepic];
            
            [self.actProfile startAnimating];
            
            self.imgProfilePic.frame=CGRectMake(36,self.imgProfilePic.frame.origin.y,SCREEN_SIZE.width-46,self.imgProfilePic.frame.size.height);
            
            [self.imgProfilePic sd_setImageWithURL:urlProfile completed:^(UIImage * _Nullable image1, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                self.imgProfilePic.image = image1;
                if (self.imgProfilePic.image == nil)
                {
                    [self.imgProfilePic sd_setImageWithURL:tempurlProfile completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        if(image != nil){
                            self.imgProfilePic.image = image;
                        }
                        else{
                            self.imgProfilePic.image  = [UIImage imageNamed:@"TempProfile"];
                        }
                        
                        [self.actProfile stopAnimating];
                        
                    }];
                }else{
                    self.imgProfilePic.frame=CGRectMake(36,self.imgProfilePic.frame.origin.y,[self aspectScaledImageSizeForImageView:self.imgProfilePic image:image1].width, [self aspectScaledImageSizeForImageView:self.imgProfilePic image:image1].height);
                    
                    [self.actProfile stopAnimating];
                }
                [self SetFramesAccordingly];
            }];
        }
        
        self.vwPhotos.frame = CGRectMake(0, self.vwKids.frame.origin.y + self.vwKids.frame.size.height, self.vwPhotos.frame.size.width, self.vwPhotos.frame.size.height + 8);
        
        if([gallary count] == 1)
        {
            self.vwPhotos.frame = CGRectMake(0, self.vwKids.frame.origin.y + self.vwKids.frame.size.height, self.vwPhotos.frame.size.width, 0);
        }
        
        
        if([gallary valueForKey:@"img2"] != nil) {
            // The key existed...
            NSString *img1 = [NSString stringWithFormat:@"%@%@",imageUrl,[gallary valueForKey:@"img2"]];
            NSURL *urlOne = [Util EncodedURL:img1];
            
            [self.actOne startAnimating];
            [self.imgOne sd_setImageWithURL:urlOne completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if(image != nil){
                    self.imgOne.image = image;
                }
                else{
                    self.imgOne.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actOne stopAnimating];
                self.imgOne.frame = CGRectMake(36, self.vwPhotos.frame.origin.y + self.vwPhotos.frame.size.height,[self aspectScaledImageSizeForImageView:self.imgOne image:image].width, [self aspectScaledImageSizeForImageView:self.imgOne image:image].height);
                [self SetFramesAccordingly];
            }];
            
        }
        else {
            // No joy...
            self.imgOne.frame = CGRectMake(self.imgOne.frame.origin.x, self.vwPhotos.frame.origin.y + self.vwPhotos.frame.size.height, self.imgOne.frame.size.width, 0);
        }
        
        if([gallary valueForKey:@"img3"] != nil)
        {
            NSString *img2 = [NSString stringWithFormat:@"%@%@",imageUrl,[gallary valueForKey:@"img3"]];
            NSURL *urlTwo = [Util EncodedURL:img2];
            self.imgTwo.frame = CGRectMake(36, self.imgOne.frame.origin.y + self.imgOne.frame.size.height + 22, SCREEN_SIZE.width-46, self.imgTwo.frame.size.height);
            
            [self.actTwo startAnimating];
            [self.imgTwo sd_setImageWithURL:urlTwo completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image != nil){
                    self.imgTwo.image = image;
                }
                else{
                    self.imgTwo.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actTwo stopAnimating];
                
                self.imgTwo.frame = CGRectMake(36, self.imgOne.frame.origin.y + self.imgOne.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgTwo image:image].width, [self aspectScaledImageSizeForImageView:self.imgTwo image:image].height);
                [self SetFramesAccordingly];
            }];
            
        }
        else
        {
            self.imgTwo.frame = CGRectMake(self.imgTwo.frame.origin.x, self.imgOne.frame.origin.y + self.imgOne.frame.size.height, self.imgTwo.frame.size.width, 0);
        }
        if([gallary valueForKey:@"img4"] != nil)
        {
            NSString *img3 = [NSString stringWithFormat:@"%@%@",imageUrl,[gallary valueForKey:@"img4"]];
            NSURL *urlThree = [Util EncodedURL:img3];
            
            
            self.imgThree.frame = CGRectMake(36, self.imgTwo.frame.origin.y + self.imgTwo.frame.size.height + 22, SCREEN_SIZE.width-46, self.imgThree.frame.size.height);
            
            
            [self.actThree startAnimating];
            [self.imgThree sd_setImageWithURL:urlThree completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image != nil){
                    self.imgThree.image = image;
                }
                else{
                    self.imgThree.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actThree stopAnimating];
                self.imgThree.frame = CGRectMake(36, self.imgTwo.frame.origin.y + self.imgTwo.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgThree image:image].width, [self aspectScaledImageSizeForImageView:self.imgThree image:image].height);
                
                [self SetFramesAccordingly];
            }];
            
        }
        else
        {
            self.imgThree.frame = CGRectMake(self.imgThree.frame.origin.x, self.imgTwo.frame.origin.y + self.imgTwo.frame.size.height, self.imgThree.frame.size.width, 0);
        }
        if([gallary valueForKey:@"img5"] != nil)
        {
            NSString *img4 = [NSString stringWithFormat:@"%@%@",imageUrl,[gallary valueForKey:@"img5"]];
            NSURL *urlFour = [Util EncodedURL:img4];
            self.imgFour.frame = CGRectMake(36, self.imgThree.frame.origin.y + self.imgThree.frame.size.height + 22, SCREEN_SIZE.width-46, self.imgFour.frame.size.height);
            
            [self.actFour startAnimating];
            [self.imgFour sd_setImageWithURL:urlFour completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if(image != nil){
                    self.imgFour.image = image;
                }
                else{
                    self.imgFour.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actFour stopAnimating];
                self.imgFour.frame = CGRectMake(36, self.imgThree.frame.origin.y + self.imgThree.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgFour image:image].width, [self aspectScaledImageSizeForImageView:self.imgFour image:image].height);
                [self SetFramesAccordingly];
                
            }];
        }
        else
        {
            self.imgFour.frame = CGRectMake(self.imgFour.frame.origin.x, self.imgThree.frame.origin.y + self.imgThree.frame.size.height, self.imgFour.frame.size.width, 0);
        }
        if([gallary valueForKey:@"img6"] != nil)
        {
            NSString *img5 = [NSString stringWithFormat:@"%@%@",imageUrl,[gallary valueForKey:@"img6"]];
            NSURL *urlFive = [Util EncodedURL:img5];
            
            self.imgFive.frame = CGRectMake(36, self.imgFour.frame.origin.y + self.imgFour.frame.size.height + 22, SCREEN_SIZE.width-46, self.imgFive.frame.size.height);
            
            [self.actFive startAnimating];
            [self.imgFive sd_setImageWithURL:urlFive completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if(image != nil){
                    self.imgFive.image = image;
                }
                else{
                    self.imgFive.image = [UIImage imageNamed:@"TempProfile"];
                }
                
                [self.actFive stopAnimating];
                self.imgFive.frame = CGRectMake(36, self.imgFour.frame.origin.y + self.imgFour.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgFive image:image].width, [self aspectScaledImageSizeForImageView:self.imgFive image:image].height);
                
                [self SetFramesAccordingly];
                
            }];
            
        }
        else
        {
            self.imgFive.frame = CGRectMake(self.imgFive.frame.origin.x, self.imgFour.frame.origin.y + self.imgFour.frame.size.height, self.imgFive.frame.size.width, 0);
        }
    }
    
    //MARK:- Hide instagram
    
    if ( ([[appDelegate GetData:INSTAGRAM_CLIENT_ID] isEqualToString:@""] || [[appDelegate GetData:INSTAGRAM_CLIENT_ID] isEqualToString:@"Key Not Found"])
        || ([[appDelegate GetData:INSTAGRAM_CALLBACK_BASE] isEqualToString:@""] || [[appDelegate GetData:INSTAGRAM_CALLBACK_BASE] isEqualToString:@"Key Not Found"])
        || ([[appDelegate GetData:INSTAGRAM_CLIENT_SECRET] isEqualToString:@""] || [[appDelegate GetData:INSTAGRAM_CLIENT_SECRET] isEqualToString:@"Key Not Found"]) ) {
        
        self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwEthnicity.frame.origin.y+self.vwEthnicity.frame.size.height, self.vwInsta.frame.size.width, 0.0);
        
    }
    else {
        self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwEthnicity.frame.origin.y+self.vwEthnicity.frame.size.height, self.vwInsta.frame.size.width, self.vwInsta.frame.size.height);
    }
    
    if (self.lblLine.frame.size.height < (SCREEN_SIZE.height - self.vwNavBar.frame.size.height))
    {
        self.lblLine.frame = CGRectMake(self.lblLine.frame.origin.x, self.lblLine.frame.origin.y, 1, SCREEN_SIZE.height - self.vwNavBar.frame.size.height);
    }
    else{
        self.lblLine.frame = CGRectMake(self.lblLine.frame.origin.x, self.lblLine.frame.origin.y, 1, self.vwInsta.frame.origin.y + self.vwInsta.frame.size.height + 22);
    }
    
    self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.vwInsta.frame.origin.y + self.vwInsta.frame.size.height);
}
/*!
 * @discussion Set Frames for ImageViews according to image size
 */
-(void)SetFramesAccordingly
{
    self.lblPhoto.frame = CGRectMake(self.lblPhoto.frame.origin.x, 8*SCREEN_SIZE.height/667, self.lblPhoto.frame.size.width, self.lblPhoto.frame.size.height);
    self.lblPhotoline.frame = CGRectMake(self.lblPhoto.frame.origin.x, self.lblPhoto.frame.origin.y + self.lblPhoto.frame.size.height + 2, self.lblPhoto.frame.size.width, self.lblPhotoline.frame.size.height);
    if([gallary valueForKey:@"img2"] == nil)
    {
        self.imgOne.frame = CGRectMake(36, self.vwPhotos.frame.origin.y + self.vwPhotos.frame.size.height,[self aspectScaledImageSizeForImageView:self.imgOne image:self.imgOne.image].width, 0);
        
    }
    else
    {
        self.imgOne.frame = CGRectMake(36, self.vwPhotos.frame.origin.y + self.vwPhotos.frame.size.height,[self aspectScaledImageSizeForImageView:self.imgOne image:self.imgOne.image].width, [self aspectScaledImageSizeForImageView:self.imgOne image:self.imgOne.image].height);
        
    }
    
    
    if([gallary valueForKey:@"img3"] == nil)
    {
        self.imgTwo.frame = CGRectMake(36, self.imgOne.frame.origin.y + self.imgOne.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgTwo image:self.imgTwo.image].width, 0);
        
    }
    else
    {
        self.imgTwo.frame = CGRectMake(36, self.imgOne.frame.origin.y + self.imgOne.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgTwo image:self.imgTwo.image].width, [self aspectScaledImageSizeForImageView:self.imgTwo image:self.imgTwo.image].height);
        
    }
    
    if([gallary valueForKey:@"img4"] == nil)
    {
        self.imgThree.frame = CGRectMake(36, self.imgTwo.frame.origin.y + self.imgTwo.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgThree image:self.imgThree.image].width, 0);
        
    }
    else
    {
        self.imgThree.frame = CGRectMake(36, self.imgTwo.frame.origin.y + self.imgTwo.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgThree image:self.imgThree.image].width, [self aspectScaledImageSizeForImageView:self.imgThree image:self.imgThree.image].height);
        
    }
    
    
    
    if([gallary valueForKey:@"img5"] == nil)
    {
        self.imgFour.frame = CGRectMake(36, self.imgThree.frame.origin.y + self.imgThree.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgFour image:self.imgFour.image].width,0);
    }
    else{
        self.imgFour.frame = CGRectMake(36, self.imgThree.frame.origin.y + self.imgThree.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgFour image:self.imgFour.image].width, [self aspectScaledImageSizeForImageView:self.imgFour image:self.imgFour.image].height);
        
    }
    
    if([gallary valueForKey:@"img6"] == nil)
    {
        self.imgFive.frame = CGRectMake(36, self.imgFour.frame.origin.y + self.imgFour.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgFive image:self.imgFive.image].width, 0);
    }
    else
    {
        self.imgFive.frame = CGRectMake(36, self.imgFour.frame.origin.y + self.imgFour.frame.size.height + 22,[self aspectScaledImageSizeForImageView:self.imgFive image:self.imgFive.image].width, [self aspectScaledImageSizeForImageView:self.imgFive image:self.imgFive.image].height);
    }
    
    
    
    self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.vwInsta.frame.origin.y + self.vwInsta.frame.size.height);
    
    self.lblLine.frame=CGRectMake(self.lblLine.frame.origin.x,self.scrlSlider.frame.origin.y+self.scrlSlider.frame.size.height,1,self.scrl.contentSize.height);
    self.imgVerticalline.frame = self.lblLine.frame;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 * @discussion calculte size for Image
 * @param iv For indentifying Image view need to resize
 * @param im For indentifying Image need to resize
 * @return Size for Image View
 */
- (CGSize) aspectScaledImageSizeForImageView:(UIImageView *)iv image:(UIImage *)im {
    
    float x,y;
    float a,b;
    x = iv.frame.size.width;
    y = iv.frame.size.height;
    a = im.size.width;
    b = im.size.height;
    
    if ( x == a && y == b )
    {           // image fits exactly, no scaling required
        
    }
    else if(a==b)
    {
        a=x;
        b=x;
    }
    else if ( x > a && y > b ) {         // image fits completely within the imageview
        b = x/a * b;                // image width is limiting factor, scale by width
        a = x;
        
    }
    else if ( x < a && y < b ) {        // image is wider and taller than image view
        // width is limiting factor, scale by width
        b = x/a * b;
        a = x;
        
    }
    else if ( x < a && y > b ) {        // image is wider than view, scale by width
        b = x/a * b;
        a = x;
    }
    else if ( x > a && y < b )
    {        // image is taller than view, scale by height
        b = x/a * b;
        a = x;
        
    }
    else if ( x == a ) {
        a = y/b * a;
        b = y;
    } else if ( y == b ) {
        b = x/a * b;
        a = x;
    }
    return CGSizeMake(a,b);
    
}

-(void)setPreferences {
    //get user preferences
    NSArray *tempString = [[dictDetails valueForKey:@"date_pref"] componentsSeparatedByString:@","];
    pref1 = tempString[0];
    pref2 = tempString[1];
    pref3 = tempString[2];
    pref4 = tempString[3];
    
    //set view according to user preferences
    switch ([pref1 intValue]) {
        case 1:
            self.imgPref1.image = [UIImage imageNamed:@"iconCoffee"];
            self.lblPref1.text = [MCLocalization stringForKey:@"Coffee"];
            break;
        case 2:
            self.imgPref1.image = [UIImage imageNamed:@"iconDrink"];
            self.lblPref1.text = [MCLocalization stringForKey:@"Drink"];
            break;
        case 3:
            self.imgPref1.image = [UIImage imageNamed:@"iconFood"];
            self.lblPref1.text = [MCLocalization stringForKey:@"Food"];
            break;
        case 4:
            self.imgPref1.image = [UIImage imageNamed:@"iconFun"];
            self.lblPref1.text = [MCLocalization stringForKey:@"Fun"];
            break;
            
        default:
            break;
    }
    switch ([pref2 intValue]) {
        case 1:
            self.imgPref2.image = [UIImage imageNamed:@"iconCoffee"];
            self.lblPref2.text = [MCLocalization stringForKey:@"Coffee"];
            break;
        case 2:
            self.imgPref2.image = [UIImage imageNamed:@"iconDrink"];
            self.lblPref2.text = [MCLocalization stringForKey:@"Drink"];
            break;
        case 3:
            self.imgPref2.image = [UIImage imageNamed:@"iconFood"];
            self.lblPref2.text = [MCLocalization stringForKey:@"Food"];
            break;
        case 4:
            self.imgPref2.image = [UIImage imageNamed:@"iconFun"];
            self.lblPref2.text = [MCLocalization stringForKey:@"Fun"];
            break;
            
        default:
            break;
    }
    switch ([pref3 intValue]) {
        case 1:
            self.imgPref3.image = [UIImage imageNamed:@"iconCoffee"];
            self.lblPref3.text = [MCLocalization stringForKey:@"Coffee"];
            break;
        case 2:
            self.imgPref3.image = [UIImage imageNamed:@"iconDrink"];
            self.lblPref3.text = [MCLocalization stringForKey:@"Drink"];
            break;
        case 3:
            self.imgPref3.image = [UIImage imageNamed:@"iconFood"];
            self.lblPref3.text = [MCLocalization stringForKey:@"Food"];
            break;
        case 4:
            self.imgPref3.image = [UIImage imageNamed:@"iconFun"];
            self.lblPref3.text = [MCLocalization stringForKey:@"Fun"];
            break;
            
        default:
            break;
    }
    switch ([pref4 intValue]) {
        case 1:
            self.imgPref4.image = [UIImage imageNamed:@"iconCoffee"];
            self.lblPref4.text = [MCLocalization stringForKey:@"Coffee"];
            break;
        case 2:
            self.imgPref4.image = [UIImage imageNamed:@"iconDrink"];
            self.lblPref4.text = [MCLocalization stringForKey:@"Drink"];
            break;
        case 3:
            self.imgPref4.image = [UIImage imageNamed:@"iconFood"];
            self.lblPref4.text = [MCLocalization stringForKey:@"Food"];
            break;
        case 4:
            self.imgPref4.image = [UIImage imageNamed:@"iconFun"];
            self.lblPref4.text = [MCLocalization stringForKey:@"Fun"];
            break;
            
        default:
            break;
    }
}

#pragma mark - UICollectionView Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView.tag == 101) {
        
        static NSString *indenti = @"NumbersCell";
        NumbersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
        
        [cell.lblNumber setFont:[UIFont fontWithName:@"Lato-Semibold" size:12]];
        
        for(int i=0; i < arrReligionIDs.count; i++)
        {
            if([[arrSelectedReligionIds objectAtIndex:indexPath.row] isEqualToString:[arrReligionIDs objectAtIndex:i]])
            {
                cell.lblNumber.text = [arrReligion objectAtIndex:i];
                break;
            }
            else
            {
                cell.lblNumber.text = [MCLocalization stringForKey:@"Religion"];
            }
        }
        
        cell.lblNumber.textColor = [UIColor whiteColor];
        
        UIColor *bgSelect = Theme_Color;
        cell.backgroundColor = bgSelect;
        
        return cell;
    }
    else if (collectionView.tag == 102) {
        
        static NSString *indenti = @"NumbersCell";
        NumbersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
        
        [cell.lblNumber setFont:[UIFont fontWithName:@"Lato-Semibold" size:12]];
        
        for(int i=0; i < arrEthnicityIDs.count; i++){
            if([[arrSelectedEthnicityIds objectAtIndex:indexPath.row] isEqualToString:[arrEthnicityIDs objectAtIndex:i]])
            {
                cell.lblNumber.text = [arrEthnicity objectAtIndex:i];
                break;
            }
            else
            {
                cell.lblNumber.text = [MCLocalization stringForKey:@"Ethnicity"];
            }
        }
        
        cell.lblNumber.textColor = [UIColor whiteColor];
        
        UIColor *bgSelect = Theme_Color;
        cell.backgroundColor = bgSelect;
        
        return cell;
        
    }
    else if(collectionView.tag == 104){
        static NSString *indenti=@"ImageCell1";
        ImageCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
        cell.selectionLabel.hidden = YES;
        cell.boarderImage.hidden = YES;
        
        [cell.act startAnimating];
        [cell.galleryImage sd_setImageWithURL:[assets objectAtIndex:indexPath.row ] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            cell.galleryImage.image=image;
            if(image==nil){
                cell.galleryImage.image = [UIImage imageNamed:@"NoPlaceFound"];
            }
            [cell.act stopAnimating];
        }];
        
        return cell;
    }
    
    return nil;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(collectionView.tag ==101){
        return arrSelectedReligionIds.count;
    }
    else if (collectionView.tag==102){
        return arrSelectedEthnicityIds.count;
    }
    else if(collectionView.tag == 104){
        return assets.count;
    }
    else{
        return 0;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 101) {
        return CGSizeMake((collectionView.frame.size.width/3)-7, 25);
    } else if (collectionView.tag == 102) {
        return CGSizeMake((collectionView.frame.size.width/2)-7, 25);
    } else if (collectionView.tag == 104) {
        return CGSizeMake((self.colInstaImages.frame.size.width/3)-5,(self.colInstaImages.frame.size.width/3)-5);
    } else {
        return CGSizeMake(0, 0);
    }
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    return layoutAttributes;
}

#pragma mark - Button Click
/*!
 * @discussion Called when back button is clicked
 * @param sender For indentifying sender
 */
- (IBAction)btnBackClicked:(id)sender {
    if ([strFriendID isEqualToString:@""] || strFriendID == nil) {
        [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark- scrollview Delegates
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    if(scrollView.tag == 1) {
        CGFloat y = -scrollView.contentOffset.y;
        if (y > 0) {
            if (@available(iOS 11.0, *))
            {
                self.img1.frame = CGRectMake(0, -y, SCREEN_SIZE.width, self.scrlSlider.frame.size.height + y);
                self.img2.frame = CGRectMake(SCREEN_SIZE.width, -y, SCREEN_SIZE.width, self.scrlSlider.frame.size.height + y);
                self.img3.frame = CGRectMake(SCREEN_SIZE.width*2, -y, SCREEN_SIZE.width, self.scrlSlider.frame.size.height + y);
                self.img4.frame = CGRectMake(SCREEN_SIZE.width*3, -y, SCREEN_SIZE.width, self.scrlSlider.frame.size.height + y);
                self.img5.frame = CGRectMake(SCREEN_SIZE.width*4, -y, SCREEN_SIZE.width, self.scrlSlider.frame.size.height + y);
                self.img6.frame = CGRectMake(SCREEN_SIZE.width*5, -y, SCREEN_SIZE.width, self.scrlSlider.frame.size.height + y);
            }
            
            if(self.scrlSlider.contentOffset.x >= self.view.frame.size.width && self.scrlSlider.contentOffset.x < self.view.frame.size.width*2) {
                self.img2.frame = CGRectMake(self.view.frame.size.width, -y, cachedImage.size.width + y, cachedImage.size.height + y);
                self.img2.center = CGPointMake(self.view.frame.size.width+self.view.center.x , self.img2.center.y);
            } else if(self.scrlSlider.contentOffset.x >= self.view.frame.size.width*2 && self.scrlSlider.contentOffset.x < self.view.frame.size.width*3) {
                self.img3.frame = CGRectMake(self.view.frame.size.width*2, -y, cachedImage.size.width + y, cachedImage.size.height+y);
                self.img3.center = CGPointMake(self.view.frame.size.width*2+self.view.center.x , self.img3.center.y);
            } else if(self.scrlSlider.contentOffset.x >= self.view.frame.size.width*3 && self.scrlSlider.contentOffset.x < self.view.frame.size.width*4) {
                self.img4.frame = CGRectMake(self.view.frame.size.width*3, -y, cachedImage.size.width+y, cachedImage.size.height+y);
                self.img4.center = CGPointMake(self.view.frame.size.width*3+self.view.center.x , self.img4.center.y);
            } else if(self.scrlSlider.contentOffset.x >= self.view.frame.size.width*4 && self.scrlSlider.contentOffset.x < self.view.frame.size.width*5) {
                self.img5.frame = CGRectMake(self.view.frame.size.width*4, -y, cachedImage.size.width+y, cachedImage.size.height+y);
                self.img5.center = CGPointMake(self.view.frame.size.width*4+self.view.center.x , self.img5.center.y);
            } else if(self.scrlSlider.contentOffset.x >= self.view.frame.size.width*5) {
                self.img6.frame = CGRectMake(self.view.frame.size.width*5, -y, cachedImage.size.width+y, cachedImage.size.height+y);
                self.img6.center = CGPointMake(self.view.frame.size.width*5+self.view.center.x , self.img6.center.y);
            } else {
                self.img1.frame = CGRectMake(0, -y, cachedImage.size.width+y, cachedImage.size.height+y);
                self.img1.center = CGPointMake(self.view.center.x, self.img1.center.y);
            }
            
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.tag == 2) {
        // self.page.currentPage=scrollView.contentOffset.x/SCREEN_SIZE.width;
        int page = scrollView.contentOffset.x/SCREEN_SIZE.width + 1;
        [self.pageController updateStateForPageNumber:page];
    }
}

#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblTitle.text = [MCLocalization stringForKey:@"FRIEND's STORY"];
    
    self.lblProfilePic.text = [MCLocalization stringForKey:@"Profile Photo"];
    self.lblQuate.text = [MCLocalization stringForKey:@"Quotes"];
    [self.lblQuate sizeToFit];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.lblQuoteline.frame = CGRectMake(self.lblQuate.frame.origin.x, self.lblQuate.frame.origin.y+ self.lblQuate.frame.size.height+2, self.lblQuate.frame.size.width, 1);
    });
    
    qu_id = [dictDetails valueForKey:@"que_id"] ;
    
    for(int i = 0; i < arrQues.count; i++) {
        if([qu_id isEqualToString:[arrQuestionIds objectAtIndex:i]]){
            self.lblQuestion.text = [arrQues objectAtIndex:i];
            break;
        }
    }
    
    self.lblBasicInfo.text = [MCLocalization stringForKey:@"Basics"];
    self.lblAboutme.text = [MCLocalization stringForKey:@"About Me"];
    self.lblReligion.text = [MCLocalization stringForKey:@"Religion"];
    self.lblEthnicity.text = [MCLocalization stringForKey:@"Ethnicity"];
    self.lblKidstext.text = [MCLocalization stringForKey:@"Kids"];
    self.lblPhoto.text = [MCLocalization stringForKey:@"Photos"];
    
    self.lblPreferences.text = [MCLocalization stringForKey:@"Date Preferences"];
    
    [self.lblAboutme sizeToFit];
    self.lblAboutmeline.frame = CGRectMake(self.lblAboutme.frame.origin.x, self.lblAboutmeline.frame.origin.y, self.lblAboutme.frame.size.width, 1);
    
    [self.lblBasicInfo sizeToFit];
    self.lblBasicInfoline.frame = CGRectMake(self.lblBasicInfo.frame.origin.x, self.lblBasicInfoline.frame.origin.y, self.lblBasicInfo.frame.size.width, 1);
    [self.lblReligion sizeToFit];
    self.lblReligionline.frame = CGRectMake(self.lblReligion.frame.origin.x, self.lblReligionline.frame.origin.y, self.lblReligion.frame.size.width, 1);
    [self.lblEthnicity sizeToFit];
    self.lblEthnicityline.frame = CGRectMake(self.lblEthnicity.frame.origin.x, self.lblEthnicityline.frame.origin.y, self.lblEthnicity.frame.size.width, 1);
    
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    self.lblTitleUnderline.frame = CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
    
    
    self.lblInsta.text = [MCLocalization stringForKey:@"Instagram Images"];
    [self.lblInsta sizeToFit];
    self.lblInstaLine.frame = CGRectMake(self.lblInsta.frame.origin.x, self.lblInstaLine.frame.origin.y, self.lblInsta.frame.size.width, 1);
    
    self.lblInstaNotConnected.text = [MCLocalization stringForKey:@"Instagram not connected"];
    [self.lblInstaNotConnected sizeToFit];
    self.vwInstaNotConnected.frame = CGRectMake((SCREEN_SIZE.width - self.lblInstaNotConnected.frame.size.width)/2, self.vwInstaNotConnected.frame.origin.y, self.lblInstaNotConnected.frame.size.width, self.vwInstaNotConnected.frame.size.height);
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"]) {
        [self setRTL];
    }
}
/*!
 * @discussion set RTL UI
 */
- (void)setRTL{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.lblQuate.frame = CGRectMake(45 *SCREEN_SIZE.width/375, self.lblQuate.frame.origin.y, self.lblQuate.frame.size.width, self.lblQuate.frame.size.height);
    });
    
    self.lblAboutme.frame = CGRectMake(45 *SCREEN_SIZE.width/375, self.lblAboutme.frame.origin.y, self.lblAboutme.frame.size.width, self.lblAboutme.frame.size.height);
    
    self.lblBasicInfo.frame = CGRectMake(45 *SCREEN_SIZE.width/375, self.lblBasicInfo.frame.origin.y, self.lblBasicInfo.frame.size.width, self.lblBasicInfo.frame.size.height);
    
    self.lblReligion.frame = CGRectMake(45 *SCREEN_SIZE.width/375, self.lblReligion.frame.origin.y, self.lblReligion.frame.size.width, self.lblReligion.frame.size.height);
    
    self.lblEthnicity.frame = CGRectMake(45 *SCREEN_SIZE.width/375, self.lblEthnicity.frame.origin.y, self.lblEthnicity.frame.size.width, self.lblEthnicity.frame.size.height);
    
    self.lblInsta.frame = CGRectMake(45 *SCREEN_SIZE.width/375, self.lblInsta.frame.origin.y, self.lblInsta.frame.size.width, self.lblInsta.frame.size.height);
}
/*!
 * @discussion Transform views
 */
- (void)transforms {
    [self.scrl setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblBasicInfo setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblAge setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblHeight setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblDegree setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblJob setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblKids setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblQuate setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblQuestion setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtAnswers setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.txtAnswers.textAlignment = NSTextAlignmentRight;
    self.lblQuate.textAlignment = NSTextAlignmentRight;
    
    [self.lblAboutme setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtAboutMe setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.txtAboutMe.textAlignment = NSTextAlignmentRight;
    
    [self.lblReligion setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.colReligion setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblReligion.textAlignment = NSTextAlignmentRight;
    self.lblEthnicity.textAlignment = NSTextAlignmentRight;
    
    [self.lblEthnicity setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.colEthnicity setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblInsta setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwInstaNotConnected setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblName setTransform:CGAffineTransformMakeScale(-1, 1)];
}
#pragma mark -API call
/*!
 * @discussion Webservice call for get ethnicity and religion list
 */
-(void) getEthnicityAndReligionAndQuestions
{
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         } else {
             NSString *str = @"get_all_static";
             NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
             
             NSString *strSelectedLanguage = [appDelegate GetData:@"SelectedLanguage"];
             [dict setValue:strSelectedLanguage forKey:@"language"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue] == 0) {
                     
                     NSArray *arr=[dictionary valueForKey:@"question"];
                     for (int i = 0; i < arr.count; i++)
                     {
                         NSData *data = [[[arr objectAtIndex:i] valueForKey:strSelectedLanguage] dataUsingEncoding:NSUTF16StringEncoding];
                         NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
                         [arrQues addObject:decodevalue];
                     }
                     
                     arrQuestionIds = [[[dictionary valueForKey:@"question"] valueForKey:@"id"] mutableCopy];
                     self.lblQuestion.text = [arrQues objectAtIndex:0];
                     
                     
                     NSArray *arr1 = [dictionary valueForKey:@"religion"];
                     for (int i = 0; i < arr1.count; i++)
                     {
                         NSData *data = [[[arr1 objectAtIndex:i] valueForKey:strSelectedLanguage] dataUsingEncoding:NSUTF16StringEncoding];
                         NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
                         [arrReligion addObject:decodevalue];
                     }
                     arrReligionIDs = [[[dictionary valueForKey:@"religion"] valueForKey:@"id"] mutableCopy];
                     
                     
                     NSArray *arr2 = [dictionary valueForKey:@"ethnicity"];
                     for (int i = 0; i < arr2.count; i++)
                     {
                         NSData *data = [[[arr2 objectAtIndex:i] valueForKey:strSelectedLanguage] dataUsingEncoding:NSUTF16StringEncoding];
                         NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
                         [arrEthnicity addObject:decodevalue];
                     }
                     arrEthnicityIDs = [[[dictionary valueForKey:@"ethnicity"] valueForKey:@"id"] mutableCopy];
                     
                     if ([dictDetails valueForKey:@"religion"] != nil) {
                         arrSelectedReligionIds = [[[dictDetails valueForKey:@"religion"] componentsSeparatedByString:@","] mutableCopy];
                     }
                    
                     if([arrSelectedReligionIds containsObject:@"0"]){
                         [arrSelectedReligionIds removeAllObjects];
                         self.vwReligion.frame = CGRectMake(self.vwReligion.frame.origin.x, self.vwReligion.frame.origin.y, self.vwReligion.frame.size.width, 0);
                     }
                     self.colReligion.frame = CGRectMake(self.colReligion.frame.origin.x, self.colReligion.frame.origin.y, self.colReligion.frame.size.width, 35*(ceil(arrSelectedReligionIds.count/3.0)));
                     
                     if ([dictDetails valueForKey:@"ethnicity"] != nil) {
                         arrSelectedEthnicityIds = [[[dictDetails valueForKey:@"ethnicity"] componentsSeparatedByString:@","] mutableCopy];
                     }
                     
                     if([arrSelectedEthnicityIds containsObject:@"0"]){
                         [arrSelectedEthnicityIds removeAllObjects];
                         self.vwEthnicity.frame = CGRectMake(self.vwEthnicity.frame.origin.x, self.vwEthnicity.frame.origin.y, self.vwEthnicity.frame.size.width, 0);
                     }
                     else{
                         //TODO: removing ethinicity
                         
                         self.colEthnicity.frame=CGRectMake(self.colEthnicity.frame.origin.x, self.colEthnicity.frame.origin.y, self.colEthnicity.frame.size.width, 35*(ceil(arrSelectedEthnicityIds.count/2.0)));
                         self.vwEthnicity.frame = CGRectMake(self.vwEthnicity.frame.origin.x, self.vwEthnicity.frame.origin.y, self.vwEthnicity.frame.size.width, self.colEthnicity.frame.origin.y+self.colEthnicity.frame.size.height);
                     }

                     [self.colReligion reloadData];
                     [self.colEthnicity reloadData];
                     
                     [self getInstaImages];
                 }
                 else
                 {
                     HIDE_PROGRESS;
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
             }];
         }
     }];
}
/*!
 * @discussion Webservice call for getting image urls from instagram
 */
-(void) getInstaImages
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         } else {
             NSString *str = @"GetInstagramImages";
             NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"userid"];
             if ([strFriendID isEqualToString:@""] || strFriendID == nil) {
                 [dict setValue:[appDelegate GetData:kuserid] forKey:@"friendid"];
             } else {
                 [dict setValue:strFriendID forKey:@"friendid"];
             }
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     if([[dictionary valueForKey:@"InstaImages"] valueForKey:@"url"] != nil) {
                         assets = [[dictionary valueForKey:@"InstaImages"] valueForKey:@"url"] ;
                     }
                     if(assets.count > 0) {
                         
                         //Images found
                         
                         self.vwInstaNotConnected.hidden = YES;
                         self.colInstaImages.hidden = NO;
                         self.colInstaImages.frame = CGRectMake(self.colInstaImages.frame.origin.x, self.colInstaImages.frame.origin.y, self.colInstaImages.frame.size.width, (self.colInstaImages.frame.size.width/3)*2+20);
                         self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwInsta.frame.origin.y, self.vwInsta.frame.size.width, self.colInstaImages.frame.origin.y+self.colInstaImages.frame.size.height+10);
                         
                         self.lblLine.frame = CGRectMake(self.lblLine.frame.origin.x, self.lblLine.frame.origin.y, 1, self.vwInsta.frame.origin.y);
                         
                         self.imgVerticalline.frame = self.lblLine.frame;
                         self.scrl.contentSize = CGSizeMake(SCREEN_SIZE.width, self.vwInsta.frame.origin.y+self.vwInsta.frame.size.height+10);
                         [self.colInstaImages reloadData];
                     } else {
                         // Images not found
                         self.vwInstaNotConnected.hidden = NO;
                         self.colInstaImages.hidden = YES;
                     }
                     //continue viewdidload
                     [self viewDidLayoutSubviews];
                 }
             }];
         }
     }];
}
#pragma mark -- Custom page controller configuration
- (void) configureHorizontalControllerWithTotalPages:(NSInteger)totalPages {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //Set delegate to the page controller object. To handle page change event.
        [self.pageController setDelegate:self];
        
        //Set Base View
        //Note: You don't need to set baseScrollView if there's only one HHPageView per view controller.
        [self.pageController setBaseScrollView:self.scrlSlider];
        
        //Set Images for Active and Inactive state.
        [self.pageController setImageActiveState:[UIImage imageNamed:@"PageSelect"] InActiveState:[UIImage  imageNamed:@"PageDeselect"]];
        
        //Tell PageController, the number of pages you want to show.
        [self.pageController setNumberOfPages:totalPages];
        
        //Tell PageController to show page from this page index.
        [self.pageController setCurrentPage:1];
        
        //Show when you ready!
        [self.pageController load];
    });
}
#pragma mark - HHPageController Delegate
- (void) HHPageView:(HHPageView *)pageView currentIndex:(NSInteger)currentIndex {
    UIScrollView *baseScrollView = (UIScrollView *) [pageView baseScrollView];
    if(baseScrollView) {
        [baseScrollView setContentOffset:CGPointMake(currentIndex * self.scrlSlider.frame.size.width, 0) animated:YES];
    } else {
        //If you've only single HHPageController for any of the view then no need to set baseScrollView.
        NSLog(@"You forgot to set baseScrollView for the HHPageView object!");
    }
}
@end
