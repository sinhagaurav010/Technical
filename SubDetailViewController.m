//
//  SubDetailViewController.m
//  TechnicalApp
//
//  Created by preet dhillon on 10/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "SubDetailViewController.h"

@implementation SubDetailViewController
@synthesize dictDetail,stringTitle;
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

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(back)];
    self.navigationItem.leftBarButtonItem = saveButton;
    [saveButton release];
    
    [self.navigationItem setTitle:stringTitle];
    NSLog(@"%@",dictDetail);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#define mark -TableView Code-

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dictDetail objectForKey:POST] count];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stringCell];
    }
    cell.textLabel.text = [[[dictDetail objectForKey:POST] objectAtIndex:indexPath.row] objectForKey:POSTTITLE];
    cell.detailTextLabel.text = [[[dictDetail objectForKey:POST] objectAtIndex:indexPath.row] objectForKey:POSTDATE];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.accessoryType = 1;
    
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostDetailViewController *postDetailController = [[PostDetailViewController alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[dictDetail objectForKey:ID] forKey:@"SUBID"];
    [dict setObject:[[[dictDetail objectForKey:POST] objectAtIndex:indexPath.row] objectForKey:POSTDATE] forKey:POSTDATE];
    [dict setObject:[[[dictDetail objectForKey:POST] objectAtIndex:indexPath.row] objectForKey:POSTTITLE] forKey:POSTTITLE];
    [dict setObject:[[[dictDetail objectForKey:POST] objectAtIndex:indexPath.row] objectForKey:ID] forKey:ID];
    postDetailController.dictPostDetail = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [dict release];
    [self.navigationController pushViewController:postDetailController animated:YES];
    [postDetailController   release];
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
