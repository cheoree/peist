//
//  DevInfoViewControllerViewController.m
//  Peist
//
//  Created by 배 철희 on 12. 5. 1..
//  Copyright (c) 2012년 me. All rights reserved.
//

#import "DevInfoViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface DevInfoViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation DevInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)sendMail:(id)sender 
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"[Peist 1.3] 사용자 문의 및 제안"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"ditty@hanmail.net", nil];
        [mailer setToRecipients:toRecipients];
        
//        UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
//        NSData *imageData = UIImagePNGRepresentation(myImage);
//        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"]; 
        
//        NSString *emailBody = @"Have a nice day... ^^";
        [mailer setMessageBody:@"" isHTML:NO];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"메일 전송 실패" 
                                                        message:@"메일을 보낼 수 있는 설정이 되어있지 않습니다." 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - MFMailComposeController delegate


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{ 
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the Drafts folder");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
            break;
        default:
            NSLog(@"Mail not sent");
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
