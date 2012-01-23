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
//    [ModalController removeContentForKey:SUBLEVEL];
    //    [ModalController removeContentForKey:@"Active Trading Partners"];
    //    [ModalController removeContentForKey:@"Futures Trading Signals"];
    //    [ModalController removeContentForKey:@"Options Trading Signals"];
    //    [ModalController removeContentForKey:@"The Gold And Oil Guy"];
    //    [ModalController removeContentForKey:@"The Market Trend Forecast"];
    
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
    if(section == 0)
    return [arrayElment count];
    else
        return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *stringCell = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:stringCell];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell];
    }
    if(indexPath.section == 0)
    {
        cell.textLabel.text = [arrayElment objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        if(checkedItem == indexPath.row)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.accessoryType = 1;
        cell.textLabel.text = @"User Guide";
    }
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
    if(indexPath.section == 0)
    {
        checkedItem = indexPath.row;
        [ModalController saveTheContent:[arrayElment objectAtIndex:indexPath.row] withKey:SUBLEVEL];
        
        [tableSetting reloadData];
        [self Done];
    }
    else
    {
        UserGuideViewController *UserGuideController = [[UserGuideViewController alloc] init];
        [self.navigationController pushViewController:UserGuideController animated:YES];
        [UserGuideController release];
    }
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
    [self.navigationItem setTitle:TITLESETTING];
    
    tableSetting.backgroundView = nil;
    
    if([(NSString*)[ModalController getContforKey:SUBLEVEL] isEqualToString:ALERTS])
        checkedItem = 0;
    else
        checkedItem = 1;
    
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
