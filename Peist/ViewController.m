//
//  ViewController.m
//  Pasty
//
//  Created by 배 철희 on 12. 3. 4..
//  Copyright (c) 2012년 . All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "WordLabel.h"
#import "PastedScrollView.h"
#import "ConfViewController.h"
#import "FontSetViewController.h"
#import "UserState.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>

@interface ViewController () <
    WordLabelDelegate,
    ConfViewControllerDelegate,
    WebViewControllerDelegate,
    UISearchBarDelegate,
    FontSetViewControllerDelegate,
    UIScrollViewDelegate
>
@end

@implementation ViewController

@synthesize pastedOriginal = _pastedOriginal;
@synthesize labelWords = _labelWords;
@synthesize scrollView = _scrollView;
@synthesize tappedWordArr= _tappedWordArr;
@synthesize searchBar = _searchBar;
@synthesize userState = _userState;
@synthesize spinner = _spinner;
@synthesize isFirstLaunch = _isFirstLaunch;
@synthesize lastPasted = _lastPasted;
@synthesize processedWords = _processedWords;
@synthesize pinButton = _pinButton;
@synthesize mainNaviBar = _mainNaviBar;

- (NSString *)getStringsInPasteboard {
    UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
    NSString *pastedResult = [appPasteBoard string];
    
    NSString *result = [pastedResult stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return result;
}

- (void)notiPasteWithWidth:(CGFloat)width height:(CGFloat)height msg:(NSString *)msg font:(UIFont *)font interval:(NSTimeInterval)interval {
    int centerX = self.scrollView.center.x;
    int centerY = self.scrollView.center.y;

    int left = centerX - width / 2;
    int top = centerY - height / 2 ;
    UILabel *pastingView = [[UILabel alloc] initWithFrame:CGRectMake(left, top, width, height)];
    pastingView.backgroundColor = [UIColor blackColor];
    [pastingView setNumberOfLines:0];
    [pastingView setLineBreakMode:UILineBreakModeWordWrap];
    pastingView.alpha = 0.5;
    pastingView.layer.cornerRadius = 10;
    pastingView.text = msg;
    pastingView.font = font;
    pastingView.textAlignment = UITextAlignmentCenter;
    pastingView.textColor = [UIColor whiteColor];
    [self.view addSubview:pastingView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    NSLog(@"%f", interval);
    [UIView setAnimationDuration: interval];
    
    pastingView.alpha = 0;
    
    [UIView commitAnimations];
}

- (void)startPaste {
    if (self.userState.pasteLock && self.pastedOriginal && ![self.pastedOriginal isEqualToString:[self getStringsInPasteboard]]) {
        [self shakeView:self.pinButton];
        return;
    }
    
    [self.spinner startAnimating];
    self.scrollView.userInteractionEnabled = NO;
    
    // 커서가 서치바에 있는 상태로 메인쓰레드가 아닌 다른 쓰레드에서 서치바텍스트를 수정하려고 하면 뻑남
    [self.searchBar resignFirstResponder]; 
    
    [NSThread detachNewThreadSelector:@selector(initilizePasted) toTarget:self withObject:nil];
}

- (void)initilizePasted {
    isNew = NO;
    NSString *pasted = [self getStringsInPasteboard];
    
    if (pasted == nil || [pasted isEqualToString:@""]) {
        [self performSelectorOnMainThread:@selector(pasteDone) withObject:nil waitUntilDone:NO];
        
        UIFont *font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:17.0f];
        [self notiPasteWithWidth:250 height:50 msg:@"Nothing to Paste." font:font interval:4.50f];

        if ([pasted isEqualToString:@""] && self.pastedOriginal == nil) {
            pasted = @"Copy First.";
        } else {
            return;
        }
    }
    
    if ([self.pastedOriginal isEqualToString:pasted]) {
        [self performSelectorOnMainThread:@selector(pasteDone) withObject:nil waitUntilDone:YES];
        return;
    }
        
    isNew = YES;
    
    self.processedWords = nil;
    
    //개행 처리를 위해
    NSString *wordsTemp = 
        [pasted stringByReplacingOccurrencesOfString:@"\n" withString:@" ::NL:: "];
    self.processedWords = [wordsTemp componentsSeparatedByCharactersInSet:[NSMutableCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (self.processedWords.count > 2800) {
        [self performSelectorOnMainThread:@selector(pasteDone) withObject:nil waitUntilDone:NO];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Paste 실패" message:@"현재 복사된 데이터가 너무 큽니다. 2800단어 이하의 문장만 지원됩니다." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        
        [alertView show];
        isNew = NO;
        return;
    }
    
    self.pastedOriginal = pasted;
    
    [self cleanAndPasteWithWords];
    
    // 단어 하나면 띄우지 않음
//    if (self.labelWords.count != 1) {
//        UIFont *font = [UIFont fontWithName:@"Optima-Bold" size:36.0f];
//        [self notiPasteWithWidth:160 height:80 msg:@"Pasted." font:font interval:1.50f];
//    }
}

- (void)cleanAndPasteWithWords {
    for (id button in self.labelWords) {
        [button removeFromSuperview];
    }

    [self.labelWords removeAllObjects];
    [self.tappedWordArr removeAllObjects];
    
    [self viewPasted];

    int scrollHeight = self.scrollView.frame.size.height;
    
    // scrollview height initialize
    WordLabel *lastLabel = [self.labelWords lastObject];
    if (lastLabel != nil) {
        scrollHeight = lastLabel.frame.origin.y + lastLabel.frame.size.height + 10;
    }
    
    lastLabel = nil;
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, scrollHeight)];
    if (isNew) {
        self.lastPasted.text = [self getLastUpdatedTimeString];
    }
    
    [self performSelectorOnMainThread:@selector(pasteDone) withObject:nil waitUntilDone:YES];
}

- (int)viewPasted {
    NSString *fontName = self.userState.fontName;
    int fontSize = self.userState.fontSize;
    int wordsCount = self.processedWords.count;
    
    if (wordsCount == 1 && self.userState.onthego) { // 복사된 단어가 단 하나뿐이고 onthego 설정을 했을 때
        WordLabel *word = [[WordLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) title:[self.processedWords objectAtIndex:0] fontName:fontName fontSize:fontSize];
        
        word.delegate = self;
        
        int left = self.scrollView.center.x - (word.frame.size.width/2);
        int top = self.scrollView.center.y - (word.frame.size.height/2) - self.searchBar.frame.size.height;
        word.frame = CGRectMake(left, top, word.frame.size.width, word.frame.size.height);
        
        [self.scrollView addSubview:word];
        [self.labelWords addObject:word];
        [self.tappedWordArr addObject:[NSNumber numberWithInt:0]];
        
        [word changeSelectedState:YES];
        
        self.searchBar.text = [self getTappedWords];
        
        return 1;
    }
    
    NSLog(@"words count: %d", self.processedWords.count);
    int nextStartLeft = 8;
    int nextStartTop = 8;
    
    int frameEnd = self.scrollView.frame.size.width;
    for (int i = 0; i < wordsCount; i++) {
        //        NSLog(@"wordsCount:%d", words.count);
        CGRect rect = CGRectMake(nextStartLeft, nextStartTop, frameEnd, 0);
        NSString *wordTitle = [self.processedWords objectAtIndex:i];
        
        WordLabel *word = [[WordLabel alloc] initWithFrame:rect title:wordTitle fontName:fontName fontSize:fontSize];
        
        word.delegate = self;
        
        int left = word.frame.origin.x;
        int width = word.frame.size.width;
        int top = word.frame.origin.y;
        int height = word.frame.size.height;
        
        if ([word.text isEqualToString:@"::NL::"]) {
            nextStartLeft = 8;
            nextStartTop = top + height + 3; // @todo: 간격조절 필요
            continue;
        }
        
        if (i != 0) {// 최초에도 체크하면 무한정 밑으로 내려감
            if (nextStartLeft >= frameEnd || nextStartLeft + width >= frameEnd) {
                //NSLog(@"frameEnd:%d, %d %d", frameEnd, nextStartLeft, width);
                nextStartLeft = 8;
                nextStartTop = top + height + 4; // @todo: 간격조절 필요
                word.frame = CGRectMake(nextStartLeft, nextStartTop, width, height);
                nextStartLeft = nextStartLeft + width + 4;
            } else {
                nextStartLeft = left + width + 4;
            }
        } else {
            nextStartLeft = left + width + 4;
        }
        
        [self performSelectorOnMainThread:@selector(addWordAtScrollView:) withObject:word waitUntilDone:YES];
        
    }
    NSLog(@"words add end");
    return self.processedWords.count;
}

- (void)pasteDone {
    NSLog(@"pasteDone start");
    // stop the activityIndicator
    [self.spinner stopAnimating]; // 에니메이션 끝.

    self.scrollView.userInteractionEnabled = YES;
    
    // webview를 여기서 띄우지 않고 쓰레드 내에서 띄우면 뻑남
    if (self.presentedViewController != nil && ![self.presentedViewController isKindOfClass:[WebViewController class]]) {
    }
    if (self.labelWords.count == 1 && self.userState.onthego && isNew) {
//        if ([self.presentedViewController isKindOfClass:[WebViewController class]]) {
//            NSLog(@"ok webview presented");
//            [self.presentedViewController dismissModalViewControllerAnimated:NO];
//        }
        [self showWebViewWithWord:self.searchBar.text];
    }
    
    if (self.labelWords.count != 1 && isNew) { // 폰트 설정 제외
        UIFont *font = [UIFont fontWithName:@"Optima-Bold" size:36.0f];
        [self notiPasteWithWidth:160 height:80 msg:@"Pasted." font:font interval:1.50f];
    }
    NSLog(@"pasteDone end");
}

         
- (NSString *)getLastUpdatedTimeString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"y. M. d. HH:mm:ss"]; //From this format
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"]];
    
    NSString *tmp = [dateFormat stringFromDate:[[NSDate alloc] init]];
    NSString *first = @"";
    return [first stringByAppendingString:tmp];
}

