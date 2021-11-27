//
//  SettingsVC.m
//  CupidLove
//
//  Created by APPLE on 07/12/16.
//  Copyright © 2016 Potenza. All rights reserved.
//

#import "SettingsVC.h"
#import "REDRangeSlider.h"
#import "KTCenterFlowLayout.h"
#import "GalleryVC.h"
#import "FacebookImageGalleryVC.h"
#import "NumbersCell.h"
#import <Photos/Photos.h>
#import "NMRangeSlider.h"
#import "InstagramAuthController.h"
#import "ImageCell1.h"

@interface SettingsVC ()<UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwScrollKids;

@property (weak,nonatomic) IBOutlet UIView *vwMenu;
@property (weak,nonatomic) IBOutlet UIView *vwTitle;
@property (strong,atomic) IBOutlet UICollectionView *colInstaImages;
@property (strong,atomic) IBOutlet UIView *vwInsta;
@property (strong,atomic) IBOutlet UILabel *lblInsta;
@property (strong,atomic) IBOutlet UILabel *lblInstaLine;
@property (strong,atomic) IBOutlet UIView *vwConnectInsta;
@property (strong,atomic) IBOutlet UILabel *lblConnect;
@property (strong,atomic) IBOutlet UIButton *btnUpdateInstaImages;

@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act1;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act2;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act3;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act4;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act5;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act6;

@property (weak,nonatomic) IBOutlet UIScrollView *scrl;
@property (weak, nonatomic) IBOutlet NMRangeSlider *labelSlider;
@property (weak, nonatomic) IBOutlet NMRangeSlider *distSlider;

@property (weak,nonatomic) IBOutlet UIView *lastView;
@property (strong,nonatomic) IBOutlet UIPickerView *pickerHeight;

@property (strong, nonatomic) REDRangeSlider *rangeSlider;

- (void)updateSliderLabels;
- (void)rangeSliderValueChanged:(id)sender;

@property (strong, nonatomic) REDRangeSlider *rangeSlider2;
- (void)updateSliderLabels2;

//age slider
@property (weak, nonatomic) IBOutlet UILabel *leftValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightValueLabel;
@property (weak,nonatomic) IBOutlet UIView *ageSlider;
@property (weak,nonatomic) IBOutlet UIView *leftTag;
@property (weak,nonatomic) IBOutlet UIView *rightTag;

//distance slider
@property (weak, nonatomic) IBOutlet UILabel *leftDistance;
@property (weak, nonatomic) IBOutlet UILabel *rightDistance;
@property (weak,nonatomic) IBOutlet UIView *distanceSlider;
@property (weak,nonatomic) IBOutlet UIView *leftTagDistance;
@property (weak,nonatomic) IBOutlet UIView *rightTagDistance;

@property (weak,nonatomic) IBOutlet UILabel *lblOffset;

//gender pref
@property (strong,nonatomic) IBOutlet UIImageView *imgMaleCheck;
@property (strong,nonatomic) IBOutlet UIImageView *imgFemaleCheck;
@property (strong,nonatomic) IBOutlet UIImageView *imgMale;
@property (strong,nonatomic) IBOutlet UIImageView *ImgFemale;
//gallery images
@property (strong,nonatomic) IBOutlet UIImageView *img1;
@property (strong,nonatomic) IBOutlet UIImageView *img2;
@property (strong,nonatomic) IBOutlet UIImageView *img3;
@property (strong,nonatomic) IBOutlet UIImageView *img4;
@property (strong,nonatomic) IBOutlet UIImageView *img5;
@property (strong,nonatomic) IBOutlet UIImageView *img6;

@property (strong,nonatomic) IBOutlet UITextView *txtAboutMe;
//for date preferences
@property (strong, nonatomic) IBOutlet UIView *viewCoffee;
@property (strong, nonatomic) IBOutlet UIView *viewDrink;
@property (strong, nonatomic) IBOutlet UIView *viewFood;
@property (strong, nonatomic) IBOutlet UIView *viewFun;
@property (strong, nonatomic) IBOutlet UILabel *lblOne;
@property (strong, nonatomic) IBOutlet UILabel *lblTwo;
@property (strong, nonatomic) IBOutlet UILabel *lblThree;
@property (strong, nonatomic) IBOutlet UILabel *lblFour;
@property (strong,nonatomic) IBOutlet UIView *preferenceView;
@property (strong,nonatomic) IBOutlet UIImageView *imgPref1;
@property (strong,nonatomic) IBOutlet UIImageView *imgPref2;
@property (strong,nonatomic) IBOutlet UIImageView *imgPref3;
@property (strong,nonatomic) IBOutlet UIImageView *imgPref4;

@property (strong,nonatomic) IBOutlet UIView *vwShadow;

//prefer not to say
@property (strong,nonatomic) IBOutlet UIImageView *imgNotSay1;
@property (strong,nonatomic) IBOutlet UIImageView *imgNotSay2;
//no of childern
@property(weak,nonatomic) IBOutlet UICollectionView *collNumbers;
@property (strong,nonatomic) IBOutlet UIImageView *imgNextArrow;
@property (strong,nonatomic) IBOutlet UIImageView *imgPrevArrow;
@property (strong,nonatomic) IBOutlet UIImageView *imgNone;
@property (strong,nonatomic) IBOutlet UIImageView *imgOneday;
@property (strong,nonatomic) IBOutlet UIImageView *imgDontwant;

@property (weak,nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak,nonatomic) IBOutlet UITextView *txtAnswer;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPhotos;
@property (strong, nonatomic) IBOutlet UILabel *lblDatePref;
@property (strong, nonatomic) IBOutlet UILabel *lblAgePref;
@property (strong, nonatomic) IBOutlet UILabel *lblDistancePref;
@property (strong, nonatomic) IBOutlet UILabel *lblInterestedIn;
@property (strong, nonatomic) IBOutlet UILabel *lblAboutMe;
@property (strong, nonatomic) IBOutlet UILabel *lblHeight;
@property (strong, nonatomic) IBOutlet UILabel *lblReligion;
@property (strong, nonatomic) IBOutlet UILabel *lblEthnicity;
@property (strong, nonatomic) IBOutlet UILabel *lblNotSay2;
@property (strong, nonatomic) IBOutlet UILabel *lblNotSay1;
@property (strong, nonatomic) IBOutlet UILabel *lblAlwaysVisible;
@property (strong, nonatomic) IBOutlet UILabel *lblKids;
@property (strong, nonatomic) IBOutlet UILabel *lblNone;
@property (strong, nonatomic) IBOutlet UILabel *lblOneDay;
@property (strong, nonatomic) IBOutlet UILabel *lblDontwantkids;
@property (strong, nonatomic) IBOutlet UIButton *btnNone;
@property (strong, nonatomic) IBOutlet UIButton *btnOneDay;
@property (strong, nonatomic) IBOutlet UIButton *btnDontwantKids;
@property (strong, nonatomic) IBOutlet UILabel *lblQuotes;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIButton *btnNotSay1;
@property (strong, nonatomic) IBOutlet UIButton *btnNotSay2;

@property (weak, nonatomic) IBOutlet UICollectionView *colReligion;
@property (weak, nonatomic) IBOutlet UICollectionView *colEthnicity;
@property (strong, nonatomic) KTCenterFlowLayout *layout;
@property (strong, nonatomic) KTCenterFlowLayout *layout1;

@property (weak, nonatomic) IBOutlet UIView *vwReligion;
@property (weak, nonatomic) IBOutlet UIView *vwEthnicity;
@property (weak, nonatomic) IBOutlet UIView *vwKids;
@property (weak, nonatomic) IBOutlet UIView *vwQuote;

@property (weak, nonatomic) IBOutlet UILabel *lblline;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;

@property(weak,nonatomic) IBOutlet UILabel *lblPhotosUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblDatePrefUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblAgeUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblDistanceUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblInsteredInUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblAboutUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblHeightUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblReligionUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblEthnicityUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblKidsUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblQuoteUnderline;

@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgVerticalline;

@property (weak, nonatomic) IBOutlet UIView *vwPhotos;
@property (weak, nonatomic) IBOutlet UIView *vwDatePref;
@property (weak, nonatomic) IBOutlet UIView *vwIntrestedIn;
@property (weak, nonatomic) IBOutlet UIView *vwAboutMe;
@property (weak, nonatomic) IBOutlet UIView *vwHeight;

@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblInfoQuote;

@end

