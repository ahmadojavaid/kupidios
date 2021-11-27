//
//  DatePreferencesVC.m
//  CupidLove
//
//  Created by Umesh on 11/11/16.
//  Copyright © 2016 Umesh. All rights reserved.
//

#import "DatePreferencesVC.h"
#import "DiscoveryPreferencesVC.h"
#import "IQKeyboardManager.h"
#import <QuartzCore/QuartzCore.h>


@interface DatePreferencesVC () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *vwInfo;

@property (weak, nonatomic) IBOutlet UIView *vwAboutMe;

@property (strong, nonatomic) IBOutlet UIView *viewScroll;
@property (strong,nonatomic) IBOutlet UIButton *btnBack;
@property (strong,nonatomic) IBOutlet UIImageView *imgBack;

@property (strong, nonatomic) IBOutlet UIView *viewCoffee;
@property (strong, nonatomic) IBOutlet UIView *viewDrink;
@property (strong, nonatomic) IBOutlet UIView *viewFood;
@property (strong, nonatomic) IBOutlet UIView *viewFun;

@property (strong, nonatomic) IBOutlet UIView *viewCoffeeInitial;
@property (strong, nonatomic) IBOutlet UIView *viewDrinkInitial;
@property (strong, nonatomic) IBOutlet UIView *viewFoodInitial;
@property (strong, nonatomic) IBOutlet UIView *viewFunInitial;

@property (strong, nonatomic) IBOutlet UIView *viewOne;
@property (strong, nonatomic) IBOutlet UIView *viewTwo;
@property (strong, nonatomic) IBOutlet UIView *viewThree;
@property (strong, nonatomic) IBOutlet UIView *viewFour;

@property (strong, nonatomic) IBOutlet UILabel *lblCoffee;
@property (strong, nonatomic) IBOutlet UILabel *lblDrink;
@property (strong, nonatomic) IBOutlet UILabel *lblFood;
@property (strong, nonatomic) IBOutlet UILabel *lblFun;

@property (strong, nonatomic) IBOutlet UILabel *lblOne;
@property (strong, nonatomic) IBOutlet UILabel *lblTwo;
@property (strong, nonatomic) IBOutlet UILabel *lblThree;
@property (strong, nonatomic) IBOutlet UILabel *lblFour;

@property (strong,nonatomic) IBOutlet UIView *preferenceView;
@property (strong,nonatomic) IBOutlet UITextView *txtAboutMe;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UILabel *lblAboutMe;

@property (strong, nonatomic) IBOutlet UILabel *lblInfo;
@property (strong, nonatomic) IBOutlet UIImageView *imgIconInfo;

@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblAboutUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;

@property(weak,nonatomic) IBOutlet UIView *vwBack;
@property (weak,nonatomic) IBOutlet UIView *vwTitle;
@end