- (void)closeWebView {
    WebViewController *webViewController = (WebViewController*)[self presentedViewController];
    [webViewController closeView];
    NSLog(@"closeWebView");
}

- (void)addWordAtScrollView:(WordLabel *)word {
    [self.scrollView addSubview:word];
    [self.labelWords addObject:word];
}

- (void)didReceiveMemoryWarning {
    // 2700여 단어부터 Received Memory Warning..
    NSLog(@"didReceiveMemoryWarning");
}

- (void)showWebViewWithWord:(NSString *)word
{    
    if (self.presentedViewController != nil && ![self.presentedViewController isKindOfClass:[WebViewController class]]) {
        NSLog(@"*** Not WebView Presented ***");
        return;
    }
    
    [self performSegueWithIdentifier:@"ShowWebView" sender:self];
    
    WebViewController *webViewController = (WebViewController*)[self presentedViewController];
    webViewController.delegate = self;
    
    [webViewController loadWeb:word dictIndex:self.userState.dictIndex];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.labelWords == nil) {
        self.labelWords = [[NSMutableArray alloc] init];
        self.tappedWordArr = [[NSMutableArray alloc] init];
        self.processedWords = nil;
    }
    
    [self loadConfiguration];
    
    self.scrollView.delegate = self;
    self.scrollView.canCancelContentTouches = YES;
    self.scrollView.delaysContentTouches = NO;
    self.scrollView.showsVerticalScrollIndicator = YES;
    
    self.isFirstLaunch = YES;
  
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] init];
    UINavigationItem *item = [[UINavigationItem alloc] init];
    item.rightBarButtonItem = rightButton;

    UIImage *lockedImage = [UIImage imageNamed:@"locked.png"];
    UIImage *unlockedImage = [UIImage imageNamed:@"unlocked.png"];
    
    self.pinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setCustomView:self.pinButton];
    item.hidesBackButton = YES;
    [self.mainNaviBar pushNavigationItem:item animated:NO];
   
    [self.pinButton addTarget:self action:@selector(pinButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.pinButton setImage:unlockedImage forState:UIControlStateNormal];
    [self.pinButton setImage:unlockedImage forState:UIControlStateDisabled];
    [self.pinButton setImage:lockedImage forState:UIControlStateSelected];
    [self.pinButton setImage:lockedImage forState:UIControlStateHighlighted];
    [self.pinButton setImage:unlockedImage forState:UIControlStateReserved];
    [self.pinButton sizeToFit];
    self.pinButton.showsTouchWhenHighlighted = YES;
    
    NSLog(@"viewDidLoad");
}