@implementation SettingsVC
{
    CGRect rectCoffee,rectDrink,rectFood,rectFun;
    CGPoint centreCoffee,centreDrink,centreFood,centreFun;
    CGPoint centreOne,centreTwo,centreThree,centreFour;
    
    int set;
    float ageX,distanceX;
    NSString *genderPerf;
    
    NSString *flag_FB_Gallery;
    
    NSArray *pref;
    
    Boolean flag;
    
    Boolean flagUploadImage, flagUploadImage1, flagUploadImage2, flagUploadImage3, flagUploadImage4, flagUploadImage5, flagUploadImage6;
    
    NSArray *pickerArray;
    
    Boolean flagNotSay1;
    Boolean flagNotSay2;
    
    NSInteger noOfChildren;
    NSInteger scrollCellIndexCollectionView;
    
    Boolean flagChildrenNone;
    Boolean flagChildrenOneDay;
    Boolean flagChildrenDontWant;
    Boolean flagsetUI;
    
    NSInteger quesIndex;
    NSMutableArray *arrQuestions;
    
    NSString *kids;
    NSString *height;
    NSString *religion;
    NSString *ethinicity;
    UIColor *bgDeselect, *bgSelect;
    
    NSString *qu_id;
    
    NSMutableArray *arrEthnicity, *arrReligion, *arrReligionIDs, *arrEthnicityIDs, *arrSelectedReligionIds,*arrSelectedEthnicityIds, *arrQuestionIds;
    
    NSInteger TOTAL_QUESTIONS;
    
    NSString *nextPageURL;
    NSMutableArray *assets;
    
    NSMutableArray *arrDeletedImages;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    TOTAL_QUESTIONS=0;
    
    self.scrl.delegate=self;
    
    assets = [[NSMutableArray alloc] init];
    arrDeletedImages = [[NSMutableArray alloc] init];
    
    ageX=0.0;
    distanceX=0.0;
    flagsetUI=true;
    
    self.act1.color = Theme_Color;
    self.act2.color = Theme_Color;
    self.act3.color = Theme_Color;
    self.act4.color = Theme_Color;
    self.act5.color = Theme_Color;
    self.act6.color = Theme_Color;
    
    UIColor *underline_color = [UIColor whiteColor];
    
    UIColor *verticalline = [UIColor whiteColor];
    self.lblline.backgroundColor = verticalline;
    
    self.lblTitleUnderline.backgroundColor = underline_color;
    self.lblPhotosUnderline.backgroundColor = underline_color;
    self.lblDatePrefUnderline.backgroundColor = underline_color;
    self.lblAgeUnderline.backgroundColor = underline_color;
    self.lblDistanceUnderline.backgroundColor = underline_color;
    self.lblInsteredInUnderline.backgroundColor = underline_color;
    self.lblAboutUnderline.backgroundColor = underline_color;
    self.lblHeightUnderline.backgroundColor = underline_color;
    self.lblReligionUnderline.backgroundColor = underline_color;
    self.lblEthnicityUnderline.backgroundColor = underline_color;
    self.lblKidsUnderline.backgroundColor = underline_color;
    self.lblQuoteUnderline.backgroundColor = underline_color;
    self.lblInstaLine.backgroundColor = underline_color;
    
    flagChildrenNone=false;
    flagChildrenOneDay=false;
    flagChildrenDontWant=false;
    noOfChildren=0;
    flagNotSay1=false;
    flagNotSay2=false;
    
    kids=[[NSString alloc]init];
    height=[[NSString alloc] init];
    religion=[[NSString alloc]init];
    ethinicity=[[NSString alloc] init];
    
    quesIndex=0;
    
    bgDeselect=[UIColor lightTextColor];
    bgSelect=  Theme_Color ;
    
    //Pan Gesture for date Preferance..
    
    NSMutableSet *views = [[NSMutableSet alloc] init];
    
    //corner radius to all views..
    self.viewCoffee.layer.cornerRadius = self.viewCoffee.frame.size.height/2.5;
    self.viewDrink.layer.cornerRadius = self.viewDrink.frame.size.height/2.5;
    self.viewFood.layer.cornerRadius = self.viewFood.frame.size.height/2.5;
    self.viewFun.layer.cornerRadius = self.viewFun.frame.size.height/2.5;
    
    self.viewCoffee.layer.masksToBounds = YES;
    self.viewDrink.layer.masksToBounds = YES;
    self.viewFood.layer.masksToBounds = YES;
    self.viewFun.layer.masksToBounds = YES;
    
    [views addObject: self.viewCoffee];
    [views addObject: self.viewDrink];
    [views addObject: self.viewFood];
    [views addObject: self.viewFun];
    
    self.viewCoffee.tag = 101;
    self.viewDrink.tag = 102;
    self.viewFood.tag = 103;
    self.viewFun.tag = 104;
    
    for(UIView *view in views)
    {
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
        [view addGestureRecognizer:panGestureRecognizer];
    }
    
    self.vwShadow.layer.borderWidth =1.0f;
    self.vwShadow.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.vwShadow.layer.shadowRadius =2;
    self.vwShadow.layer.shadowOpacity = 0.5;
    self.vwShadow.layer.shadowOffset = CGSizeMake(-1,-1);
    
    arrQuestions=[[NSMutableArray alloc] init];
    
    self.lblQuestion.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblQuestion.numberOfLines = 0;
    
    //height picker
    pickerArray = [[NSArray alloc]initWithObjects:@"3'0 (92 cm)",
                   @"3'1 (94 cm)",@"3'2 (97 cm)",@"3'3 (99 cm)",@"3'4 (102 cm)",@"3'5 (104 cm)",@"3'6 (107 cm)",@"3'7 (109 cm)",@"3'8 (112 cm)",@"3'9 (114 cm)",@"3'10 (117 cm)",@"3'11 (119 cm)",@"4'0 (122 cm)",@"4'1 (125 cm)",@"4'2 (127 cm)",@"4'3 (130 cm)",@"4'4 (132 cm)",@"4'5 (135 cm)",@"4'6 (137 cm)",@"4'7 (140 cm)",@"4'8 (142 cm)",@"4'9 (145 cm)",@"4'10 (147 cm)",@"4'11 (150 cm)",@"5'0 (152 cm)",             @"5'1 (155 cm)",@"5'2 (158 cm)",@"5'3 (160 cm)",@"5'4 (163 cm)",@"5'5 (165 cm)",@"5'6 (168 cm)",@"5'7 (170 cm)",@"5'8 (173 cm)",@"5'9 (175 cm)",@"5'10 (178 cm)",@"5'11 (180 cm)",@"6'0 (183 cm)",@"6'1 (185 cm)",@"6'2 (188 cm)",@"6'3 (191 cm)",@"6'4 (193 cm)",@"6'5 (196 cm)",@"6'6 (198 cm)",@"6'7 (201 cm)",@"6'8 (203 cm)",@"6'9 (206 cm)",@"6'10 (208 cm)",@"6'11 (211 cm)",@"7'0 (213 cm)", nil];
    
    self.pickerHeight.delegate=self;
    self.pickerHeight.dataSource=self;
    self.pickerHeight.showsSelectionIndicator=YES;
    
    
    [self.collNumbers registerNib:[UINib nibWithNibName:@"NumbersCell" bundle:nil] forCellWithReuseIdentifier:@"NumbersCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setItemSize:CGSizeMake(42*SCREEN_SIZE.width/320, 42* SCREEN_SIZE.width/320)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collNumbers setCollectionViewLayout:flowLayout];
    self.collNumbers.scrollEnabled=NO;
    
    TOTAL_QUESTIONS=0;
    
    arrReligion=[[NSMutableArray alloc] init];
    arrEthnicity=[[NSMutableArray alloc] init];
    
    arrReligionIDs=[[NSMutableArray alloc] init];
    arrEthnicityIDs=[[NSMutableArray alloc] init];
    
    arrQuestionIds=[[NSMutableArray alloc] init];
    qu_id=0;
    
    arrSelectedReligionIds=[[NSMutableArray alloc] init];
    arrSelectedEthnicityIds=[[NSMutableArray alloc] init];
    
    self.layout = [[KTCenterFlowLayout alloc] init];
    self.layout1 = [[KTCenterFlowLayout alloc] init];
    
    self.colReligion.collectionViewLayout = self.layout;
    self.colEthnicity.collectionViewLayout = self.layout1;
    
    [self.colReligion registerClass:[NumbersCell class] forCellWithReuseIdentifier:@"NumbersCell"];
    [self.colReligion registerNib:[UINib nibWithNibName:@"NumbersCell" bundle: nil]forCellWithReuseIdentifier:@"NumbersCell"];
    
    [self.colEthnicity registerClass:[NumbersCell class] forCellWithReuseIdentifier:@"NumbersCell"];
    [self.colEthnicity registerNib:[UINib nibWithNibName:@"NumbersCell" bundle: nil]forCellWithReuseIdentifier:@"NumbersCell"];
    
    [self.colInstaImages registerNib:[UINib nibWithNibName:@"ImageCell1" bundle:nil] forCellWithReuseIdentifier:@"ImageCell1"];
    UIEdgeInsets collectionViewInsets = UIEdgeInsetsMake(10.0, 8.0, 10.0, 8.0);
    self.colInstaImages.contentInset = collectionViewInsets;
    self.colInstaImages.scrollIndicatorInsets = UIEdgeInsetsMake(collectionViewInsets.top, 0, collectionViewInsets.bottom, 0);
    
    [self getEthnicityAndReligionAndQuestions];
    
    [self configureLabelSlider];
    [self configureDistanceSlider];
    [self setupviewdidloadUi];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    
    self.vwTitle.hidden = NO;
    
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    
    if(flag==true)
    {
        centreOne = self.viewCoffee.center;
        centreTwo = self.viewDrink.center;
        centreThree = self.viewFood.center;
        centreFour = self.viewFun.center;
        if([pref count]==4)
        {
            int pref_one=[[pref objectAtIndex:0] intValue];
            int pref_two=[[pref objectAtIndex:1] intValue];
            int pref_three=[[pref objectAtIndex:2] intValue];
            int pref_four=[[pref objectAtIndex:3] intValue];
            switch (pref_one) {
                case 1:
                    self.viewCoffee.center = centreOne;
                    
                    self.lblOne.text=[MCLocalization stringForKey:@"Coffee"];
                    break;
                case 2:
                    self.viewDrink.center = centreOne;
                    
                    self.lblOne.text=[MCLocalization stringForKey:@"Drink"];
                    break;
                case 3:
                    self.viewFood.center = centreOne;
                    
                    self.lblOne.text=[MCLocalization stringForKey:@"Food"];
                    break;
                case 4:
                    self.viewFun.center = centreOne;
                    
                    self.lblOne.text=[MCLocalization stringForKey:@"Fun"];
                    break;
                default:
                    break;
            }
            switch (pref_two)
            {
                case 1:
                    self.viewCoffee.center = centreTwo;
                    
                    self.lblTwo.text=[MCLocalization stringForKey:@"Coffee"];
                    break;
                case 2:
                    self.viewDrink.center = centreTwo;
                    
                    self.lblTwo.text=[MCLocalization stringForKey:@"Drink"];
                    break;
                case 3:
                    self.viewFood.center = centreTwo;
                    
                    self.lblTwo.text=[MCLocalization stringForKey:@"Food"];
                    break;
                case 4:
                    self.viewFun.center = centreTwo;
                    
                    self.lblTwo.text=[MCLocalization stringForKey:@"Fun"];
                    break;
                default:
                    break;
            }
            switch (pref_three)
            {
                case 1:
                    self.viewCoffee.center = centreThree;
                    
                    self.lblThree.text=[MCLocalization stringForKey:@"Coffee"];
                    break;
                case 2:
                    self.viewDrink.center = centreThree;
                    
                    self.lblThree.text=[MCLocalization stringForKey:@"Drink"];
                    break;
                case 3:
                    self.viewFood.center = centreThree;
                    
                    self.lblThree.text=[MCLocalization stringForKey:@"Food"];
                    break;
                case 4:
                    self.viewFun.center = centreThree;
                    
                    self.lblThree.text=[MCLocalization stringForKey:@"Fun"];
                    break;
                default:
                    break;
            }
            switch (pref_four)
            {
                case 1:
                    self.viewCoffee.center = centreFour;
                    
                    self.lblFour.text=[MCLocalization stringForKey:@"Coffee"];
                    break;
                case 2:
                    self.viewDrink.center = centreFour;
                    
                    self.lblFour.text=[MCLocalization stringForKey:@"Drink"];
                    break;
                case 3:
                    self.viewFood.center = centreFour;
                    
                    self.lblFour.text=[MCLocalization stringForKey:@"Food"];
                    break;
                case 4:
                    self.viewFun.center = centreFour;
                    
                    self.lblFour.text=[MCLocalization stringForKey:@"Fun"];
                    break;
                default:
                    break;
            }
        }
        [self setRect];
    }
    flag=false;
}


-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self setFrames];
    
    [self localize];
    
    self.vwConnectInsta.hidden = NO;
    self.colInstaImages.hidden = YES;
    self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwInsta.frame.origin.y, self.vwInsta.frame.size.width, self.vwConnectInsta.frame.origin.y+self.vwConnectInsta.frame.size.height+15);
    
    CGRect temp = self.viewCoffee.frame;
    temp.size.height = temp.size.width;
    self.viewCoffee.frame = temp;
    temp.origin.x = self.viewDrink.frame.origin.x;
    self.viewDrink.frame = temp;
    temp.origin.x = self.viewFood.frame.origin.x;
    self.viewFood.frame = temp;
    temp.origin.x = self.viewFun.frame.origin.x;
    self.viewFun.frame = temp;    
    
    self.labelSlider.lowerValue = [[appDelegate GetData:kminAgePref] integerValue];
    self.labelSlider.upperValue =  [[appDelegate GetData:kmaxAgePref] integerValue];
    
    self.distSlider.lowerValue = [[appDelegate GetData:kMinDistance] integerValue];
    self.distSlider.upperValue =  [[appDelegate GetData:kmaxDistance] integerValue];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateSliderLabels];
        
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateSliderLabels2];
        
    });
    
    self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.lastView.frame.size.height+self.lastView.frame.origin.y);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.vwTitle.hidden = NO;
    [self setRect];
    int editedImage= appDelegate.editImage.intValue;
    if([arrDeletedImages containsObject:[NSString stringWithFormat:@"%d", editedImage]]){
        [arrDeletedImages removeObject:[NSString stringWithFormat:@"%d", editedImage]];
    }
    NSLog(@"Deleted images: %@",arrDeletedImages);
    if([flag_FB_Gallery isEqualToString:@"gallery"]){
        //back from gallery images
        if(editedImage>0 && (! [appDelegate.editImageName isEqualToString:@""])){
            
            PHImageManager *manager = [PHImageManager defaultManager];
            PHAsset *asset = appDelegate.asset;
            [appDelegate.selectedImages replaceObjectAtIndex:(editedImage-1) withObject:asset];
            [manager requestImageForAsset:asset
                               targetSize:CGSizeMake(300,300)
                              contentMode:PHImageContentModeAspectFit
                                  options:nil
                            resultHandler:^(UIImage * _Nullable result1, NSDictionary * _Nullable info) {
                                flagUploadImage=true;
                                switch (editedImage) {
                                    case 1:
                                        self.img1.image=result1;
                                        flagUploadImage1=true;
                                        break;
                                    case 2:
                                        self.img2.image=result1;
                                        flagUploadImage2=true;
                                        break;
                                    case 3:
                                        self.img3.image=result1;
                                        flagUploadImage3=true;
                                        break;
                                    case 4:
                                        self.img4.image=result1;
                                        flagUploadImage4=true;
                                        break;
                                    case 5:
                                        self.img5.image=result1;
                                        flagUploadImage5=true;
                                        break;
                                    case 6:
                                        self.img6.image=result1;
                                        flagUploadImage6=true;
                                        break;
                                    default:
                                        break;
                                }
                            }];
            
            appDelegate.editImageName=@"";
            editedImage=-1;
        }
    }
    else if ([flag_FB_Gallery isEqualToString:@"facebook"]){
        //back from fb images
        
        if(editedImage>0 && (! [appDelegate.editImageName isEqualToString:@""]))
        {
            UIImageView *temp=[[UIImageView alloc] init];
            [temp sd_setImageWithURL: [NSURL URLWithString:appDelegate.editImageName]  completed:^(UIImage * _Nullable result1, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                flagUploadImage=true;
                switch (editedImage) {
                    case 1:
                        self.img1.image=result1;
                        flagUploadImage1=true;
                        break;
                    case 2:
                        self.img2.image=result1;
                        flagUploadImage2=true;
                        break;
                    case 3:
                        self.img3.image=result1;
                        flagUploadImage3=true;
                        break;
                    case 4:
                        self.img4.image=result1;
                        flagUploadImage4=true;
                        break;
                    case 5:
                        self.img5.image=result1;
                        flagUploadImage5=true;
                        break;
                    case 6:
                        self.img6.image=result1;
                        flagUploadImage6=true;
                        break;
                    default:
                        break;
                }
            }];
            appDelegate.editImageName=@"";
            editedImage=-1;
            
        }
        
        
    }
    
    
}
/*!
 * @discussion Setup Ui
 */