@implementation DatePreferencesVC
{
    CGPoint centreCoffee,centreDrink,centreFood,centreFun;
    CGRect rectCoffee,rectDrink,rectFood,rectFun;
    int set, tapCoffee, tapDrink, tapFood, tapFun;
    
    NSArray *pref;
    
    BOOL first,flag_back ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    UIColor *underline_color = [UIColor whiteColor];
    
    self.lblAboutUnderline.backgroundColor = underline_color;
    
    self.txtAboutMe.delegate=self;
    
    Boolean flag_left;
    flag_left = true;
    
    if([[appDelegate GetData:@"flagBack"] isEqualToString:@"hide"]){
        //hide back button
        self.vwBack.hidden = YES;
        flag_left = false;
    }
    else{
        flag_left = true;
    }
 
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    
    //corner radius to all views..
    self.viewCoffee.layer.cornerRadius = self.viewCoffee.frame.size.height/2.5;
    self.viewDrink.layer.cornerRadius = self.viewDrink.frame.size.height/2.5;
    self.viewFood.layer.cornerRadius = self.viewFood.frame.size.height/2.5;
    self.viewFun.layer.cornerRadius = self.viewFun.frame.size.height/2.5;
    
    self.viewCoffee.layer.masksToBounds = YES;
    self.viewDrink.layer.masksToBounds = YES;
    self.viewFood.layer.masksToBounds = YES;
    self.viewFun.layer.masksToBounds = YES;
    
    self.viewCoffee.tag = 101;
    self.viewDrink.tag = 102;
    self.viewFood.tag = 103;
    self.viewFun.tag = 104;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    self.lblOne.text = @"";
    self.lblTwo.text = @"";
    self.lblThree.text = @"";
    self.lblFour.text = @"";
   
    first = YES;
}
-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.viewOne.frame = CGRectMake(self.viewOne.frame.origin.x, self.viewOne.frame.origin.y, self.viewCoffee.frame.size.width, self.viewCoffee.frame.size.height);
    self.viewTwo.frame = CGRectMake(self.viewTwo.frame.origin.x, self.viewTwo.frame.origin.y, self.viewCoffee.frame.size.width, self.viewCoffee.frame.size.height);
    self.viewThree.frame = CGRectMake(self.viewThree.frame.origin.x, self.viewThree.frame.origin.y, self.viewCoffee.frame.size.width, self.viewCoffee.frame.size.height);
    self.viewFour.frame = CGRectMake(self.viewFour.frame.origin.x, self.viewFour.frame.origin.y, self.viewCoffee.frame.size.width, self.viewCoffee.frame.size.height);
    
    [self localize];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    self.vwTitle.hidden = NO;
    
    if(![[appDelegate GetData:kdatePref] isEqualToString:@"Key Not Found"]){
        pref = [[appDelegate GetData:kdatePref] componentsSeparatedByString:@","];
        
        if([pref count]==4){
            self.lblCoffee.hidden = YES;
            self.lblDrink.hidden = YES;
            self.lblFood.hidden = YES;
            self.lblFun.hidden = YES;
            
            dispatch_async(dispatch_get_main_queue(), ^{

                
            
            int pref_one=[[pref objectAtIndex:0] intValue];
            int pref_two=[[pref objectAtIndex:1] intValue];
            int pref_three=[[pref objectAtIndex:2] intValue];
            int pref_four=[[pref objectAtIndex:3] intValue];
            switch (pref_one) {
                case 1:
                    self.viewCoffee.frame = self.viewOne.frame;
                    self.lblOne.text=[MCLocalization stringForKey:@"Coffee"];
                    break;
                case 2:
                    self.viewDrink.frame = self.viewOne.frame;
                    self.lblOne.text=[MCLocalization stringForKey:@"Drink"];
                    break;
                case 3:
                    self.viewFood.frame = self.viewOne.frame;
                    
                    self.lblOne.text=[MCLocalization stringForKey:@"Food"];
                    break;
                case 4:
                    self.viewFun.frame = self.viewOne.frame;
                    self.lblOne.text=[MCLocalization stringForKey:@"Fun"];
                    break;
                default:
                    break;
            }
            switch (pref_two) {
                case 1:
                    self.viewCoffee.frame = self.viewTwo.frame;
                    self.lblTwo.text=[MCLocalization stringForKey:@"Coffee"];
                    break;
                case 2:
                    self.viewDrink.frame = self.viewTwo.frame;
                    self.lblTwo.text=[MCLocalization stringForKey:@"Drink"];
                    break;
                case 3:
                    self.viewFood.frame = self.viewTwo.frame;
                    self.lblTwo.text=[MCLocalization stringForKey:@"Food"];
                    break;
                case 4:
                    self.viewFun.frame = self.viewTwo.frame;
                    self.lblTwo.text=[MCLocalization stringForKey:@"Fun"];
                    break;
                default:
                    break;
            }
            switch (pref_three) {
                case 1:
                    self.viewCoffee.frame = self.viewThree.frame;
                    self.lblThree.text=[MCLocalization stringForKey:@"Coffee"];
                    break;
                case 2:
                    self.viewDrink.frame = self.viewThree.frame;
                    self.lblThree.text=[MCLocalization stringForKey:@"Drink"];
                    break;
                case 3:
                    self.viewFood.frame = self.viewThree.frame;
                    self.lblThree.text=[MCLocalization stringForKey:@"Food"];
                    break;
                case 4:
                    self.viewFun.frame = self.viewThree.frame;
                    self.lblThree.text=[MCLocalization stringForKey:@"Fun"];
                    break;
                default:
                    break;
            }
            switch (pref_four) {
                case 1:
                    self.viewCoffee.frame = self.viewFour.frame;
                    self.lblFour.text=[MCLocalization stringForKey:@"Coffee"];
                    break;
                case 2:
                    self.viewDrink.frame = self.viewFour.frame;
                    self.lblFour.text=[MCLocalization stringForKey:@"Drink"];
                    break;
                case 3:
                    self.viewFood.frame = self.viewFour.frame;
                    self.lblFour.text=[MCLocalization stringForKey:@"Food"];
                    break;
                case 4:
                    self.viewFun.frame = self.viewFour.frame;
                    self.lblFour.text=[MCLocalization stringForKey:@"Fun"];
                    break;
                default:
                    break;
            }
                 [self setRect1];
                });
           
            if(first){
                NSMutableSet *views = [[NSMutableSet alloc] init];
                [views addObject: self.viewCoffee];
                [views addObject: self.viewDrink];
                [views addObject: self.viewFood];
                [views addObject: self.viewFun];
                for(UIView *view in views)
                {
                    UIPanGestureRecognizer *panGestureRecognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer1:)];
                    [view addGestureRecognizer:panGestureRecognizer1];
                }
                first = NO;
            }
        }
    }
    
    else{
        self.lblCoffee.hidden = NO;
        self.lblDrink.hidden = NO;
        self.lblFood.hidden = NO;
        self.lblFun.hidden = NO;
        if(first){
            NSMutableSet *views = [[NSMutableSet alloc] init];
            [views addObject: self.viewCoffee];
            [views addObject: self.viewDrink];
            [views addObject: self.viewFood];
            [views addObject: self.viewFun];
            for(UIView *view in views)
            {
                UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
                [view addGestureRecognizer:panGestureRecognizer];
            }
            first = NO;
        }
        [self setRect];
    }
    
    CGRect temp = self.viewCoffeeInitial.frame;
    temp.size.height = temp.size.width;
    self.viewCoffeeInitial.frame = temp;
    temp.origin.x = self.viewDrinkInitial.frame.origin.x;
    self.viewDrinkInitial.frame = temp;
    temp.origin.x = self.viewFoodInitial.frame.origin.x;
    self.viewFoodInitial.frame = temp;
    temp.origin.x = self.viewFunInitial.frame.origin.x;
    self.viewFunInitial.frame = temp;
    
   
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"\n=======Frames=========\nviewOne=%@\nviewTwo=%@\nviewThree=%@\nviewFour=%@\n\nviewCoffee=%@\nviewDrink=%@\nviewFood=%@\nviewFun%@\n\nviewCoffeeInitial=%@\nviewDrinkInitial=%@\nviewFoodInitial=%@\nviewFunInitial%@\n\nrectCoffee=%@\nrectDrink=%@\nrectFood=%@\nrectFun%@", NSStringFromCGRect(self.viewOne.frame),NSStringFromCGRect(self.viewTwo.frame),NSStringFromCGRect(self.viewThree.frame),NSStringFromCGRect(self.viewFour.frame),NSStringFromCGRect(self.viewCoffee.frame),NSStringFromCGRect(self.viewDrink.frame),NSStringFromCGRect(self.viewFood.frame),NSStringFromCGRect(self.viewFun.frame),NSStringFromCGRect(self.viewCoffeeInitial.frame),NSStringFromCGRect(self.viewDrinkInitial.frame),NSStringFromCGRect(self.viewFoodInitial.frame),NSStringFromCGRect(self.viewFunInitial.frame),NSStringFromCGRect(rectCoffee),NSStringFromCGRect(rectDrink),NSStringFromCGRect(rectFood),NSStringFromCGRect(rectFun));
        
    });
}

