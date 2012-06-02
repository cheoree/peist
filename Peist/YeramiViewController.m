//
//  YeramiViewControllerViewController.m
//  Pasty
//
//  Created by 배 철희 on 12. 4. 8..
//  Copyright (c) 2012년 . All rights reserved.
//

#import "YeramiViewController.h"

@interface YeramiViewController ()

@end

@implementation YeramiViewController

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return NO;
}

- (IBAction) done:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