-(void) setFrames{
    
    CGRect temp = self.vwDatePref.frame;
    temp.origin.y = self.vwPhotos.frame.origin.y;
    self.vwDatePref.frame = temp;
    
    temp = self.ageSlider.frame;
    temp.origin.y = self.vwDatePref.frame.origin.y + self.vwDatePref.frame.size.height;
    self.ageSlider.frame = temp;
    
    temp = self.distanceSlider.frame;
    temp.origin.y = self.ageSlider.frame.origin.y + self.ageSlider.frame.size.height;
    self.distanceSlider.frame = temp;
    
    temp = self.vwIntrestedIn.frame;
    temp.origin.y = self.distanceSlider.frame.origin.y + self.distanceSlider.frame.size.height;
    self.vwIntrestedIn.frame = temp;
    
//    temp = self.vwAboutMe.frame;
//    temp.origin.y = self.vwIntrestedIn.frame.origin.y + self.vwIntrestedIn.frame.size.height;
//    self.vwAboutMe.frame = temp;
//
//    temp = self.vwHeight.frame;
//    temp.origin.y = self.vwAboutMe.frame.origin.y + self.vwAboutMe.frame.size.height;
//    self.vwHeight.frame = temp;
    
    self.colReligion.frame=CGRectMake(self.colReligion.frame.origin.x, self.colReligion.frame.origin.y, self.colReligion.frame.size.width, 35*(ceil(arrReligion.count/3.0)));
    self.vwReligion.frame=CGRectMake(self.vwReligion.frame.origin.x, self.vwIntrestedIn.frame.origin.y + self.vwIntrestedIn.frame.size.height, self.vwReligion.frame.size.width, self.colReligion.frame.size.height+self.colReligion.frame.origin.y);
    
    self.colEthnicity.frame=CGRectMake(self.colEthnicity.frame.origin.x, self.colEthnicity.frame.origin.y, self.colEthnicity.frame.size.width, 35*(ceil(arrEthnicity.count/2.0)));
    self.vwEthnicity.frame=CGRectMake(self.vwEthnicity.frame.origin.x, self.vwReligion.frame.origin.y+self.vwReligion.frame.size.height, self.vwEthnicity.frame.size.width, self.colEthnicity.frame.size.height+self.colEthnicity.frame.origin.y);
    
//    self.vwKids.frame=CGRectMake(self.vwKids.frame.origin.x, self.vwEthnicity.frame.origin.y+self.vwEthnicity.frame.size.height, self.vwKids.frame.size.width, self.vwKids.frame.size.height);
    self.vwQuote.frame=CGRectMake(self.vwQuote.frame.origin.x, self.vwEthnicity.frame.origin.y + self.vwEthnicity.frame.size.height, self.vwQuote.frame.size.width, self.vwQuote.frame.size.height);
//    self.vwInsta.frame=CGRectMake(self.vwInsta.frame.origin.x, self.vwQuote.frame.origin.y+self.vwQuote.frame.size.height, self.vwInsta.frame.size.width, self.vwInsta.frame.size.height);
    self.lastView.frame=CGRectMake(self.lastView.frame.origin.x, self.vwQuote.frame.origin.y+self.vwQuote.frame.size.height, self.lastView.frame.size.width, self.lastView.frame.size.height);
    
    self.lblline.frame=CGRectMake(self.lblline.frame.origin.x, self.lblline.frame.origin.y, 1, self.lastView.frame.origin.y);
    self.imgVerticalline.frame = self.lblline.frame;
    self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.lastView.frame.origin.y+self.lastView.frame.size.height);
    
}

#pragma mark- btnClicks
/*!
 * @discussion Show previous question
 * @param sender For Identifying sender
 */
- (IBAction)btnPrevQuestion:(id)sender {
    quesIndex--;
    if(quesIndex<0){
        quesIndex=TOTAL_QUESTIONS-1;
    }
    self.lblQuestion.text=[arrQuestions objectAtIndex:quesIndex];
    self.txtAnswer.text = @"";
    qu_id=[arrQuestionIds objectAtIndex:quesIndex];
}
/*!
 * @discussion Show next question
 * @param sender For Identifying sender
 */
- (IBAction)btnNextQuestion:(id)sender {
    quesIndex++;
    if(quesIndex == TOTAL_QUESTIONS){
        quesIndex=0;
    }
    self.lblQuestion.text=[arrQuestions objectAtIndex:quesIndex];
    self.txtAnswer.text = @"";
    qu_id=[arrQuestionIds objectAtIndex:quesIndex];
}
/*!
 * @discussion None is set to kids option
 * @param sender For Identifying sender
 */
- (IBAction)btnNoneClicked:(id)sender {
    
    if(flagChildrenNone){
        kids=@"";
        self.imgNone.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenNone=false;
    }
    else{
        kids=@"None";
        self.imgNone.image=[UIImage imageNamed:@"CircleGreen"];
        flagChildrenNone=true;
        self.imgOneday.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenOneDay=false;
        self.imgDontwant.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenDontWant=false;
        noOfChildren=0;
        [self.collNumbers reloadData];
    }
    
}
/*!
 * @discussion One day is set to kids option
 * @param sender For Identifying sender
 */
- (IBAction)btnOneDayClicked:(id)sender {
    
    if(flagChildrenOneDay){
        kids=@"";
        self.imgOneday.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenOneDay=false;
    }
    else{
        kids=@"One Day";
        self.imgOneday.image=[UIImage imageNamed:@"CircleGreen"];
        flagChildrenOneDay=true;
        self.imgNone.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenNone=false;
        self.imgDontwant.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenDontWant=false;
        noOfChildren=0;
        [self.collNumbers reloadData];
    }
}
/*!
 * @discussion Don't want kids is set to kids option
 * @param sender For Identifying sender
 */
- (IBAction)btnDontWantClicked:(id)sender {
    
    if(flagChildrenDontWant){
        kids=@"";
        self.imgDontwant.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenDontWant=false;
        
    }
    else{
        kids=@"I Don't Want Kids";
        self.imgDontwant.image=[UIImage imageNamed:@"CircleGreen"];
        flagChildrenDontWant=true;
        self.imgNone.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenNone=false;
        self.imgOneday.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenOneDay=false;
        noOfChildren=0;
        [self.collNumbers reloadData];
        
    }
}
/*!
 * @discussion Scroll number of kids to left to show more option
 * @param sender For Identifying sender
 */
