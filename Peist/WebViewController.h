//
//  ModalViewController.h
//  Pasty
//
//  Created by 배 철희 on 12. 3. 11..
//  Copyright (c) 2012년 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebViewControllerDelegate;

@interface WebViewController : UIViewController {
}
    
@property(nonatomic, strong) IBOutlet UIWebView *webView;
@property(nonatomic, strong) IBOutlet UIButton *closeButton;
@property(nonatomic, strong) IBOutlet UINavigationBar *topNavBar;
@property(nonatomic, strong) IBOutlet UINavigationBar *bottomNavBar;
@property(nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property(nonatomic, strong) NSString * targetDictUrlFormat;
@property(nonatomic, strong) NSMutableArray *dictArray;
@property (weak, nonatomic) id <WebViewControllerDelegate> delegate;

- (void)loadWeb:(NSString *)pasted dictIndex:(NSInteger)index ;
- (IBAction)closeView;
- (IBAction)changeDict;

@end

@protocol WebViewControllerDelegate <NSObject>
- (void)dictChangeFinished:(WebViewController *)controller;
@end