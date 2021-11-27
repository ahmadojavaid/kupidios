//
//  SignUpVC.m
//  CupidLove
//
//  Created by Umesh on 11/10/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import "SignUpVC.h"
#import "DetailsSignUpVC.h"
#import "LocationHelper.h"
#import "WebViewVC.h"

@interface SignUpVC () <LocationUpdateDelegate,UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwback;

@property(weak,nonatomic) IBOutlet UIButton *btnVerify;

@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
@property (weak,nonatomic) IBOutlet UIImageView *imgMale;
@property (weak,nonatomic) IBOutlet UIImageView *imgFemale;
@property (weak,nonatomic) IBOutlet UITextField *txtEmail;
@property (weak,nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak,nonatomic) IBOutlet UITextField *txtLastName;
@property (weak,nonatomic) IBOutlet UITextField *txtPassword;
@property (weak,nonatomic) IBOutlet UITextField *txtConfirmPassword;
@property (weak,nonatomic) IBOutlet UITextField *txtCollege;
@property (weak,nonatomic) IBOutlet UITextField *txtprofession;
@property (weak,nonatomic) IBOutlet UITextField *txtDOB;
@property (weak,nonatomic) IBOutlet UIScrollView *scrl;

@property (weak,nonatomic) IBOutlet UIView *myDatePickerView;
@property (weak,nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak,nonatomic) IBOutlet UIButton *btnSignUp;

@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UILabel *lblSignUp;
@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UILabel *lblMale;
@property (strong, nonatomic) IBOutlet UILabel *lblFemale;

@property (weak, nonatomic) IBOutlet UILabel *lblTermsAndConditions;
@property (weak, nonatomic) IBOutlet UIButton *btnTermsAndConditions;
@property (weak, nonatomic) IBOutlet UIImageView *imgAccepted;
@property (weak, nonatomic) IBOutlet UIView *vwTermsAndconditions;
@property (weak, nonatomic) IBOutlet UIView *vwCheckBox;
@property (weak, nonatomic) IBOutlet UIView *vwSignUp;
@property (weak, nonatomic) IBOutlet UIView *vwInputs;
@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;

@property (weak, nonatomic) IBOutlet UIView *vwForSize;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgFname;
@property (weak, nonatomic) IBOutlet UIImageView *imgLname;
@property (weak, nonatomic) IBOutlet UIImageView *imgClg;
@property (weak, nonatomic) IBOutlet UIImageView *imgProf;
@property (weak, nonatomic) IBOutlet UIImageView *imgAge;
@property (weak, nonatomic) IBOutlet UIImageView *imgPass1;
@property (weak, nonatomic) IBOutlet UIImageView *imgPass2;
@property (weak, nonatomic) IBOutlet UIView *vwFemale;
@property (weak, nonatomic) IBOutlet UIView *vwMale;

@property (weak,nonatomic) IBOutlet UIView *vwPopup;
@property(weak,nonatomic) IBOutlet UILabel *lblEnterCode;
@property(weak,nonatomic) IBOutlet UITextField *txtVarificationCode;
@property(weak,nonatomic) IBOutlet UIButton *btnOk;

@end

@implementation SignUpVC
{
    NSArray *_pickerData;
    NSString *selectedpickerdata;
    
    NSString *mylatitude;
    NSString *mylongitude;
    
    BOOL isAccepted;
  
    NSString *gender;
    BOOL rtlNotSet;
    
    BOOL varified;
    NSString *strCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    varified  = NO;
    strCode = [[NSString alloc] init];
    
    isAccepted=NO;
    rtlNotSet = YES;
    
    mylatitude=@"00";
    mylongitude=@"00";
    [LocationHelper sharedInstance].delegate=self;
    [[LocationHelper sharedInstance] updateLocation];
    
    
    UIColor *color = [UIColor whiteColor];
    UIFont *font=[UIFont fontWithName:@"Lato-Regular" size:14];

    self.txtVarificationCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Varification Code"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    
    self.txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Email"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    self.txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Password"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    self.txtFirstName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"First Name"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    self.txtLastName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Last Name"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    self.txtCollege.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"College Name"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    self.txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Confirm Password"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    self.txtprofession.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Profession"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    self.txtDOB.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[MCLocalization stringForKey:@"Birth Date"] attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;

    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDate *date = [NSDate date];
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:unitFlags fromDate:date];
    
    [comps setYear:comps.year-18];
    
    date = [[NSCalendar currentCalendar] dateFromComponents:comps];
        //To Disable Future date :
    self.datePicker.maximumDate=date;
   
    self.scrl.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    gender=@"male";
    
