//
//  ViewController.m
//  MySafari
//
//  Created by Shannon Beck on 1/7/15.
//  Copyright (c) 2015 Shannon Beck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (nonatomic, assign) CGFloat lastContentOffset;
//@property NSURL *url;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self.urlTextField.text isEqualToString:@"http://"])
    {
        self.urlTextField.text = @"http://";
    }
     self.webView.scrollView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *addressString = self.urlTextField.text;
    NSURL *addressURL = [NSURL URLWithString:addressString];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:addressURL];
    [self.webView loadRequest:addressRequest];
    [textField resignFirstResponder];
    return true;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //ScrollDirection scrollDirection;
    if (self.lastContentOffset >= scrollView.contentOffset.y)
    {
        self.urlTextField.hidden = NO;
        NSLog(@"HELLOO");
    }
    else
    {
        self.urlTextField.hidden = YES;
        NSLog(@"YESS");
    }


}



- (IBAction)onBackButtonTapped:(id)sender
{
     [self.webView goBack];

}

- (IBAction)onForwardButtonTapped:(id)sender
{
    [self.webView goForward];
}

- (IBAction)onStopLoadingButtonTapped:(id)sender
{
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonTapped:(id)sender
{
    [self.webView reload];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
    self.spinner.hidden = false;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
    self.spinner.hidden = true;
    if ([self.webView canGoBack] == true)
    {
        self.backButton.enabled = YES;
    }
    else
    {
        self.backButton.enabled = NO;
    }


    if ([self.webView canGoForward] == true)
    {
        self.forwardButton.enabled = YES;
    }
    else
    {
        self.forwardButton.enabled = NO;
    }

    NSString *currentURL = webView.request.URL.absoluteString;
    self.urlTextField.text = currentURL;

    NSString* title = [webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    self.title = title;


}

- (IBAction)onClearButtonTapped:(id)sender
{
    self.urlTextField.text = @"";
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];

}



- (IBAction)onAddButtonTapped:(id)sender
{
    UIAlertView *comingSoon = [[UIAlertView alloc]init];
    comingSoon.title = @"Coming Soon!";
    [comingSoon addButtonWithTitle:@"Dismiss"];
    [comingSoon show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