/*!
 * @discussion Set frame of date preferences views
 */
-(void)setRect {
    
    rectCoffee = CGRectMake(self.viewCoffeeInitial.frame.origin.x,self.viewCoffeeInitial.frame.origin.y,self.viewCoffeeInitial.frame.size.width,self.viewCoffeeInitial.frame.size.height);
    rectDrink = CGRectMake(self.viewDrinkInitial.frame.origin.x,self.viewDrinkInitial.frame.origin.y,self.viewDrinkInitial.frame.size.width,self.viewDrinkInitial.frame.size.height);
    rectFood = CGRectMake(self.viewFoodInitial.frame.origin.x,self.viewFoodInitial.frame.origin.y,self.viewFoodInitial.frame.size.width,self.viewFoodInitial.frame.size.height);
    rectFun = CGRectMake(self.viewFunInitial.frame.origin.x,self.viewFunInitial.frame.origin.y,self.viewFunInitial.frame.size.width,self.viewFunInitial.frame.size.height);
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    self.vwTitle.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - PanGesture recorgniser for swipe

-(void)moveViewWithGestureRecognizer1:(UIPanGestureRecognizer *)panGestureRecognizer
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
            
            [self swipeFrames1:point];
            if(set==0)
            {
                [self afterSwipeAction1:vw];
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
-(void)setRect1{
    
    centreCoffee = self.viewCoffee.center;
    centreDrink = self.viewDrink.center;
    centreFood = self.viewFood.center;
    centreFun = self.viewFun.center;
    
    rectCoffee = CGRectMake(self.viewCoffee.frame.origin.x,self.viewCoffee.frame.origin.y,self.viewCoffee.frame.size.width,self.viewCoffee.frame.size.height);
    rectDrink = CGRectMake(self.viewDrink.frame.origin.x,self.viewDrink.frame.origin.y,self.viewDrink.frame.size.width,self.viewDrink.frame.size.height);
    rectFood = CGRectMake(self.viewFood.frame.origin.x,self.viewFood.frame.origin.y,self.viewFood.frame.size.width,self.viewFood.frame.size.height);
    rectFun = CGRectMake(self.viewFun.frame.origin.x,self.viewFun.frame.origin.y,self.viewFun.frame.size.width,self.viewFun.frame.size.height);
}

/*!
 * @discussion Called after views are swiped
 * @param vw set frame of vw
 */
- (void)afterSwipeAction1:(UIView*)vw
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
-(void)swipeFrames1:(CGPoint)point{
    if(CGPointEqualToPoint(point, self.viewCoffee.center))
    {
        if(CGRectContainsPoint(rectDrink, point))
        {
            self.viewCoffee.center=self.viewDrink.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewDrink.center = centreCoffee;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewCoffee];
            [self makeFrameOfView1:_viewDrink];
        }
        else if(CGRectContainsPoint(rectFood, point))
        {
            self.viewCoffee.center=self.viewFood.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewFood.center = centreCoffee;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewCoffee];
            [self makeFrameOfView1:_viewFood];
        }
        else if(CGRectContainsPoint(rectFun, point))
        {
            self.viewCoffee.center=self.viewFun.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewFun.center = centreCoffee;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewCoffee];
            [self makeFrameOfView1:_viewFun];
        }
    }
    
    if(CGPointEqualToPoint(point, self.viewDrink.center))
    {
        if(CGRectContainsPoint(rectCoffee, point))
        {
            self.viewDrink.center=self.viewCoffee.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewCoffee.center = centreDrink;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewDrink];
            [self makeFrameOfView1:_viewCoffee];
        }
        else if(CGRectContainsPoint(rectFood, point))
        {
            self.viewDrink.center=self.viewFood.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewFood.center = centreDrink;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewDrink];
            [self makeFrameOfView1:_viewFood];
        }
        else if(CGRectContainsPoint(rectFun, point))
        {
            self.viewDrink.center=self.viewFun.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewFun.center = centreDrink;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewDrink];
            [self makeFrameOfView1:_viewFun];
        }
    }
    
    if(CGPointEqualToPoint(point, self.viewFood.center))
    {
        if(CGRectContainsPoint(rectCoffee, point))
        {
            self.viewFood.center=self.viewCoffee.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewCoffee.center = centreFood;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewFood];
            [self makeFrameOfView1:_viewCoffee];
        }
        else if(CGRectContainsPoint(rectDrink, point))
        {
            self.viewFood.center=self.viewDrink.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewDrink.center = centreFood;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewDrink];
            [self makeFrameOfView1:_viewFood];
        }
        else if(CGRectContainsPoint(rectFun, point))
        {
            self.viewFood.center=self.viewFun.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewFun.center = centreFood;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewFood];
            [self makeFrameOfView1:_viewFun];
        }
    }
    
    if(CGPointEqualToPoint(point, self.viewFun.center))
    {
        if(CGRectContainsPoint(rectCoffee, point))
        {
            self.viewFun.center=self.viewCoffee.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewCoffee.center = centreFun;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewFun];
            [self makeFrameOfView1:_viewCoffee];
        }
        else if(CGRectContainsPoint(rectDrink, point))
        {
            self.viewFun.center=self.viewDrink.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewDrink.center = centreFun;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewFun];
            [self makeFrameOfView1:_viewDrink];
        }
        else if(CGRectContainsPoint(rectFood, point))
        {
            self.viewFun.center=self.viewFood.center;
            [UIView animateWithDuration:0.5 animations:^{self.viewFood.center = centreFun;} completion:^(BOOL finished){[self changeLabelValue1];}];
            set=1;
            
            [self makeFrameOfView1:_viewFun];
            [self makeFrameOfView1:_viewFood];
        }
    }
}
/*!
 * @discussion Set frame of view and set it to desired place
 * @param view View whose frame is setting
 */
