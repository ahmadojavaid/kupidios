//
//  DetailsSignUpVC.m
//  CupidLove
//
//  Created by APPLE on 16/01/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "DetailsSignUpVC.h"
#import "NumbersCell.h"
#import "ImageUploadVC.h"
#import "KTCenterFlowLayout.h"

@interface DetailsSignUpVC ()
@property(weak,nonatomic) IBOutlet UIImageView *imgTitleUnderline;
@property (weak,nonatomic) IBOutlet UIView *lastView;
@property (strong,nonatomic) IBOutlet UIPickerView *pickerHeight;

@property (weak,nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak,nonatomic) IBOutlet UITextView *txtAnswer;
@property (weak, nonatomic) IBOutlet UILabel *lblline;

@property (weak,nonatomic) IBOutlet UIScrollView *scrl;

@property (strong,nonatomic) IBOutlet UIImageView *imgNotSay1;
@property (strong,nonatomic) IBOutlet UIImageView *imgNotSay2;
//no of childern
@property(weak,nonatomic) IBOutlet UICollectionView *collNumbers;

@property (strong,nonatomic) IBOutlet UIImageView *imgNextArrow;
@property (strong,nonatomic) IBOutlet UIImageView *imgPrevArrow;
@property (strong,nonatomic) IBOutlet UIImageView *imgNone;
@property (strong,nonatomic) IBOutlet UIImageView *imgOneday;
@property (strong,nonatomic) IBOutlet UIImageView *imgDontwant;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblHeight;
@property (strong, nonatomic) IBOutlet UILabel *lblAlwaysVisible;
@property (strong, nonatomic) IBOutlet UILabel *lblReligion;
@property (strong, nonatomic) IBOutlet UILabel *lblNotPrefertosay1;
@property (strong, nonatomic) IBOutlet UILabel *lblEthnicity;
@property (strong, nonatomic) IBOutlet UILabel *lblNotPrefertosay2;
@property (strong, nonatomic) IBOutlet UILabel *lblKids;
@property (strong, nonatomic) IBOutlet UILabel *lblNone;
@property (strong, nonatomic) IBOutlet UILabel *lblOneDay;
@property (strong, nonatomic) IBOutlet UILabel *lblDontWantKids;
@property (strong, nonatomic) IBOutlet UIButton *btnNone;
@property (strong, nonatomic) IBOutlet UIButton *btnOneDay;
@property (strong, nonatomic) IBOutlet UIButton *btnDontwantKids;
@property (strong, nonatomic) IBOutlet UILabel *lblQuotes;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

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

@property(weak,nonatomic) IBOutlet UILabel *lblTitleUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblHeightUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblReligionUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblEthnicityUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblKidsUnderline;
@property(weak,nonatomic) IBOutlet UILabel *lblQuoteUnderline;
@property(weak,nonatomic) IBOutlet UIImageView *imgVerticalline;

@property (weak,nonatomic) IBOutlet UIView *vwTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imgCircle1;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle2;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle3;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle4;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircle5;
@property (weak, nonatomic) IBOutlet UIView *vwKidsScrl;
@property (weak, nonatomic) IBOutlet UILabel *lblInfoQuote;
@end

