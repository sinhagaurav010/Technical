//
//  MemberAreaViewController.m
//  TechnicalApp
//
//  Created by preet dhillon on 26/11/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

/*
 {
 "user-subscriptions" =     {
 ActiveTradingPartners =         {
 "@id" = 14;
 post =             (
 {
 "@id" = 8578;
 "post-date" = "2011-12-09 14:40:31";
 "post-title" = "Dec 9th- Position Notes, Updates, Email/Server issues";
 },
 {
 "@id" = 8576;
 "post-date" = "2011-12-09 08:49:18";
 "post-title" = "Dec 9th- Bonus Play Notes/SZYM Notes- Charts";
 },
 {
 "@id" = 8570;
 "post-date" = "2011-12-08 10:00:48";
 "post-title" = "Dec 8 Stop Loss on SZYM Advice";
 },
 {
 "@id" = 8568;
 "post-date" = "2011-12-08 07:18:29";
 "post-title" = "Dec 8th- Bonus Plays, Market Volatility, Updates";
 }
 );
 };
 FuturesTradingSignals =         {
 "@id" = 18;
 post =             (
 {
 "@id" = 3694;
 "post-date" = "2011-12-08 18:24:54";
 "post-title" = "Thursday End Of Day Update";
 },
 {
 "@id" = 3692;
 "post-date" = "2011-12-08 16:33:01";
 "post-title" = "Thursday Update";
 },
 {
 "@id" = 3690;
 "post-date" = "2011-12-08 08:08:50";
 "post-title" = "Thursday Dec 8th - Morning Video Report";
 },
 {
 "@id" = 3688;
 "post-date" = "2011-12-07 16:33:56";
 "post-title" = "Wednesday End Of Day Update";
 }
 );
 };
 OptionsTradingSignals =         {
 "@id" = 19;
 post =             (
 {
 "@id" = 2998;
 "post-date" = "2011-12-08 17:10:53";
 "post-title" = "Late Day Post - 12/08/11";
 },
 {
 "@id" = 2996;
 "post-date" = "2011-12-07 22:26:49";
 "post-title" = "Wednesday Evening Video - 12/07/11";
 },
 {
 "@id" = 2994;
 "post-date" = "2011-12-07 15:51:41";
 "post-title" = "Wednesday EOD Post - 12/07/11";
 },
 {
 "@id" = 2992;
 "post-date" = "2011-12-07 11:43:03";
 "post-title" = "GLD Trade Execution - 12/07/11";
 }
 );
 };
 TheGoldAndOilGuy =         {
 "@id" = 15;
 post =             (
 {
 "@id" = 3342;
 "post-date" = "2011-12-09 09:36:35";
 "post-title" = "Friday Morning Video Report";
 },
 {
 "@id" = 3338;
 "post-date" = "2011-12-08 18:25:33";
 "post-title" = "Thursday End Of Day Update";
 },
 {
 "@id" = 3333;
 "post-date" = "2011-12-08 14:21:18";
 "post-title" = "SP500 Trade Adjustment and Server Issue";
 },
 {
 "@id" = 3336;
 "post-date" = "2011-12-08 10:36:22";
 "post-title" = "Thursday Update";
 }
 );
 };
 };
 }
 */

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
    arrayElement = [[NSMutableArray alloc] init];
    
    NSLog(@"ksdvfv%@",modal.stringRx);
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    
    _xmlDictionaryData = [[XMLReader dictionaryForXMLData:modal.dataXml  error:nil] retain];
    NSLog(@"%@",_xmlDictionaryData);
    
    if(![[_xmlDictionaryData objectForKey:USERSUB] isKindOfClass:[NSString class]])
    {
        if([[_xmlDictionaryData objectForKey:USERSUB] objectForKey:SUBACTIVETRADING])
            [arrayElement addObject:@"Active Trading Partners"];
        
        if([[_xmlDictionaryData objectForKey:USERSUB] objectForKey:SUBFUTTRADSIG])
            [arrayElement addObject:@"Futures Trading Signals"];
        
        if([[_xmlDictionaryData objectForKey:USERSUB] objectForKey:SUBOPTTRADSIG])
            [arrayElement addObject:@"Options Trading Signals"];
        
        if([[_xmlDictionaryData objectForKey:USERSUB] objectForKey:SUBTHEGOLDOIL])
            [arrayElement addObject:@"The Gold And Oil Guy"];
        
        if([[_xmlDictionaryData objectForKey:USERSUB] objectForKey:SUBTHEMARTRNDFOR])
            [arrayElement addObject:@"The Market Trend Forecast"];
        
        [tableViewMem reloadData];
    }
    else
        [ModalController showTheAlertWithMsg:@"No Subscription Found" withTitle:@"Info" inController:self];
    
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
    [modal sendTheRequestWithPostString:nil withURLString:[NSString stringWithFormat:URLSUBDEC,[ModalController getContforKey:USERNAME]]];
    
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
    cell.textLabel.text = [arrayElement objectAtIndex:indexPath.section];
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
