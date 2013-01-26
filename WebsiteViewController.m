//
//  ViewController.m
//  TestApp
//
//  Created by William Gestrich on 11/12/12.
//  Copyright (c) 2012 William Gestrich. All rights reserved.
//

#import "WebsiteViewController.h"
#import "MultiLevelTableViewController.h"

@implementation WebsiteViewController

-(void)setWebView:(UIWebView *)webView{
    
    _webView = webView;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Application frame is frame minus the status bar
    self.webView.frame = [[UIScreen mainScreen] applicationFrame];
    // Load the html as a string from the file system
    NSString *urlAddress = @"http://54.243.28.182/";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
   
    
}

- (void)viewDidAppear:(BOOL)animated{


    

    
}


/*
 * Use this to intercept a load request
 * This can be used after repurposing an
 * element using stringByEvaluatingJavaScriptFromString
 * to be a link which will caus this method to be fired
 * when clicked. Then do whatever you want and return NO
 * so that it doesn't load the fake website
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //***First you have to put this commented code somewhere -- maybe view did load
    /*
    NSString *urlString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('refresh').onclick = function() {location.href='http://www.somefakewebsite.com/'; }"];
    
    if(!urlString) NSLog(@"Error in javascriptbuttontapped");
     */

    
    //Now here, see if your redirect path is the
    //fake address you put in earlier
    if([[[request URL] absoluteString] isEqualToString:@"http://www.somefakewebsite.com/"]){

        [self.webEventDelegate websiteDidRefresh];
        
        //Return NO becuase we don't really
        //want to go to that fake address!
        return NO;
    }
    
	return YES; // Return YES in other cases to make sure real redirects work as expected.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"Finished loading");

    NSString *currentJavaScript = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('refresh').getAttribute('onclick')"];
    
    NSString *executionString = [NSString stringWithFormat:@"document.getElementById('refresh').onclick =  function() {location.href='http://www.somefakewebsite.com/'; %@; }", currentJavaScript];
    
    currentJavaScript = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('submit').getAttribute('onclick')"];
    
    executionString = [NSString stringWithFormat:@"document.getElementById('submit').onclick =  function() {location.href='http://www.somefakewebsite.com/'; %@; }", currentJavaScript];
    
    
    
    [self.webView stringByEvaluatingJavaScriptFromString:executionString];
    
}




@end