@implementation DetailsSignUpVC{
    
    NSArray *pickerArray;
    NSInteger quesIndex;
    NSMutableArray *arrQuestions;
    
    Boolean flagNotSay1;
    Boolean flagNotSay2;
    
    NSInteger noOfChildren;
    NSInteger scrollCellIndexCollectionView;
    
    Boolean flagChildrenNone;
    Boolean flagChildrenOneDay;
    Boolean flagChildrenDontWant;
    
    NSString *kids;
    NSString *height;
    NSString *religion;
    NSString *ethinicity;
    NSString *qu_id;
    
    NSMutableArray *arrEthnicity, *arrReligion, *arrReligionIDs, *arrEthnicityIDs, *arrSelectedReligionIds,*arrSelectedEthnicityIds, *arrQuestionIds;
    
    NSInteger TOTAL_QUESTIONS;
    
    UIColor *bgDeselect,*bgSelect;
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if( [[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self transforms];
    }
    
    TOTAL_QUESTIONS=25;
    
    bgDeselect=[UIColor lightTextColor];
    bgSelect=Theme_Color;
    UIColor *underline_color = [UIColor whiteColor];
    
    self.lblTitleUnderline.backgroundColor = underline_color;
 
    self.lblHeightUnderline.backgroundColor = underline_color;
    self.lblReligionUnderline.backgroundColor = underline_color;
    self.lblEthnicityUnderline.backgroundColor = underline_color;
    self.lblKidsUnderline.backgroundColor = underline_color;
    self.lblQuoteUnderline.backgroundColor = underline_color;
    
    arrReligion=[[NSMutableArray alloc] init];
    arrEthnicity=[[NSMutableArray alloc] init];
    
    arrReligionIDs=[[NSMutableArray alloc] init];
    arrEthnicityIDs=[[NSMutableArray alloc] init];
    
    arrQuestionIds=[[NSMutableArray alloc] init];
    qu_id=@"1";
    
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

    

    kids=[[NSString alloc]init];
    height=[[NSString alloc] init];
    religion=[[NSString alloc]init];
    ethinicity=[[NSString alloc] init];
    pickerArray = [[NSArray alloc]initWithObjects:@"3'0 (92 cm)",
                            @"3'1 (94 cm)",@"3'2 (97 cm)",@"3'3 (99 cm)",@"3'4 (102 cm)",@"3'5 (104 cm)",@"3'6 (107 cm)",@"3'7 (109 cm)",@"3'8 (112 cm)",@"3'9 (114 cm)",@"3'10 (117 cm)",@"3'11 (119 cm)",@"4'0 (122 cm)",@"4'1 (125 cm)",@"4'2 (127 cm)",@"4'3 (130 cm)",@"4'4 (132 cm)",@"4'5 (135 cm)",@"4'6 (137 cm)",@"4'7 (140 cm)",@"4'8 (142 cm)",@"4'9 (145 cm)",@"4'10 (147 cm)",@"4'11 (150 cm)",@"5'0 (152 cm)",@"5'1 (155 cm)",@"5'2 (158 cm)",@"5'3 (160 cm)",@"5'4 (163 cm)",@"5'5 (165 cm)",@"5'6 (168 cm)",@"5'7 (170 cm)",@"5'8 (173 cm)",@"5'9 (175 cm)",@"5'10 (178 cm)",@"5'11 (180 cm)",@"6'0 (183 cm)",@"6'1 (185 cm)",@"6'2 (188 cm)",@"6'3 (191 cm)",@"6'4 (193 cm)",@"6'5 (196 cm)",@"6'6 (198 cm)",@"6'7 (201 cm)",@"6'8 (203 cm)",@"6'9 (206 cm)",@"6'10 (208 cm)",@"6'11 (211 cm)",@"7'0 (213 cm)", nil];
    
    self.pickerHeight.delegate=self;
    self.pickerHeight.dataSource=self;
    self.pickerHeight.showsSelectionIndicator=YES;
    
    //questions
    quesIndex=0;
    arrQuestions=[[NSMutableArray alloc] init];
    
    self.lblQuestion.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblQuestion.numberOfLines = 0;
    scrollCellIndexCollectionView=3;
    
    if ([[appDelegate GetData:kGender] isEqualToString:@"male"]) {
        //select row
        [self.pickerHeight selectRow:34 inComponent:0 animated:YES];
        height=@"5'10 (178 cm)";
    } else {
        //select row
        [self.pickerHeight selectRow:25 inComponent:0 animated:YES];
        height=@"5'1 (155 cm)";
    }

    //for no of childerns
    [self.collNumbers registerNib:[UINib nibWithNibName:@"NumbersCell" bundle:nil] forCellWithReuseIdentifier:@"NumbersCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(42*SCREEN_SIZE.width/320, 42* SCREEN_SIZE.width/320)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collNumbers setCollectionViewLayout:flowLayout];
    self.collNumbers.scrollEnabled=NO;
    [self getEthnicityAndReligionAndQuestions];
    
    
    
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.lastView.frame.size.height+self.lastView.frame.origin.y);
    [self localize];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    self.vwTitle.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;
}
/*!
 * @discussion Setup Ui
 */
-(void) setFrames{
    
    
    self.colReligion.frame=CGRectMake(self.colReligion.frame.origin.x, self.colReligion.frame.origin.y, self.colReligion.frame.size.width, 40*(ceil(arrReligion.count/3.0)));
    self.vwReligion.frame=CGRectMake(self.vwReligion.frame.origin.x, self.vwReligion.frame.origin.y, self.vwReligion.frame.size.width, self.colReligion.frame.size.height+self.colReligion.frame.origin.y+15);
    
    self.colEthnicity.frame=CGRectMake(self.colEthnicity.frame.origin.x, self.colEthnicity.frame.origin.y, self.colEthnicity.frame.size.width, 40*(ceil(arrEthnicity.count/2.0)));
    self.vwEthnicity.frame=CGRectMake(self.vwEthnicity.frame.origin.x, self.vwReligion.frame.origin.y+self.vwReligion.frame.size.height, self.vwEthnicity.frame.size.width, self.colEthnicity.frame.size.height+self.colEthnicity.frame.origin.y+15);
    
    self.vwKids.frame=CGRectMake(self.vwKids.frame.origin.x, self.vwEthnicity.frame.origin.y+self.vwEthnicity.frame.size.height, self.vwKids.frame.size.width, self.vwKids.frame.size.height);
    self.vwQuote.frame=CGRectMake(self.vwQuote.frame.origin.x, self.vwKids.frame.origin.y+self.vwKids.frame.size.height, self.vwQuote.frame.size.width, self.vwQuote.frame.size.height);
    self.lastView.frame=CGRectMake(self.lastView.frame.origin.x, self.vwQuote.frame.origin.y+self.vwQuote.frame.size.height, self.lastView.frame.size.width, self.lastView.frame.size.height);
    
    self.lblline.frame=CGRectMake(self.lblline.frame.origin.x, self.lblline.frame.origin.y, 1, self.lastView.frame.origin.y);
    self.imgVerticalline.frame = self.lblline.frame;
    self.scrl.contentSize=CGSizeMake(SCREEN_SIZE.width, self.lastView.frame.origin.y+self.lastView.frame.size.height);
    
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

#pragma mark- collectionView delegates
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(collectionView.tag==101){
        return arrReligion.count;
    }
    else if(collectionView.tag==102){
        return arrEthnicity.count;
    }
    else{
        return 7;
    }
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *indenti=@"NumbersCell";
    NumbersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indenti forIndexPath:indexPath];
    [cell.lblNumber setFont:[UIFont fontWithName:@"Lato-Semibold" size:12]];
    
    if(collectionView.tag==101){
     
        cell.lblNumber.text = [arrReligion objectAtIndex:indexPath.row];
        
        if([arrSelectedReligionIds containsObject:[arrReligionIDs objectAtIndex:indexPath.row]]){
            cell.backgroundColor = bgSelect;
        }
        else{
            cell.backgroundColor = bgDeselect;
        }
        
    }
    else if(collectionView.tag==102){
        cell.lblNumber.text = [arrEthnicity objectAtIndex:indexPath.row];
        
        if([arrSelectedEthnicityIds containsObject:[arrEthnicityIDs objectAtIndex:indexPath.row]]){
            cell.backgroundColor = bgSelect;
        }
        else{
            cell.backgroundColor = bgDeselect;
        }
        
    }
    else{
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
    }
    
    
    return cell;
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
    }
    else{
        kids=[NSString stringWithFormat:@"%ld", indexPath.row+1 ];
        self.imgNone.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenNone=false;
        self.imgOneday.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenOneDay=false;
        self.imgDontwant.image=[UIImage imageNamed:@"UntickCircle"];
        flagChildrenDontWant=false;
        noOfChildren=indexPath.row+1;
    }
    [collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 101) {
        return CGSizeMake((collectionView.frame.size.width/3)-7, 25);
    }
    else if (collectionView.tag == 102){
        
        return CGSizeMake((collectionView.frame.size.width/2)-7, 25);
    }
    else {
        return CGSizeMake((collectionView.frame.size.width-30)/4, (collectionView.frame.size.width-30)/4);
    }
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    return layoutAttributes;
}


