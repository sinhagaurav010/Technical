//
//  SettingViewController.m
//  TechnicalApp
//
//  Created by preet dhillon on 01/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)logOut:(id)sender
{
    [ModalController removeContentForKey:USERNAME];
    LoginViewController *loginController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginController animated:YES];
    
}


-(void)Done
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: .75];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
	[[self navigationController] popViewControllerAnimated:NO];
	[UIView commitAnimations];
}

#pragma mark -tableView Code-

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayElment count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *stringCell = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:stringCell];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell];
    }
    cell.textLabel.text = [arrayElment objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    if(checkedItem == indexPath.row)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;

    //cell.accessoryType = 1;
    
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section 
{
    return 0;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    checkedItem = indexPath.row;
    [tableSetting reloadData];
	// Recover the cell and key
//	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//	NSString *key = cell.textLabel.text;
//	
//	// Created an inverted value and store it
//	BOOL isChecked = !([[self.stateDictionary objectForKey:key] boolValue]);
//	NSNumber *checked = [NSNumber numberWithBool:isChecked];
//	[self.stateDictionary setObject:checked forKey:key];
//	
//	// Update the cell accessory checkmark
//	cell.accessoryType = isChecked ? UITableViewCellAccessoryCheckmark :  UITableViewCellAccessoryNone;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    tableSetting.backgroundView = nil;
    tableSetting.backgroundColor = [UIColor clearColor];
    
    arrayElment = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"Alerts",@"Alerts + All Updates", nil]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                             style:UIBarButtonItemStyleDone 
                                                                            target:self 
                                                                            action:@selector(Done)];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
