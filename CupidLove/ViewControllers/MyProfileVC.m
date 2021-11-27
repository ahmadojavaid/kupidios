//
//  MyProfileVC.m
//  LoveDove
//
//  Created by Potenza on 30/03/18.
//  Copyright © 2018 Potenza. All rights reserved.
//

#import "MyProfileVC.h"
#import "FacebookImageGalleryVC.h"
#import "GalleryVC.h"
#import "KTCenterFlowLayout.h"
#import "NumbersCell.h"
#import "ImageCell1.h"
#import "InstagramAuthController.h"

#import "TOCropViewController.h"


@interface MyProfileVC () <UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, InstagramAuthDelegate,TOCropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *vwTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;

@property (weak, nonatomic) IBOutlet UIScrollView *scrl;
@property (weak, nonatomic) IBOutlet UILabel *lblline;

@property (weak, nonatomic) IBOutlet UIView *vwPhotos;
@property (strong, nonatomic) IBOutlet UILabel *lblPhotos;
@property(weak,nonatomic) IBOutlet UILabel *lblPhotosUnderline;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act1;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act2;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act3;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act4;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act5;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *act6;
@property (strong,nonatomic) IBOutlet UIImageView *img1;
@property (strong,nonatomic) IBOutlet UIImageView *img2;
@property (strong,nonatomic) IBOutlet UIImageView *img3;
@property (strong,nonatomic) IBOutlet UIImageView *img4;
@property (strong,nonatomic) IBOutlet UIImageView *img5;
@property (strong,nonatomic) IBOutlet UIImageView *img6;

@property (weak, nonatomic) IBOutlet UIView *vwBasics;
@property (strong, nonatomic) IBOutlet UILabel *lblBasics;
@property(weak,nonatomic) IBOutlet UILabel *lblBasicsUnderline;
@property (weak,nonatomic) IBOutlet UITextField *txtEmail;
@property (weak,nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak,nonatomic) IBOutlet UITextField *txtLastName;
@property (weak,nonatomic) IBOutlet UITextField *txtCollege;
@property (weak,nonatomic) IBOutlet UITextField *txtprofession;
@property (weak,nonatomic) IBOutlet UITextField *txtDOB;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgFname;
@property (weak, nonatomic) IBOutlet UIImageView *imgLname;
@property (weak, nonatomic) IBOutlet UIImageView *imgClg;
@property (weak, nonatomic) IBOutlet UIImageView *imgProf;
@property (weak, nonatomic) IBOutlet UIImageView *imgAge;

