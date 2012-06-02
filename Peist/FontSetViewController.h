//
//  FontSetViewController.h
//  Pasty
//
//  Created by 배 철희 on 12. 4. 24..
//  Copyright (c) 2012년 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FontSetViewControllerDelegate;

@interface FontSetViewController : UIViewController {
}

@property (nonatomic, strong) NSMutableArray * arrayFonts;
@property (nonatomic, strong) NSMutableArray * arrayFontSizes;
@property (weak, nonatomic) id <FontSetViewControllerDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIPickerView *fontPicker;
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic) NSInteger fontSize;
- (IBAction) done;
- (IBAction) cancel;

@end

@protocol FontSetViewControllerDelegate <NSObject>
- (void)fontSetViewControllerDidFinish:(FontSetViewController *)controller;
@end