//
//  MemberAreaViewController.m
//  TechnicalApp
//
//  Created by preet dhillon on 26/11/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "MemberAreaViewController.h"

@implementation MemberAreaViewController

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:NO];
    tableViewMem.backgroundView = nil;
    tableViewMem.backgroundColor = [UIColor clearColor];
    arrayElement = [[NSMutableArray alloc] init];
    [arrayElement addObject:@"The Gold And Oil Guy"];
    
    [arrayElement addObject:@"Active Trading Partners"];
    
    [arrayElement addObject:@"The Market Trend Forecast"];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#define mark -TableView Code-

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
	return [arrayElement count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    NSString *stringCell = @"cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:stringCell];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringCell];
    }
    cell.textLabel.text = [arrayElement objectAtIndex:indexPath.section];
       
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section 
{
    return 0;
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