@property (weak,nonatomic) IBOutlet UIView *myDatePickerView;
@property (weak,nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;

@property (weak,nonatomic) IBOutlet UIView *vwGender;
@property (strong,nonatomic) IBOutlet UIImageView *imgMaleCheck;
@property (strong,nonatomic) IBOutlet UIImageView *imgFemaleCheck;
@property (strong,nonatomic) IBOutlet UIImageView *imgMale;
@property (strong,nonatomic) IBOutlet UIImageView *ImgFemale;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblGenderUnderline;

@property (weak, nonatomic) IBOutlet UIView *vwAboutMe;
@property (strong, nonatomic) IBOutlet UILabel *lblAboutMe;
@property(weak,nonatomic) IBOutlet UILabel *lblAboutUnderline;
@property (strong,nonatomic) IBOutlet UITextView *txtAboutMe;

@property (weak, nonatomic) IBOutlet UIView *vwHeight;
@property (strong, nonatomic) IBOutlet UILabel *lblHeight;
@property(weak,nonatomic) IBOutlet UILabel *lblHeightUnderline;
@property (strong,nonatomic) IBOutlet UIPickerView *pickerHeight;
@property (strong, nonatomic) IBOutlet UILabel *lblAlwaysVisible;

@property (weak, nonatomic) IBOutlet UIView *vwReligion;
@property (strong, nonatomic) IBOutlet UILabel *lblReligion;
@property(weak,nonatomic) IBOutlet UILabel *lblReligionUnderline;
@property (strong, nonatomic) KTCenterFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *colReligion;
@property (strong, nonatomic) IBOutlet UIButton *btnNotSay1;
@property (strong, nonatomic) IBOutlet UILabel *lblNotSay1;
@property (strong,nonatomic) IBOutlet UIImageView *imgNotSay1;

@property (weak, nonatomic) IBOutlet UIView *vwEthnicity;
@property(weak,nonatomic) IBOutlet UILabel *lblEthnicity;
@property(weak,nonatomic) IBOutlet UILabel *lblEthnicityUnderline;
@property (strong, nonatomic) IBOutlet UILabel *lblNotSay2;
@property (strong, nonatomic) KTCenterFlowLayout *layout1;
@property (strong,nonatomic) IBOutlet UIImageView *imgNotSay2;
@property (strong, nonatomic) IBOutlet UIButton *btnNotSay2;
@property (weak, nonatomic) IBOutlet UICollectionView *colEthnicity;

@property (strong,atomic) IBOutlet UICollectionView *colInstaImages;
@property (strong,atomic) IBOutlet UIView *vwInsta;
@property (strong,atomic) IBOutlet UILabel *lblInsta;
@property (strong,atomic) IBOutlet UILabel *lblInstaLine;
@property (strong,atomic) IBOutlet UIView *vwConnectInsta;
@property (strong,atomic) IBOutlet UILabel *lblConnect;
@property (strong,atomic) IBOutlet UIButton *btnUpdateInstaImages;

@property (weak,nonatomic) IBOutlet UIView *lastView;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;

@property (weak,nonatomic) IBOutlet UIView *vwPopup;
@property(weak,nonatomic) IBOutlet UILabel *lblEnterCode;
@property(weak,nonatomic) IBOutlet UITextField *txtVarificationCode;
@property(weak,nonatomic) IBOutlet UIButton *btnOk;

@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;

@end

@implementation MyProfileVC{
    
    UIColor *bgDeselect, *bgSelect;
    
    NSString *flag_FB_Gallery;
    NSMutableArray *arrDeletedImages;
    Boolean flagUploadImage, flagUploadImage1, flagUploadImage2, flagUploadImage3, flagUploadImage4, flagUploadImage5, flagUploadImage6;
    
    NSArray *_pickerData;
    NSString *selectedpickerdata;
    
    NSString *strGender;
    
    NSArray *pickerArray;
    NSString *height;
    
    NSString *religion;
    NSMutableArray *arrReligion, *arrReligionIDs, *arrSelectedReligionIds;
    Boolean flagNotSay1;
    
    NSString *ethinicity;
    NSMutableArray *arrEthnicity, *arrEthnicityIDs, *arrSelectedEthnicityIds;
    Boolean flagNotSay2;
    
    NSString *nextPageURL;
    NSMutableArray *assets;
    
    BOOL changedEmail;
    NSString *strCode;
    
    BOOL flagForCropper;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    flagForCropper = true;
    
    [self getEthnicityAndReligionAndQuestions];
    
    bgDeselect=[UIColor lightTextColor];
    bgSelect=  Theme_Color ;
    UIColor *underline_color = [UIColor whiteColor];
    
    UIColor *verticalline = [UIColor whiteColor];
    self.lblline.backgroundColor = verticalline;
    
    self.lblTitleUnderline.backgroundColor = underline_color;
    self.lblPhotosUnderline.backgroundColor = underline_color;
    self.lblBasicsUnderline.backgroundColor = underline_color;
    self.lblGenderUnderline.backgroundColor = underline_color;
    self.lblAboutUnderline.backgroundColor = underline_color;
    self.lblHeightUnderline.backgroundColor = underline_color;
    self.lblReligionUnderline.backgroundColor = underline_color;
    self.lblInstaLine.backgroundColor = underline_color;
    
    self.act1.color = Theme_Color;
    self.act2.color = Theme_Color;
    self.act3.color = Theme_Color;
    self.act4.color = Theme_Color;
    self.act5.color = Theme_Color;
    self.act6.color = Theme_Color;
    arrDeletedImages = [[NSMutableArray alloc] init];

    self.datePicker.datePickerMode = UIDatePickerModeDate;
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDate *date = [NSDate date];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:unitFlags fromDate:date];
    [comps setYear:comps.year-18];
    date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    //To Disable Future date :
    self.datePicker.maximumDate=date;
    
    strGender = [[NSString alloc] init];
    
    height=[[NSString alloc] init];
    //height picker
    pickerArray = [[NSArray alloc]initWithObjects:@"3'0 (92 cm)",
                   @"3'1 (94 cm)",@"3'2 (97 cm)",@"3'3 (99 cm)",@"3'4 (102 cm)",@"3'5 (104 cm)",@"3'6 (107 cm)",@"3'7 (109 cm)",@"3'8 (112 cm)",@"3'9 (114 cm)",@"3'10 (117 cm)",@"3'11 (119 cm)",@"4'0 (122 cm)",@"4'1 (125 cm)",@"4'2 (127 cm)",@"4'3 (130 cm)",@"4'4 (132 cm)",@"4'5 (135 cm)",@"4'6 (137 cm)",@"4'7 (140 cm)",@"4'8 (142 cm)",@"4'9 (145 cm)",@"4'10 (147 cm)",@"4'11 (150 cm)",@"5'0 (152 cm)",             @"5'1 (155 cm)",@"5'2 (158 cm)",@"5'3 (160 cm)",@"5'4 (163 cm)",@"5'5 (165 cm)",@"5'6 (168 cm)",@"5'7 (170 cm)",@"5'8 (173 cm)",@"5'9 (175 cm)",@"5'10 (178 cm)",@"5'11 (180 cm)",@"6'0 (183 cm)",@"6'1 (185 cm)",@"6'2 (188 cm)",@"6'3 (191 cm)",@"6'4 (193 cm)",@"6'5 (196 cm)",@"6'6 (198 cm)",@"6'7 (201 cm)",@"6'8 (203 cm)",@"6'9 (206 cm)",@"6'10 (208 cm)",@"6'11 (211 cm)",@"7'0 (213 cm)", nil];
    
    self.pickerHeight.delegate=self;
    self.pickerHeight.dataSource=self;
    self.pickerHeight.showsSelectionIndicator=YES;
    
    religion=[[NSString alloc]init];
    arrReligion=[[NSMutableArray alloc] init];
    arrReligionIDs=[[NSMutableArray alloc] init];
    arrSelectedReligionIds=[[NSMutableArray alloc] init];
    self.layout = [[KTCenterFlowLayout alloc] init];
    self.colReligion.collectionViewLayout = self.layout;
    [self.colReligion registerClass:[NumbersCell class] forCellWithReuseIdentifier:@"NumbersCell"];
    [self.colReligion registerNib:[UINib nibWithNibName:@"NumbersCell" bundle: nil]forCellWithReuseIdentifier:@"NumbersCell"];
    flagNotSay1=false;
    
    flagNotSay2=false;
    ethinicity=[[NSString alloc] init];
    arrEthnicity=[[NSMutableArray alloc] init];
    arrEthnicityIDs=[[NSMutableArray alloc] init];
    arrSelectedEthnicityIds=[[NSMutableArray alloc] init];
    self.layout1 = [[KTCenterFlowLayout alloc] init];
    self.colEthnicity.collectionViewLayout = self.layout1;
    [self.colEthnicity registerClass:[NumbersCell class] forCellWithReuseIdentifier:@"NumbersCell"];
    [self.colEthnicity registerNib:[UINib nibWithNibName:@"NumbersCell" bundle: nil]forCellWithReuseIdentifier:@"NumbersCell"];
    
    assets = [[NSMutableArray alloc] init];
    arrDeletedImages = [[NSMutableArray alloc] init];
    [self.colInstaImages registerNib:[UINib nibWithNibName:@"ImageCell1" bundle:nil] forCellWithReuseIdentifier:@"ImageCell1"];
    UIEdgeInsets collectionViewInsets = UIEdgeInsetsMake(10.0, 8.0, 10.0, 8.0);
    self.colInstaImages.contentInset = collectionViewInsets;
    self.colInstaImages.scrollIndicatorInsets = UIEdgeInsetsMake(collectionViewInsets.top, 0, collectionViewInsets.bottom, 0);
    
    changedEmail = NO;
    strCode = [[NSString alloc] init];

    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    [self.vwPopup addGestureRecognizer:singleTapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self localize];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.vwTitle.hidden = NO;
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
    [self setFrames];
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

    int editedImage= appDelegate.editImage.intValue;
    if([arrDeletedImages containsObject:[NSString stringWithFormat:@"%d", editedImage]]) {
        [arrDeletedImages removeObject:[NSString stringWithFormat:@"%d", editedImage]];
    }
    NSLog(@"Deleted images: %@",arrDeletedImages);
    if([flag_FB_Gallery isEqualToString:@"gallery"]) {
        //back from gallery images
        if(editedImage>0 && (! [appDelegate.editImageName isEqualToString:@""])) {
            
            PHImageManager *manager = [PHImageManager defaultManager];
            PHAsset *asset = appDelegate.asset;
            [appDelegate.selectedImages replaceObjectAtIndex:(editedImage-1) withObject:asset];
            
            
            [manager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                
                UIImage *image = [UIImage imageWithData:imageData];
                flagUploadImage=true;
                if(flagForCropper){
                    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:image];
                    cropController.customAspectRatio = CGSizeMake(1, 1);
                    cropController.delegate = self;
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
//                else{
////                    flagUploadImage=true;
//                    switch (editedImage) {
//                        case 1:
//                            self.img1.image=image;
//                            flagUploadImage1=true;
//                            break;
//                        case 2:
//                            self.img2.image=image;
//                            flagUploadImage2=true;
//                            break;
//                        case 3:
//                            self.img3.image=image;
//                            flagUploadImage3=true;
//                            break;
//                        case 4:
//                            self.img4.image=image;
//                            flagUploadImage4=true;
//                            break;
//                        case 5:
//                            self.img5.image=image;
//                            flagUploadImage5=true;
//                            break;
//                        case 6:
//                            self.img6.image=image;
//                            flagUploadImage6=true;
//                            break;
//                        default:
//                            break;
//                    }
//                    appDelegate.editImageName=@"";
//                    //editedImage = -1;
//                }
                
                
                
            }];
            
//            [manager requestImageForAsset:asset
//                               targetSize:CGSizeMake(300,300)
//                              contentMode:PHImageContentModeAspectFit
//                                  options:nil
//                            resultHandler:^(UIImage * _Nullable result1, NSDictionary * _Nullable info) {
//                                flagUploadImage=true;
//                                switch (editedImage) {
//                                    case 1:
//                                        self.img1.image=result1;
//                                        flagUploadImage1=true;
//                                        break;
//                                    case 2:
//                                        self.img2.image=result1;
//                                        flagUploadImage2=true;
//                                        break;
//                                    case 3:
//                                        self.img3.image=result1;
//                                        flagUploadImage3=true;
//                                        break;
//                                    case 4:
//                                        self.img4.image=result1;
//                                        flagUploadImage4=true;
//                                        break;
//                                    case 5:
//                                        self.img5.image=result1;
//                                        flagUploadImage5=true;
//                                        break;
//                                    case 6:
//                                        self.img6.image=result1;
//                                        flagUploadImage6=true;
//                                        break;
//                                    default:
//                                        break;
//                                }
//                            }];
//
//            appDelegate.editImageName=@"";
//            editedImage=-1;
        }
    }
    else if ([flag_FB_Gallery isEqualToString:@"facebook"]){
        //back from fb images
        
        if(editedImage>0 && (! [appDelegate.editImageName isEqualToString:@""]))
        {
            UIImageView *temp=[[UIImageView alloc] init];
            [temp sd_setImageWithURL: [NSURL URLWithString:appDelegate.editImageName]  completed:^(UIImage * _Nullable result1, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                flagUploadImage=true;
                
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
//                else{
//                    switch (editedImage) {
//                        case 1:
//                            self.img1.image=result1;
//                            flagUploadImage1=true;
//                            break;
//                        case 2:
//                            self.img2.image=result1;
//                            flagUploadImage2=true;
//                            break;
//                        case 3:
//                            self.img3.image=result1;
//                            flagUploadImage3=true;
//                            break;
//                        case 4:
//                            self.img4.image=result1;
//                            flagUploadImage4=true;
//                            break;
//                        case 5:
//                            self.img5.image=result1;
//                            flagUploadImage5=true;
//                            break;
//                        case 6:
//                            self.img6.image=result1;
//                            flagUploadImage6=true;
//                            break;
//                        default:
//                            break;
//                    }
//                     appDelegate.editImageName=@"";
//                }
                

            }];
//            appDelegate.editImageName=@"";
//            editedImage=-1;
        }
    }
}
#pragma mark - setup ui
/*!
 * @discussion Setup UI for settings page
 */
