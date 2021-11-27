//
//  WebViewVC.m
//  CupidLove
//
//  Created by Umesh on 6/10/17.
//  Copyright © 2017 Potenza. All rights reserved.
//

#import "WebViewVC.h"

@interface WebViewVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *vwBack;
@property (weak, nonatomic) IBOutlet UIView *vwTitle;
@end


@implementation WebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setHidesBackButton:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    UIGraphicsBeginImageContext (self.navigationController.navigationBar.frame.size);
    [[UIImage imageNamed:@"FBRectangle.png"] drawInRect:self.navigationController.navigationBar.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.navigationController.navigationBar setBarTintColor :[UIColor colorWithPatternImage:image]];
    
    [self.navigationController.navigationBar addSubview:self.vwTitle];
    
    CGRect tempFrame = self.vwTitle.frame;
    tempFrame.size.height = self.navigationController.navigationBar.frame.size.height;
    self.vwTitle.frame = tempFrame;
    
    SHOW_LOADER_ANIMTION();
    [[ApiManager sharedInstance] CheckReachibilty:^(BOOL responseObject)
     {
         
         if (responseObject == false)
         {
             HIDE_PROGRESS;
             ALERTVIEW([MCLocalization stringForKey:@"Please check internet connection and try again."], self);
             return ;
         }
         else {
//             [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kTermsAndConditionsUrl]]];
             [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[appDelegate GetData:kTermsAndConditionsUrl]]]];
         }
     }];
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.vwTitle.hidden = NO;
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.vwTitle.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button click


/*!
 * @discussion Back from Terms and Agreements
 * @param sender For identifying sender
 */
- (IBAction)btnBackWebViewClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - webview delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
   
    HIDE_PROGRESS;

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
     HIDE_PROGRESS;
}

@end
