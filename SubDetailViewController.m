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


#pragma mark -viewWillAppear-

- (void)viewWillAppear:(BOOL)animated
{
    [tableSub reloadData];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //[UIApplication sharedApplication].applicationIconBadgeNumber = 23;
    arraySub = [[NSMutableArray alloc] init];
    if([[ModalController getContforKey:SUBLEVEL] isEqualToString:ALERTS])
    {
        
        for(int i=0;i<[[dictDetail objectForKey:POST] count];i++)
        {
            if([[[[dictDetail objectForKey:POST] objectAtIndex:i] objectForKey:POSTCAT] isEqualToString:@"Alerts"] || [[[[dictDetail objectForKey:POST] objectAtIndex:i] objectForKey:POSTCAT] isEqualToString:@"alerts"])
                [arraySub addObject:[[dictDetail objectForKey:POST] objectAtIndex:i]];
        }
    }        
    else
        arraySub = [[NSMutableArray alloc] initWithArray:[dictDetail objectForKey:POST]];
    
    stringSubID = [dictDetail objectForKey:ID];
    
    if([arraySub count]==0)
    {
        [ModalController showTheAlertWithMsg:@"No Post is available" withTitle:@"Info" inController:self];
        tableSub.hidden = YES;
    }
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(back)];
    self.navigationItem.leftBarButtonItem = saveButton;
    [saveButton release];
    
    [self.navigationItem setTitle:stringTitle];
    NSLog(@"%@",arraySub);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -saveTheUsedPostID-

-(void)saveTheUsedPostID:(NSInteger)index
{
    NSLog(@"[ModalController getContforKey:stringTitle]%@",[ModalController getContforKey:stringTitle]);
    NSMutableArray *arrayPsts;
    if([ModalController getContforKey:stringTitle])
    {
        arrayPsts = [[NSMutableArray alloc] initWithArray:[ModalController getContforKey:stringTitle]];
        
    }
    else
        arrayPsts = [[NSMutableArray alloc] init];
    
    [arrayPsts addObject:[[arraySub objectAtIndex:index ] objectForKey:ID]];
    
    [ModalController saveTheContent:arrayPsts withKey:stringTitle];
    [arrayPsts release];
}

#pragma mark -isAlreadyRead-

-(BOOL)isAlreadyRead:(NSInteger)index
{
    NSLog(@"isal");
    if([ModalController getContforKey:stringTitle])
    {
        NSMutableArray *arrayPsts = [[NSMutableArray alloc] initWithArray:[ModalController getContforKey:stringTitle]];
        if([arrayPsts containsObject:[[arraySub objectAtIndex:index]objectForKey:ID]])
            return NO;
        else
            return YES;
    }
    else
        return YES;
}
#define mark -TableView Code-

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arraySub count];
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
    
    
    cell.textLabel.text = [[arraySub objectAtIndex:indexPath.row] objectForKey:POSTTITLE];
    cell.detailTextLabel.text = [[arraySub objectAtIndex:indexPath.row] objectForKey:POSTDATE];
    
    if([self isAlreadyRead:indexPath.row])
        cell.imageView.image = [UIImage imageNamed:@"icon_blue_dot.png"];
    else
        cell.imageView.image = nil;
    
    NSLog(@"here%@ %d %@",[[arraySub objectAtIndex:indexPath.row] objectForKey:POSTCAT],indexPath.row,[arraySub objectAtIndex:indexPath.row]);
    
    //    if([[[arraySub objectAtIndex:indexPath.row] objectForKey:POSTCAT] isEqualToString:@"alerts"] || [[[arraySub objectAtIndex:indexPath.row] objectForKey:POSTCAT] isEqualToString:@"Alerts"] )
    //    {
    //        cell.contentView.backgroundColor = [UIColor  yellowColor];
    //    }
    //    else
    //        cell.contentView.backgroundColor = [UIColor  whiteColor];
    //    
    //        cell.contentView.backgroundColor = [UIColor colorWithRed:.953 green:.929 blue:.667 alpha:1.0];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.accessoryType = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if([[[arraySub objectAtIndex:indexPath.row] objectForKey:POSTCAT] isEqualToString:@"alerts"] || [[[arraySub objectAtIndex:indexPath.row] objectForKey:POSTCAT] isEqualToString:@"Alerts"] )
        cell.backgroundColor = [UIColor colorWithRed:.953 green:.929 blue:.667 alpha:1.0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if([self isAlreadyRead:indexPath.row])
    {
        [self saveTheUsedPostID:indexPath.row];
        totalrem -= 1;
        [tableSub reloadData];
    }
    PostDetailViewController *postDetailController = [[PostDetailViewController alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:stringSubID forKey:@"SUBID"];
    [dict setObject:[[arraySub objectAtIndex:indexPath.row] objectForKey:POSTDATE] forKey:POSTDATE];
    [dict setObject:[[arraySub objectAtIndex:indexPath.row] objectForKey:POSTTITLE] forKey:POSTTITLE];
    [dict setObject:[[arraySub objectAtIndex:indexPath.row] objectForKey:ID] forKey:ID];
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