-(void) setupUI{
    
    self.txtFirstName.text =  [appDelegate GetData:kUserName];
    self.txtLastName.text =  [appDelegate GetData:kLname];
    self.txtEmail.text = [appDelegate GetData:kEmail];
    self.txtCollege.text =  [appDelegate GetData:kCollege];
    self.txtprofession.text =  [appDelegate GetData:kProfession];
    self.txtDOB.text = [appDelegate GetData:kDOB];
    
    [self setAge];
    height=[appDelegate GetData:kheight];
    BOOL isTheObjectThere = [pickerArray containsObject:height];
    if(isTheObjectThere){
        NSUInteger indexOfTheObject = [pickerArray indexOfObject:height];
        [self.pickerHeight selectRow:indexOfTheObject inComponent:0 animated:YES];
    }
    else{
        [self.pickerHeight selectRow:25 inComponent:0 animated:YES];
        
    }

    
//    kids=[appDelegate GetData:kno_of_kids];
    
//    if ([[appDelegate GetData:kno_of_kids] intValue] <= 7)
//    {
//        if (([[appDelegate GetData:kno_of_kids] intValue] - 1) <= 3)
//        {
//            scrollCellIndexCollectionView = 4;
//            [self btnPrevClicked:nil];
//        }
//        else
//        {
//            scrollCellIndexCollectionView = [[appDelegate GetData:kno_of_kids] intValue] - 2;
//            [self btnNextClicked:nil];
//        }
//    }
//    else
//    {
//        scrollCellIndexCollectionView = 3;
//    }
//    if( [kids isEqualToString:@"None"]){
//        self.imgNone.image=[UIImage imageNamed:@"CircleGreen"];
//        flagChildrenNone=true;
//        noOfChildren=-1;
//    }
//    else if( [kids isEqualToString:@"One Day"]){
//        self.imgOneday.image=[UIImage imageNamed:@"CircleGreen"];
//        flagChildrenOneDay=true;
//        noOfChildren=-1;
//    }
//    else if( [kids isEqualToString:@"I Don't Want Kids"]){
//        self.imgDontwant.image=[UIImage imageNamed:@"CircleGreen"];
//        flagChildrenDontWant=true;
//        noOfChildren=-1;
//    }
//    else{
//        noOfChildren=[kids integerValue];
//        self.imgDontwant.image=[UIImage imageNamed:@"UntickCircle"];
//        self.imgOneday.image=[UIImage imageNamed:@"UntickCircle"];
//        self.imgNone.image=[UIImage imageNamed:@"UntickCircle"];
//    }
//    [self.collNumbers reloadData];
//
    religion=[appDelegate GetData:kreligion];
    arrSelectedReligionIds=[[religion componentsSeparatedByString:@","] mutableCopy];
    
    
    if([arrSelectedReligionIds containsObject: @"0"]){
        self.imgNotSay1.image=[UIImage imageNamed:@"CircleGreen"];
        flagNotSay1=true;
        [arrSelectedReligionIds removeAllObjects];
    }else{
        //TODO: for single selection
        if(arrSelectedReligionIds.count>1){
            NSString *temp = [arrSelectedReligionIds firstObject];
            [arrSelectedReligionIds removeAllObjects];
            [arrSelectedReligionIds addObject:temp];
        }
        self.imgNotSay1.image=[UIImage imageNamed:@"UntickCircle"];
        flagNotSay1=false;
    }
    [self.colReligion reloadData];
    
    
    ethinicity=[appDelegate GetData:kethnicity];
    arrSelectedEthnicityIds=[[ethinicity componentsSeparatedByString:@","] mutableCopy];
    if([arrSelectedEthnicityIds containsObject: @"0"]){
        self.imgNotSay2.image=[UIImage imageNamed:@"CircleGreen"];
        flagNotSay2=true;
        [arrSelectedEthnicityIds removeAllObjects];
    }else{
        if(arrSelectedEthnicityIds.count>1){
            NSString *temp = [arrSelectedEthnicityIds firstObject];
            [arrSelectedEthnicityIds removeAllObjects];
            [arrSelectedEthnicityIds addObject:temp];
        }
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

    if([[appDelegate GetData:kGender] isEqualToString:@"female"]){
        strGender = @"female";
        self.imgMaleCheck.image=[UIImage imageNamed:@"Uncheck"];
        self.imgMale.image=[UIImage imageNamed:@"MaleGray"];
        self.imgFemaleCheck.image=[UIImage imageNamed:@"Check"];
        self.ImgFemale.image=[UIImage imageNamed:@"Female"];
    }
    else{
        strGender=@"male";
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
    
//    pref = [[appDelegate GetData:kdatePref] componentsSeparatedByString:@","];
//    
//    //select row
//    
//
//    [self updateSliderLabels];
//    [self updateSliderLabels2];
//    //for no of childerns
//    
//    self.leftDistance.text=[appDelegate GetData:kMinDistance];
//    self.rightDistance.text=[appDelegate GetData:kmaxDistance];
//    self.leftValueLabel.text=[appDelegate GetData:kminAgePref];
//    self.rightValueLabel.text=[appDelegate GetData:kmaxAgePref];
//    
    
    [self viewWillAppear:YES];

}
/*!
 * @discussion Setup Ui
 */
-(void) setFrames{
    
    CGRect temp = self.vwBasics.frame;
    temp.origin.y = self.vwPhotos.frame.origin.y + self.vwPhotos.frame.size.height;
    self.vwBasics.frame = temp;

    temp = self.vwGender.frame;
    temp.origin.y = self.vwBasics.frame.origin.y + self.vwBasics.frame.size.height;
    self.vwGender.frame = temp;

    temp = self.vwAboutMe.frame;
    temp.origin.y = self.vwGender.frame.origin.y + self.vwGender.frame.size.height;
    self.vwAboutMe.frame = temp;

    temp = self.vwHeight.frame;
    temp.origin.y = self.vwAboutMe.frame.origin.y + self.vwAboutMe.frame.size.height;
    self.vwHeight.frame = temp;

    self.colReligion.frame=CGRectMake(self.colReligion.frame.origin.x, self.colReligion.frame.origin.y, self.colReligion.frame.size.width, 35*(ceil(arrReligion.count/3.0)));
    self.vwReligion.frame=CGRectMake(self.vwReligion.frame.origin.x, self.vwHeight.frame.origin.y + self.vwHeight.frame.size.height, self.vwReligion.frame.size.width, self.colReligion.frame.size.height+self.colReligion.frame.origin.y);

    self.colEthnicity.frame=CGRectMake(self.colEthnicity.frame.origin.x, self.colEthnicity.frame.origin.y, self.colEthnicity.frame.size.width, 35*(ceil(arrEthnicity.count/2.0)));
    self.vwEthnicity.frame=CGRectMake(self.vwEthnicity.frame.origin.x, self.vwReligion.frame.origin.y+self.vwReligion.frame.size.height, self.vwEthnicity.frame.size.width, self.colEthnicity.frame.size.height+self.colEthnicity.frame.origin.y);
//
//    self.vwKids.frame=CGRectMake(self.vwKids.frame.origin.x, self.vwEthnicity.frame.origin.y+self.vwEthnicity.frame.size.height, self.vwKids.frame.size.width, self.vwKids.frame.size.height);
//    self.vwQuote.frame=CGRectMake(self.vwQuote.frame.origin.x, self.vwKids.frame.origin.y+self.vwKids.frame.size.height, self.vwQuote.frame.size.width, self.vwQuote.frame.size.height);
    
    //MARK:- Hide instagram
   
    if ( ([[appDelegate GetData:INSTAGRAM_CLIENT_ID] isEqualToString:@""] || [[appDelegate GetData:INSTAGRAM_CLIENT_ID] isEqualToString:@"Key Not Found"])
        || ([[appDelegate GetData:INSTAGRAM_CALLBACK_BASE] isEqualToString:@""] || [[appDelegate GetData:INSTAGRAM_CALLBACK_BASE] isEqualToString:@"Key Not Found"])
        || ([[appDelegate GetData:INSTAGRAM_CLIENT_SECRET] isEqualToString:@""] || [[appDelegate GetData:INSTAGRAM_CLIENT_SECRET] isEqualToString:@"Key Not Found"]) ) {
        
        self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwEthnicity.frame.origin.y+self.vwEthnicity.frame.size.height, self.vwInsta.frame.size.width,0.0);
    
    }
    else {
        self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwEthnicity.frame.origin.y+self.vwEthnicity.frame.size.height, self.vwInsta.frame.size.width, self.vwInsta.frame.size.height);
    }
    
    self.lastView.frame=CGRectMake(self.lastView.frame.origin.x, self.vwInsta.frame.origin.y+self.vwInsta.frame.size.height, self.lastView.frame.size.width, self.lastView.frame.size.height);
    self.lblline.frame=CGRectMake(self.lblline.frame.origin.x, self.lblline.frame.origin.y, 1, self.lastView.frame.origin.y);
    self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.lastView.frame.origin.y+self.lastView.frame.size.height);
    
}
#pragma mark - TextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self datePickerClose];
}
-(void) textViewDidEndEditing:(UITextView *)textView{
    [self validateAboutMe:textView];
}
#pragma mark- methods
/*!
 * @discussion For closing date picker
 */
