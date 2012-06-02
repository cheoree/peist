//
//  ViewController.h
//  Pasty
//
//  Created by 배 철희 on 12. 3. 4..
//  Copyright (c) 2012년 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class PastedScrollView;
@class UserState;
@class WordLabel;

@interface ViewController : UIViewController {
    BOOL isNew;
}

@property (strong, nonatomic) NSString *pastedOriginal;
@property (strong, nonatomic) NSMutableArray *labelWords;
@property (strong, nonatomic) NSMutableArray *tappedWordArr;
@property (strong, nonatomic) NSArray *processedWords;
@property (strong, nonatomic) IBOutlet PastedScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) UserState *userState;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UILabel *lastPasted;
@property (strong, nonatomic) UIButton *pinButton;
@property (strong, nonatomic) IBOutlet UINavigationBar *mainNaviBar;
@property Boolean isFirstLaunch;

- (IBAction) showWebViewWithWord:(NSString *)word;
- (IBAction)pinButtonTapped;
- (NSString *) getStringsInPasteboard;
- (void) closeWebView;
- (void) initilizePasted;
- (void) saveConfiguration;
- (void)touchesEndedOutside:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) startPaste;

@end