- (NSString *)getTappedWords {
    NSString * result = [[NSString alloc] init];

    [self.tappedWordArr sortUsingSelector:@selector(compare:)]; //sorting
    
    for (NSNumber *numIndex in self.tappedWordArr) {
        WordLabel *label = [self.labelWords objectAtIndex:[numIndex intValue]];
        result = [result stringByAppendingString:label.text];
        result = [result stringByAppendingString:@" "];
    }
    
    result = [self getTrimedWords:result];
    return result;
}

- (NSString *)getTrimedWords:(NSString *) words {
    words = [words stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
    words = [words stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    words = [words stringByTrimmingCharactersInSet:[NSCharacterSet illegalCharacterSet]];
    words = [words stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    words = [words stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
    words = [words stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"'\",[]{}()-=!@#$%^&*()_+;:,./?"]];
    
    return words;
}

- (void)buttonSelectAndOthersOut:(WordLabel *)wordLabel {
    int meIndex = [self.labelWords indexOfObject:wordLabel];
    int preIndex = meIndex - 1;
    int postIndex = meIndex + 1;
    
    WordLabel *preButton = nil;
    WordLabel *postButton = nil;
    if (preIndex >= 0) {
        preButton = [self.labelWords objectAtIndex:preIndex];
    }
    if (postIndex + 1 <= self.labelWords.count) {
        postButton = [self.labelWords objectAtIndex:postIndex];
    }
    
    if (!preButton.isTapped && !postButton.isTapped) {
        for (NSNumber *numIndex in self.tappedWordArr) {
            NSLog(@"tapped Index: %d", [numIndex intValue]);
            WordLabel *label = [self.labelWords objectAtIndex:[numIndex intValue]];
            [label changeSelectedState:NO];
        }
        [self.tappedWordArr removeAllObjects];
    }
    
    [self.tappedWordArr addObject:[NSNumber numberWithInt:meIndex]];
    [wordLabel changeSelectedState:YES];
}

- (void)wordTouched:(WordLabel *)wordLabel {
    NSLog(@"wordTouched");
    
    int meIndex = [self.labelWords indexOfObject:wordLabel];
    int preIndex = meIndex - 1;
    int postIndex = meIndex + 1;
    
    if (wordLabel.isTapped) {
        if (meIndex == 0 || meIndex == self.labelWords.count - 1) {
            [wordLabel changeSelectedState:NO];
            [self.tappedWordArr removeObject:[NSNumber numberWithInt:meIndex]];
        } else if (![[self.labelWords objectAtIndex:preIndex] isTapped] || ![[self.labelWords objectAtIndex:postIndex] isTapped]) {
            [wordLabel changeSelectedState:NO];
            [self.tappedWordArr removeObject:[NSNumber numberWithInt:meIndex]];
        }
    } else {
        [self buttonSelectAndOthersOut:wordLabel];
    }
    //NSLog(@"search: %@, %@", self.searchBar.text, [self getTappedWords]);
    NSString *words = [self getTappedWords];
    self.searchBar.text = words;
    
    NSLog(@"touched word index: %d", meIndex);
}

- (void)touchesEndedOutside:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseEnded) {
        [self.searchBar resignFirstResponder];
    }
}

- (void)wordLongPressed:(WordLabel *)wordButton {
    NSLog(@"wordLongPressed");

    if (!wordButton.isTapped) {
        [self buttonSelectAndOthersOut:wordButton];
        self.searchBar.text = [self getTappedWords];
    }

    [self showWebViewWithWord:[self getTappedWords]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear");
    if (self.isFirstLaunch) {
        [self startPaste];
        self.isFirstLaunch = NO;
    }
    
    self.pinButton.selected = self.userState.pasteLock;
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    NSLog(@"viewDidUnload");
    self.pastedOriginal = nil;
    self.labelWords = nil;
    self.tappedWordArr = nil;
    self.scrollView = nil;
    self.searchBar = nil;
    self.userState = nil;
    self.spinner = nil;
    self.lastPasted = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSeque");
    if ([[segue identifier] isEqualToString:@"ShowConfView"]) {
        ConfViewController *confController = (ConfViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        confController.delegate = self;
    } 
    else if ([[segue identifier] isEqualToString:@"ShowWebView"]) {
        WebViewController *webViewController = (WebViewController *)[segue destinationViewController];                            
        webViewController.delegate = self;
    }
    else if ([[segue identifier] isEqualToString:@"ShowFontSetView"]) {
        FontSetViewController *fontSetViewController = (FontSetViewController *)[segue destinationViewController];                            
        fontSetViewController.delegate = self;
    }
}

- (void)pinButtonTapped {
    if (self.userState.pasteLock) {
        NSLog(@"locked -> unlock");
        self.userState.pasteLock = NO;
        self.pinButton.selected = NO;
        
    } else {
        NSLog(@"unlocked -> lock");
        self.userState.pasteLock = YES;
        self.pinButton.selected = YES;
    }
}

-(UIImage *) shadowImage:(UIImage *)image{
	//3 pixel shadow blur 픽셀치를 조정해서 세도우 블뤄 효과의 크기를 조절할수 있습니다. 
	UIGraphicsBeginImageContext(CGSizeMake(image.size.width + 6, image.size.height + 6));
    CGContextSetShadow(UIGraphicsGetCurrentContext(),CGSizeMake(-1.0f, -1.0f), -1.0f);
	[image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];  
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext();
    
	return newImage;
}

// 뷰를 흔드는 애니메이션 효과를 주는 메소드
- (void)shakeView:(UIView *)theView {
    CABasicAnimation *theAnimation;
    theAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    theAnimation.duration = 0.3;
    theAnimation.repeatCount = 4;
    theAnimation.autoreverses = YES;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    theAnimation.fromValue = [NSNumber numberWithFloat:2];
    theAnimation.toValue = [NSNumber numberWithFloat:-6];
    theAnimation.fillMode = kCAFillModeForwards;
    [theView.layer addAnimation:theAnimation forKey:@"animateLayer"];
    
}

- (void)saveConfiguration {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"conf.plist"];
    
    NSLog(@"path:%@", path);
    NSMutableDictionary *data = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path]) {
        data = [[NSMutableDictionary alloc] init];
    } else {
        data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    }

    [data setObject:self.userState.dictTitle forKey:@"dictTitle"];
    [data setObject:self.userState.dictUrl forKey:@"dictUrl"];
    [data setObject:[NSNumber numberWithInt:self.userState.dictIndex] forKey:@"lastDictIndex"];
    [data setObject:[NSNumber numberWithBool:self.userState.onthego] forKey:@"onthego"];
    [data setObject:self.userState.fontName forKey:@"fontName"];
    [data setObject:[NSNumber numberWithInt:self.userState.fontSize] forKey:@"fontSize"];
    [data setObject:[NSNumber numberWithBool:self.userState.pasteLock] forKey:@"pasteLock"];
    
    [data writeToFile: path atomically:YES];
}