-(void)makeFrameOfView1:(UIView*)view
{
    if(view==self.viewCoffee)
    {
        rectCoffee = CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
        centreCoffee=view.center;
    } else if(view==self.viewDrink)
    {
        rectDrink = CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
        centreDrink=view.center;
    } else if(view==self.viewFood)
    {
        rectFood = CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
        centreFood=view.center;
    } else if(view==self.viewFun)
    {
        rectFun = CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
        centreFun=view.center;
    }
}
/*!
 * @discussion Change date preference lables' text
 */
-(void)changeLabelValue1{
    if(CGPointEqualToPoint(self.viewOne.center, self.viewCoffee.center))
    {
        _lblOne.text=[MCLocalization stringForKey:@"Coffee"];
    } if(CGPointEqualToPoint(self.viewOne.center, self.viewDrink.center))
    {
        _lblOne.text=[MCLocalization stringForKey:@"Drink"];
    } if(CGPointEqualToPoint(self.viewOne.center, self.viewFood.center))
    {
        _lblOne.text=[MCLocalization stringForKey:@"Food"];
    } if(CGPointEqualToPoint(self.viewOne.center, self.viewFun.center))
    {
        _lblOne.text=[MCLocalization stringForKey:@"Fun"];
    }
    
    if(CGPointEqualToPoint(self.viewTwo.center, self.viewCoffee.center))
    {
        _lblTwo.text=[MCLocalization stringForKey:@"Coffee"];
    } if(CGPointEqualToPoint(self.viewTwo.center, self.viewDrink.center))
    {
        _lblTwo.text=[MCLocalization stringForKey:@"Drink"];
    } if(CGPointEqualToPoint(self.viewTwo.center, self.viewFood.center))
    {
        _lblTwo.text=[MCLocalization stringForKey:@"Food"];
    } if(CGPointEqualToPoint(self.viewTwo.center, self.viewFun.center))
    {
        _lblTwo.text=[MCLocalization stringForKey:@"Fun"];
    }
    
    if(CGPointEqualToPoint(self.viewThree.center, self.viewCoffee.center))
    {
        _lblThree.text=[MCLocalization stringForKey:@"Coffee"];
    } if(CGPointEqualToPoint(self.viewThree.center, self.viewDrink.center))
    {
        _lblThree.text=[MCLocalization stringForKey:@"Drink"];
    }  if(CGPointEqualToPoint(self.viewThree.center, self.viewFood.center))
    {
        _lblThree.text=[MCLocalization stringForKey:@"Food"];
    } if(CGPointEqualToPoint(self.viewThree.center, self.viewFun.center))
    {
        _lblThree.text=[MCLocalization stringForKey:@"Fun"];
    }
    
    if(CGPointEqualToPoint(self.viewFour.center, self.viewCoffee.center))
    {
        _lblFour.text=[MCLocalization stringForKey:@"Coffee"];
    } if(CGPointEqualToPoint(self.viewFour.center, self.viewDrink.center))
    {
        _lblFour.text=[MCLocalization stringForKey:@"Drink"];
    } if(CGPointEqualToPoint(self.viewFour.center, self.viewFood.center))
    {
        _lblFour.text=[MCLocalization stringForKey:@"Food"];
    } if(CGPointEqualToPoint(self.viewFour.center, self.viewFun.center))
    {
        _lblFour.text=[MCLocalization stringForKey:@"Fun"];
    }
}

#pragma mark- Drag Delegate

/*!
 * @discussion Move items
 * @param panGestureRecognizer Identify guesture
 */
