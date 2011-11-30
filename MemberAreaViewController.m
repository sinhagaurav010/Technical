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


#pragma mark -modal Delegate-

-(void)getdata
{
    NSLog(@"ksdvfv%@",modal.stringRx);
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    
    NSDictionary *_xmlDictionaryData = [[XMLReader dictionaryForXMLData:modal.dataXml  error:nil] retain];
    NSLog(@"%@",_xmlDictionaryData);
    
    
    if([[_xmlDictionaryData objectForKey:@"user-subscriptions"] isKindOfClass:[NSString class]])
    {
        [ModalController showTheAlertWithMsg:@"No Subscription found!"
                                   withTitle:nil inController:self];
    }
    else
        if([[[[_xmlDictionaryData objectForKey:@"user-subscriptions"]objectForKey:@"products"]objectForKey:@"product"] isKindOfClass:[NSArray class]])
        {
            NSLog(@"arryayay");
            arrayElement = [[NSMutableArray alloc] initWithArray:[[[_xmlDictionaryData objectForKey:@"user-subscriptions"]objectForKey:@"products"]objectForKey:@"product"]];
        }
        else 
        {
            [arrayElement addObject:[[[_xmlDictionaryData objectForKey:@"user-subscriptions"]objectForKey:@"products"]objectForKey:@"product"]];
        }
    [tableViewMem reloadData];
    //[self parseData:modal.dataXml];
}

-(void)getError
{
    //isInternetConnect = 1;
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    
    [ModalController showTheAlertWithMsg:@"Error" 
                               withTitle:@"Error in Network"
                            inController:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [self.navigationItem setTitle:TITLEMEMBERAREA];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
//    UIButton *infoButton = [[UIButton buttonWithType:UIButtonTypeInfoLight]retain];
//	[infoButton addTarget:self 
//                   action:@selector(infoButtonClicked:) 
//         forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Setting"
                                                                             style:UIBarButtonItemStyleDone 
                                                                            target:self 
                                                                            action:@selector(setting)];
    
    [self.navigationController setNavigationBarHidden:NO];
    tableViewMem.backgroundView = nil;
    tableViewMem.backgroundColor = [UIColor clearColor];
    //arrayElement = [[NSMutableArray alloc] init];
    
    
    //    [arrayElement addObject:@"The Gold And Oil Guy"];
    //    
    //    [arrayElement addObject:@"Active Trading Partners"];
    //    
    //    [arrayElement addObject:@"The Market Trend Forecast"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading...";
    
    modal = [[ModalController alloc] init];
    modal.delegate = self;
    [modal sendTheRequestWithPostString:nil withURLString:[NSString stringWithFormat:URLSUB,[ModalController getContforKey:USERNAME]]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)setting{
	
	//[self.view setBackgroundColor:BACKGROUND_COLOR];
	
	SettingViewController *mySettingViewController = [[SettingViewController alloc]init];
	mySettingViewController.hidesBottomBarWhenPushed = YES;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: .75];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
	[[self navigationController] pushViewController:mySettingViewController animated:NO];
	[UIView commitAnimations];
	
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
    cell.textLabel.text = [[[[arrayElement objectAtIndex:indexPath.section] objectForKey:@"text"] componentsSeparatedByString:@"-"] objectAtIndex:0];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.accessoryType = 1;
    
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