//    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
//    [self.vwPopup addGestureRecognizer:singleTapGestureRecognizer];
//    UITapGestureRecognizer *singleTapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(datePickerClose:)];
//    [self.scrl addGestureRecognizer:singleTapGestureRecognizer1];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self localize];
    
    self.vwback.center = CGPointMake(30, self.lblSignUp.center.y);
    
    self.scrl.frame = CGRectMake(0, 30*SCREEN_SIZE.height/667, SCREEN_SIZE.width, SCREEN_SIZE.height-30*SCREEN_SIZE.height/667);
    self.scrl.contentSize= CGSizeMake(SCREEN_SIZE.width, 825* SCREEN_SIZE.height/667) ;
    self.scrl.contentSize= CGSizeMake(SCREEN_SIZE.width, 825* SCREEN_SIZE.height/667) ;
    
    self.vwPopup.frame = CGRectMake(0, -self.vwPopup.frame.size.height, self.vwPopup.frame.size.width, self.vwPopup.frame.size.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - TextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self datePickerClose];
}
/*!
 * @discussion For closing date picker
 */
-(void)datePickerClose {
    [UIView animateWithDuration:0.5 animations:^{
        self.myDatePickerView.frame = CGRectMake(0, SCREEN_SIZE.height, self.myDatePickerView.frame.size.width,self.myDatePickerView.frame.size.height);
    }];
}
#pragma mark - tapgesture delegate
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [UIView animateWithDuration:0.7 animations:^{
        self.vwPopup.frame=CGRectMake(0,-(self.vwPopup.frame.size.height),[UIScreen mainScreen].bounds.size.width,self.vwPopup.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - Scrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self datePickerClose];
}
#pragma mark - Location Delegate
/*!
 * @discussion Set Latitude and Longitude from delegate
 */
- (void) LocationUpdated{
    mylatitude=[LocationHelper sharedInstance].latitude;
    mylongitude=[LocationHelper sharedInstance].longitude;
    
}

#pragma mark - Button Clicked

- (IBAction)btnAleadyHaveAccountClicked:(id)sender {
for (UIViewController *controller in self.navigationController.viewControllers) {
    
    //Do not forget to import AnOldViewController.h
    if ([controller isKindOfClass:[WelcomeVC class]]) {
        
        [self.navigationController popToViewController:controller
                                              animated:YES];
        return;
    }
}
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
            
        } completion:^(BOOL finished) {
            
        }];
   // }
    
}
/*!
 * @discussion When User click on Verify code
 * @param sender For identifying sender
 */
- (IBAction)btnVerifyCodeClicked:(id)sender {
    
    //
    NSString *strEnterdcode = [[NSString alloc] init];
    strEnterdcode = self.txtVarificationCode.text;
    if(strEnterdcode.length == 4){
        [UIView animateWithDuration:0.7 animations:^{
            self.vwPopup.frame=CGRectMake(0,-(self.vwPopup.frame.size.height),[UIScreen mainScreen].bounds.size.width,self.vwPopup.frame.size.height);
        } completion:^(BOOL finished) {
            [self verifyCode];
            [self.view endEditing:YES];
        }];
    }
    else{
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
/*!
 * @discussion When User click on Accept terms and conditions
 * @param sender For identifying sender
 */
- (IBAction)btnTermsAndConditionClicked:(id)sender {
    
    if(!isAccepted){
        self.imgAccepted.image=[UIImage imageNamed:@"Check"];
        isAccepted=YES;
    }
    else{
        self.imgAccepted.image=[UIImage imageNamed:@"Uncheck"];
        isAccepted=NO;
    }
}
/*!
 * @discussion When User click sign in, Go back to Sign In Page
 * @param sender For identifying sender
 */
- (IBAction)btnSignInClicked:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    } completion:^(BOOL finished) {
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
        self.txtDOB.text=selectedpickerdata;
        
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
    } completion:^(BOOL finished) {
        
    }];
}
/*!
 * @discussion When SignUp is Clicked, Check all validation and call webservice if everything is fine
 * @param sender For identifying sender
 */
