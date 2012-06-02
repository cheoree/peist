//
//  FontSetViewController.m
//  Pasty
//
//  Created by 배 철희 on 12. 4. 24..
//  Copyright (c) 2012년 . All rights reserved.
//

#import "FontSetViewController.h"
#import "ViewController.h"
#import "UserState.h"

@interface FontSetViewController () <UIPickerViewDataSource, UIPickerViewDelegate> 

@end

@implementation FontSetViewController

@synthesize arrayFonts = _arrayFonts;
@synthesize arrayFontSizes = _arrayFontSizes;

@synthesize delegate = _delegate;
@synthesize fontPicker = _fontPicker;
@synthesize label = _label;
@synthesize fontName = _fontName;
@synthesize fontSize = _fontSize;

NSInteger PICKER_HEIGHT = 216;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.arrayFonts = [[NSMutableArray alloc] initWithObjects:
                  @"Verdana",
                  @"Courier",
                  @"MarkerFelt-Thin",
                  @"ArialRoundedBold",
                  @"Marion-Regular",
                  @"Papyrus",
                  @"Optima-Regular",
                  @"AppleSDGothicNeo-Medium",
                  @"Futura-Medium",
                  @"ChalkboardSE-Regular",
                  @"AmericanTypewriter",
                  @"Georgia",
                  @"Didot",
                  @"Palatino",
                  @"HelveticaNeue",
                  @"Cochin-Bold",
                  @"GillSans",
                  @"NanumGothicOTF",
                  @"NanumMyeongjoOTF",
                  @"NanumPenOTF",
                  nil];
    
    self.arrayFontSizes = [[NSMutableArray alloc] init];
    for (int size = 15; size <= 40; size++) {
        [self.arrayFontSizes addObject:[NSString stringWithFormat:@"%d", size]];
    }
    
    self.fontPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.fontPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    // setup the data source and delegate for this picker
    CGRect viewFrame = self.view.frame;

    self.fontPicker.frame = CGRectMake(0, viewFrame.size.height - PICKER_HEIGHT, viewFrame.size.width, PICKER_HEIGHT);
    
    self.fontPicker.showsSelectionIndicator = YES;
    [self.view addSubview:self.fontPicker];
    
    self.fontPicker.delegate = self;
    self.fontPicker.dataSource = self;
    
    ViewController *viewController = (ViewController *)self.delegate;
    self.fontName = viewController.userState.fontName;
    self.fontSize = viewController.userState.fontSize;
    
    bool fontNameFound = NO;
    bool fontSizeFound = NO;
    for (int i = 0; i < self.arrayFonts.count; i++) {
        NSString * fontName = [self.arrayFonts objectAtIndex:i];
        if ([fontName isEqualToString:self.fontName]) {
            [self.fontPicker selectRow:i inComponent:0 animated:YES];
            fontNameFound = YES;
            break;
        }
    }
    
    for (int i = 0; i < self.arrayFontSizes.count; i++) {
        NSString * fontSize = [self.arrayFontSizes objectAtIndex:i];
        if ([fontSize intValue] == self.fontSize) {
            [self.fontPicker selectRow:i inComponent:1 animated:YES];
            fontSizeFound = YES;
            break;
        }
    }
    
    if (!fontNameFound) {
        self.fontName = [self.arrayFonts objectAtIndex:0];
    }
    if (!fontSizeFound) {
        self.fontSize = [[self.arrayFontSizes objectAtIndex:0] intValue];
    }
    
    [self.label setFont:[UIFont fontWithName:self.fontName size:self.fontSize]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.arrayFonts count];
    } else {
        return [self.arrayFontSizes count];
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.arrayFonts objectAtIndex:row];
    } else {
        return [self.arrayFontSizes objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSLog(@"Selected Font: %@. Index of selected font: %i", [self.arrayFonts objectAtIndex:row], row);
        self.fontName = [self.arrayFonts objectAtIndex:row];
    } else{
        NSLog(@"Selected FontSize: %@. Index of selected font size: %i", [self.arrayFontSizes objectAtIndex:row], row);
        self.fontSize = [[self.arrayFontSizes objectAtIndex:row] intValue];
    }
    
    //self.label.text = self.fontName;
    [self.label setFont:[UIFont fontWithName:self.fontName size:self.fontSize]];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    NSInteger pickerWidth = self.fontPicker.frame.size.width;
    NSInteger compo0Width = pickerWidth * 0.75;
    switch(component) {
        case 0: return compo0Width;
        case 1: return pickerWidth - compo0Width - 20;
        default: return compo0Width;
    }
    return compo0Width;
}

- (void)done {
    [self dismissModalViewControllerAnimated:TRUE];
    [[self delegate] fontSetViewControllerDidFinish:self];
}

- (void)cancel {
    [self dismissModalViewControllerAnimated:TRUE];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.arrayFonts = nil;
    self.arrayFontSizes = nil;
    self.delegate = nil;
    self.fontPicker = nil;
    self.label = nil;
    self.fontName = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return NO;
}

@end