- (void)loadConfiguration {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"conf.plist"];
    
    NSLog(@"path : %@", path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    self.userState = [[UserState alloc] initWithDictTitle:@"" url:@"" index:0 onthego:YES pasteLock:NO];
    
    if ([fileManager fileExistsAtPath: path]) {
        NSMutableDictionary *dictDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSLog(@"dictTitle: %@", [dictDic objectForKey:@"dictTitle"]);
        self.userState.dictTitle = [dictDic objectForKey:@"dictTitle"];
        self.userState.dictUrl = [dictDic objectForKey:@"dictUrl"];
        self.userState.dictIndex = [[dictDic objectForKey:@"lastDictIndex"] intValue];
        self.userState.onthego = [[dictDic objectForKey:@"onthego"] boolValue];
        if ([dictDic objectForKey:@"fontName"] != nil) {
            self.userState.fontName = [dictDic objectForKey:@"fontName"];
        }
        if ([dictDic objectForKey:@"fontSize"] != 0) {
            self.userState.fontSize = [[dictDic objectForKey:@"fontSize"] intValue];
        }
        self.userState.pasteLock = [[dictDic objectForKey:@"pasteLock"] boolValue];
    }
    NSLog(@"loaded : fontName: %@, fontSize: %d", self.userState.fontName, self.userState.fontSize);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return NO;
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
    UIInterfaceOrientation toOrientation = self.interfaceOrientation;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    if (toOrientation == UIInterfaceOrientationPortrait
        || toOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"rect.size.height: %f", rect.size.height);
        self.lastPasted.center = CGPointMake(self.view.center.x, 460 - 22);
    }else {
        self.lastPasted.center = CGPointMake(self.view.center.x, rect.size.width - 42);
    }
    
}