-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    UIView *vw = (UIView *)panGestureRecognizer.view;
    vw.center = CGPointMake(vw.center.x + translation.x, vw.center.y + translation.y);
    [panGestureRecognizer setTranslation:CGPointZero inView:vw];
    
    [self.preferenceView bringSubviewToFront:vw];
    
    tapCoffee=0;
    tapDrink=0;
    tapFood=0;
    tapFun=0;
    
    [self lblChangeToNULL];
    
    //checks what state the gesture is in. (are you just starting, letting go, or in the middle of a swipe?)
    switch (panGestureRecognizer.state) {
            // just started swiping
        case UIGestureRecognizerStateBegan:break;
        case UIGestureRecognizerStateChanged:break;
            // let go of the card
        case UIGestureRecognizerStateEnded: {
            if (vw.tag == self.viewCoffee.tag)
            {
                tapCoffee=1;
                CGPoint point = self.viewCoffee.center;
                [self DropView:point view:self.viewCoffee];
            }
            else if (vw.tag == self.viewDrink.tag)
            {
                tapDrink=1;
                CGPoint point = self.viewDrink.center;
                [self DropView:point view:self.viewDrink];
            }
            else if (vw.tag == self.viewFood.tag)
            {
                tapFood=1;
                CGPoint point = self.viewFood.center;
                [self DropView:point view:self.viewFood];
            }
            else if (vw.tag == self.viewFun.tag)
            {
                tapFun=1;
                CGPoint point = self.viewFun.center;
                [self DropView:point view:self.viewFun];
            }
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
 * @discussion after swipe action
 * @param vw Identify view
 */
- (void)afterSwipeAction:(UIView*) vw
{
    if (vw.tag == self.viewCoffee.tag)
    {
        [UIView animateWithDuration:0.4 animations:^{self.viewCoffee.frame=rectCoffee;} completion:^(BOOL finished) {
            self.lblCoffee.hidden = NO;
        }];
        
    }
    else if (vw.tag == self.viewDrink.tag)
    {
        [UIView animateWithDuration:0.4 animations:^{self.viewDrink.frame=rectDrink;} completion:^(BOOL finished){
            self.lblDrink.hidden = NO;
        }];
    }
    else if (vw.tag == self.viewFood.tag)
    {
        [UIView animateWithDuration:0.4 animations:^{self.viewFood.frame=rectFood;} completion:^(BOOL finished){
            self.lblFood.hidden = NO;
        }];
    }
    else if (vw.tag == self.viewFun.tag)
    {
        [UIView animateWithDuration:0.4 animations:^{self.viewFun.frame=rectFun;} completion:^(BOOL finished){        self.lblFun.hidden = NO;
        }];
    }
}

/*!
 * @discussion Drop view
 * @param point Point- where to drop
 * @param view1 Identify view
 */
-(void)DropView:(CGPoint)point view:(UIView *)view1
{
    CGRect rectOne = CGRectMake(self.viewOne.frame.origin.x, self.viewOne.frame.origin.y, self.viewOne.frame.size.width, self.viewOne.frame.size.height);
    CGRect rectTwo = CGRectMake(self.viewTwo.frame.origin.x, self.viewTwo.frame.origin.y, self.viewTwo.frame.size.width, self.viewTwo.frame.size.height);
    CGRect rectThree = CGRectMake(self.viewThree.frame.origin.x, self.viewThree.frame.origin.y, self.viewThree.frame.size.width, self.viewThree.frame.size.height);
    CGRect rectFour = CGRectMake(self.viewFour.frame.origin.x, self.viewFour.frame.origin.y, self.viewFour.frame.size.width, self.viewFour.frame.size.height);
    set=0;
    if (CGRectContainsPoint(rectOne, point))
    {
        view1.center = self.viewOne.center;
        [self shiftViews:view1];
        view1.center = self.viewOne.center;
        [self setLabel];
        set=1;
    }
    else if(CGRectContainsPoint(rectTwo, point))
    {
        view1.center = self.viewTwo.center;
        [self shiftViews:view1];
        view1.center = self.viewTwo.center;
        [self setLabel];
        set=1;
    }
    else if(CGRectContainsPoint(rectThree, point))
    {
        view1.center = self.viewThree.center;
        [self shiftViews:view1];
        view1.center = self.viewThree.center;
        [self setLabel];
        set=1;
    }
    else if(CGRectContainsPoint(rectFour, point))
    {
        view1.center = self.viewFour.center;
        [self shiftViews:view1];
        view1.center = self.viewFour.center;
        [self setLabel];
        set=1;
    }
}
/*!
 * @discussion Shift viewes
 * @param view1 Identify view
 */
-(void)shiftViews :(UIView *) view1
{
    
    if(CGPointEqualToPoint(view1.center, self.viewCoffee.center))
    {
        if(CGPointEqualToPoint(self.viewCoffee.center, self.viewDrink.center))
        {
            if(tapDrink==0)
            {
                [UIView animateWithDuration:0.4 animations:^{self.viewDrink.frame=rectDrink;} completion:^(BOOL finishsed){self.lblDrink.hidden = NO;}];
            }
        }
        else if(CGPointEqualToPoint(self.viewCoffee.center, self.viewFood.center))
        {
            if(tapFood==0)
            {
                [UIView animateWithDuration:0.4 animations:^{self.viewFood.frame=rectFood;} completion:^(BOOL finishsed){self.lblFood.hidden = NO;}];
            }
        }
        else if(CGPointEqualToPoint(self.viewCoffee.center, self.viewFun.center))
        {
            if(tapFun==0)
            {
                [UIView animateWithDuration:0.4 animations:^{self.viewFun.frame=rectFun;} completion:^(BOOL finishsed){self.lblFun.hidden = NO;}];
            }
        }
        if(tapCoffee==0)
        {
            [UIView animateWithDuration:0.4 animations:^{self.viewCoffee.frame = rectCoffee;} completion:^(BOOL finishsed){self.lblCoffee.hidden = NO;}];
        }
    }
    else if(CGPointEqualToPoint(view1.center, self.viewDrink.center))
    {
        if(CGPointEqualToPoint(self.viewDrink.center, self.viewFood.center))
        {
            if(tapFood==0)
            {
                [UIView animateWithDuration:0.4 animations:^{self.viewFood.frame=rectFood;} completion:^(BOOL finishsed){self.lblFood.hidden = NO;}];
            }
        }
        else if(CGPointEqualToPoint(self.viewDrink.center, self.viewFun.center))
        {
            if(tapFun==0)
            {
                [UIView animateWithDuration:0.4 animations:^{self.viewFun.frame=rectFun;} completion:^(BOOL finishsed){self.lblFun.hidden = NO;}];
            }
        }
        if(tapDrink==0)
        {
            [UIView animateWithDuration:0.4 animations:^{self.viewDrink.frame = rectDrink;} completion:^(BOOL finishsed){self.lblDrink.hidden = NO;}];
        }
    }
    else if(CGPointEqualToPoint(view1.center, self.viewFood.center))
    {
        if(CGPointEqualToPoint(self.viewFood.center, self.viewFun.center))
        {
            if(tapFun==0)
            {
                [UIView animateWithDuration:0.4 animations:^{self.viewFun.frame=rectFun;} completion:^(BOOL finishsed){self.lblFun.hidden = NO;}];
            }
        }
        if(tapFood==0)
        {
            [UIView animateWithDuration:0.4 animations:^{self.viewFood.frame = rectFood;} completion:^(BOOL finishsed){self.lblFood.hidden = NO;}];
        }
    }
    else if(CGPointEqualToPoint(view1.center, self.viewFun.center))
    {
        if(tapFun==0)
        {
            [UIView animateWithDuration:0.4 animations:^{self.viewFun.frame = rectFun;} completion:^(BOOL finishsed){self.lblFun.hidden = NO;}];
        }
    }
}
/*!
 * @discussion Set text of preferences
 */
-(void)setLabel{
    if(CGPointEqualToPoint(self.viewOne.center,self.viewCoffee.center))
    {
        self.lblOne.text=[MCLocalization stringForKey:@"Coffee"];
        self.lblCoffee.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewOne.center,self.viewDrink.center))
    {
        self.lblOne.text=[MCLocalization stringForKey:@"Drink"];
        self.lblDrink.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewOne.center,self.viewFood.center))
    {
        self.lblOne.text=[MCLocalization stringForKey:@"Food"];
        self.lblFood.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewOne.center,self.viewFun.center))
    {
        self.lblOne.text=[MCLocalization stringForKey:@"Fun"];
        self.lblFun.hidden = YES;
    } else {
        self.lblOne.text=@"";
    }
    
    if(CGPointEqualToPoint(self.viewTwo.center,self.viewCoffee.center))
    {
        self.lblTwo.text=[MCLocalization stringForKey:@"Coffee"];
        self.lblCoffee.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewTwo.center,self.viewDrink.center))
    {
        self.lblTwo.text=[MCLocalization stringForKey:@"Drink"];
        self.lblDrink.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewTwo.center,self.viewFood.center))
    {
        self.lblTwo.text=[MCLocalization stringForKey:@"Food"];
        self.lblFood.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewTwo.center,self.viewFun.center))
    {
        self.lblTwo.text=[MCLocalization stringForKey:@"Fun"];
        self.lblFun.hidden = YES;
    } else {
        self.lblTwo.text = @"";
    }
    
    if(CGPointEqualToPoint(self.viewThree.center,self.viewCoffee.center))
    {
        self.lblThree.text=[MCLocalization stringForKey:@"Coffee"];
        self.lblCoffee.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewThree.center,self.viewDrink.center))
    {
        self.lblThree.text=[MCLocalization stringForKey:@"Drink"];
        self.lblDrink.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewThree.center,self.viewFood.center))
    {
        self.lblThree.text=[MCLocalization stringForKey:@"Food"];
        self.lblFood.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewThree.center,self.viewFun.center))
    {
        self.lblThree.text=[MCLocalization stringForKey:@"Fun"];
        self.lblFun.hidden = YES;
    } else {
        self.lblThree.text = @"";
    }
    
    if(CGPointEqualToPoint(self.viewFour.center,self.viewCoffee.center))
    {
        self.lblFour.text=[MCLocalization stringForKey:@"Coffee"];
        self.lblCoffee.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewFour.center,self.viewDrink.center))
    {
        self.lblFour.text=[MCLocalization stringForKey:@"Drink"];
        self.lblDrink.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewFour.center,self.viewFood.center))
    {
        self.lblFour.text=[MCLocalization stringForKey:@"Food"];
        self.lblFood.hidden = YES;
    } else if(CGPointEqualToPoint(self.viewFour.center,self.viewFun.center))
    {
        self.lblFour.text=[MCLocalization stringForKey:@"Fun"];
        self.lblFun.hidden = YES;
    } else {
        self.lblFour.text = @"";
    }
}

