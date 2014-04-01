//
//  ViewController.m
//  ColorWriterExample
//
//  Created by Alan Skipp on 01/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import "ViewController.h"
#import "ColorCell.h"
#import "UIColor+Additions.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController () <UITextFieldDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *paletteLabel;

- (IBAction)insertNewColor:(id)sender;
- (IBAction)exportColors:(id)sender;
@end

@implementation ViewController
{
    NSMutableArray *_colors;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _colors = [[NSMutableArray alloc] init];
    _paletteLabel.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions

- (IBAction)insertNewColor:(id)sender;
{
    [_colors insertObject:[UIColor randomColor] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)exportColors:(id)sender
{
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.mailComposeDelegate = self;
    
    NSString *paletteName = self.paletteLabel.text;
    if ([paletteName length] == 0) {
        paletteName = @"Untitled";
    }
    
    [mailViewController setSubject:paletteName];

    NSData * swatchData;
    swatchData = [NSData data];
    [mailViewController addAttachmentData:swatchData mimeType:@"application/octet-stream" fileName:[NSString stringWithFormat:@"%@.ase", paletteName]];
    
    [self presentViewController:mailViewController animated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _colors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ColorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell setColor:_colors[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_colors removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