- (IBAction)btnPrevClicked:(id)sender {

        self.imgNextArrow.image=[UIImage imageNamed:@"arrowNextGreen"];
        if(scrollCellIndexCollectionView > 3){
            scrollCellIndexCollectionView--;
            NSArray *visibleItems = [self.collNumbers indexPathsForVisibleItems];
            NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
            NSIndexPath *nextItem = [NSIndexPath indexPathForItem:(scrollCellIndexCollectionView-3) inSection:currentItem.section];
            
            [self.collNumbers scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
        if (scrollCellIndexCollectionView==3){
            //set prev button gray
            self.imgPrevArrow.image=[UIImage imageNamed:@"arrowPrevGray"];
        }
}
/*!
 * @discussion Scroll number of kids to right to show more option
 * @param sender For Identifying sender
 */
- (IBAction)btnNextClicked:(id)sender {
    
        self.imgPrevArrow.image=[UIImage imageNamed:@"arrowPrevGreen"];
        if(scrollCellIndexCollectionView<6){
            scrollCellIndexCollectionView++;
            
            NSArray *visibleItems = [self.collNumbers indexPathsForVisibleItems];
            NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
            NSIndexPath *nextItem = [NSIndexPath indexPathForItem:scrollCellIndexCollectionView inSection:currentItem.section];
            
            [self.collNumbers scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            
            //set next image gray
        }
        if (scrollCellIndexCollectionView == 6){
            
            //set next image gray
            self.imgNextArrow.image=[UIImage imageNamed:@"arrowNextGray"];
        }
}

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
/*!
 * @discussion Save changes in user's Details
 * @param sender For Identifying sender
 */
- (IBAction)btnDoneClicked:(id)sender {
    //save changes
    if ([[self.txtAboutMe.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
        if([[self.txtAnswer.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0){
            
            if([kids isEqualToString:@""]) {
                ALERTVIEW([MCLocalization stringForKey:@"Please select kids"], self);
            }
            else {
                [self updatePerf];
            }
        }
        else {
            ALERTVIEW([MCLocalization stringForKey:@"Please Answer any one question"], self);
        }
    }
    else{
        ALERTVIEW([MCLocalization stringForKey:@"Please Enter Something About You. "], self);
    }
    
}
/*!
 * @discussion Open Menu
 * @param sender For Identifying sender
 */
- (IBAction)btnMenuClicked:(id)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];
}
/*!
 * @discussion Set gender preference to Male
 * @param sender For Identifying sender
 */
- (IBAction)btnMaleClicked:(id)sender {
    
    if([genderPerf isEqualToString:@"male"])
    {
        genderPerf=@"female";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.imgMale.image=[UIImage imageNamed:@"MaleGray"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Check"];
        self.ImgFemale.image=[UIImage imageNamed:@"Female"];
    } else {
        genderPerf=@"male";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Check"];
        self.imgMale.image=[UIImage imageNamed:@"Male"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.ImgFemale.image=[UIImage imageNamed:@"FemaleGray"];
    }
    
}
/*!
 * @discussion Set gender preference to Female
 * @param sender For Identifying sender
 */
- (IBAction)btnFemaleClicked:(id)sender {
    if([genderPerf isEqualToString:@"male"])
    {
        genderPerf=@"female";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.imgMale.image=[UIImage imageNamed:@"MaleGray"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Check"];
        self.ImgFemale.image=[UIImage imageNamed:@"Female"];
    } else {
        genderPerf=@"male";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Check"];
        self.imgMale.image=[UIImage imageNamed:@"Male"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.ImgFemale.image=[UIImage imageNamed:@"FemaleGray"];
    }
}
/*!
 * @discussion Called when user click edit Image, Gives options to edit images
 * @param sender For Identifying sender
 */
- (IBAction)btnEditClicked:(id)sender {
    //check which image should be editted
    UIButton *btn=sender;
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
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:[MCLocalization stringForKey:@"Select Image From"] preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Facebook"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        SHOW_LOADER_ANIMTION();
        // SHOW_PROGRESS([MCLocalization stringForKey:@"Please Wait."]);
        if ([FBSDKAccessToken currentAccessToken]) {
            FacebookImageGalleryVC *vc=[[FacebookImageGalleryVC alloc] initWithNibName:@"FacebookImageGalleryVC" bundle:nil];
            
            UINavigationController *navigationController =
            [[UINavigationController alloc] initWithRootViewController:vc];
            
            //now present this navigation controller modally
            [self presentViewController:navigationController
                               animated:YES
                             completion:^{
                                 
                             }];
        } else  {
            FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
            [login setLoginBehavior:FBSDKLoginBehaviorWeb];
            [login logInWithReadPermissions: @[@"public_profile", @"user_photos"]fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                HIDE_PROGRESS;
                if (error) {
                    
                    // Process error
                } else if (result.isCancelled) {
                    
                    // Handle cancellations
                } else {
                    
                    FacebookImageGalleryVC *vc=[[FacebookImageGalleryVC alloc] initWithNibName:@"FacebookImageGalleryVC" bundle:nil];
                    
                    UINavigationController *navigationController =
                    [[UINavigationController alloc] initWithRootViewController:vc];
                    
                    //now present this navigation controller modally
                    [self presentViewController:navigationController
                                       animated:YES
                                     completion:^{
                                         
                                     }];
                    
                    // If you ask for multiple permissions at once, you should check if specific permissions missing
                }
            }];
        }
        flag_FB_Gallery=@"facebook";
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Gallery"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        flag_FB_Gallery=@"gallery";
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
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Delete"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //delete image
        [arrDeletedImages addObject:[NSString stringWithFormat:@"%ld", (long)btn.tag]];
        NSLog(@"Deleted images: %@",arrDeletedImages);
        switch (btn.tag) {
            case 2:
                self.img2.image = [UIImage imageNamed:@"NoPlaceFound"];
                break;
            case 3:
                self.img3.image = [UIImage imageNamed:@"NoPlaceFound"];
                break;
            case 4:
                self.img4.image = [UIImage imageNamed:@"NoPlaceFound"];
                break;
            case 5:
                self.img5.image = [UIImage imageNamed:@"NoPlaceFound"];
                break;
            case 6:
                self.img6.image = [UIImage imageNamed:@"NoPlaceFound"];
                break;
            default:
                break;
        }
        
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
/*!
 * @discussion Called when user click edit Image, Gives options to edit images
 * @param sender For Identifying sender
 */
- (IBAction)btnEditProfileImageClicked:(id)sender {
    //check which image should be editted
//    UIButton *btn=sender;
    appDelegate.editImage=@"1";
    appDelegate.editImageName=@"Name";
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:[MCLocalization stringForKey:@"Select Image From"] preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
//    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Facebook"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        SHOW_LOADER_ANIMTION();
//        // SHOW_PROGRESS([MCLocalization stringForKey:@"Please Wait."]);
//        if ([FBSDKAccessToken currentAccessToken]) {
//            FacebookImageGalleryVC *vc=[[FacebookImageGalleryVC alloc] initWithNibName:@"FacebookImageGalleryVC" bundle:nil];
//
//            UINavigationController *navigationController =
//            [[UINavigationController alloc] initWithRootViewController:vc];
//
//            //now present this navigation controller modally
//            [self presentViewController:navigationController
//                               animated:YES
//                             completion:^{
//
//                             }];
//        } else  {
//            FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//            [login setLoginBehavior:FBSDKLoginBehaviorWeb];
//            [login logInWithReadPermissions: @[@"public_profile", @"user_photos"]fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//                HIDE_PROGRESS;
//                if (error) {
//
//                    // Process error
//                } else if (result.isCancelled) {
//
//                    // Handle cancellations
//                } else {
//
//                    FacebookImageGalleryVC *vc=[[FacebookImageGalleryVC alloc] initWithNibName:@"FacebookImageGalleryVC" bundle:nil];
//
//                    UINavigationController *navigationController =
//                    [[UINavigationController alloc] initWithRootViewController:vc];
//
//                    //now present this navigation controller modally
//                    [self presentViewController:navigationController
//                                       animated:YES
//                                     completion:^{
//
//                                     }];
//
//                    // If you ask for multiple permissions at once, you should check if specific permissions missing
//                }
//            }];
//        }
//        flag_FB_Gallery=@"facebook";
//    }]];
//    
    [actionSheet addAction:[UIAlertAction actionWithTitle:[MCLocalization stringForKey:@"Gallery"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        flag_FB_Gallery=@"gallery";
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
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
/*!
 * @discussion Called when user click import images from instagram
 * @param sender For Identifying sender
 */
- (IBAction)btnInstagramImportClicked:(id)sender {
    SHOW_LOADER_ANIMTION();
    
    [self performSelector:@selector(checkInstagramAuth) withObject:nil afterDelay:0];
}
#pragma mark- image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    int editedImage= appDelegate.editImage.intValue;
    if(editedImage>0){
        flagUploadImage=true;
        if([arrDeletedImages containsObject:[NSString stringWithFormat:@"%d", editedImage]]){
            [arrDeletedImages removeObject:[NSString stringWithFormat:@"%d", editedImage]];
        }
        NSLog(@"Deleted images: %@",arrDeletedImages);
        switch (editedImage) {
            case 1:
                self.img1.image=chosenImage;
                flagUploadImage1=true;
                break;
            case 2:
                self.img2.image=chosenImage;
                flagUploadImage2=true;
                break;
            case 3:
                self.img3.image=chosenImage;
                flagUploadImage3=true;
                break;
            case 4:
                self.img4.image=chosenImage;
                flagUploadImage4=true;
                break;
            case 5:
                self.img5.image=chosenImage;
                flagUploadImage5=true;
                break;
            case 6:
                self.img6.image=chosenImage;
                flagUploadImage6=true;
                break;
                
            default:
                break;
        }
        appDelegate.editImage=@"";
        appDelegate.editImageName=@"";
        editedImage=-1;
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    appDelegate.editImage=@"";
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
#pragma mark - Slider actions
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

/*!
 * @discussion Called when slider's value is changed
 * @param sender For identifying sender slider
 */
- (IBAction)labelSliderChanged:(NMRangeSlider*)sender
{
    
    UIButton *btn=(UIButton *)sender;
    if(btn.tag ==101){
        //age slider
        [self updateSliderLabels];
    }
    else if(btn.tag==102){
        //distance slider
        [self updateSliderLabels2];
    }
}
/*!
 * @discussion Update value for minimun and maximum Age prefernce after slliding the Age slider
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
 * @discussion Update value for minimun and maximum distance prefernce after slliding the distance slider
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

#pragma mark - PanGesture recorgniser

-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    set=0;
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    UIView *vw = (UIView *)panGestureRecognizer.view;
    vw.center = CGPointMake(vw.center.x + translation.x, vw.center.y + translation.y);
    [panGestureRecognizer setTranslation:CGPointZero inView:vw];
    
    [self.preferenceView bringSubviewToFront:vw];
    
    //checks what state the gesture is in. (are you just starting, letting go, or in the middle of a swipe?)
    switch (panGestureRecognizer.state) {
            // just started swiping
        case UIGestureRecognizerStateBegan:break;
        case UIGestureRecognizerStateChanged:break;
            // let go of the card
        case UIGestureRecognizerStateEnded: {
            CGPoint point = vw.center;
            
            [self swipeFrames:point];
            if(set==0)
            {
                [self afterSwipeAction:vw];
            }
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

/*!
 * @discussion Set frame of date preferences views
 */
-(void)setRect{
    centreCoffee = self.viewCoffee.center;
    centreDrink = self.viewDrink.center;
    centreFood = self.viewFood.center;
    centreFun = self.viewFun.center;
    
    rectCoffee = CGRectMake(self.viewCoffee.frame.origin.x, self.viewCoffee.frame.origin.y, self.viewCoffee.frame.size.width, self.viewCoffee.frame.size.height);
    rectDrink = CGRectMake(self.viewDrink.frame.origin.x, self.viewDrink.frame.origin.y, self.viewDrink.frame.size.width, self.viewDrink.frame.size.height);
    rectFood = CGRectMake(self.viewFood.frame.origin.x, self.viewFood.frame.origin.y, self.viewFood.frame.size.width, self.viewFood.frame.size.height);
    rectFun = CGRectMake(self.viewFun.frame.origin.x, self.viewFun.frame.origin.y, self.viewFun.frame.size.width, self.viewFun.frame.size.height);
}

/*!
 * @discussion Called after views are swiped
 * @param vw set frame of vw
 */
- (void)afterSwipeAction:(UIView*)vw
{
    if (vw.tag == self.viewCoffee.tag)
    {
        [UIView animateWithDuration:0.4 animations:^{self.viewCoffee.frame=rectCoffee;}];
    }
    else if (vw.tag == self.viewDrink.tag)
    {
        [UIView animateWithDuration:0.4 animations:^{self.viewDrink.frame=rectDrink;}];
    }
    else if (vw.tag == self.viewFood.tag)
    {
        [UIView animateWithDuration:0.4 animations:^{self.viewFood.frame=rectFood;}];
    }
    else if (vw.tag == self.viewFun.tag)
    {
        [UIView animateWithDuration:0.4 animations:^{self.viewFun.frame=rectFun;}];
    }
}


/*!
 * @discussion Swipe frames to point
 * @param point Center Point
 */
-(void)swipeFrames:(CGPoint)point{
    if(CGPointEqualToPoint(point, self.viewCoffee.center))
    {
        if(CGRectContainsPoint(rectDrink, point))
        {
            self.viewCoffee.center=self.viewDrink.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewDrink.center = centreCoffee;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewCoffee];
            [self makeFrameOfView:_viewDrink];
        }
        else if(CGRectContainsPoint(rectFood, point))
        {
            self.viewCoffee.center=self.viewFood.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewFood.center = centreCoffee;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewCoffee];
            [self makeFrameOfView:_viewFood];
        }
        else if(CGRectContainsPoint(rectFun, point))
        {
            self.viewCoffee.center=self.viewFun.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewFun.center = centreCoffee;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewCoffee];
            [self makeFrameOfView:_viewFun];
        }
    }
    
    if(CGPointEqualToPoint(point, self.viewDrink.center))
    {
        if(CGRectContainsPoint(rectCoffee, point))
        {
            self.viewDrink.center=self.viewCoffee.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewCoffee.center = centreDrink;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewDrink];
            [self makeFrameOfView:_viewCoffee];
        }
        else if(CGRectContainsPoint(rectFood, point))
        {
            self.viewDrink.center=self.viewFood.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewFood.center = centreDrink;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewDrink];
            [self makeFrameOfView:_viewFood];
        }
        else if(CGRectContainsPoint(rectFun, point))
        {
            self.viewDrink.center=self.viewFun.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewFun.center = centreDrink;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewDrink];
            [self makeFrameOfView:_viewFun];
        }
    }
    
    if(CGPointEqualToPoint(point, self.viewFood.center))
    {
        if(CGRectContainsPoint(rectCoffee, point))
        {
            self.viewFood.center=self.viewCoffee.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewCoffee.center = centreFood;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewFood];
            [self makeFrameOfView:_viewCoffee];
        }
        else if(CGRectContainsPoint(rectDrink, point))
        {
            self.viewFood.center=self.viewDrink.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewDrink.center = centreFood;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewDrink];
            [self makeFrameOfView:_viewFood];
        }
        else if(CGRectContainsPoint(rectFun, point))
        {
            self.viewFood.center=self.viewFun.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewFun.center = centreFood;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewFood];
            [self makeFrameOfView:_viewFun];
        }
    }
    
    if(CGPointEqualToPoint(point, self.viewFun.center))
    {
        if(CGRectContainsPoint(rectCoffee, point))
        {
            self.viewFun.center=self.viewCoffee.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewCoffee.center = centreFun;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewFun];
            [self makeFrameOfView:_viewCoffee];
        }
        else if(CGRectContainsPoint(rectDrink, point))
        {
            self.viewFun.center=self.viewDrink.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewDrink.center = centreFun;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewFun];
            [self makeFrameOfView:_viewDrink];
        }
        else if(CGRectContainsPoint(rectFood, point))
        {
            self.viewFun.center=self.viewFood.center;
            [UIView animateWithDuration:0.5 animations:^{
                self.viewFood.center = centreFun;
            } completion:^(BOOL finished){
                [self changeLabelValue];
            }];
            set=1;
            
            [self makeFrameOfView:_viewFun];
            [self makeFrameOfView:_viewFood];
        }
    }
}
/*!
 * @discussion Set frame of view and set it to desired place
 * @param view View whose frame is setting
 */
-(void)makeFrameOfView:(UIView*)view
{
    if(view==self.viewCoffee)
    {
        rectCoffee = CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
        centreCoffee=view.center;
    } else if(view==self.viewDrink)
    {
        rectDrink = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        centreDrink=view.center;
    } else if(view==self.viewFood)
    {
        rectFood = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        centreFood=view.center;
    } else if(view==self.viewFun)
    {
        rectFun = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        centreFun=view.center;
    }
}
/*!
 * @discussion Change date preference lables' text
 */
-(void)changeLabelValue{
    if(CGPointEqualToPoint(centreOne, self.viewCoffee.center))
    {
        _lblOne.text=[MCLocalization stringForKey:@"Coffee"];
    }
    if(CGPointEqualToPoint(centreOne, self.viewDrink.center))
    {
        _lblOne.text=[MCLocalization stringForKey:@"Drink"];
    }
    if(CGPointEqualToPoint(centreOne, self.viewFood.center))
    {
        _lblOne.text=[MCLocalization stringForKey:@"Food"];
    }
    if(CGPointEqualToPoint(centreOne, self.viewFun.center))
    {
        _lblOne.text=[MCLocalization stringForKey:@"Fun"];
    }
    
    if(CGPointEqualToPoint(centreTwo, self.viewCoffee.center))
    {
        _lblTwo.text=[MCLocalization stringForKey:@"Coffee"];
    }
    if(CGPointEqualToPoint(centreTwo, self.viewDrink.center))
    {
        _lblTwo.text=[MCLocalization stringForKey:@"Drink"];
    }
    if(CGPointEqualToPoint(centreTwo, self.viewFood.center))
    {
        _lblTwo.text=[MCLocalization stringForKey:@"Food"];
    }
    if(CGPointEqualToPoint(centreTwo, self.viewFun.center))
    {
        _lblTwo.text=[MCLocalization stringForKey:@"Fun"];
    }
    
    if(CGPointEqualToPoint(centreThree, self.viewCoffee.center))
    {
        _lblThree.text=[MCLocalization stringForKey:@"Coffee"];
    }
    if(CGPointEqualToPoint(centreThree, self.viewDrink.center))
    {
        _lblThree.text=[MCLocalization stringForKey:@"Drink"];
    }
    if(CGPointEqualToPoint(centreThree, self.viewFood.center))
    {
        _lblThree.text=[MCLocalization stringForKey:@"Food"];
    }
    if(CGPointEqualToPoint(centreThree, self.viewFun.center))
    {
        _lblThree.text=[MCLocalization stringForKey:@"Fun"];
    }
    
    if(CGPointEqualToPoint(centreFour, self.viewCoffee.center))
    {
        _lblFour.text=[MCLocalization stringForKey:@"Coffee"];
    }
    if(CGPointEqualToPoint(centreFour, self.viewDrink.center))
    {
        _lblFour.text=[MCLocalization stringForKey:@"Drink"];
    }
    if(CGPointEqualToPoint(centreFour, self.viewFood.center))
    {
        _lblFour.text=[MCLocalization stringForKey:@"Food"];
    }
    if(CGPointEqualToPoint(centreFour, self.viewFun.center))
    {
        _lblFour.text=[MCLocalization stringForKey:@"Fun"];
    }
}

#pragma mark - PickerView Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return [pickerArray count];
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [pickerArray objectAtIndex:row];
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}

#pragma mark- PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    height=[pickerArray objectAtIndex:row];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [pickerArray objectAtIndex:row];
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
    else if(collectionView.tag == 104)
    {
        return assets.count;
    }
    else if(collectionView.tag == 103)
    {
        return 7;
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
    else if(collectionView.tag == 103)
    {
        
        static NSString *indenti=@"NumbersCell";
        NumbersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
        [cell.lblNumber setFont:[UIFont fontWithName:@"Lato-Semibold" size:12]];
        
        cell.lblNumber.text=[NSString stringWithFormat:@"%ld",(indexPath.row+1) ];
        
        if((noOfChildren-1)== indexPath.row){
            cell.lblNumber.backgroundColor=bgSelect;
        }
        else{
            cell.lblNumber.backgroundColor=[UIColor clearColor];
        }
        cell.layer.cornerRadius=2.0;
        cell.layer.masksToBounds=YES;
        cell.lblNumber.layer.borderColor=bgSelect.CGColor;
        [cell.lblNumber.layer setBorderWidth: 1.5];
        
        return cell;
    }
    else if(collectionView.tag == 104){
        static NSString *indenti=@"ImageCell1";
        ImageCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
        cell.selectionLabel.hidden=YES;
        cell.boarderImage.hidden=YES;
        
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
    else if(collectionView.tag == 103){
        kids=[NSString stringWithFormat:@"%ld", indexPath.row+1 ];
        self.imgNone.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenNone=false;
        self.imgOneday.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenOneDay=false;
        self.imgDontwant.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenDontWant=false;
        noOfChildren=indexPath.row+1;
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
    else if(collectionView.tag == 103) {
        return CGSizeMake((collectionView.frame.size.width-30)/4, (collectionView.frame.size.width-30)/4);
    }
    else if (collectionView.tag == 104){
        return CGSizeMake((self.colInstaImages.frame.size.width/3)-5,(self.colInstaImages.frame.size.width/3)-5);
    }
    else {
        return CGSizeMake(0, 0);
    }
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    return layoutAttributes;
}
#pragma mark - textview delegates
-(void) textViewDidEndEditing:(UITextView *)textView {
    [self validateAnswer:textView];
}
/*!
 * @discussion For validating profession
 * @param sender For identifying sender
 */
-(IBAction) validateAnswer:(id)sender{
    NSString *str = [self.txtAnswer.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(str.length > 100) {
        self.txtAnswer.text = [str substringToIndex:100];
        ALERTVIEW([MCLocalization stringForKey:@"Your answer is too long. Enter answer containing maximum 100 characters"], self);
    }
    
}

#pragma mark- scrollview Delegates
-(void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    //get refrence of vertical indicator
    UIImageView *verticalIndicator = ((UIImageView *)[self.scrl.subviews objectAtIndex:(self.scrl.subviews.count-1)]);
    //set color to vertical indicator
    [verticalIndicator setBackgroundColor:Theme_Color];
}


#pragma mark - Api Calls
/*!
 * @discussion Websevice call for updating user's details
 */
-(void) updatePerf
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
             
             NSString *datePref=[[NSString alloc]init];
             
             if([self.lblOne.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]){
                 datePref=@"1";
             }
             else if([self.lblOne.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]){
                 datePref=@"2";
             }
             else if([self.lblOne.text isEqualToString:[MCLocalization stringForKey:@"Food"]]){
                 datePref=@"3";
             }
             else{
                 datePref=@"4";
             }
             if([self.lblTwo.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]) {
                 datePref=[NSString stringWithFormat:@"%@,1",datePref];
             }
             else if([self.lblTwo.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]) {
                 datePref=[NSString stringWithFormat:@"%@,2",datePref];
             }
             else if([self.lblTwo.text isEqualToString:[MCLocalization stringForKey:@"Food"]]) {
                 datePref=[NSString stringWithFormat:@"%@,3",datePref];
             }
             else {
                 datePref=[NSString stringWithFormat:@"%@,4",datePref];
             }
             if([self.lblThree.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]) {
                 datePref=[NSString stringWithFormat:@"%@,1",datePref];
             }
             else if([self.lblThree.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]) {
                 datePref=[NSString stringWithFormat:@"%@,2",datePref];
             }
             else if([self.lblThree.text isEqualToString:[MCLocalization stringForKey:@"Food"]]) {
                 datePref=[NSString stringWithFormat:@"%@,3",datePref];
             }
             else {
                 datePref=[NSString stringWithFormat:@"%@,4",datePref];;
             }
             if([self.lblFour.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]) {
                 datePref=[NSString stringWithFormat:@"%@,1",datePref];
             }
             else if([self.lblFour.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]) {
                 datePref=[NSString stringWithFormat:@"%@,2",datePref];
             }
             else if([self.lblFour.text isEqualToString:[MCLocalization stringForKey:@"Food"]]) {
                 datePref=[NSString stringWithFormat:@"%@,3",datePref];
             }
             else {
                 datePref=[NSString stringWithFormat:@"%@,4",datePref];;
             }
             
             NSString *str=@"userPrefencesUpdate";
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:genderPerf forKey:@"gender_pref"];
             [dict setValue:self.leftValueLabel.text forKey:@"min_age_pref"];
             [dict setValue:self.rightValueLabel.text forKey:@"max_age_pref"];
             [dict setValue:datePref forKey:@"date_pref"];
             [dict setValue:self.leftDistance.text forKey:@"min_dist_pref"];
             [dict setValue:self.rightDistance.text forKey:@"max_dist_pref"];
             [dict setValue:[self.txtAboutMe.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"about"];
             [dict setValue:height forKey:@"height"];
             
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
             
             [dict setValue:kids forKey:@"kids"];
//             if (qu_id != 0) {
                 [dict setValue:qu_id forKey:@"que_id"];
//             }
             [dict setValue:[self.txtAnswer.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"que_ans"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue] == 0) {
                     
                     [appDelegate SetData:self.leftDistance.text value:kMinDistance];
                     [appDelegate SetData:self.rightDistance.text value:kmaxDistance];
                     [appDelegate SetData:datePref value:kdatePref];
                     [appDelegate SetData:genderPerf value:kgenderPref];
                     [appDelegate SetData:self.leftValueLabel.text value:kminAgePref];
                     [appDelegate SetData:self.rightValueLabel.text value:kmaxAgePref];
                     [appDelegate SetData:[self.txtAboutMe.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kabout];
                     
                     [appDelegate SetData:height value:kheight];
                     [appDelegate SetData:kids value:kno_of_kids];
                     [appDelegate SetData:religion value:kreligion];
                     [appDelegate SetData:ethinicity value:kethnicity];
                     
                     [appDelegate SetData:qu_id value:kquestionID];
                     [appDelegate SetData:[self.txtAnswer.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kanswer];
                     
                     
                     ALERTVIEW([MCLocalization stringForKey:@"Data Updated Successfully "], self);
                 }
                 else
                 {
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
             }];
             
             //image uploading
             if (!flagUploadImage) {
                 
             }
             else {
                 NSString *str1=@"edit_gallery_images";
                 NSMutableDictionary *dict1=[[NSMutableDictionary alloc] init];
                 NSMutableDictionary *dict2=[[NSMutableDictionary alloc] init];
                 
                 [dict1 setValue:[appDelegate GetData:kuserid] forKey:@"id"];
                 
                 if (flagUploadImage1)
                 {
                     NSData *imaagedata1=UIImageJPEGRepresentation(self.img1.image, 0.80);
                     [dict2 setValue:imaagedata1 forKey:@"img1"];
                 }
                 else
                 {
                     [dict2 setValue:nil forKey:@"img1"];
                 }
                 if(!flagUploadImage2)
                 {
                     [dict2 setValue:nil forKey:@"img2"];
                 }
                 else{
                     NSData *imaagedata2=UIImageJPEGRepresentation(self.img2.image, 0.80);
                     [dict2 setValue:imaagedata2 forKey:@"img2"];
                 }
                 
                 if(flagUploadImage3) {
                     NSData *imaagedata3=UIImageJPEGRepresentation(self.img3.image, 0.80);
                     [dict2 setValue:imaagedata3 forKey:@"img3"];
                 }
                 else{
                     [dict2 setValue:nil forKey:@"img3"];
                 }
                 
                 if(flagUploadImage4) {
                     NSData *imaagedata4=UIImageJPEGRepresentation(self.img4.image, 0.80);
                     [dict2 setValue:imaagedata4 forKey:@"img4"];
                 }
                 else{
                     [dict2 setValue:nil forKey:@"img4"];
                 }
                 if(flagUploadImage5) {
                     NSData *imaagedata5=UIImageJPEGRepresentation(self.img5.image, 0.80);
                     [dict2 setValue:imaagedata5 forKey:@"img5"];
                 }
                 else{
                     [dict2 setValue:nil forKey:@"img5"];
                 }
                 if(flagUploadImage6) {
                     NSData *imaagedata6=UIImageJPEGRepresentation(self.img6.image, 0.80);
                     [dict2 setValue:imaagedata6 forKey:@"img6"];
                 }
                 else{
                     [dict2 setValue:nil forKey:@"img6"];
                 }
                 
                 
                 NSString *_url1 = [NSString stringWithFormat:@"%@%@",appURL,str1];
                 [[ApiManager sharedInstance] apiCallWithImage:_url1 parameterDict:dict1 imageDataDictionary:dict2 CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                     
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
             
         }
     }];
}
/*!
 * @discussion Websevice call for getting user's details
 */
-(void) getUserDetails
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             NSString *str=@"getuserdetails";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"userid"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 [self getInstaImages];
                 if( success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     
                     //get data for user
                     
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"about"] value:kabout];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"date_pref"] value:kdatePref];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"ethnicity_pref"] value:kethnicity];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"religion_pref"] value:kreligion];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"gender_pref"] value:kgenderPref];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"height"] value:kheight];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"kids"] value:kno_of_kids];
                     
                     
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"max_age_pref"] value:kmaxAgePref];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"max_dist_pref"] value:kmaxDistance];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"min_age_pref"] value:kminAgePref];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"min_dist_pref"] value:kMinDistance];
                     
                     
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"que_id"] value:kquestionID];
                     if([[appDelegate GetData:kquestionID] integerValue] < 1){
                         [appDelegate SetData:@"1" value:kquestionID];
                     }
                     else if([[appDelegate GetData:kquestionID] integerValue] >25 ){
                         [appDelegate SetData:@"25" value:kquestionID];
                     }
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"que_ans"] value:kanswer];
                     
                     [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img1"]] value:kimg1];
                     [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img1"]] value:kprofileimage];
                     
                     NSString *temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img2"];
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img2"]] value:kimg2];
                     }
                     temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img3"];
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img3"]] value:kimg3];
                     }
                     
                     temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img4"];
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img4"]] value:kimg4];
                     }
                     
                     temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img5"];
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img5"]] value:kimg5];
                     }
                     
                     temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img6"];
                     if(temp!=nil){
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img6"]] value:kimg6];
                     }
                     
                     if ([[appDelegate GetData:kno_of_kids] intValue] <= 7)
                     {
                         if (([[appDelegate GetData:kno_of_kids] intValue] - 1) <= 3)
                         {
                             scrollCellIndexCollectionView = 4;
                             [self btnPrevClicked:nil];
                         }
                         else
                         {
                             scrollCellIndexCollectionView = [[appDelegate GetData:kno_of_kids] intValue] - 2;
                             [self btnNextClicked:nil];
                         }
                     }
                     else
                     {
                         scrollCellIndexCollectionView = 3;
                     }
                 }
                 else
                 {
                     ALERTVIEW([MCLocalization stringForKey:@"Something went wrong!! Please try again!!"], self);
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
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     
                     NSArray *arr=[dictionary valueForKey:@"question"];
                     for (int i=0; i<arr.count; i++)
                     {
                         NSData *data = [[[arr objectAtIndex:i] valueForKey:strSelectedLanguage] dataUsingEncoding:NSUTF16StringEncoding];
                         NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
                         [arrQuestions addObject:decodevalue];
                     }
                     TOTAL_QUESTIONS=arr.count;
                     arrQuestionIds=[[[dictionary valueForKey:@"question"] valueForKey:@"id"] mutableCopy];
                     
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
                     [self getUserDetails];
                     
                     [self setFrames];
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
 * @discussion Webservice call for saving image urls from instagram
 */
-(void) saveInstaImages
{
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
             
             NSString *str=@"saveInstagramImages"; //userid, url
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"userid"];
             [dict setValue:assets forKey:@"url"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     
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
         }
         else {
             
             NSString *str=@"GetInstagramImages"; //userid, url
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"userid"];
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"friendid"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     assets = [[[dictionary valueForKey:@"InstaImages"] valueForKey:@"url"] mutableCopy] ;

                     if(assets.count > 0){
                         
                         //Images found
                         
                         self.vwConnectInsta.hidden = YES;
                         self.colInstaImages.hidden = NO;
                         self.colInstaImages.frame = CGRectMake(self.colInstaImages.frame.origin.x, self.colInstaImages.frame.origin.y, self.colInstaImages.frame.size.width, (self.colInstaImages.frame.size.width/3)*2+20);
                         self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwQuote.frame.origin.y+self.vwQuote.frame.size.height, self.vwInsta.frame.size.width, self.colInstaImages.frame.origin.y+self.colInstaImages.frame.size.height+10);
//                         self.lastView.frame=CGRectMake(self.lastView.frame.origin.x, self.vwInsta.frame.origin.y+self.vwInsta.frame.size.height, self.lastView.frame.size.width, self.lastView.frame.size.height);
                         
                         self.lblline.frame=CGRectMake(self.lblline.frame.origin.x, self.lblline.frame.origin.y, 1, self.lastView.frame.origin.y);
                         self.imgVerticalline.frame = self.lblline.frame;
                         self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.lastView.frame.origin.y+self.lastView.frame.size.height);
                         [self.colInstaImages reloadData];
                     }
                     else{
                         // Images not found
                         self.vwConnectInsta.hidden = NO;
                         self.colInstaImages.hidden = YES;
                     }
                     
                     //continue viewdidload
                     flag=true;
                     [self setupviewdidloadUi];
                     
                 }
                 else
                 {
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
                 
             }];
         }
     }];
}
#pragma mark - setup ui
/*!
 * @discussion Setup UI for settings page
 */
