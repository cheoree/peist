//
//  ConfViewController.h
//  Pasty
//
//  Created by 배 철희 on 12. 3. 27..
//  Copyright (c) 2012년 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfViewControllerDelegate;

@interface ConfViewController : UITableViewController {
}

@property (weak, nonatomic) id <ConfViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *dictName;
@property (strong, nonatomic) IBOutlet UITextField *dictUrl;
@property (strong, nonatomic) IBOutlet UISwitch *goSwitch;

- (IBAction)done:(id)sender;
@end

@protocol ConfViewControllerDelegate <NSObject>
- (void)confViewControllerDidFinish:(ConfViewController *)controller;
@end