/*!
 * @discussion Change label value to null
 */
-(void)lblChangeToNULL{
    if (CGRectContainsPoint(self.viewOne.frame,self.viewCoffee.center))
    {   }
    else if (CGRectContainsPoint(self.viewOne.frame,self.viewDrink.center))
    {   }
    else if (CGRectContainsPoint(self.viewOne.frame,self.viewFood.center))
    {   }
    else if (CGRectContainsPoint(self.viewOne.frame,self.viewFun.center))
    {   }
    else {
        self.lblOne.text = @"";
    }
    
    if (CGRectContainsPoint(self.viewTwo.frame,self.viewCoffee.center))
    {   }
    else if (CGRectContainsPoint(self.viewTwo.frame,self.viewDrink.center))
    {   }
    else if (CGRectContainsPoint(self.viewTwo.frame,self.viewFood.center))
    {   }
    else if (CGRectContainsPoint(self.viewTwo.frame,self.viewFun.center))
    {   }
    else {
        self.lblTwo.text = @"";
    }
    
    if (CGRectContainsPoint(self.viewThree.frame,self.viewCoffee.center))
    {   }
    else if (CGRectContainsPoint(self.viewThree.frame,self.viewDrink.center))
    {   }
    else if (CGRectContainsPoint(self.viewThree.frame,self.viewFood.center))
    {   }
    else if (CGRectContainsPoint(self.viewThree.frame,self.viewFun.center))
    {   }
    else {
        self.lblThree.text = @"";
    }
    
    if (CGRectContainsPoint(self.viewFour.frame,self.viewCoffee.center))
    {   }
    else if (CGRectContainsPoint(self.viewFour.frame,self.viewDrink.center))
    {   }
    else if (CGRectContainsPoint(self.viewFour.frame,self.viewFood.center))
    {   }
    else if (CGRectContainsPoint(self.viewFour.frame,self.viewFun.center))
    {   }
    else {
        self.lblFour.text = @"";
    }
}

#pragma mark - Button Clicked
/*!
 * @discussion Called when done button clicked
 * @param sender For indentifying sender
 */