-(void) setupviewdidloadUi{
    height=[appDelegate GetData:kheight];
    kids=[appDelegate GetData:kno_of_kids];
    
//    scrollCellIndexCollectionView=3;
    
    if( [kids isEqualToString:@"None"]){
        self.imgNone.image=[UIImage imageNamed:@"CircleGreen"];
        flagChildrenNone=true;
        noOfChildren=-1;
    }
    else if( [kids isEqualToString:@"One Day"]){
        self.imgOneday.image=[UIImage imageNamed:@"CircleGreen"];
        flagChildrenOneDay=true;
        noOfChildren=-1;
    }
    else if( [kids isEqualToString:@"I Don't Want Kids"]){
        self.imgDontwant.image=[UIImage imageNamed:@"CircleGreen"];
        flagChildrenDontWant=true;
        noOfChildren=-1;
    }
    else{
        noOfChildren=[kids integerValue];
        self.imgDontwant.image=[UIImage imageNamed:@"UntickCircle"];
        self.imgOneday.image=[UIImage imageNamed:@"UntickCircle"];
        self.imgNone.image=[UIImage imageNamed:@"UntickCircle"];
    }
    [self.collNumbers reloadData];
    
    religion=[appDelegate GetData:kreligion];
    ethinicity=[appDelegate GetData:kethnicity];
    
    arrSelectedReligionIds=[[religion componentsSeparatedByString:@","] mutableCopy];
    arrSelectedEthnicityIds=[[ethinicity componentsSeparatedByString:@","] mutableCopy];

    if(arrQuestionIds.count == 0)
    {
        self.lblQuestion.text = @"";
    }
    else
    {
        for(int i=0;i<arrQuestionIds.count;i++){
            if([[appDelegate GetData:kquestionID] intValue]==[[arrQuestionIds objectAtIndex:i]intValue]){
                quesIndex=i;
                self.lblQuestion.text=[arrQuestions objectAtIndex:quesIndex];
                qu_id=[arrQuestionIds objectAtIndex:quesIndex];
                break;
            }
        }
    }
    
    self.txtAnswer.text=[appDelegate GetData:kanswer];
    
    if([arrSelectedReligionIds containsObject: @"0"]){
        self.imgNotSay1.image=[UIImage imageNamed:@"CircleGreen"];
        flagNotSay1=true;
        [arrSelectedReligionIds removeAllObjects];
    }else{
        self.imgNotSay1.image=[UIImage imageNamed:@"UntickCircle"];
        flagNotSay1=false;
        
    }
    [self.colReligion reloadData];
    
    if([arrSelectedEthnicityIds containsObject: @"0"]){
        self.imgNotSay2.image=[UIImage imageNamed:@"CircleGreen"];
        flagNotSay2=true;
        [arrSelectedEthnicityIds removeAllObjects];
    }else{
        self.imgNotSay2.image=[UIImage imageNamed:@"UntickCircle"];
        flagNotSay2=false;
    }
    [self.colEthnicity reloadData];
    
    flagUploadImage=false;
    flagUploadImage1=false;
    flagUploadImage2=false;
    flagUploadImage3=false;
    flagUploadImage4=false;
    flagUploadImage5=false;
    flagUploadImage6=false;
    
    flag_FB_Gallery=@"";
    
    self.scrl.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.txtAboutMe.text=[appDelegate GetData:kabout];
    
    if([[appDelegate GetData:kgenderPref] isEqualToString:@"female"]){
        genderPerf=@"female";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.imgMale.image=[UIImage imageNamed:@"MaleGray"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Check"];
        self.ImgFemale.image=[UIImage imageNamed:@"Female"];
    }
    else{
        genderPerf=@"male";
    }
    
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
    
    //set gallery images
    [self.act1 startAnimating];
    [self.img1 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg1]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(image!=nil){
            self.img1.image=image;
        }
        else{
            self.img1.image = [UIImage imageNamed:@"TempProfile"];
        }
        
        [self.act1 stopAnimating];
    }];
    
    if(![[appDelegate GetData:kimg2] isEqualToString:@"Key Not Found"]){
        [self.act2 startAnimating];
        [self.img2 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg2]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img2.image=image;
            }
            else{
                self.img2.image=[UIImage imageNamed:@"NoPlaceFound"];
            }
            
            [self.act2 stopAnimating];
        }];
    }
    if(![[appDelegate GetData:kimg3] isEqualToString:@"Key Not Found"]){
        [self.act3 startAnimating];
        [self.img3 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg3]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img3.image=image;
            }
            else{
                self.img3.image=[UIImage imageNamed:@"NoPlaceFound"];
            }
            
            [self.act3 stopAnimating];
        }];
    }
    if(![[appDelegate GetData:kimg4] isEqualToString:@"Key Not Found"]){
        [self.act4 startAnimating];
        [self.img4 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg4]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img4.image=image;
            }
            else{
                self.img4.image=[UIImage imageNamed:@"NoPlaceFound"];
            }
            
            [self.act4 stopAnimating];
        }];
    }
    if(![[appDelegate GetData:kimg5] isEqualToString:@"Key Not Found"]){
        [self.act5 startAnimating];
        [self.img5 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg5]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img5.image=image;
            }
            else{
                self.img5.image=[UIImage imageNamed:@"NoPlaceFound"];
            }
            
            [self.act5 stopAnimating];
            
        }];
    }
    if(![[appDelegate GetData:kimg6] isEqualToString:@"Key Not Found"]){
        [self.act6 startAnimating];
        [self.img6 sd_setImageWithURL:[Util EncodedURL:[appDelegate GetData:kimg6]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(image !=nil){
                self.img6.image=image;
            }
            else{
                self.img6.image = [UIImage imageNamed:@"NoPlaceFound"];
            }
            
            [self.act6 stopAnimating];
        }];
    }
    
    PHAsset *asset = [[PHAsset alloc] init];
    while(appDelegate.selectedImages.count<6){
        [appDelegate.selectedImages addObject:asset];
    }
    
    pref = [[appDelegate GetData:kdatePref] componentsSeparatedByString:@","];
    
    //select row
    
    BOOL isTheObjectThere = [pickerArray containsObject:height];
    if(isTheObjectThere){
        NSUInteger indexOfTheObject = [pickerArray indexOfObject:height];
        [self.pickerHeight selectRow:indexOfTheObject inComponent:0 animated:YES];
    }
    else{
        [self.pickerHeight selectRow:25 inComponent:0 animated:YES];
        
    }
    
    [self updateSliderLabels];
    [self updateSliderLabels2];
    //for no of childerns
    
    self.leftDistance.text=[appDelegate GetData:kMinDistance];
    self.rightDistance.text=[appDelegate GetData:kmaxDistance];
    self.leftValueLabel.text=[appDelegate GetData:kminAgePref];
    self.rightValueLabel.text=[appDelegate GetData:kmaxAgePref];
    
    
    [self viewWillAppear:YES];
    
    
    
    
}
#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    
    self.lblTitle.text=[MCLocalization stringForKey:@"My Preferences"];
    
    self.lblAboutMe.text=[MCLocalization stringForKey:@"About Me"];
    self.lblInterestedIn.text=[MCLocalization stringForKey:@"Intrested In"];
    
    self.lblDistancePref.text=[MCLocalization stringForKey:@"Distance Preferences (miles)"];
    self.lblAgePref.text=[MCLocalization stringForKey:@"Age Preferences"];
    self.lblDatePref.text=[MCLocalization stringForKey:@"Date Preferences"];
    self.lblPhotos.text=[MCLocalization stringForKey:@"Photos"];
    
    self.lblHeight.text=[MCLocalization stringForKey:@"Height"];
    self.lblAlwaysVisible.text=[MCLocalization stringForKey:@"Always visible"];
    
    self.lblReligion.text=[MCLocalization stringForKey:@"Religion"];
    self.lblNotSay1.text=[MCLocalization stringForKey:@"Doesn't matter"];
    
    self.lblInfo.text=[MCLocalization stringForKey:@"Drag & arrange your prefered dating options"];
    self.lblInfoQuote.text=[MCLocalization stringForKey:@"Click on Arrows for next and previous question"];

    [self.lblNotSay1 sizeToFit];
    self.lblNotSay1.frame=CGRectMake(SCREEN_SIZE.width-self.lblNotSay1.frame.size.width-35*SCREEN_SIZE.width/375, self.lblNotSay1.frame.origin.y, self.lblNotSay1.frame.size.width, self.lblNotSay1.frame.size.height);
    self.imgNotSay1.frame=CGRectMake(self.lblNotSay1.frame.origin.x-self.imgNotSay1.frame.size.width-5, self.imgNotSay1.frame.origin.y, self.imgNotSay1.frame.size.width, self.imgNotSay1.frame.size.height);
    self.btnNotSay1.frame=CGRectMake(self.imgNotSay1.frame.origin.x, self.lblNotSay1.frame.origin.y, self.imgNotSay1.frame.size.width+self.lblNotSay1.frame.size.width, self.btnNotSay1.frame.size.height);
    
    
    self.lblEthnicity.text=[MCLocalization stringForKey:@"Ethnicity"];
    self.lblNotSay2.text=[MCLocalization stringForKey:@"Doesn't matter"];
    
    [self.lblNotSay2 sizeToFit];
    self.lblNotSay2.frame=CGRectMake(SCREEN_SIZE.width-self.lblNotSay2.frame.size.width-35*SCREEN_SIZE.width/375, self.lblNotSay2.frame.origin.y, self.lblNotSay2.frame.size.width, self.lblNotSay2.frame.size.height);
    self.imgNotSay2.frame=CGRectMake(self.lblNotSay2.frame.origin.x-self.imgNotSay2.frame.size.width-5, self.imgNotSay2.frame.origin.y, self.imgNotSay2.frame.size.width, self.imgNotSay2.frame.size.height);
    self.btnNotSay2.frame=CGRectMake(self.imgNotSay2.frame.origin.x, self.btnNotSay2.frame.origin.y, self.imgNotSay2.frame.size.width+self.lblNotSay2.frame.size.width, self.btnNotSay2.frame.size.height);
    
    
    self.lblKids.text=[MCLocalization stringForKey:@"Kids"];
    self.lblNone.text=[MCLocalization stringForKey:@"None"];
    self.lblOneDay.text=[MCLocalization stringForKey:@"One Day"];
    self.lblDontwantkids.text=[MCLocalization stringForKey:@"I Don't Want Kids"];
    
    [self.lblNone sizeToFit];
    self.btnNone.frame = CGRectMake(self.imgNone.frame.origin.x, self.lblNone.frame.origin.y, self.lblNone.frame.origin.x + self.lblNone.frame.size.width - self.imgNone.frame.origin.x, self.btnNone.frame.size.height );
    [self.lblOneDay sizeToFit];
    self.btnOneDay.frame = CGRectMake(self.imgOneday.frame.origin.x, self.lblOneDay.frame.origin.y, self.lblOneDay.frame.origin.x + self.lblOneDay.frame.size.width -self.imgOneday.frame.origin.x, self.btnOneDay.frame.size.height );
    [self.lblDontwantkids sizeToFit];
    self.btnDontwantKids.frame = CGRectMake(self.imgDontwant.frame.origin.x, self.lblDontwantkids.frame.origin.y, self.lblDontwantkids.frame.origin.x + self.lblDontwantkids.frame.size.width - self.imgDontwant.frame.origin.x, self.btnDontwantKids.frame.size.height );
    
    self.lblQuotes.text=[MCLocalization stringForKey:@"Quote"];
    
    [self.btnDone setTitle:[MCLocalization stringForKey:@"DONE"] forState:UIControlStateNormal];
    
    [self.lblPhotos sizeToFit];
    self.lblPhotosUnderline.frame=CGRectMake(self.lblPhotos.frame.origin.x, self.lblPhotosUnderline.frame.origin.y, self.lblPhotos.frame.size.width, 1);
    
    [self.lblDatePref sizeToFit];
    self.lblDatePrefUnderline.frame=CGRectMake(self.lblDatePref.frame.origin.x, self.lblDatePrefUnderline.frame.origin.y, self.lblDatePref.frame.size.width, 1);
    
    [self.lblAgePref sizeToFit];
    self.lblAgeUnderline.frame=CGRectMake(self.lblAgePref.frame.origin.x, self.lblAgeUnderline.frame.origin.y, self.lblAgePref.frame.size.width, 1);
    
    [self.lblDistancePref sizeToFit];
    self.lblDistanceUnderline.frame=CGRectMake(self.lblDistancePref.frame.origin.x, self.lblDistanceUnderline.frame.origin.y, self.lblDistancePref.frame.size.width, 1);
    
    [self.lblInterestedIn sizeToFit];
    self.lblInsteredInUnderline.frame=CGRectMake(self.lblInterestedIn.frame.origin.x, self.lblInsteredInUnderline.frame.origin.y, self.lblInterestedIn.frame.size.width, 1);
    
    [self.lblAboutMe sizeToFit];
    self.lblAboutUnderline.frame=CGRectMake(self.lblAboutMe.frame.origin.x, self.lblAboutUnderline.frame.origin.y, self.lblAboutMe.frame.size.width, 1);
    
    [self.lblHeight sizeToFit];
    self.lblHeightUnderline.frame=CGRectMake(self.lblHeight.frame.origin.x, self.lblHeightUnderline.frame.origin.y, self.lblHeight.frame.size.width, 1);
    
    [self.lblReligion sizeToFit];
    self.lblReligionUnderline.frame=CGRectMake(self.lblReligion.frame.origin.x, self.lblReligionUnderline.frame.origin.y, self.lblReligion.frame.size.width, 1);
    
    [self.lblEthnicity sizeToFit];
    self.lblEthnicityUnderline.frame=CGRectMake(self.lblEthnicity.frame.origin.x, self.lblEthnicityUnderline.frame.origin.y, self.lblEthnicity.frame.size.width, 1);
    
    [self.lblKids sizeToFit];
    self.lblKidsUnderline.frame=CGRectMake(self.lblKids.frame.origin.x, self.lblKidsUnderline.frame.origin.y, self.lblKids.frame.size.width, 1);
    
    [self.lblQuotes sizeToFit];
    self.lblQuoteUnderline.frame=CGRectMake(self.lblQuotes.frame.origin.x, self.lblQuoteUnderline.frame.origin.y, self.lblQuotes.frame.size.width, 1);
    
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    
    self.lblInsta.text = [MCLocalization stringForKey:@"Instagram Images"];
    [self.lblInsta sizeToFit];
    self.lblInstaLine.frame=CGRectMake(self.lblInsta.frame.origin.x, self.lblInstaLine.frame.origin.y, self.lblInsta.frame.size.width, 1);
    
    [self.btnUpdateInstaImages setTitle:[MCLocalization stringForKey:@"Update"] forState:UIControlStateNormal];
    
    self.lblConnect.text = [MCLocalization stringForKey:@"Connect to Instagram"];
    [self.lblConnect sizeToFit];
    self.vwConnectInsta.frame=CGRectMake((SCREEN_SIZE.width - self.lblConnect.frame.size.width)/2, self.vwConnectInsta.frame.origin.y, self.lblConnect.frame.size.width, self.vwConnectInsta.frame.size.height);
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
       
            [self setRTL];
     
    }
}
/*!
 * @discussion set RTL UI
 */