- (IBAction)btnSignUpClicked:(id)sender
{
    NSString *strEmail = [self.txtEmail.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (strEmail.length>0)
    {
        if ([Util ValidateEmailString:strEmail])
        {
            NSString *strFName = [self.txtFirstName.text stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if(strFName.length >0)
            {
                
                NSString *strLName = [self.txtLastName.text stringByTrimmingCharactersInSet:
                                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if(strLName.length >0)
                {
                    NSString *strCollege = [self.txtCollege.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if(strCollege.length>0){
                        NSString *strProfession = [self.txtprofession.text stringByTrimmingCharactersInSet:
                                                [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        if(strProfession.length>0){
                            NSString *str = [self.txtPassword.text stringByTrimmingCharactersInSet:
                                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            if(str.length >0)
                            {
                                if(str.length < 6){
                                    ALERTVIEW([MCLocalization stringForKey:@"Your password is too short. Enter password containing atlest 6 characters"], self);
                                }
                                else{
                                    if(self.txtConfirmPassword.text.length >0)
                                    {
                                        if([self.txtPassword.text isEqualToString:self.txtConfirmPassword.text]){
                                            
                                            if(self.txtDOB.text.length>0){
                                                if(isAccepted){
                                                    
                                                    //call api for generating code
                                                    [self verifyEmail];
//                                                    if(varified){
//                                                        [self RegisterUser];
//                                                    }
//                                                    else{
//                                                        ALERTVIEW([MCLocalization stringForKey:@"Please varify your email to Continue Sign Up."], self);
//                                                    }
                                                }
                                                else{
                                                    ALERTVIEW([MCLocalization stringForKey:@"Please Agree Terms & Agreements and Privacy Policy to Continue Sign Up."], self);
                                                }
                                                
                                            }
                                            else{
                                                ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Birth Date."], self);
                                            }
                                            
                                            
                                        }
                                        else{
                                            ALERTVIEW([MCLocalization stringForKey:@"Your Password and Confirm Password do not match."], self);
                                        }
                                    }
                                    else{
                                        ALERTVIEW([MCLocalization stringForKey:@"Please Confirm Your Password."], self);
                                    }
                                }
                                
                            }
                            else{
                                ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Password."], self);
                            }
                        }
                        else{
                            ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Profession."], self);
                        }
                    }
                    else{
                        ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your College Name."], self);
                    }
                    
                }
                else{
                    ALERTVIEW([MCLocalization stringForKey:@"Please Enter Your Last Name."], self);
                }
            }
            else{
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
/*!
 * @discussion When Male is selected for Gender
 * @param sender For identifying sender
 */
- (IBAction)btnMaleClicked:(id)sender {
    gender=@"male";
    self.imgMale.image=[UIImage imageNamed:@"FilledCircle"];
    self.imgFemale.image=[UIImage imageNamed:@"UntickCircle"];
}
/*!
 * @discussion When Female is selected for Gender
 * @param sender For identifying sender
 */
- (IBAction)btnFemaleClicked:(id)sender {
    gender=@"female";
    self.imgMale.image=[UIImage imageNamed:@"UntickCircle"];
    self.imgFemale.image=[UIImage imageNamed:@"FilledCircle"];
}
/*!
 * @discussion When User Clicks Terms and Agreements
 * @param sender For identifying sender
 */
- (IBAction)btnOpenTermsAndConditions:(id)sender {
    
    WebViewVC *vc=[[WebViewVC alloc ] initWithNibName:@"WebViewVC" bundle:nil];

    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Api Calls
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
                     
                     [self RegisterUser];
                     
                     //                     }
                     
                     
                     
                 }else{
                     //(//                     else{
                                                 ALERTVIEW([MCLocalization stringForKey:@"Invalid verification code! Try again!"], self);
                        //                     }

//                     ALERTVIEW([MCLocalization stringForKey:@"Something Went Wrong, Please Try Again."], self);
                 }
                 self.txtVarificationCode.text = @"";
             }];
             
         }
     }];
}
/*!
 * @discussion Web service call for register user
 */
-(void)RegisterUser
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
             NSString *str=@"register";
             
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[self.txtFirstName.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"fname"];
             [dict setValue:[self.txtLastName.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"lname"];
             [dict setValue:[self.txtEmail.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"email"];
             [dict setValue:self.txtPassword.text forKey:@"password"];
             if([self.txtDOB.text isEqualToString:@""]){
                 [dict setValue:@"-" forKey:@"dob"];
             }
             else{
                 [dict setValue:self.txtDOB.text forKey:@"dob"];
             }
             if([self.txtCollege.text isEqualToString:@""]){
                 [dict setValue:@"-" forKey:@"education"];
             }
             else{
                 [dict setValue:self.txtCollege.text forKey:@"education"];
             }
             if([self.txtprofession.text isEqualToString:@""]){
                 [dict setValue:@"-" forKey:@"profession"];
             }
             else{
                 [dict setValue:self.txtprofession.text forKey:@"profession"];
             }
             [dict setValue:@"About me" forKey:@"about"];
             [dict setValue:@"1,2,3,4" forKey:@"date_pref"];
             [dict setValue:gender forKey:@"gender"];
            
             if([gender isEqualToString:@"female"]){
                 [dict setValue:@"male" forKey:@"gender_pref"];
             }
             else{
                 [dict setValue:@"female" forKey:@"gender_pref"];
             }
             
             [dict setValue:@"18" forKey:@"min_age_pref"];//default value
             [dict setValue:@"60" forKey:@"max_age_pref"];//default value
             [dict setValue:@"0" forKey:@"min_dist_pref"];//default value
             [dict setValue:@"200" forKey:@"max_dist_pref"];//default value
             [dict setValue:mylatitude forKey:@"location_lat"];
             [dict setValue:mylongitude forKey:@"location_long"];
             [dict setValue:@"1" forKey:@"access_location"];//default value
             [dict setValue:@"0" forKey:@"status"];//default value
             [dict setValue:@"5'0 (152 cm)" forKey:@"height"];//default value
             [dict setValue:@"0" forKey:@"religion"];//default value
             [dict setValue:@"0" forKey:@"ethnicity"];//default value
             [dict setValue:@"None" forKey:@"kids"];//default value
             [dict setValue:@"1" forKey:@"que_id"];//default value
             [dict setValue:@"ANSWER" forKey:@"que_ans"];//default value
             //device token
             [dict setValue:[appDelegate GetData:kdeviceToken]  forKey:@"device_token"];
             
             NSData *tempData=[[NSData alloc] init];
             [dict setValue:tempData forKey:@"profile_image"];
             [dict setValue:kdevice forKey:@"device"];
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             
            [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary)
             {
                 HIDE_PROGRESS;
                 if(success && [[dictionary valueForKey:@"message"] isEqualToString:@"Email Already Exist"] )
                 {
                     ALERTVIEW([MCLocalization stringForKey:@"This Email Already Exists. Please Enter Different Email or Login with Email."], self);
                     self.btnSignUp.enabled=YES;
                 }
                 else if(success && [[dictionary valueForKey:@"error"] intValue]==0)
                 {
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"age"] value:kAge];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"lname"] value:kLname];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"fname"] value:kUserName];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"id"] value:kuserid];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"AuthToken"] value:kauthToken];
                     [appDelegate SetData:[[dictionary valueForKey:@"body"] valueForKey:@"gender_pref"] value:kgenderPref];
                     
                     [appDelegate SetData:gender value:kGender];
                     
                     [appDelegate SetData:[[dictionary valueForKey:@"body"]valueForKey:@"ejuser"] value:kejID];
                     [appDelegate SetData:@"00" value:klatitude];
                     [appDelegate SetData:@"00" value:klongitude];
                  
                     [[ApiManager sharedInstance] RegisterLoginXMPP];
                     [appDelegate SetData:@"DetailsSignUp" value:@"Page"];
                     DetailsSignUpVC *vc=[[DetailsSignUpVC alloc]initWithNibName:@"DetailsSignUpVC" bundle:nil];
                     [self.navigationController pushViewController:vc animated:YES];
                 }
                 else
                 {
                     ALERTVIEW([dictionary valueForKey:@"message"], self);
                 }
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
    self.lblSignUp.text=[MCLocalization stringForKey:@"SIGN UP"];
    
    self.lblMale.text=[MCLocalization stringForKey:@"Male"];
    self.lblFemale.text=[MCLocalization stringForKey:@"Female"];
    
    [self.btnCancel setTitle:[MCLocalization stringForKey:@"Cancel"] forState:UIControlStateNormal];
    [self.btnDone setTitle:[MCLocalization stringForKey:@"Done"] forState:UIControlStateNormal];
    [self.btnSignUp setTitle:[MCLocalization stringForKey:@"SIGN UP"] forState:UIControlStateNormal];
    [self.btnSignIn setTitle:[MCLocalization stringForKey:@"Already have an account? Tap to Login"] forState:UIControlStateNormal];
   
    [self.btnVerify setTitle:[MCLocalization stringForKey:@"Verify your email"] forState:UIControlStateNormal];
    [self.btnVerify sizeToFit];
    CGRect rect = self.btnVerify.frame;
    rect.origin.x = self.vwForSize.frame.origin.x + self.vwForSize.frame.size.width - rect.size.width ;
    self.btnVerify.frame = rect;
    
    self.lblTermsAndConditions.lineBreakMode=NSLineBreakByWordWrapping;
    self.lblTermsAndConditions.numberOfLines = 0;
    
    NSString *str=[MCLocalization stringForKey:@"I agree to the Terms & Agreements and Privacy Policy"];
    self.lblTermsAndConditions.text=str;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:  self.lblTermsAndConditions.attributedText];
    NSString *str1=[MCLocalization stringForKey:@"Terms & Agreements"];
    NSRange range = [str rangeOfString:str1];
    [text addAttribute:NSForegroundColorAttributeName
                 value:Theme_Color
                 range:range];

    
    NSRange range1 = [str rangeOfString:[MCLocalization stringForKey:@"Privacy Policy"]];
    [text addAttribute:NSForegroundColorAttributeName
                 value:Theme_Color
                 range:range1];
    
    [self.lblTermsAndConditions setAttributedText: text];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        Float32 temp = self.lblTermsAndConditions.frame.size.width;
        
        [self.lblTermsAndConditions sizeToFit];

        self.lblTermsAndConditions.frame = CGRectMake(self.lblTermsAndConditions.frame.origin.x, self.lblTermsAndConditions.frame.origin.y, temp, self.lblTermsAndConditions.frame.size.height);
    
    if (self.btnTermsAndConditions.frame.size.height>40)
    {
            self.btnTermsAndConditions.frame = CGRectMake(self.btnTermsAndConditions.frame.origin.x,self.btnTermsAndConditions.frame.origin.y, self.btnTermsAndConditions.frame.size.width, self.lblTermsAndConditions.frame.size.height+10);
        self.vwTermsAndconditions.frame = CGRectMake(self.vwTermsAndconditions.frame.origin.x, self.vwTermsAndconditions.frame.origin.y, self.vwTermsAndconditions.frame.size.width, self.btnTermsAndConditions.frame.size.height+self.btnTermsAndConditions.frame.origin.y+5);
        self.btnTermsAndConditions.frame = CGRectMake(self.btnTermsAndConditions.frame.origin.x, (self.btnTermsAndConditions.frame.size.height-self.btnTermsAndConditions.frame.size.height)/2, self.btnTermsAndConditions.frame.size.width, self.btnTermsAndConditions.frame.size.width);
    }
    else
    {
        self.btnTermsAndConditions.frame=CGRectMake(self.btnTermsAndConditions.frame.origin.x, self.btnTermsAndConditions.frame.origin.y, self.btnTermsAndConditions.frame.size.width,40);
        self.vwTermsAndconditions.frame=CGRectMake(self.vwTermsAndconditions.frame.origin.x, self.vwTermsAndconditions.frame.origin.y, self.vwTermsAndconditions.frame.size.width, 50);
        self.btnTermsAndConditions.frame=CGRectMake(self.btnTermsAndConditions.frame.origin.x, (self.btnTermsAndConditions.frame.size.height-self.btnTermsAndConditions.frame.size.height)/2, self.btnTermsAndConditions.frame.size.width, self.btnTermsAndConditions.frame.size.width);

    }
        self.vwInputs.frame=CGRectMake(self.vwInputs.frame.origin.x, self.vwInputs.frame.origin.y, self.vwInputs.frame.size.width, self.vwTermsAndconditions.frame.origin.y+self.vwTermsAndconditions.frame.size.height+8+30*SCREEN_SIZE.height/667);
        self.vwSignUp.frame=CGRectMake(self.vwSignUp.frame.origin.x, self.vwInputs.frame.origin.y+self.vwInputs.frame.size.height, self.vwSignUp.frame.size.width, 110*SCREEN_SIZE.height/667);
        self.scrl.contentSize=CGSizeMake(self.scrl.frame.size.width, self.vwSignUp.frame.origin.y+self.vwSignUp.frame.size.height);
    });

    [self.lblSignUp sizeToFit];
    self.lblSignUp.frame = CGRectMake((SCREEN_SIZE.width - self.lblSignUp.frame.size.width)/2 , self.lblSignUp.frame.origin.y, self.lblSignUp.frame.size.width, self.lblSignUp.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblSignUp.frame.origin.x, self.lblSignUp.frame.origin.y+self.lblSignUp.frame.size.height+3, self.lblSignUp.frame.size.width, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
    if(rtlNotSet && [[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self setRTL];
    }
    
    ///
    [self.btnOk setTitle:[MCLocalization stringForKey:@"OK"] forState:UIControlStateNormal];
    self.lblEnterCode.text = [MCLocalization stringForKey:@"Enter varification code"];
    
}

/*!
 * @discussion set RTL UI
 */
- (void)setRTL{
    rtlNotSet = false;
    
    self.txtEmail.textAlignment = NSTextAlignmentRight;
    self.txtFirstName.textAlignment = NSTextAlignmentRight;
    self.txtLastName.textAlignment = NSTextAlignmentRight;
    self.txtCollege.textAlignment = NSTextAlignmentRight;
    self.txtprofession.textAlignment = NSTextAlignmentRight;
    self.txtDOB.textAlignment = NSTextAlignmentRight;
    self.txtPassword.textAlignment = NSTextAlignmentRight;
    self.txtConfirmPassword.textAlignment = NSTextAlignmentRight;
    self.lblFemale.textAlignment = NSTextAlignmentRight;
    self.lblMale.textAlignment = NSTextAlignmentRight;
    
    self.lblTermsAndConditions.textAlignment = NSTextAlignmentRight;
    
    
    CGRect tempFrame = self.imgEmail.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgEmail.frame = tempFrame ;
    tempFrame = self.txtEmail.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.txtEmail.frame = tempFrame ;
    
    tempFrame = self.imgFname.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgFname.frame = tempFrame ;
    tempFrame = self.txtFirstName.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.txtFirstName.frame = tempFrame ;
    
    tempFrame = self.imgLname.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgLname.frame = tempFrame ;
    tempFrame = self.txtLastName.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.txtLastName.frame = tempFrame ;
    
    tempFrame = self.imgClg.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgClg.frame = tempFrame ;
    tempFrame = self.txtCollege.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.txtCollege.frame = tempFrame ;
    
    tempFrame = self.imgProf.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgProf.frame = tempFrame ;
    tempFrame = self.txtprofession.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.txtprofession.frame = tempFrame ;
    
    tempFrame = self.imgAge.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgAge.frame = tempFrame ;
    tempFrame = self.txtDOB.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.txtDOB.frame = tempFrame ;
    
    tempFrame = self.imgPass1.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgPass1.frame = tempFrame ;
    tempFrame = self.txtPassword.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.txtPassword.frame = tempFrame ;
    
    tempFrame = self.imgPass2.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgPass2.frame = tempFrame ;
    tempFrame = self.txtConfirmPassword.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.txtConfirmPassword.frame = tempFrame ;
    
    tempFrame = self.imgMale.frame;
    tempFrame.origin.x = self.vwMale.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgMale.frame = tempFrame ;
    tempFrame = self.lblMale.frame;
    tempFrame.origin.x = self.vwMale.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.lblMale.frame = tempFrame ;
    tempFrame = self.imgFemale.frame;
    tempFrame.origin.x = self.vwFemale.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.imgFemale.frame = tempFrame ;
    tempFrame = self.lblFemale.frame;
    tempFrame.origin.x = self.vwMale.frame.size.width - tempFrame.origin.x - tempFrame.size.width;
    self.lblFemale.frame = tempFrame ;
    tempFrame = self.vwMale.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.vwMale.frame = tempFrame ;
    tempFrame = self.vwFemale.frame;
    tempFrame.origin.x = self.vwForSize.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.vwFemale.frame = tempFrame ;
    
    tempFrame = self.vwCheckBox.frame;
    tempFrame.origin.x = self.vwTermsAndconditions.frame.size.width - tempFrame.origin.x - tempFrame.size.width ;
    self.vwCheckBox.frame = tempFrame ;
    tempFrame = self.lblTermsAndConditions.frame;
    tempFrame.origin.x = 5 * SCREEN_SIZE.width/375;
    self.lblTermsAndConditions.frame = tempFrame ;
    self.btnTermsAndConditions.frame = tempFrame;
    self.imgAccepted.transform = CGAffineTransformMakeScale(-1, 1);
    
    self.btnVerify.titleLabel.textAlignment = NSTextAlignmentLeft;
    tempFrame = self.btnVerify.frame;
    tempFrame.origin.x = self.vwTermsAndconditions.frame.origin.x  ;
    self.btnVerify.frame = tempFrame ;
    
}
@end