- (IBAction)btnDoneClicked:(id)sender
{
    
   // if([[appDelegate GetData:kdatePref] isEqualToString:@"Key Not Found"]){
    
    [self.txtAboutMe resignFirstResponder];
    
    if(CGPointEqualToPoint(self.viewOne.center,self.viewCoffee.center) || CGPointEqualToPoint(self.viewOne.center,self.viewDrink.center) || CGPointEqualToPoint(self.viewOne.center,self.viewFood.center) || CGPointEqualToPoint(self.viewOne.center,self.viewFun.center)){
        
    }else{
        ALERTVIEW([MCLocalization stringForKey:@"please set all the preferences"], self);
        return;
    }
    
    if(CGPointEqualToPoint(self.viewTwo.center,self.viewCoffee.center) || CGPointEqualToPoint(self.viewTwo.center,self.viewDrink.center) || CGPointEqualToPoint(self.viewTwo.center,self.viewFood.center) || CGPointEqualToPoint(self.viewTwo.center,self.viewFun.center)){
        
    }else{
        ALERTVIEW([MCLocalization stringForKey:@"please set all the preferences"], self);
        return;
    }
    
    if(CGPointEqualToPoint(self.viewThree.center,self.viewCoffee.center) || CGPointEqualToPoint(self.viewThree.center,self.viewDrink.center) || CGPointEqualToPoint(self.viewThree.center,self.viewFood.center) || CGPointEqualToPoint(self.viewThree.center,self.viewFun.center)){
        
    }else{
        ALERTVIEW([MCLocalization stringForKey:@"please set all the preferences"], self);
        return;
    }
    
    if(CGPointEqualToPoint(self.viewFour.center,self.viewCoffee.center) || CGPointEqualToPoint(self.viewFour.center,self.viewDrink.center) || CGPointEqualToPoint(self.viewFour.center,self.viewFood.center) || CGPointEqualToPoint(self.viewFour.center,self.viewFun.center)){
        
    }else{
        ALERTVIEW([MCLocalization stringForKey:@"please set all the preferences"], self);
        return;
    }
    
    //}
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
    if([self.lblTwo.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]){
        datePref=[NSString stringWithFormat:@"%@,1",datePref];
    }
    else if([self.lblTwo.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]){
        datePref=[NSString stringWithFormat:@"%@,2",datePref];
    }
    else if([self.lblTwo.text isEqualToString:[MCLocalization stringForKey:@"Food"]]){
        datePref=[NSString stringWithFormat:@"%@,3",datePref];
    }
    else{
        datePref=[NSString stringWithFormat:@"%@,4",datePref];;
    }
    if([self.lblThree.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]){
        datePref=[NSString stringWithFormat:@"%@,1",datePref];
    }
    else if([self.lblThree.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]){
        datePref=[NSString stringWithFormat:@"%@,2",datePref];
    }
    else if([self.lblThree.text isEqualToString:[MCLocalization stringForKey:@"Food"]]){
        datePref=[NSString stringWithFormat:@"%@,3",datePref];
    }
    else{
        datePref=[NSString stringWithFormat:@"%@,4",datePref];;
    }
    if([self.lblFour.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]){
        datePref=[NSString stringWithFormat:@"%@,1",datePref];
    }
    else if([self.lblFour.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]){
        datePref=[NSString stringWithFormat:@"%@,2",datePref];
    }
    else if([self.lblFour.text isEqualToString:[MCLocalization stringForKey:@"Food"]]){
        datePref=[NSString stringWithFormat:@"%@,3",datePref];
    }
    else{
        datePref=[NSString stringWithFormat:@"%@,4",datePref];;
    }
    
    if(([[self.txtAboutMe.text stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0 ) && (![self.txtAboutMe.text isEqualToString:[MCLocalization stringForKey:@"Tap to write about me.."]])){
        
        [self updateDatePerf];
        
    }
    else{
        ALERTVIEW([MCLocalization stringForKey:@"Please Enter Something About You. "], self);
    }
}
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
 * @discussion Called when keyboard will show: Display keyboard with animation
 * @param notification Default parameter
 */
- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.view.frame=CGRectMake(0,SCREEN_SIZE.height-(kbSize.height+self.view.frame.size.height),SCREEN_SIZE.width,self.view.frame.size.height);
}
/*!
 * @discussion Called when keyboard will hie: Hide keyboard with animation
 * @param notification Default parameter
 */
- (void)keyboardWillHide:(NSNotification*)notification {
    self.view.frame=CGRectMake(0,SCREEN_SIZE.height-(self.view.frame.size.height),SCREEN_SIZE.width,self.view.frame.size.height);
}
#pragma textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([self.txtAboutMe.text isEqualToString: [MCLocalization stringForKey:@"Tap to write about me.."]]) {
        [self.txtAboutMe setText:@""];
    }
    
}
-(void) textViewDidEndEditing:(UITextView *)textView{
    NSString *str = [self.txtAboutMe.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str isEqualToString: @""] || str.length == 0 ) {
        [self.txtAboutMe setText:[MCLocalization stringForKey:@"Tap to write about me.."]];
    }
    else{
        if(str.length > 500){
            self.txtAboutMe.text = [str substringToIndex:500];
            ALERTVIEW([MCLocalization stringForKey:@"Your about me discription is too long. Enter about me discription containing maximum 500 characters"], self);
        }
    }
}

#pragma mark - Api Calls
/*!
 * @discussion Web service call for update preferences
 */
