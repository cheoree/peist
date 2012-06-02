//
//  ModalViewController.m
//  Pasty
//
//  Created by 배 철희 on 12. 3. 11..
//  Copyright (c) 2012년 . All rights reserved.
//

#import "WebViewController.h"
#import "ViewController.h"
#import "UserState.h"

@interface WebViewController () <UIWebViewDelegate>

@end

@implementation WebViewController

@synthesize webView = _webView;
@synthesize closeButton = _closeButton;
@synthesize topNavBar = _topNavBar;
@synthesize bottomNavBar = _bottomNavBar;
@synthesize segmentedControl = _segmentedControl;
@synthesize targetDictUrlFormat = _targetDictUrlFormat;
@synthesize dictArray = _dictArray;
@synthesize delegate = _delegate;
@synthesize spinner = _spinner;

NSString * const NAVER_DIC = @"http://m.endic.naver.com/search.nhn?searchOption=all&query=%@";
NSString * const DAUM_DIC = @"http://m.engdic.daum.net/search.do?q=%@&dic=eng";
NSString * const YAHOO_DIC = @"http://kr.dictionary.search.yahoo.com/search/dictionaryp?subtype=eng&prop=&p=%@";


- (void) loadWeb:(NSString *)words dictIndex:(NSInteger)index {
    NSLog(@"modalViewController.loadWeb: %@", words);
    
    NSString *urlStr = nil;
    self.topNavBar.topItem.title = words;
    
    if ([words hasPrefix:@"http://"]) { // url이 복사된 경우 바로 그 주소로 띄운다.
        urlStr = words;
    } else {
        NSString *orgTargetUrlFormat = [[NSString alloc] initWithString:[self.dictArray objectAtIndex:index]];
        if (index == 2) { // 사용자 정의 사전인 경우 TEST => %@으로 한번 더 변환
            orgTargetUrlFormat = [orgTargetUrlFormat stringByReplacingOccurrencesOfString:@"%" withString:@"%%" options:NSCaseInsensitiveSearch range:NSMakeRange(0, orgTargetUrlFormat.length)];
            self.targetDictUrlFormat = [orgTargetUrlFormat stringByReplacingOccurrencesOfString:@"test" withString:@"%@" options:NSCaseInsensitiveSearch range:NSMakeRange(0, orgTargetUrlFormat.length)];
            NSLog(@"targetDict Url form :%@", self.targetDictUrlFormat);
        } else {
            self.targetDictUrlFormat = [self.dictArray objectAtIndex:index];
        }

        NSString *encodedWords = [words stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        urlStr = [NSString stringWithFormat:self.targetDictUrlFormat, encodedWords];
    }
    NSURL *nsUrl = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:nsUrl];
    self.segmentedControl.selectedSegmentIndex = index;
    
    [self.webView loadRequest:request];
}

- (void) webViewDidStartLoad:(UIWebView *)webView {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    [self.spinner startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    [self.spinner stopAnimating];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) changeDict {
    NSInteger index = self.segmentedControl.selectedSegmentIndex;
    NSLog(@"selected: %d", index);
    
    self.targetDictUrlFormat = [self.dictArray objectAtIndex:index];
    
    [self loadWeb:self.topNavBar.topItem.title dictIndex:index];
    
    [self.delegate dictChangeFinished:self];
}

- (void) closeView {
    NSLog(@"closeView");
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;

    [self dismissModalViewControllerAnimated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"WebViewController.viewDidLoad");
    ViewController *viewController = (ViewController *)self.delegate;
    
    NSString *userStateDictUrl = viewController.userState.dictUrl;
    NSString *userStateDictTitle = viewController.userState.dictTitle;
    self.dictArray = [[NSMutableArray alloc] initWithObjects: (NSString *) NAVER_DIC, (NSString *)DAUM_DIC, nil];
    
    if (![userStateDictUrl isEqualToString:@""]) {
        [self.dictArray addObject:userStateDictUrl];
        [self.segmentedControl insertSegmentWithTitle:userStateDictTitle atIndex:2 animated:NO];
//        [self.segmentedControl setTitle:userStateDictTitle forSegmentAtIndex:2];
    }
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.webView = nil;
    self.closeButton = nil;
    self.topNavBar = nil;
    self.bottomNavBar = nil;
    self.segmentedControl = nil;
    self.spinner = nil;
    self.targetDictUrlFormat = nil;
    self.dictArray = nil;
    self.delegate = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return NO;
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration
{
    UIInterfaceOrientation toOrientation = self.interfaceOrientation;
    if (toOrientation == UIInterfaceOrientationPortrait
        || toOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        int portWidth = self.webView.frame.size.width;
        int portHeight = self.bottomNavBar.frame.size.height;
        self.bottomNavBar.frame = CGRectMake(0, 460-portHeight, portWidth, portHeight);
    }else {
        int portWidth = self.webView.frame.size.width;
        int portHeight = self.bottomNavBar.frame.size.height;
        self.bottomNavBar.frame = CGRectMake(0, 320-20-portHeight, portWidth, portHeight);
    }
    
}
@end