- (void)setRTL{
    
    float x = 45 * SCREEN_SIZE.width/375;
    
    CGRect temp = self.lblPhotos.frame;
    temp.origin.x = x ;
    self.lblPhotos.frame = temp;
    
    self.lblPhotosUnderline.frame = CGRectMake(x, self.lblPhotosUnderline.frame.origin.y, self.lblPhotosUnderline.frame.size.width, 1);
    self.lblDatePrefUnderline.frame = CGRectMake(x, self.lblDatePrefUnderline.frame.origin.y, self.lblDatePrefUnderline.frame.size.width, 1);
    self.lblAgeUnderline.frame = CGRectMake(x, self.lblAgeUnderline.frame.origin.y, self.lblAgeUnderline.frame.size.width, 1);
    self.lblDistanceUnderline.frame = CGRectMake(x, self.lblDistanceUnderline.frame.origin.y, self.lblDistanceUnderline.frame.size.width, 1);
    self.lblInsteredInUnderline.frame = CGRectMake(x, self.lblInsteredInUnderline.frame.origin.y, self.lblInsteredInUnderline.frame.size.width, 1);
    self.lblAboutUnderline.frame = CGRectMake(x, self.lblAboutUnderline.frame.origin.y, self.lblAboutUnderline.frame.size.width, 1);
    self.lblHeightUnderline.frame = CGRectMake(x, self.lblHeightUnderline.frame.origin.y, self.lblHeightUnderline.frame.size.width, 1);
    self.lblReligionUnderline.frame = CGRectMake(x, self.lblReligionUnderline.frame.origin.y, self.lblReligionUnderline.frame.size.width, 1);
    self.lblEthnicityUnderline.frame = CGRectMake(x, self.lblEthnicityUnderline.frame.origin.y, self.lblEthnicityUnderline.frame.size.width, 1);
    self.lblKidsUnderline.frame = CGRectMake(x, self.lblKidsUnderline.frame.origin.y, self.lblKidsUnderline.frame.size.width, 1);
    self.lblQuoteUnderline.frame = CGRectMake(x, self.lblQuoteUnderline.frame.origin.y, self.lblQuoteUnderline.frame.size.width, 1);
    self.lblInstaLine.frame = CGRectMake(x, self.lblInstaLine.frame.origin.y, self.lblInstaLine.frame.size.width, 1);
    
    self.lblDatePref.frame = CGRectMake(x, self.lblDatePref.frame.origin.y, self.lblDatePref.frame.size.width, self.lblDatePref.frame.size.height);
    
    self.preferenceView.frame = CGRectMake(35* SCREEN_SIZE.width/375, self.preferenceView.frame.origin.y, self.preferenceView.frame.size.width, self.preferenceView.frame.size.height);
    
    self.lblAgePref.frame = CGRectMake(x, self.lblAgePref.frame.origin.y, self.lblAgePref.frame.size.width, self.lblAgePref.frame.size.height);
    self.lblDistancePref.frame = CGRectMake(x, self.lblDistancePref.frame.origin.y, self.lblDistancePref.frame.size.width, self.lblDistancePref.frame.size.height);
    self.lblInterestedIn.frame = CGRectMake(x, self.lblInterestedIn.frame.origin.y, self.lblInterestedIn.frame.size.width, self.lblInterestedIn.frame.size.height);
    self.lblAboutMe.frame = CGRectMake(x, self.lblAboutMe.frame.origin.y, self.lblAboutMe.frame.size.width, self.lblAboutMe.frame.size.height);
    
    self.lblHeight.frame = CGRectMake(x, self.lblHeight.frame.origin.y, self.lblHeight.frame.size.width, self.lblHeight.frame.size.height);

    self.lblAlwaysVisible.frame = CGRectMake(self.txtAboutMe.frame.origin.x+self.txtAnswer.frame.size.width-self.lblAlwaysVisible.frame.size.width, self.lblAlwaysVisible.frame.origin.y, self.lblAlwaysVisible.frame.size.width, self.lblAlwaysVisible.frame.size.height);

    self.lblReligion.frame = CGRectMake(x, self.lblReligion.frame.origin.y, self.lblReligion.frame.size.width, self.lblReligion.frame.size.height);
    self.colReligion.frame = CGRectMake(55 * SCREEN_SIZE.width/375, self.colReligion.frame.origin.y, self.colReligion.frame.size.width, self.colReligion.frame.size.height);
    self.lblNotSay1.frame = CGRectMake(self.txtAboutMe.frame.origin.x+self.txtAnswer.frame.size.width-self.lblNotSay1.frame.size.width, self.lblNotSay1.frame.origin.y, self.lblNotSay1.frame.size.width, self.lblNotSay1.frame.size.height);
    
    self.lblEthnicity.frame = CGRectMake(x, self.lblEthnicity.frame.origin.y, self.lblEthnicity.frame.size.width, self.lblEthnicity.frame.size.height);
    self.colEthnicity.frame = CGRectMake(55 * SCREEN_SIZE.width/375, self.colEthnicity.frame.origin.y, self.colEthnicity.frame.size.width, self.colEthnicity.frame.size.height);
    self.lblNotSay2.frame = CGRectMake(self.txtAboutMe.frame.origin.x+self.txtAnswer.frame.size.width-self.lblNotSay2.frame.size.width, self.lblNotSay2.frame.origin.y, self.lblNotSay2.frame.size.width, self.lblNotSay2.frame.size.height);
    
    self.lblKids.frame = CGRectMake(x, self.lblKids.frame.origin.y, self.lblKids.frame.size.width, self.lblKids.frame.size.height);
    
    self.vwScrollKids.frame = CGRectMake(24 * SCREEN_SIZE.width/375, self.vwScrollKids.frame.origin.y, self.vwScrollKids.frame.size.width, self.vwScrollKids.frame.size.height);
    self.lblNone.frame = CGRectMake(75 * SCREEN_SIZE.width/375, self.lblNone.frame.origin.y, self.lblNone.frame.size.width, self.lblNone.frame.size.height);
    self.lblOneDay.frame = CGRectMake(75 * SCREEN_SIZE.width/375, self.lblOneDay.frame.origin.y, self.lblOneDay.frame.size.width, self.lblOneDay.frame.size.height);
    self.lblDontwantkids.frame = CGRectMake(75 * SCREEN_SIZE.width/375, self.lblDontwantkids.frame.origin.y, self.lblDontwantkids.frame.size.width, self.lblDontwantkids.frame.size.height);
    self.btnNone.frame = CGRectMake(self.imgNone.frame.origin.x, self.lblNone.frame.origin.y, self.lblNone.frame.origin.x + self.lblNone.frame.size.width - self.imgNone.frame.origin.x, self.btnNone.frame.size.height );
    self.btnOneDay.frame = CGRectMake(self.imgOneday.frame.origin.x, self.lblOneDay.frame.origin.y, self.lblOneDay.frame.origin.x + self.lblOneDay.frame.size.width -self.imgOneday.frame.origin.x, self.btnOneDay.frame.size.height );
    self.btnDontwantKids.frame = CGRectMake(self.imgDontwant.frame.origin.x, self.lblDontwantkids.frame.origin.y, self.lblDontwantkids.frame.origin.x + self.lblDontwantkids.frame.size.width - self.imgDontwant.frame.origin.x, self.btnDontwantKids.frame.size.height );
    
    
    self.lblQuestion.frame = CGRectMake(63 * SCREEN_SIZE.width/375, self.lblQuestion.frame.origin.y, self.lblQuestion.frame.size.width, self.lblQuestion.frame.size.height);
    self.lblQuotes.frame = CGRectMake(x, self.lblQuotes.frame.origin.y, self.lblQuotes.frame.size.width, self.lblQuotes.frame.size.height);
    self.txtAnswer.frame = CGRectMake(x, self.txtAnswer.frame.origin.y, self.txtAnswer.frame.size.width, self.txtAnswer.frame.size.height);
    
    self.lblInsta.frame = CGRectMake(x, self.lblInsta.frame.origin.y, self.lblInsta.frame.size.width, self.lblInsta.frame.size.height);
    self.btnUpdateInstaImages.frame = CGRectMake(SCREEN_SIZE.width - 25 * SCREEN_SIZE.width/375 - self.btnUpdateInstaImages.frame.size.width, self.btnUpdateInstaImages.frame.origin.y, self.btnUpdateInstaImages.frame.size.width, self.btnUpdateInstaImages.frame.size.height);
    self.colInstaImages.frame = CGRectMake(40 * SCREEN_SIZE.width/375, self.colInstaImages.frame.origin.y, self.colInstaImages.frame.size.width, self.colInstaImages.frame.size.height);
}
/*!
 * @discussion Transform views
 */