-(void)datePickerClose {
    [UIView animateWithDuration:0.5 animations:^{
        self.myDatePickerView.frame = CGRectMake(0, SCREEN_SIZE.height, self.myDatePickerView.frame.size.width,self.myDatePickerView.frame.size.height);
    }];
}
/*!
 * @discussion For validating profession
 * @param sender For identifying sender
 */
-(IBAction) validateAboutMe:(id)sender{
    NSString *str = [self.txtAboutMe.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(str.length > 500){
        self.txtAboutMe.text = [str substringToIndex:500];
        ALERTVIEW([MCLocalization stringForKey:@"Your about me discription is too long. Enter about me discription containing maximum 500 characters"], self);
    }
    
}
#pragma mark - Scrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self datePickerClose];
}
#pragma mark - PickerView Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
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

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    height=[pickerArray objectAtIndex:row];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}
#pragma mark - Validations
/*!
 * @discussion For validating first Name
 * @param sender For identifying sender
 */
-(IBAction)validateFirstName :(id)sender{
    NSString *str = [self.txtFirstName.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(str.length > 20){
        self.txtFirstName.text = [str substringToIndex:20];
        ALERTVIEW([MCLocalization stringForKey:@"Your first name is too long. Enter first name containing maximum 20 characters"], self);
    }
    
}
/*!
 * @discussion For validating last Name
 * @param sender For identifying sender
 */
-(IBAction) validateLastName:(id)sender{
    NSString *str = [self.txtLastName.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(str.length > 20){
        self.txtLastName.text = [str substringToIndex:20];
        ALERTVIEW([MCLocalization stringForKey:@"Your last name is too long. Enter last name containing maximum 20 characters"], self);
    }
    
}
/*!
 * @discussion For validating Education
 * @param sender For identifying sender
 */
-(IBAction) validateEducation:(id)sender{
    NSString *str = [self.txtCollege.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(str.length > 100){
        self.txtCollege.text = [str substringToIndex:100];
        ALERTVIEW([MCLocalization stringForKey:@"Your college name is too long. Enter college name containing maximum 100 characters"], self);
    }
    
}
/*!
 * @discussion For validating profession
 * @param sender For identifying sender
 */
-(IBAction) validateProfession:(id)sender{
    NSString *str = [self.txtprofession.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(str.length > 100){
        self.txtprofession.text = [str substringToIndex:100];
        ALERTVIEW([MCLocalization stringForKey:@"Your profession is too long. Enter profession containing maximum 100 characters"], self);
    }
    
}
#pragma mark - Button clicks
/*!
 * @discussion Open Menu
 * @param sender For Identifying sender
 */
- (IBAction)btnMenuClicked:(id)sender {
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        
    }];
}
/*!
 * @discussion Called when user click edit Image, Gives options to edit images
 * @param sender For Identifying sender
 */
- (IBAction)btnEditClicked:(id)sender {
    //check which image should be editted
    UIButton *btn=sender;
    
    flagForCropper = true;
    
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
        picker.allowsEditing = NO;
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
        [self deleteImages];
        
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
    
    flagForCropper = true;
    
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
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
/*!
 * @discussion Open Calender for selection of birthdate
 * @param sender For identifying sender
 */
- (IBAction)btnSelectDate:(id)sender
{
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.myDatePickerView.frame = CGRectMake(0, self.txtDOB.frame.origin.y+(417*SCREEN_SIZE.height/667), self.myDatePickerView.frame.size.width,self.myDatePickerView.frame.size.height);
    }];
}
/*!
 * @discussion Set selected date as Date of Birth
 * @param sender For identifying sender
 */
-(IBAction)btnSaveDate:(id)sender {
    //done date picker
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect temp = self.myDatePickerView.frame;
        temp.origin.y = 877*SCREEN_SIZE.height/667;
        self.myDatePickerView.frame = temp;
    } completion:^(BOOL finished) {
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy"];
        
        selectedpickerdata=[NSString stringWithFormat:@"%@",[df stringFromDate:self.datePicker.date]];
        self.txtDOB.text = selectedpickerdata;
    }];
}
/*!
 * @discussion When Cancel is clicked from birthdate selection
 * @param sender For identifying sender
 */
-(IBAction)btnCancelDate:(id)sender {
    //Cancel date picker
    [UIView animateWithDuration:0.5 animations:^{
        CGRect temp = self.myDatePickerView.frame;
        temp.origin.y = 877;
        self.myDatePickerView.frame = temp;
    }];
}
/*!
 * @discussion Save changes in user's Details
 * @param sender For Identifying sender
 */