-(void) updateDatePerf
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
             if([self.lblTwo.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]){
                 datePref=[NSString stringWithFormat:@"%@,1",datePref];
             }
             else if([self.lblTwo.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]){
                 datePref=[NSString stringWithFormat:@"%@,2",datePref];
             }
             else if([self.lblTwo.text isEqualToString:[MCLocalization stringForKey:@"Food"]]){
                 datePref=[NSString stringWithFormat:@"%@,3",datePref];
             }
             else{
                 datePref=[NSString stringWithFormat:@"%@,4",datePref];
             }
             if([self.lblThree.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]){
                 datePref=[NSString stringWithFormat:@"%@,1",datePref];
             }
             else if([self.lblThree.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]){
                 datePref=[NSString stringWithFormat:@"%@,2",datePref];
             }
             else if([self.lblThree.text isEqualToString:[MCLocalization stringForKey:@"Food"]]){
                 datePref=[NSString stringWithFormat:@"%@,3",datePref];
             }
             else{
                 datePref=[NSString stringWithFormat:@"%@,4",datePref];
             }
             if([self.lblFour.text isEqualToString:[MCLocalization stringForKey:@"Coffee"]]){
                 datePref=[NSString stringWithFormat:@"%@,1",datePref];
             }
             else if([self.lblFour.text isEqualToString:[MCLocalization stringForKey:@"Drink"]]){
                 datePref=[NSString stringWithFormat:@"%@,2",datePref];
             }
             else if([self.lblFour.text isEqualToString:[MCLocalization stringForKey:@"Food"]]){
                 datePref=[NSString stringWithFormat:@"%@,3",datePref];
             }
             else{
                 datePref=[NSString stringWithFormat:@"%@,4",datePref];;
             }
             
             NSString *str=@"userPrefencesUpdate";
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:[appDelegate GetData:kgenderPref] forKey:@"gender_pref"];
             [dict setValue:@"18" forKey:@"min_age_pref"];//default value
             [dict setValue:@"60" forKey:@"max_age_pref"];//default value
             [dict setValue:datePref forKey:@"date_pref"];
             [dict setValue:@"0" forKey:@"min_dist_pref"];//default value
             [dict setValue:@"200" forKey:@"max_dist_pref"];//default value
             [dict setValue:[self.txtAboutMe.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"about"];
             
             
             [dict setValue:[appDelegate GetData:kheight] forKey:@"height"];
             [dict setValue:[appDelegate GetData:kreligion] forKey:@"religion"];
             [dict setValue:[appDelegate GetData:kethnicity] forKey:@"ethnicity"];
             [dict setValue:[appDelegate GetData:kno_of_kids] forKey:@"kids"];
             [dict setValue:[appDelegate GetData:kquestionID] forKey:@"que_id"];
             [dict setValue:[appDelegate GetData:kanswer] forKey:@"que_ans"];

             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                 
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     ////////////
                     first = true;
                     NSMutableSet *views = [[NSMutableSet alloc] init];
                     [views addObject: self.viewCoffee];
                     [views addObject: self.viewDrink];
                     [views addObject: self.viewFood];
                     [views addObject: self.viewFun];
                     for(UIView *view in views)
                     {
                         UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
                         UIPanGestureRecognizer *panGestureRecognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer1:)];
                         [view removeGestureRecognizer:panGestureRecognizer];
                         [view removeGestureRecognizer:panGestureRecognizer1];
                     }
                     flag_back = true;
                     ////////////
                     [appDelegate SetData:datePref value:kdatePref];
                     [appDelegate SetData:[self.txtAboutMe.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kabout];
                     [appDelegate SetData:@"DiscPref" value:@"Page"];
                     [appDelegate RemoveData:@"flagBack"];
                     DiscoveryPreferencesVC *vc=[[DiscoveryPreferencesVC alloc] initWithNibName:@"DiscoveryPreferencesVC" bundle:nil];
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
    self.lblTitle.text=[MCLocalization stringForKey:@"DATE PREFERENCE"];
    self.lblFun.text=[MCLocalization stringForKey:@"Fun"];
    self.lblFood.text=[MCLocalization stringForKey:@"Food"];
    self.lblDrink.text=[MCLocalization stringForKey:@"Drink"];
    self.lblCoffee.text=[MCLocalization stringForKey:@"Coffee"];
    self.lblAboutMe.text=[MCLocalization stringForKey:@"About Me"];
    self.lblInfo.text=[MCLocalization stringForKey:@"Drag & arrange your prefered dating options"];
    [self.lblInfo sizeToFit];
    
    if(self.lblInfo.frame.size.width > (SCREEN_SIZE.width - 30*SCREEN_SIZE.width/375)){
        self.lblInfo.frame=CGRectMake(self.lblInfo.frame.origin.x, self.lblInfo.frame.origin.y, SCREEN_SIZE.width - 30*SCREEN_SIZE.width/375, self.lblInfo.frame.size.height);
    }
    
    CGRect temp = self.vwInfo.frame;
    temp.size.width = self.lblInfo.frame.origin.x + self.lblInfo.frame.size.width;
    temp.origin.x = (SCREEN_SIZE.width - temp.size.width)/2 ;
    self.vwInfo.frame = temp;
    
    [self.txtAboutMe setText:[MCLocalization stringForKey:@"Tap to write about me.."]];
    if(![[appDelegate GetData:kabout] isEqualToString:@"Key Not Found"]){
        [self.txtAboutMe setText:[appDelegate GetData:kabout]];
    }
    
    [self.btnDone setTitle:[MCLocalization stringForKey:@"DONE"] forState:UIControlStateNormal];
   
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    
    [self.lblAboutMe sizeToFit];
    self.lblAboutUnderline.frame=CGRectMake(self.lblAboutMe.frame.origin.x, self.lblAboutUnderline.frame.origin.y, self.lblAboutMe.frame.size.width, 1);
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
    if([[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self setRTL];
    }
}
/*!
 * @discussion set RTL UI
 */
- (void)setRTL{
    
    
     self.lblInfo.frame = CGRectMake(34 * SCREEN_SIZE.width/375, (self.vwInfo.frame.origin.y - self.lblInfo.frame.size.height)/2, self.lblInfo.frame.size.width, self.lblInfo.frame.size.height);
    self.lblAboutMe.frame = CGRectMake(16 * SCREEN_SIZE.width/375, self.lblAboutMe.frame.origin.y, self.lblAboutMe.frame.size.width, self.lblAboutMe.frame.size.height);
    self.lblAboutUnderline.frame = CGRectMake(self.lblAboutMe.frame.origin.x, self.lblAboutUnderline.frame.origin.y, self.lblAboutMe.frame.size.width, 1);
    self.txtAboutMe.frame=CGRectMake(15 * SCREEN_SIZE.width/375, self.txtAboutMe.frame.origin.y, self.txtAboutMe.frame.size.width, self.txtAboutMe.frame.size.height);
    
    
}
/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.vwInfo setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblInfo setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.vwAboutMe setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lblAboutMe setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtAboutMe setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.txtAboutMe.textAlignment = NSTextAlignmentRight;
}

@end