- (void)transforms{

    [self.scrl setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lastView setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.img1 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img2 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img3 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img4 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img5 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.img6 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblPhotos setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblDatePref setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.preferenceView setTransform:CGAffineTransformMakeScale(-1, 1)];

    [self.lblAgePref setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.leftValueLabel setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.rightValueLabel setTransform:CGAffineTransformMakeScale(-1, 1)];

    [self.lblDistancePref setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.leftDistance setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.rightDistance setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblInterestedIn setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblAboutMe setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtAboutMe setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.txtAboutMe.textAlignment = NSTextAlignmentRight;

    [self.lblHeight setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblAlwaysVisible.textAlignment = NSTextAlignmentLeft;
    [self.lblAlwaysVisible setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.pickerHeight setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    self.lblNotSay1.textAlignment = NSTextAlignmentLeft;
    [self.lblNotSay1 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblReligion setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.colReligion setTransform:CGAffineTransformMakeScale(-1, 1)];

    self.lblNotSay2.textAlignment = NSTextAlignmentLeft;
    [self.lblNotSay2 setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblEthnicity setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.colEthnicity setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblKids setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwScrollKids setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblNone setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblDontwantkids setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblOneDay setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblNone.textAlignment = NSTextAlignmentRight;
    self.lblOneDay.textAlignment = NSTextAlignmentRight;
    self.lblDontwantkids.textAlignment = NSTextAlignmentRight;
    
    [self.lblQuestion setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtAnswer setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.txtAnswer.textAlignment = NSTextAlignmentRight;
    
    [self.btnUpdateInstaImages setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblInsta setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwConnectInsta setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.btnUpdateInstaImages.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}
#pragma mark - insta integration

//This is our authentication delegate. When the user logs in, and
// Instagram sends us our auth token, we receive that here.
-(void) didAuthWithToken:(NSString*)token
{
    
    if(!token)
    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to request token." delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error"
                                     message:@"Failed to request token"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        
        //Add your buttons to alert controller
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];

        return;
    }
    
    //save token to NSUSER DEFUALT
    [appDelegate SetData:token value:kinstaAuth];
    [assets removeAllObjects];
    assets = [[NSMutableArray alloc] init];
    
    NSString *instagramBase = @"https://api.instagram.com/v1/users/self";
    NSString *popularURLString = [NSString stringWithFormat:@"%@/media/recent?access_token=%@", instagramBase, token];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:popularURLString]];
    
    
    NSOperationQueue *theQ = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:theQ
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSError *err;
                               id val = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                               
                               if(!err && !error && val && [NSJSONSerialization isValidJSONObject:val])
                               {
                                   NSArray *data = [val objectForKey:@"data"];
                                   nextPageURL=[[val valueForKey:@"pagination"] valueForKey:@"next_url"];
                                   dispatch_sync(dispatch_get_main_queue(), ^{
                                       
                                       if(!data)
                                       {
//                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                                                               message:@"Failed to request perform request."
//                                                                                              delegate:nil
//                                                                                     cancelButtonTitle:@"OK"
//                                                                                     otherButtonTitles:nil];
//                                           [alertView show];
                                           UIAlertController * alert = [UIAlertController
                                                                        alertControllerWithTitle:@"Error"
                                                                        message:@"Failed to request perform request"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                                           
                                           //Add Buttons
                                           
                                           UIAlertAction* okButton = [UIAlertAction
                                                                      actionWithTitle:@"OK"
                                                                      style:UIAlertActionStyleDefault
                                                                      handler:nil];
                                           
                                           //Add your buttons to alert controller
                                           
                                           [alert addAction:okButton];
                                           
                                           [self presentViewController:alert animated:YES completion:nil];

                                       } else
                                       {
                                           //get instagram images
                                           id result;
                                           for (result in data) {
                                               
                                               
                                               NSURL *url = [[[result valueForKey:@"images"] valueForKey:@"standard_resolution"] valueForKey:@"url"] ;
                                               [assets addObject:url];
                                               
                                           }
                                           if(assets.count > 0){
                                               self.vwConnectInsta.hidden = YES;
                                               self.colInstaImages.hidden = NO;
                                               self.colInstaImages.frame = CGRectMake(self.colInstaImages.frame.origin.x, self.colInstaImages.frame.origin.y, self.colInstaImages.frame.size.width, (self.colInstaImages.frame.size.width/3)*2+20);
                                               self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwQuote.frame.origin.y+self.vwQuote.frame.size.height, self.vwInsta.frame.size.width, self.colInstaImages.frame.origin.y+self.colInstaImages.frame.size.height+10);
                                               self.lastView.frame=CGRectMake(self.lastView.frame.origin.x, self.vwInsta.frame.origin.y+self.vwInsta.frame.size.height, self.lastView.frame.size.width, self.lastView.frame.size.height);
                                               
                                               self.lblline.frame=CGRectMake(self.lblline.frame.origin.x, self.lblline.frame.origin.y, 1, self.lastView.frame.origin.y);
                                               self.imgVerticalline.frame = self.lblline.frame;
                                               self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.lastView.frame.origin.y+self.lastView.frame.size.height);
                                           }
                                           
                                           if (nextPageURL != nil) {
                                               [self nextPageInstaImage:nextPageURL];
                                           }
                                           [self.colInstaImages reloadData];
                                       }
                                   });
                               }
                           }];
}