- (IBAction)btnSaveClicked:(id)sender {
    //save changes
    
    if([[self.txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:[appDelegate GetData:kEmail]]){
        //call update my profile
        [self updateProfile];
    }
    else{
        NSString *strEmail = [self.txtEmail.text stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (strEmail.length>0)
        {
            if ([Util ValidateEmailString:strEmail])
            {
                NSString *strFName = [self.txtFirstName.text stringByTrimmingCharactersInSet:
                                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if(strFName.length > 0)
                {
                    
                    NSString *strLName = [self.txtLastName.text stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if(strLName.length > 0)
                    {
                        NSString *strCollege = [self.txtCollege.text stringByTrimmingCharactersInSet:
                                                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        if(strCollege.length > 0) {
                            NSString *strProfession = [self.txtprofession.text stringByTrimmingCharactersInSet:
                                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            if(strProfession.length > 0) {
                                NSString *str = [self.txtAboutMe.text stringByTrimmingCharactersInSet:
                                                 [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                if(str.length >0)
                                {
                                    if ([[self.txtAboutMe.text stringByTrimmingCharactersInSet:
                                                    [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0 ) {
                                        [self verifyEmail];
                                    } else {
                                        ALERTVIEW([MCLocalization stringForKey:@"Please enter something about you"], self);
                                    }
                                } else {
                                    ALERTVIEW([MCLocalization stringForKey:@"Please enter something about you"], self);
                                }
                            } else {
                                ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Profession."], self);
                            }
                        } else {
                            ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your College Name."], self);
                        }
                        
                    } else {
                        ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Last Name."], self);
                    }
                } else {
                    ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your First Name."], self);
                }
                
            }else{
                ALERTVIEW([MCLocalization stringForKey:@"Invalid Email Address!"], self);
            }
        }
        else{
            ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Email Address."], self);
        }
    }
//    if ([[self.txtAboutMe.text stringByTrimmingCharactersInSet:
//          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] >0 ) {
//        if([[self.txtAnswer.text stringByTrimmingCharactersInSet:
//             [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] >0){
//
//            if([kids isEqualToString:@""]){
//                ALERTVIEW([MCLocalization stringForKey:@"Please select kids"], self);
//
//            }
//            else{
//                [self updatePerf];
//            }
//        }
//        else{
//            ALERTVIEW([MCLocalization stringForKey:@"Please answer any one question"], self);
//        }
//    }
//    else{
//        ALERTVIEW([MCLocalization stringForKey:@"Please enter something about you"], self);
//    }
//
}
/*!
 * @discussion Set gender preference to Male
 * @param sender For Identifying sender
 */
- (IBAction)btnMaleClicked:(id)sender {
    
    strGender=@"male";
    self.imgMaleCheck.image=[UIImage imageNamed:@"Check"];
    self.imgMale.image=[UIImage imageNamed:@"Male"];
    self.imgFemaleCheck.image=[UIImage imageNamed:@"Uncheck"];
    self.ImgFemale.image=[UIImage imageNamed:@"FemaleGray"];
    
}
/*!
 * @discussion Set gender preference to Female
 * @param sender For Identifying sender
 */
- (IBAction)btnFemaleClicked:(id)sender {
    strGender=@"female";
    self.imgMaleCheck.image=[UIImage imageNamed:@"Uncheck"];
    self.imgMale.image=[UIImage imageNamed:@"MaleGray"];
    self.imgFemaleCheck.image=[UIImage imageNamed:@"Check"];
    self.ImgFemale.image=[UIImage imageNamed:@"Female"];
    
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
    if(flagNotSay2) {
        self.imgNotSay2.image = [UIImage imageNamed:@"UntickCircle"];
        flagNotSay2 = false;
    } else {
        self.imgNotSay2.image = [UIImage imageNamed:@"CircleGreen"];
        flagNotSay2 = true;
    }
    [self.colEthnicity reloadData];
}
/*!
 * @discussion Called when user click import images from instagram
 * @param sender For Identifying sender
 */
- (IBAction)btnInstagramImportClicked:(id)sender {
    SHOW_LOADER_ANIMTION();
    //[assets removeAllObjects];
    [self performSelector:@selector(checkInstagramAuth) withObject:nil afterDelay:0];
}
/*!
 * @discussion When User click on Verify email
 * @param sender For identifying sender
 */
- (IBAction)btnVerifyEmailClicked:(id)sender {
    
    //if([self.btnVerify.titleLabel.text isEqualToString:[MCLocalization stringForKey:@"Verify your email"]]){
    
    //   [self verifyEmail];
    [UIView animateWithDuration:0.7 animations:^{
        self.vwPopup.frame=CGRectMake(0,[UIScreen mainScreen].bounds.size.height-self.vwPopup.frame.size.height,[UIScreen mainScreen].bounds.size.width,self.vwPopup.frame.size.height);
    }];
    // }
}
/*!
 * @discussion When User click on Verify code
 * @param sender For identifying sender
 */
- (IBAction)btnVerifyCodeClicked:(id)sender {
    
    NSString *strEnterdcode = [[NSString alloc] init];
    strEnterdcode = self.txtVarificationCode.text;
    if(strEnterdcode.length == 4){
        [UIView animateWithDuration:0.7 animations:^{
            self.vwPopup.frame=CGRectMake(0,-(self.vwPopup.frame.size.height),[UIScreen mainScreen].bounds.size.width,self.vwPopup.frame.size.height);
        } completion:^(BOOL finished) {
            [self verifyCode];
            [self.view endEditing:YES];
        }];
    } else {
        ALERTVIEW([MCLocalization stringForKey:@"Please enter 4 digit verification code"], self);
    }
    //check code then set text
    // if([strEnterdcode isEqualToString:strCode]){
    //   varified = YES;//call register api
    
    //    [appDelegate SetData:[self.txtEmail.text stringByTrimmingCharactersInSet:
    //                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:@"signUpEmail"];
    //    [appDelegate SetData:[self.txtFirstName.text stringByTrimmingCharactersInSet:
    //                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:@"signUpFName"];
    //    [appDelegate SetData:[self.txtLastName.text stringByTrimmingCharactersInSet:
    //                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:@"signUpLName"];
    //    [appDelegate SetData:[self.txtCollege.text stringByTrimmingCharactersInSet:
    //                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:@"signUpCollege"];
    //    [appDelegate SetData:[self.txtprofession.text stringByTrimmingCharactersInSet:
    //                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:@"signUpProfession"];
    
    //  [self RegisterUser];
    //    self.btnVerify.userInteractionEnabled = NO;
    //        [self.btnVerify setTitle:[MCLocalization stringForKey:@"Email Verified"] forState:UIControlStateNormal];
    
    // }
    
    //        else{
    // ALERTVIEW([MCLocalization stringForKey:@"Invalid verification code! Try again!"], self);
    //        }
    
    //    }
    //    else{
    //
    //    }
    
    
    
}
#pragma mark - tapgesture delegate
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [UIView animateWithDuration:0.7 animations:^{
        self.vwPopup.frame=CGRectMake(0,-(self.vwPopup.frame.size.height),[UIScreen mainScreen].bounds.size.width,self.vwPopup.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark- collectionView delegates
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(collectionView.tag==101){
        return arrReligion.count;
    }
    else if(collectionView.tag==102){
        return arrEthnicity.count;
    }
    else if(collectionView.tag == 104){
        return assets.count;
    }
//    else if(collectionView.tag == 103){
//        return 7;
//    }
    else{
        return 0;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if(collectionView.tag==101){
        
        static NSString *indenti=@"NumbersCell";
        NumbersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
        [cell.lblNumber setFont:[UIFont fontWithName:@"Lato-Semibold" size:12]];
        
        cell.lblNumber.text = [arrReligion objectAtIndex:indexPath.row];
        
        if([arrSelectedReligionIds containsObject:[arrReligionIDs objectAtIndex:indexPath.row]]){
            cell.backgroundColor = bgSelect;
        }
        else{
            cell.backgroundColor = bgDeselect;
        }
        
        return cell;
        
    }
    else if(collectionView.tag==102){

        static NSString *indenti=@"NumbersCell";
        NumbersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
        [cell.lblNumber setFont:[UIFont fontWithName:@"Lato-Semibold" size:12]];

        cell.lblNumber.text = [arrEthnicity objectAtIndex:indexPath.row];

        if([arrSelectedEthnicityIds containsObject:[arrEthnicityIDs objectAtIndex:indexPath.row]]){
            cell.backgroundColor = bgSelect;
        }
        else{
            cell.backgroundColor = bgDeselect;
        }

        return cell;

    }
//    else if(collectionView.tag == 103){
//
//        static NSString *indenti=@"NumbersCell";
//        NumbersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
//        [cell.lblNumber setFont:[UIFont fontWithName:@"Lato-Semibold" size:12]];
//
//        cell.lblNumber.text=[NSString stringWithFormat:@"%ld",(indexPath.row+1) ];
//
//        if((noOfChildren-1)== indexPath.row){
//            cell.lblNumber.backgroundColor=bgSelect;
//        }
//        else{
//            cell.lblNumber.backgroundColor=[UIColor clearColor];
//        }
//        cell.layer.cornerRadius=2.0;
//        cell.layer.masksToBounds=YES;
//        cell.lblNumber.layer.borderColor=bgSelect.CGColor;
//        [cell.lblNumber.layer setBorderWidth: 1.5];
//
//        return cell;
//    }
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
            [arrSelectedReligionIds removeAllObjects];
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
            [arrSelectedEthnicityIds removeAllObjects];
            [arrSelectedEthnicityIds addObject:[arrEthnicityIDs objectAtIndex:indexPath.row]];
        }
        [collectionView reloadData];
    }
//    else if(collectionView.tag == 103){
//        kids=[NSString stringWithFormat:@"%ld", indexPath.row+1 ];
//        self.imgNone.image=[UIImage imageNamed:@"UntickCircle"];
//        flagChildrenNone=false;
//        self.imgOneday.image=[UIImage imageNamed:@"UntickCircle"];
//        flagChildrenOneDay=false;
//        self.imgDontwant.image=[UIImage imageNamed:@"UntickCircle"];
//        flagChildrenDontWant=false;
//        noOfChildren=indexPath.row+1;
//        [collectionView reloadData];
//    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 101) {
        return CGSizeMake((collectionView.frame.size.width/3)-7, 25);
    }
    else if (collectionView.tag == 102){

        return CGSizeMake((collectionView.frame.size.width/2)-7, 25);
    }
//    else if(collectionView.tag == 103) {
//        return CGSizeMake((collectionView.frame.size.width-30)/4, (collectionView.frame.size.width-30)/4);
//    }
    else if (collectionView.tag == 104){
        return CGSizeMake((self.colInstaImages.frame.size.width/3)-5,(self.colInstaImages.frame.size.width/3)-5);
    }
    else{
        return CGSizeMake(0, 0);
    }
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    return layoutAttributes;
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
                                     message:@"Failed to request token."
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
                                                                        message:@"Failed to request perform request."
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
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   self.colInstaImages.frame = CGRectMake(self.colInstaImages.frame.origin.x, self.colInstaImages.frame.origin.y, self.colInstaImages.frame.size.width, (self.colInstaImages.frame.size.width/3)*2+20);
                                           
                                                   self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwEthnicity.frame.origin.y + self.vwEthnicity.frame.size.height, self.vwInsta.frame.size.width, self.colInstaImages.frame.origin.y + self.colInstaImages.frame.size.height + 10);
                                                   
                                                   self.lastView.frame=CGRectMake(self.lastView.frame.origin.x, self.vwInsta.frame.origin.y+self.vwInsta.frame.size.height, self.lastView.frame.size.width, self.lastView.frame.size.height);
                                                   self.lblline.frame=CGRectMake(self.lblline.frame.origin.x, self.lblline.frame.origin.y, 1, self.lastView.frame.origin.y);
                                                   self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.lastView.frame.origin.y+self.lastView.frame.size.height);
                                               });
                                               
                                               
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
#pragma mark- image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:chosenImage];
    cropController.delegate = self;
    cropController.customAspectRatio = CGSizeMake(1, 1);
    cropController.aspectRatioLockEnabled = YES;
    cropController.rotateButtonsHidden = YES;
    cropController.rotateClockwiseButtonHidden = YES;
    cropController.aspectRatioPickerButtonHidden = YES;
    cropController.resetAspectRatioEnabled = NO;
//    int editedImage= appDelegate.editImage.intValue;
//
//    if(editedImage>0){
//        flagUploadImage=true;
//        if([arrDeletedImages containsObject:[NSString stringWithFormat:@"%d", editedImage]]){
//            [arrDeletedImages removeObject:[NSString stringWithFormat:@"%d", editedImage]];
//        }
//        NSLog(@"Deleted images: %@",arrDeletedImages);
//        switch (editedImage) {
//            case 1:
//                self.img1.image=chosenImage;
//                flagUploadImage1=true;
//                break;
//            case 2:
//                self.img2.image=chosenImage;
//                flagUploadImage2=true;
//                break;
//            case 3:
//                self.img3.image=chosenImage;
//                flagUploadImage3=true;
//                break;
//            case 4:
//                self.img4.image=chosenImage;
//                flagUploadImage4=true;
//                break;
//            case 5:
//                self.img5.image=chosenImage;
//                flagUploadImage5=true;
//                break;
//            case 6:
//                self.img6.image=chosenImage;
//                flagUploadImage6=true;
//                break;
//
//            default:
//                break;
//        }
//        appDelegate.editImage=@"";
//        appDelegate.editImageName=@"";
//        editedImage=-1;
//    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self presentViewController:cropController animated:YES completion:nil];
        //[self.navigationController pushViewController:cropController animated:YES];
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    appDelegate.editImage=@"";
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    
    self.lblTitle.text=[MCLocalization stringForKey:@"My Profile"];
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    
    self.lblPhotos.text=[MCLocalization stringForKey:@"Photos"];
    [self.lblPhotos sizeToFit];
    self.lblPhotosUnderline.frame=CGRectMake(self.lblPhotos.frame.origin.x, self.lblPhotosUnderline.frame.origin.y, self.lblPhotos.frame.size.width, 1);
    
    self.lblBasics.text=[MCLocalization stringForKey:@"My Profile"];
    [self.lblBasics sizeToFit];
    self.lblBasicsUnderline.frame=CGRectMake(self.lblBasics.frame.origin.x, self.lblBasicsUnderline.frame.origin.y, self.lblBasics.frame.size.width, 1);
    
    [self.btnCancel setTitle:[MCLocalization stringForKey:@"Cancel"] forState:UIControlStateNormal];
    [self.btnDone setTitle:[MCLocalization stringForKey:@"Done"] forState:UIControlStateNormal];
    
    self.lblGender.text=[MCLocalization stringForKey:@"Gender"];
    [self.lblGender sizeToFit];
    self.lblGenderUnderline.frame=CGRectMake(self.lblGender.frame.origin.x, self.lblGenderUnderline.frame.origin.y, self.lblGender.frame.size.width, 1);
    
    self.lblAboutMe.text=[MCLocalization stringForKey:@"About Me"];
    [self.lblAboutMe sizeToFit];
    self.lblAboutUnderline.frame = CGRectMake(self.lblAboutMe.frame.origin.x, self.lblAboutUnderline.frame.origin.y, self.lblAboutMe.frame.size.width, 1);
    
    self.lblHeight.text=[MCLocalization stringForKey:@"Height"];
    self.lblAlwaysVisible.text=[MCLocalization stringForKey:@"Always visible"];
    [self.lblHeight sizeToFit];
    self.lblHeightUnderline.frame=CGRectMake(self.lblHeight.frame.origin.x, self.lblHeightUnderline.frame.origin.y, self.lblHeight.frame.size.width, 1);

    
    UIColor *color = [UIColor whiteColor];
    UIFont *font=[UIFont fontWithName:@"Lato-Regular" size:14];
    
    self.txtVarificationCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Varification Code"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];

    self.lblReligion.text=[MCLocalization stringForKey:@"Religion"];
    [self.lblReligion sizeToFit];
    self.lblReligionUnderline.frame=CGRectMake(self.lblReligion.frame.origin.x, self.lblReligionUnderline.frame.origin.y, self.lblReligion.frame.size.width, 1);
    self.lblNotSay1.text=[MCLocalization stringForKey:@"Prefer not to say"];
    [self.lblNotSay1 sizeToFit];
    self.lblNotSay1.frame=CGRectMake(SCREEN_SIZE.width-self.lblNotSay1.frame.size.width-35*SCREEN_SIZE.width/375, self.lblNotSay1.frame.origin.y, self.lblNotSay1.frame.size.width, self.lblNotSay1.frame.size.height);
    self.imgNotSay1.frame=CGRectMake(self.lblNotSay1.frame.origin.x-self.imgNotSay1.frame.size.width-5, self.imgNotSay1.frame.origin.y, self.imgNotSay1.frame.size.width, self.imgNotSay1.frame.size.height);
    self.btnNotSay1.frame=CGRectMake(self.imgNotSay1.frame.origin.x, self.lblNotSay1.frame.origin.y, self.imgNotSay1.frame.size.width+self.lblNotSay1.frame.size.width, self.btnNotSay1.frame.size.height);

    self.lblEthnicity.text=[MCLocalization stringForKey:@"Ethnicity"];
    [self.lblEthnicity sizeToFit];
    self.lblEthnicityUnderline.frame=CGRectMake(self.lblEthnicity.frame.origin.x, self.lblEthnicityUnderline.frame.origin.y, self.lblEthnicity.frame.size.width, 1);

    self.lblNotSay2.text=[MCLocalization stringForKey:@"Prefer not to say"];
    [self.lblNotSay2 sizeToFit];
    self.lblNotSay2.frame=CGRectMake(SCREEN_SIZE.width-self.lblNotSay2.frame.size.width-35*SCREEN_SIZE.width/375, self.lblNotSay2.frame.origin.y, self.lblNotSay2.frame.size.width, self.lblNotSay2.frame.size.height);
    self.imgNotSay2.frame=CGRectMake(self.lblNotSay2.frame.origin.x-self.imgNotSay2.frame.size.width-5, self.imgNotSay2.frame.origin.y, self.imgNotSay2.frame.size.width, self.imgNotSay2.frame.size.height);
    self.btnNotSay2.frame=CGRectMake(self.imgNotSay2.frame.origin.x, self.btnNotSay2.frame.origin.y, self.imgNotSay2.frame.size.width+self.lblNotSay2.frame.size.width, self.btnNotSay2.frame.size.height);
//
//
//    self.lblKids.text=[MCLocalization stringForKey:@"Kids"];
//    self.lblNone.text=[MCLocalization stringForKey:@"None"];
//    self.lblOneDay.text=[MCLocalization stringForKey:@"One Day"];
//    self.lblDontwantkids.text=[MCLocalization stringForKey:@"I Don't Want Kids"];
//
//    [self.lblNone sizeToFit];
//    self.btnNone.frame = CGRectMake(self.imgNone.frame.origin.x, self.lblNone.frame.origin.y, self.lblNone.frame.origin.x + self.lblNone.frame.size.width - self.imgNone.frame.origin.x, self.btnNone.frame.size.height );
//    [self.lblOneDay sizeToFit];
//    self.btnOneDay.frame = CGRectMake(self.imgOneday.frame.origin.x, self.lblOneDay.frame.origin.y, self.lblOneDay.frame.origin.x + self.lblOneDay.frame.size.width -self.imgOneday.frame.origin.x, self.btnOneDay.frame.size.height );
//    [self.lblDontwantkids sizeToFit];
//    self.btnDontwantKids.frame = CGRectMake(self.imgDontwant.frame.origin.x, self.lblDontwantkids.frame.origin.y, self.lblDontwantkids.frame.origin.x + self.lblDontwantkids.frame.size.width - self.imgDontwant.frame.origin.x, self.btnDontwantKids.frame.size.height );
//
//    self.lblQuotes.text=[MCLocalization stringForKey:@"Quote"];
//
//    [self.btnDone setTitle:[MCLocalization stringForKey:@"DONE"] forState:UIControlStateNormal];
//
//    [self.lblKids sizeToFit];
//    self.lblKidsUnderline.frame=CGRectMake(self.lblKids.frame.origin.x, self.lblKidsUnderline.frame.origin.y, self.lblKids.frame.size.width, 1);

    
    self.lblInsta.text = [MCLocalization stringForKey:@"Instagram Images"];
    [self.lblInsta sizeToFit];
    self.lblInstaLine.frame=CGRectMake(self.lblInsta.frame.origin.x, self.lblInstaLine.frame.origin.y, self.lblInsta.frame.size.width, 1);
    [self.btnUpdateInstaImages setTitle:[MCLocalization stringForKey:@"Update"] forState:UIControlStateNormal];
    self.lblConnect.text = [MCLocalization stringForKey:@"Connect to Instagram"];
    [self.lblConnect sizeToFit];
    self.vwConnectInsta.frame=CGRectMake((SCREEN_SIZE.width - self.lblConnect.frame.size.width)/2, self.vwConnectInsta.frame.origin.y, self.lblConnect.frame.size.width, self.vwConnectInsta.frame.size.height);
    
    [self.btnSave setTitle:[MCLocalization stringForKey:@"DONE"] forState:UIControlStateNormal];
    
    [self.btnOk setTitle:[MCLocalization stringForKey:@"OK"] forState:UIControlStateNormal];
    self.lblEnterCode.text = [MCLocalization stringForKey:@"Enter varification code"];
    
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
    
    temp = self.lblBasics.frame;
    temp.origin.x = x ;
    self.lblBasics.frame = temp;
    self.lblBasicsUnderline.frame = CGRectMake(x, self.lblPhotosUnderline.frame.origin.y, self.lblBasics.frame.size.width, 1);
    
    temp = self.lblGender.frame;
    temp.origin.x = x ;
    self.lblGender.frame = temp;
    self.lblGenderUnderline.frame = CGRectMake(x, self.lblGenderUnderline.frame.origin.y, self.lblGender.frame.size.width, 1);

    temp = self.lblAboutMe.frame;
    temp.origin.x = x ;
    self.lblAboutMe.frame = temp;
    self.lblAboutUnderline.frame = CGRectMake(x, self.lblAboutUnderline.frame.origin.y, self.lblAboutMe.frame.size.width, 1);
    
    temp = self.lblHeight.frame;
    temp.origin.x = x ;
    self.lblHeight.frame = temp;
    self.lblHeightUnderline.frame = CGRectMake(x, self.lblHeightUnderline.frame.origin.y, self.lblHeight.frame.size.width, 1);
    self.lblAlwaysVisible.frame = CGRectMake(self.txtAboutMe.frame.origin.x+self.txtAboutMe.frame.size.width-self.lblAlwaysVisible.frame.size.width, self.lblAlwaysVisible.frame.origin.y, self.lblAlwaysVisible.frame.size.width, self.lblAlwaysVisible.frame.size.height);
    
    self.txtprofession.textAlignment =  NSTextAlignmentRight;
    self.txtCollege.textAlignment =  NSTextAlignmentRight;
    self.txtLastName.textAlignment =  NSTextAlignmentRight;
    self.txtFirstName.textAlignment =  NSTextAlignmentRight;
    self.txtDOB.textAlignment =  NSTextAlignmentRight;
    self.txtEmail.textAlignment =  NSTextAlignmentRight;
    
    self.lblReligion.frame = CGRectMake(x, self.lblReligion.frame.origin.y, self.lblReligion.frame.size.width, self.lblReligion.frame.size.height);
    self.lblReligionUnderline.frame = CGRectMake(x, self.lblReligionUnderline.frame.origin.y, self.lblReligion.frame.size.width, 1);
    self.colReligion.frame = CGRectMake(55 * SCREEN_SIZE.width/375, self.colReligion.frame.origin.y, self.colReligion.frame.size.width, self.colReligion.frame.size.height);
    self.lblNotSay1.frame = CGRectMake(self.txtAboutMe.frame.origin.x+self.txtAboutMe.frame.size.width-self.lblNotSay1.frame.size.width, self.lblNotSay1.frame.origin.y, self.lblNotSay1.frame.size.width, self.lblNotSay1.frame.size.height);

    self.lblEthnicity.frame = CGRectMake(x, self.lblEthnicity.frame.origin.y, self.lblEthnicity.frame.size.width, self.lblEthnicity.frame.size.height);
    self.lblEthnicityUnderline.frame=CGRectMake(self.lblEthnicity.frame.origin.x, self.lblEthnicityUnderline.frame.origin.y, self.lblEthnicity.frame.size.width, 1);
    self.colEthnicity.frame = CGRectMake(55 * SCREEN_SIZE.width/375, self.colEthnicity.frame.origin.y, self.colEthnicity.frame.size.width, self.colEthnicity.frame.size.height);
    self.lblNotSay2.frame = CGRectMake(self.txtAboutMe.frame.origin.x+self.txtAboutMe.frame.size.width-self.lblNotSay2.frame.size.width, self.lblNotSay2.frame.origin.y, self.lblNotSay2.frame.size.width, self.lblNotSay2.frame.size.height);
//
//    self.lblKids.frame = CGRectMake(x, self.lblKids.frame.origin.y, self.lblKids.frame.size.width, self.lblKids.frame.size.height);
//
//    self.vwScrollKids.frame = CGRectMake(24 * SCREEN_SIZE.width/375, self.vwScrollKids.frame.origin.y, self.vwScrollKids.frame.size.width, self.vwScrollKids.frame.size.height);
//    self.lblNone.frame = CGRectMake(75 * SCREEN_SIZE.width/375, self.lblNone.frame.origin.y, self.lblNone.frame.size.width, self.lblNone.frame.size.height);
//    self.lblOneDay.frame = CGRectMake(75 * SCREEN_SIZE.width/375, self.lblOneDay.frame.origin.y, self.lblOneDay.frame.size.width, self.lblOneDay.frame.size.height);
//    self.lblDontwantkids.frame = CGRectMake(75 * SCREEN_SIZE.width/375, self.lblDontwantkids.frame.origin.y, self.lblDontwantkids.frame.size.width, self.lblDontwantkids.frame.size.height);
//    self.btnNone.frame = CGRectMake(self.imgNone.frame.origin.x, self.lblNone.frame.origin.y, self.lblNone.frame.origin.x + self.lblNone.frame.size.width - self.imgNone.frame.origin.x, self.btnNone.frame.size.height );
//    self.btnOneDay.frame = CGRectMake(self.imgOneday.frame.origin.x, self.lblOneDay.frame.origin.y, self.lblOneDay.frame.origin.x + self.lblOneDay.frame.size.width -self.imgOneday.frame.origin.x, self.btnOneDay.frame.size.height );
//    self.btnDontwantKids.frame = CGRectMake(self.imgDontwant.frame.origin.x, self.lblDontwantkids.frame.origin.y, self.lblDontwantkids.frame.origin.x + self.lblDontwantkids.frame.size.width - self.imgDontwant.frame.origin.x, self.btnDontwantKids.frame.size.height );
//
    self.lblInsta.frame = CGRectMake(x, self.lblInsta.frame.origin.y, self.lblInsta.frame.size.width, self.lblInsta.frame.size.height);
    self.lblInstaLine.frame=CGRectMake(self.lblInsta.frame.origin.x, self.lblInstaLine.frame.origin.y, self.lblInsta.frame.size.width, 1);
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
    
    [self.lblBasics setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtprofession setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtCollege setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtLastName setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtFirstName setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtDOB setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtEmail setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.myDatePickerView setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.btnDone setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.btnCancel setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.datePicker setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblGender setTransform:CGAffineTransformMakeScale(-1, 1)];

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
//
//    [self.lblKids setTransform:CGAffineTransformMakeScale(-1, 1)];
//    [self.vwScrollKids setTransform:CGAffineTransformMakeScale(-1, 1)];
//    [self.lblNone setTransform:CGAffineTransformMakeScale(-1, 1)];
//    [self.lblDontwantkids setTransform:CGAffineTransformMakeScale(-1, 1)];
//    [self.lblOneDay setTransform:CGAffineTransformMakeScale(-1, 1)];
//    self.lblNone.textAlignment = NSTextAlignmentRight;
//    self.lblOneDay.textAlignment = NSTextAlignmentRight;
//    self.lblDontwantkids.textAlignment = NSTextAlignmentRight;
//
    [self.btnUpdateInstaImages setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblInsta setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.vwConnectInsta setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.btnUpdateInstaImages.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}
#pragma mark - Api Calls
/*!
 * @discussion Websevice call for updating user's details
 */

-(void) updateProfile
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
             

             NSString *str=@"update_profile";
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];

             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:[self.txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"email"];
             [dict setValue:[self.txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fname"];
             [dict setValue:[self.txtLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"lname"];
             [dict setValue:[self.txtCollege.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"education"];
             [dict setValue:[self.txtprofession.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"profession"];
             NSArray *temp = [self.txtDOB.text componentsSeparatedByString:@"/"];
             NSString *strDOB = [NSString stringWithFormat:@"%@-%@-%@",temp[2],temp[1],temp[0]];
             [dict setValue:strDOB forKey:@"dob"];
             [dict setValue:strGender forKey:@"gender"];
             [dict setValue:[self.txtAboutMe.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"about"];
             [dict setValue:height forKey:@"height"];
             

             if(arrSelectedReligionIds.count==0){
                 religion=@"0";
             }
             else{
                 religion=[NSString stringWithFormat:@"%@",[arrSelectedReligionIds objectAtIndex:0]];
                 for(int i=1;i<arrSelectedReligionIds.count;i++){
                     religion=[NSString stringWithFormat:@"%@,%@",religion,[arrSelectedReligionIds objectAtIndex:i]];
                 }
             }
             if(arrSelectedEthnicityIds.count==0){
                 ethinicity=@"0";
             }
             else{
                 ethinicity=[NSString stringWithFormat:@"%@",[arrSelectedEthnicityIds objectAtIndex:0]];
                 for(int i=1;i<arrSelectedEthnicityIds.count;i++){
                     ethinicity=[NSString stringWithFormat:@"%@,%@",ethinicity,[arrSelectedEthnicityIds objectAtIndex:i]];
                 }
             }
             [dict setValue:religion forKey:@"religion"];
             [dict setValue:ethinicity forKey:@"ethnicity"];

             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;

                 if(success && [[dictionary valueForKey:@"error"] intValue] == 0) {
                     
                     [self setAge];
                     [appDelegate SetData:[self.txtEmail.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kEmail];
                     [appDelegate SetData:[self.txtFirstName.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kUserName];
                     [appDelegate SetData:[self.txtLastName.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kLname];
                     [appDelegate SetData:[self.txtCollege.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kCollege];
                     [appDelegate SetData:[self.txtprofession.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kProfession];
                     [appDelegate SetData:self.txtDOB.text value:kDOB];
                     [appDelegate SetData:strGender value:kGender];
                     [appDelegate SetData:[self.txtAboutMe.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kabout];
                     [appDelegate SetData:height value:kheight];
                     [appDelegate SetData:religion value:kreligion];

//                     if(arrDeletedImages.count>0){
//                         [self deleteImages];
//                     }
//                     else if(flagUploadImage1||flagUploadImage2||flagUploadImage3||flagUploadImage4||flagUploadImage5||flagUploadImage6){
//                         [self updateImages];
//                     }

                     ALERTVIEW([MCLocalization stringForKey:@"Data Updated Successfully "], self);
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
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"lname"] value:kLname];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"fname"] value:kUserName];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"email"] value:kEmail];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"education"] value:kCollege];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"profession"] value:kProfession];
                     NSString *strDOB = [[dictionary valueForKey:@"body"]valueForKey:@"dob"];
                     NSArray *arrTemp = [strDOB componentsSeparatedByString:@"-"];
                     strDOB = [NSString stringWithFormat:@"%@/%@/%@",arrTemp[2],arrTemp[1],arrTemp[0]];
                     [appDelegate SetData:strDOB value:kDOB];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"gender"] value:kGender];
                     
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"about"] value:kabout];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"date_pref"] value:kdatePref];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"ethnicity"] value:kethnicity];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"religion"] value:kreligion];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"gender_pref"] value:kgenderPref];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"height"] value:kheight];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"kids"] value:kno_of_kids];
                     
                     
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"max_age_pref"] value:kmaxAgePref];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"max_dist_pref"] value:kmaxDistance];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"min_age_pref"] value:kminAgePref];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"min_dist_pref"] value:kMinDistance];
                     
                     
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"que_id"] value:kquestionID];
                     if([[appDelegate GetData:kquestionID] integerValue] < 1)
                     {
                         [appDelegate SetData:@"1" value:kquestionID];
                     }
                     else if([[appDelegate GetData:kquestionID] integerValue] >25 ){
                         [appDelegate SetData:@"25" value:kquestionID];
                     }
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"que_ans"] value:kanswer];
                     
                     [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img1"]] value:kimg1];
                     [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img1"]] value:kprofileimage];
                     
                     NSString *temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img2"];
                     if(temp!=nil)
                     {
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img2"]] value:kimg2];
                     }
                     else
                     {
                         [appDelegate RemoveData:kimg2];
                     }
                     temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img3"];
                     if(temp!=nil)
                     {
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img3"]] value:kimg3];
                     }
                     else
                     {
                         [appDelegate RemoveData:kimg3];
                     }
                     temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img4"];
                     if(temp!=nil)
                     {
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img4"]] value:kimg4];
                     }
                     else
                     {
                         [appDelegate RemoveData:kimg4];
                     }
                     temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img5"];
                     if(temp!=nil)
                     {
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img5"]] value:kimg5];
                     }
                     else
                     {
                         [appDelegate RemoveData:kimg5];
                     }
                     temp=[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img6"];
                     if(temp!=nil)
                     {
                         [appDelegate SetData:[NSString stringWithFormat:@"%@%@",imageUrl,[[[dictionary valueForKey:@"body"]valueForKey:@"gallary"] valueForKey:@"img6"]] value:kimg6];
                     }
                     else
                     {
                         [appDelegate RemoveData:kimg6];
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
                     
                     NSArray *arr1=[dictionary valueForKey:@"religion"];
                     for (int i=0; i<arr1.count; i++)
                     {
                         NSData *data = [[[arr1 objectAtIndex:i] valueForKey:strSelectedLanguage] dataUsingEncoding:NSUTF16StringEncoding];
                         NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
                         [arrReligion addObject:decodevalue];
                     }
                     arrReligionIDs=[[[dictionary valueForKey:@"religion"] valueForKey:@"id"] mutableCopy];
                     [self.colReligion reloadData];

                     NSArray *arr2=[dictionary valueForKey:@"ethnicity"];
                     for (int i=0; i<arr2.count; i++)
                     {
                         NSData *data = [[[arr2 objectAtIndex:i] valueForKey:strSelectedLanguage] dataUsingEncoding:NSUTF16StringEncoding];
                         NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
                         [arrEthnicity addObject:decodevalue];
                     }
                     arrEthnicityIDs=[[[dictionary valueForKey:@"ethnicity"] valueForKey:@"id"] mutableCopy];
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
                         self.vwInsta.frame = CGRectMake(self.vwInsta.frame.origin.x, self.vwEthnicity.frame.origin.y+self.vwEthnicity.frame.size.height, self.vwInsta.frame.size.width, self.colInstaImages.frame.origin.y+self.colInstaImages.frame.size.height+10);
                         
                         self.lastView.frame=CGRectMake(self.lastView.frame.origin.x, self.vwInsta.frame.origin.y+self.vwInsta.frame.size.height, self.lastView.frame.size.width, self.lastView.frame.size.height);
                         self.lblline.frame=CGRectMake(self.lblline.frame.origin.x, self.lblline.frame.origin.y, 1, self.lastView.frame.origin.y);

                         [self.colInstaImages reloadData];
                     }
                     else{
                         // Images not found
                         self.vwConnectInsta.hidden = NO;
                         self.colInstaImages.hidden = YES;
                     }

//                     continue viewdidload
                     [self setupUI];
                     
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
 * @discussion Web service call for verifying email id of user
 */
-(void)verifyEmail
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
             NSString *str=@"send_email";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[self.txtEmail.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"email"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     ALERTVIEW([MCLocalization stringForKey:@"Verification code is sent to your email address."], self);
                     [self btnVerifyEmailClicked:nil];
                     
                 }else{
                     ALERTVIEW([MCLocalization stringForKey:@"Something Went Wrong, Please Try Again."], self);
                 }
             }];
             
         }
     }];
}
/*!
 * @discussion Web service call for register email id of user
 */
-(void)verifyCode
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
             NSString *str=@"email_verification";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[self.txtEmail.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"email"];
             [dict setValue:[self.txtVarificationCode.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"verification_code"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     //  if(mail_Sent)
                     //     {
                     //TODO: call api for updating my profile
                    // [self RegisterUser];
                     [self updateProfile];
                     //                     }
                     
                     
                     
                 }else{
                     //(//                     else{
                     
                     self.txtEmail.text = [appDelegate GetData:kEmail];
                     ALERTVIEW([MCLocalization stringForKey:@"Invalid verification code! Try again!"], self);
                     [self updateProfile];
                     //                     }
                     
                     //                     ALERTVIEW([MCLocalization stringForKey:@"Something Went Wrong, Please Try Again."], self);
                 }
             }];
             
         }
     }];
}
/*!
 * @discussion get age of user
 */
-(void)setAge {
    NSString *birthDate = self.txtDOB.text;
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    [appDelegate SetData:[NSString stringWithFormat:@"%d",years] value:kAge];
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
    
    appDelegate.editImageName=@"";
    editedImage=-1;
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        [self updateImages];
    }];
    
}
@end