#pragma mark- Textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{

}
-(void) textViewDidEndEditing:(UITextView *)textView{
    [self validateAnswer:textView];
}
/*!
 * @discussion For validating profession
 * @param sender For identifying sender
 */
-(IBAction) validateAnswer:(id)sender{
    NSString *str = [self.txtAnswer.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(str.length > 100){
        self.txtAnswer.text = [str substringToIndex:100];
        ALERTVIEW([MCLocalization stringForKey:@"Your answer is too long. Enter answer containing maximum 100 characters"], self);
    }
    
}
#pragma mark -btnClicks
/*!
 * @discussion Called when previous arrow is clicked for questions
 * @param sender For identify sender
 */
- (IBAction)btnPrevQuestion:(id)sender {
    quesIndex--;
    if(quesIndex<0){
        quesIndex=TOTAL_QUESTIONS-1;
    }
    self.lblQuestion.text=[arrQuestions objectAtIndex:quesIndex];
    qu_id=[arrQuestionIds objectAtIndex:quesIndex];
    
}
/*!
 * @discussion Called when next arrow is clicked for questions
 * @param sender For identify sender
 */
- (IBAction)btnNextQuestion:(id)sender {
    quesIndex++;
    if(quesIndex == TOTAL_QUESTIONS){
        quesIndex=0;
    }

    self.lblQuestion.text=[arrQuestions objectAtIndex:quesIndex];
    qu_id=[arrQuestionIds objectAtIndex:quesIndex];
}
/*!
 * @discussion Called when none kids clicked
 * @param sender For identify sender
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
 * @discussion Called when  One Day for kids clicked
 * @param sender For identify sender
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
 * @discussion Called when don't want kids clicked
 * @param sender For identify sender
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
 * @discussion Called when previous for number of kids clicked
 * @param sender For identify sender
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
 * @discussion Called when next for number of kids clicked
 * @param sender For identify sender
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
 * @discussion Called when user click not prefer to say for religion
 * @param sender For indentify sender
 */
- (IBAction)btnNotSay1Clicked:(id)sender {
    
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
 * @discussion Called when user click not prefer to say for ethnicity
 * @param sender For indentify sender
 */
- (IBAction)btnNotSay2Clicked:(id)sender {
    
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
 * @discussion Called when Next button is clicked
 * @param sender For indentify sender
 */
- (IBAction)btnNextPageClicked:(id)sender {
    //go to image upload page
    if([kids isEqualToString:@""]){
        ALERTVIEW([MCLocalization stringForKey:@"Please select kids"], self);
    }
    else{
        
        if([[self.txtAnswer.text stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0 ){
            
            [self updateDatePerf];
        }
        else{
            ALERTVIEW([MCLocalization stringForKey:@"Please Answer any one question"], self);
        }
    }
    
}

#pragma mark - Api Calls
/*!
 * @discussion Webservice call for preferece update
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
             
             NSString *str=@"userPrefencesUpdate";
             NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
             
             [dict setValue:[appDelegate GetData:kuserid] forKey:@"id"];
             [dict setValue:[appDelegate GetData:kgenderPref] forKey:@"gender_pref"];
             [dict setValue:@"18" forKey:@"min_age_pref"];//default value
             [dict setValue:@"60" forKey:@"max_age_pref"];//default value
             [dict setValue:@"1,2,3,4" forKey:@"date_pref"];
             [dict setValue:@"0" forKey:@"min_dist_pref"];//default value
             [dict setValue:@"200" forKey:@"max_dist_pref"];//default value
             [dict setValue:@"test" forKey:@"about"];
             
             [dict setValue:height forKey:@"height"];
             if(arrSelectedReligionIds.count==0){
                 ALERTVIEW([MCLocalization stringForKey:@"Please Select Your Religion"], self);
                 HIDE_PROGRESS;
                 return;
             } else {
                 religion=[NSString stringWithFormat:@"%@",[arrSelectedReligionIds objectAtIndex:0]];
                 for(int i = 1; i < arrSelectedReligionIds.count; i++) {
                     religion = [NSString stringWithFormat:@"%@,%@",religion,[arrSelectedReligionIds objectAtIndex:i]];
                 }
             }
             [dict setValue:religion forKey:@"religion"];
             if(arrSelectedEthnicityIds.count==0) {
                 ALERTVIEW([MCLocalization stringForKey:@"Please Select Your Ethnicity"], self);
                 HIDE_PROGRESS;
                 return;
             }
             else{
                 ethinicity=[NSString stringWithFormat:@"%@",[arrSelectedEthnicityIds objectAtIndex:0]];
                 for(int i=1;i<arrSelectedEthnicityIds.count;i++) {
                     ethinicity=[NSString stringWithFormat:@"%@,%@",ethinicity,[arrSelectedEthnicityIds objectAtIndex:i]];
                 }
             }
             [dict setValue:ethinicity forKey:@"ethnicity"];
             [dict setValue:kids forKey:@"kids"];
             [dict setValue:qu_id forKey:@"que_id"];
             [dict setValue:[self.txtAnswer.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"que_ans"];
             
             NSString *_url = [NSString stringWithFormat:@"%@%@",appURL,str];
             [[ApiManager sharedInstance] apiCallWithPost:_url parameterDict:dict  CompletionBlock:^(BOOL success, NSString *message, NSDictionary *dictionary) {
                 HIDE_PROGRESS;
                
                 if(success && [[dictionary valueForKey:@"error"] intValue]==0){
                     
                     [appDelegate SetData:height value:kheight];
                     [appDelegate SetData:kids value:kno_of_kids];
                     [appDelegate SetData:religion value:kreligion];
                     [appDelegate SetData:ethinicity value:kethnicity];
                     
                     [appDelegate SetData:qu_id value:kquestionID];
                     [appDelegate SetData:[self.txtAnswer.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceAndNewlineCharacterSet]] value:kanswer];
                     
                     [appDelegate SetData:@"UploadImages" value:@"Page"];
                     [appDelegate RemoveData:@"flagBack"];
                     ImageUploadVC *vc=[[ImageUploadVC alloc]initWithNibName:@"ImageUploadVC" bundle:nil];
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
                     
                     
                     NSArray *arr=[dictionary valueForKey:@"question"];
                     for (int i=0; i<arr.count; i++)
                     {
                         NSData *data = [[[arr objectAtIndex:i] valueForKey:strSelectedLanguage] dataUsingEncoding:NSUTF16StringEncoding];
                         NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
                         [arrQuestions addObject:decodevalue];
                     }
                     TOTAL_QUESTIONS=arr.count;
                     arrQuestionIds=[[[dictionary valueForKey:@"question"] valueForKey:@"id"] mutableCopy];
                     qu_id=[arrQuestionIds objectAtIndex:0];
                     self.lblQuestion.text=[arrQuestions objectAtIndex:0];
                    
                     
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

#pragma mark - Localize Language
/*!
 * @discussion Change Language
 */
- (void)localize
{
    self.lblTitle.text=[MCLocalization stringForKey:@"MY PROFILE"];
    self.lblHeight.text=[MCLocalization stringForKey:@"Height"];
    self.lblAlwaysVisible.text=[MCLocalization stringForKey:@"Always visible"];
    self.lblReligion.text=[MCLocalization stringForKey:@"Religion"];
    self.lblNotPrefertosay1.text=[MCLocalization stringForKey:@"Prefer not to say"];
    self.lblInfoQuote.text = [MCLocalization stringForKey:@"Click on Arrows for next and previous question"];
    
    [self.lblNotPrefertosay1 sizeToFit];
    self.lblNotPrefertosay1.frame=CGRectMake(SCREEN_SIZE.width-self.lblNotPrefertosay1.frame.size.width-35*SCREEN_SIZE.width/375, self.lblNotPrefertosay1.frame.origin.y, self.lblNotPrefertosay1.frame.size.width, self.lblNotPrefertosay1.frame.size.height);
    self.imgNotSay1.frame=CGRectMake(self.lblNotPrefertosay1.frame.origin.x-self.imgNotSay1.frame.size.width-5, self.imgNotSay1.frame.origin.y, self.imgNotSay1.frame.size.width, self.imgNotSay1.frame.size.height);
    self.btnNotSay1.frame=CGRectMake(self.imgNotSay1.frame.origin.x, self.btnNotSay1.frame.origin.y, self.imgNotSay1.frame.size.width+self.lblNotPrefertosay1.frame.size.width, self.btnNotSay1.frame.size.height);
    
    self.lblEthnicity.text=[MCLocalization stringForKey:@"Ethnicity"];
    self.lblNotPrefertosay2.text=[MCLocalization stringForKey:@"Prefer not to say"];
    
    [self.lblNotPrefertosay2 sizeToFit];
    self.lblNotPrefertosay2.frame=CGRectMake(SCREEN_SIZE.width-self.lblNotPrefertosay2.frame.size.width-30*SCREEN_SIZE.width/375, self.lblNotPrefertosay2.frame.origin.y, self.lblNotPrefertosay2.frame.size.width, self.lblNotPrefertosay2.frame.size.height);
    self.imgNotSay2.frame=CGRectMake(self.lblNotPrefertosay2.frame.origin.x-self.imgNotSay2.frame.size.width-5, self.imgNotSay2.frame.origin.y, self.imgNotSay2.frame.size.width, self.imgNotSay2.frame.size.height);
    self.btnNotSay2.frame=CGRectMake(self.imgNotSay2.frame.origin.x, self.btnNotSay2.frame.origin.y, self.imgNotSay2.frame.size.width+self.lblNotPrefertosay2.frame.size.width, self.btnNotSay2.frame.size.height);
    
    
    self.lblKids.text=[MCLocalization stringForKey:@"Kids"];
    self.lblNone.text=[MCLocalization stringForKey:@"None"];
    self.lblOneDay.text=[MCLocalization stringForKey:@"One Day"];
    self.lblDontWantKids.text=[MCLocalization stringForKey:@"I Don't Want Kids"];
    
    [self.lblNone sizeToFit];
    self.btnNone.frame = CGRectMake(self.imgNone.frame.origin.x, self.lblNone.frame.origin.y, self.lblNone.frame.origin.x + self.lblNone.frame.size.width - self.imgNone.frame.origin.x, self.btnNone.frame.size.height );
    [self.lblOneDay sizeToFit];
    self.btnOneDay.frame = CGRectMake(self.imgOneday.frame.origin.x, self.lblOneDay.frame.origin.y, self.lblOneDay.frame.origin.x + self.lblOneDay.frame.size.width -self.imgOneday.frame.origin.x, self.btnOneDay.frame.size.height );
    [self.lblDontWantKids sizeToFit];
    self.btnDontwantKids.frame = CGRectMake(self.imgDontwant.frame.origin.x, self.lblDontWantKids.frame.origin.y, self.lblDontWantKids.frame.origin.x + self.lblDontWantKids.frame.size.width - self.imgDontwant.frame.origin.x, self.btnDontwantKids.frame.size.height );
    
    self.lblQuotes.text=[MCLocalization stringForKey:@"Quote"];
    
    [self.btnNext setTitle:[MCLocalization stringForKey:@"NEXT"] forState:UIControlStateNormal];
    
    [self.lblTitle sizeToFit];
    self.lblTitle.frame = CGRectMake((SCREEN_SIZE.width - self.lblTitle.frame.size.width)/2 , self.lblTitle.frame.origin.y, self.lblTitle.frame.size.width, self.lblTitle.frame.size.height);
    self.lblTitleUnderline.frame=CGRectMake(self.lblTitle.frame.origin.x, self.lblTitleUnderline.frame.origin.y, 40, 1);
    
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
    self.imgTitleUnderline.frame = self.lblTitleUnderline.frame;
    
    if( [[appDelegate GetData:krtl] isEqualToString:@"1"] ){
        [self setRTL];
    }
    
}

/*!
 * @discussion set RTL UI
 */
- (void)setRTL{
   
    float x = 40 * SCREEN_SIZE.width/375;
    
    self.lblHeightUnderline.frame = CGRectMake(x, self.lblHeightUnderline.frame.origin.y, self.lblHeightUnderline.frame.size.width, 1);
    self.lblReligionUnderline.frame = CGRectMake(x, self.lblReligionUnderline.frame.origin.y, self.lblReligionUnderline.frame.size.width, 1);
    self.lblEthnicityUnderline.frame = CGRectMake(x, self.lblEthnicityUnderline.frame.origin.y, self.lblEthnicityUnderline.frame.size.width, 1);
    self.lblKidsUnderline.frame = CGRectMake(x, self.lblKidsUnderline.frame.origin.y, self.lblKidsUnderline.frame.size.width, 1);
    self.lblQuoteUnderline.frame = CGRectMake(x, self.lblQuoteUnderline.frame.origin.y, self.lblQuoteUnderline.frame.size.width, 1);
    
    self.lblHeight.frame = CGRectMake(x, self.lblHeight.frame.origin.y, self.lblHeight.frame.size.width, self.lblHeight.frame.size.height);
    self.lblAlwaysVisible.frame = CGRectMake(SCREEN_SIZE.width - 25*SCREEN_SIZE.width/375 - self.lblAlwaysVisible.frame.size.width, self.lblAlwaysVisible.frame.origin.y, self.lblAlwaysVisible.frame.size.width, self.lblAlwaysVisible.frame.size.height);
    
    self.lblReligion.frame = CGRectMake(x, self.lblReligion.frame.origin.y, self.lblReligion.frame.size.width, self.lblReligion.frame.size.height);
    self.lblNotPrefertosay1.frame = CGRectMake(SCREEN_SIZE.width - 25*SCREEN_SIZE.width/375 - self.lblNotPrefertosay1.frame.size.width, self.lblNotPrefertosay1.frame.origin.y, self.lblNotPrefertosay1.frame.size.width, self.lblNotPrefertosay1.frame.size.height);
    self.colReligion.frame = CGRectMake(55*SCREEN_SIZE.width/375, self.colReligion.frame.origin.y, self.colReligion.frame.size.width, self.colReligion.frame.size.height);

    self.lblEthnicity.frame = CGRectMake(x, self.lblEthnicity.frame.origin.y, self.lblEthnicity.frame.size.width, self.lblEthnicity.frame.size.height);
    self.lblNotPrefertosay2.frame = CGRectMake(SCREEN_SIZE.width - 25*SCREEN_SIZE.width/375 - self.lblNotPrefertosay2.frame.size.width, self.lblNotPrefertosay2.frame.origin.y, self.lblNotPrefertosay2.frame.size.width, self.lblNotPrefertosay2.frame.size.height);
    self.colEthnicity.frame = CGRectMake(55*SCREEN_SIZE.width/375, self.colEthnicity.frame.origin.y, self.colEthnicity.frame.size.width, self.colEthnicity.frame.size.height);
    
    self.lblKids.frame = CGRectMake(x, self.lblKids.frame.origin.y, self.lblKids.frame.size.width, self.lblKids.frame.size.height);
    self.vwKidsScrl.frame = CGRectMake(26*SCREEN_SIZE.width/375, self.vwKidsScrl.frame.origin.y, self.vwKidsScrl.frame.size.width, self.vwKidsScrl.frame.size.height);
    self.lblNone.frame = CGRectMake(75*SCREEN_SIZE.width/375, self.lblNone.frame.origin.y, self.lblNone.frame.size.width, self.lblNone.frame.size.height);
    self.lblOneDay.frame = CGRectMake(75*SCREEN_SIZE.width/375, self.lblOneDay.frame.origin.y, self.lblOneDay.frame.size.width, self.lblOneDay.frame.size.height);
    self.lblDontWantKids.frame = CGRectMake(75*SCREEN_SIZE.width/375, self.lblDontWantKids.frame.origin.y, self.lblDontWantKids.frame.size.width, self.lblDontWantKids.frame.size.height);
    
    self.lblQuotes.frame = CGRectMake(x, self.lblQuotes.frame.origin.y, self.lblQuotes.frame.size.width, self.lblQuotes.frame.size.height);
    self.txtAnswer.frame = CGRectMake(48*SCREEN_SIZE.width/375, self.txtAnswer.frame.origin.y, self.txtAnswer.frame.size.width, self.txtAnswer.frame.size.height);
    
}
/*!
 * @discussion Transform views
 */
- (void)transforms{
    
    [self.scrl setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.lastView setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblHeight setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblHeight.textAlignment = NSTextAlignmentRight;
    [self.lblAlwaysVisible setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblAlwaysVisible.textAlignment = NSTextAlignmentLeft;
    [self.pickerHeight setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblReligion setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblReligion.textAlignment = NSTextAlignmentRight;
    [self.lblNotPrefertosay1 setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblNotPrefertosay1.textAlignment = NSTextAlignmentLeft;
    [self.colReligion setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblEthnicity setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblEthnicity.textAlignment = NSTextAlignmentRight;
    [self.lblNotPrefertosay2 setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblNotPrefertosay2.textAlignment = NSTextAlignmentLeft;
    [self.colEthnicity setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    [self.lblKids setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblKids.textAlignment = NSTextAlignmentRight;
    [self.vwKidsScrl setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblNone.textAlignment = NSTextAlignmentLeft;
    self.lblOneDay.textAlignment = NSTextAlignmentLeft;
    self.lblDontWantKids.textAlignment = NSTextAlignmentLeft;
    
    [self.lblQuotes setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.lblQuotes.textAlignment = NSTextAlignmentRight;
    [self.lblQuestion setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self.txtAnswer setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.txtAnswer.textAlignment = NSTextAlignmentRight;
    
    
}

@end