- (void)confViewControllerDidFinish:(ConfViewController *)controller {
    self.userState.dictUrl = controller.dictUrl.text;
    self.userState.dictTitle = controller.dictName.text;
    self.userState.onthego = controller.goSwitch.isOn;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)fontSetViewControllerDidFinish:(FontSetViewController *)controller {
    self.scrollView.userInteractionEnabled = NO;
    
    if ([self.userState.fontName isEqualToString:controller.fontName]) {
        if (self.userState.fontSize == controller.fontSize) {
            self.scrollView.userInteractionEnabled = YES;
            return;
        }
    }
    self.userState.fontName = controller.fontName;
    self.userState.fontSize = controller.fontSize;
    NSLog(@"fontSet Closed: fontSize: %d", controller.fontSize);

    // 커서가 서치바에 있는 상태로 메인쓰레드가 아닌 다른 쓰레드에서 서치바텍스트를 수정하려고 하면 뻑남
    //[self.searchBar resignFirstResponder];
    
    [self.spinner startAnimating];
    
    isNew = NO;
//    [self performSelectorOnMainThread:@selector(cleanAndPasteWithWords) withObject:nil waitUntilDone:NO];
    [NSThread detachNewThreadSelector:@selector(cleanAndPasteWithWords) toTarget:self withObject:nil];
}

- (void)dictChangeFinished:(WebViewController *)controller {
    self.userState.dictIndex = controller.segmentedControl.selectedSegmentIndex;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self showWebViewWithWord:searchBar.text];
}
@end
