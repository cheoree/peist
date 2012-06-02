//
//  ConfViewController.m
//  Pasty
//
//  Created by 배 철희 on 12. 3. 27..
//  Copyright (c) 2012년 . All rights reserved.
//

#import "ConfViewController.h"
#import "ViewController.h"
#import "UserState.h"

@interface ConfViewController () <UIAlertViewDelegate>

@end

@implementation ConfViewController

@synthesize delegate = _delegate;
@synthesize dictName = _dictName;
@synthesize dictUrl = _dictUrl;
@synthesize goSwitch = _goSwitch;

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    ViewController *viewController = (ViewController *)self.delegate;
    
    NSString *userStateDictUrl = viewController.userState.dictUrl;
    NSString *userStateDictTitle = viewController.userState.dictTitle;
    
    self.dictUrl.text = userStateDictUrl;
    self.dictName.text = userStateDictTitle;
    self.goSwitch.on = viewController.userState.onthego;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.dictName = nil;
    self.dictUrl = nil;
    self.goSwitch = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return NO;
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}
*/

- (void) validateInput {
    NSString *dictName = [self.dictName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *dictUrl = [self.dictUrl.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSLog(@"dicName: %@, dicUrl: %@", dictName, dictUrl);
    
    // 아무것도 입력 안한 상태는 패스
    if ([dictName isEqualToString:@""] && [dictUrl isEqualToString:@""]) {
        [[self delegate] confViewControllerDidFinish:self];
        return;
    }
    
    // 하나는 입력 하나는 입력 안한 상태는 체크
    if ([dictName isEqualToString:@""] || [dictUrl isEqualToString:@""]) {
        [self showAlertTitle:@"사용자 정의 사전 입력 필드에 누락이 있습니다." message:@""];
        return;
    }

    // 둘다 입력한 상태인데 URL이 이상한 경우
    NSRange range = [dictUrl rangeOfString:@"test" options:NSCaseInsensitiveSearch];
    if (range.location == NSNotFound) {
        [self showAlertTitle:@"사용자 정의 사전 URL에는 \"test\"라는 문자열이 필요합니다." message:@""];
        return;
    }
    
    [[self delegate] confViewControllerDidFinish:self];
}

- (void) showAlertTitle:(NSString *)title message:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"delegate alert: %d", buttonIndex);
    if (buttonIndex == 1) {
        //[[self delegate] confViewControllerDidFinish:self];
    }
}


- (IBAction)done:(id)sender {
    [self validateInput];
    //[[self delegate] confViewControllerDidFinish:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.

     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do some stuff when the row is selected
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