-(void) checkInstagramAuth
{
    
    
    InstagramAuthController *instagramAuthController = [InstagramAuthController new];
    instagramAuthController.authDelegate = self;
   
    instagramAuthController.modalPresentationStyle = UIModalPresentationFormSheet;
    instagramAuthController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:instagramAuthController animated:YES completion:^{ } ];
    
    __weak InstagramAuthController *weakAuthController = instagramAuthController;
    
    instagramAuthController.completionBlock = ^(void) {
        [weakAuthController dismissViewControllerAnimated:YES completion:nil];
    };
    
    HIDE_PROGRESS;

}
-(void)nextPageInstaImage:(NSString*)request1
{

    NSURL *url = [NSURL URLWithString:request1];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSMutableDictionary *result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
//    NSString *imageStringOfLoginUser;

    nextPageURL = [[result objectForKey:@"paging"] valueForKey:@"next"];
    
    NSArray *responseArray = [result objectForKey:@"data"];
    if(!responseArray)
    {
        
        NSLog(@"No more images");
        
    } else
    {
        //get instagram images
        id result1;
        for (result1 in responseArray) {
            
            
            NSURL *url = [[[result1 valueForKey:@"images"] valueForKey:@"standard_resolution"] valueForKey:@"url"] ;
            
            [assets addObject:url];
            NSLog(@"\n%ld",assets.count );
        }
        
        
        
    }
    
    if (nextPageURL != nil) {
        [self nextPageInstaImage:nextPageURL];
    }
    else{
        
        //save images here
        NSLog(@"\n\n=================\nTotal==%ld",assets.count );
        [self saveInstaImages];
        
        [self.colInstaImages reloadData];
    }
    
}

@end

