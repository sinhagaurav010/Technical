//
//  LoginViewController.m
//  TechnicalApp
//
//  Created by preet dhillon on 17/11/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

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
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    //txtfld = [[UITextField alloc]init];
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBarHidden=YES;
    [loginScalView setContentSize:CGSizeMake(0, 700)];
    
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
#pragma mark - UITableView 
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
//{
//    UILabel *sectionHeader = [[[UILabel alloc] initWithFrame:CGRectNull] autorelease];
//    sectionHeader.backgroundColor = [UIColor clearColor];
//    sectionHeader.textAlignment = UITextAlignmentCenter;
//    sectionHeader.font = [UIFont systemFontOfSize:20];
//    sectionHeader.textColor = [UIColor blackColor];
//        sectionHeader.text = [NSString stringWithFormat:@"Members Login"];
//        //[ addSubview:segmentSetting];
//    
//    return sectionHeader;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
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
        
        label1=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 120, 50)];
        label1.backgroundColor=[UIColor clearColor];
        label1.font=[UIFont boldSystemFontOfSize:20];
        [cell.contentView addSubview:label1];
    }
    if(indexPath.row==0)
    {
        label1.text=@"Username:";
        
        fieldUser=[[UITextField alloc]initWithFrame:CGRectMake(130, 20, 170, 70)];
        fieldUser.backgroundColor=[UIColor clearColor];
        fieldUser.delegate=self;
        [cell.contentView addSubview:fieldUser];
        
    }
    if(indexPath.row==1)
    {
        label1.text=@"Password:";
        fieldPass=[[UITextField alloc]initWithFrame:CGRectMake(130, 20, 170, 70)];
        fieldPass.backgroundColor=[UIColor clearColor];
        fieldPass.delegate=self;
        fieldPass.secureTextEntry = YES;
        [cell.contentView addSubview:fieldPass];
    }

	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section 
{
        return 0;
}

-(void)result
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" 
                                                 message:@"Incorrect Username Or Password" 
                                                delegate:nil 
                                       cancelButtonTitle:@"OK" 
                                       otherButtonTitles: nil];
    [alert show];

}



-(IBAction)clickToEnter:(id)sender
{
    [txtfld resignFirstResponder];
    
    [loginScalView setContentOffset:CGPointMake(0, 0) animated:YES];

    if([[fieldUser text] length]>0 && [[fieldPass text] length]>0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText = @"Loading...";
        
        modal = [[ModalController alloc] init];
        modal.delegate = self;
        [modal sendTheRequestWithPostString:nil withURLString:[NSString stringWithFormat:URLLOGIN,[fieldUser text],[fieldPass text]]];
    }
    else
    {
        [ModalController showTheAlertWithMsg:@"All fields are required" withTitle:@"Info" inController:self];
    }
//    [NSTimer scheduledTimerWithTimeInterval:1
//                                     target:self 
//                                   selector:@selector(result) 
//                                   userInfo:nil
//                                    repeats:NO];
    
   
}

-(void)getdata
{
    NSLog(@"ksdvfv%@",modal.stringRx);
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];

    
    NSDictionary *_xmlDictionaryData = [[XMLReader dictionaryForXMLData:modal.dataXml  error:nil] retain];
    NSLog(@"%@",_xmlDictionaryData);
    
    if([[_xmlDictionaryData objectForKey:@"userfound"] isEqualToString:@"yes"])
    {
        MemberAreaViewController *memberController = [[MemberAreaViewController alloc] init];
        [ModalController saveTheContent:[fieldUser text] withKey:USERNAME];
        [self.navigationController pushViewController:memberController animated:YES];
        
    }
    else
    {
        [ModalController showTheAlertWithMsg:@"Wrong Username or Password!" 
                                   withTitle:@"Error"
                                inController:self];

    }
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


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
     txtfld  = textField;
    [loginScalView setContentOffset:CGPointMake(0, 100) animated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
      
    [textField resignFirstResponder];
  
    [loginScalView setContentOffset:CGPointMake(0, 0) animated:YES];
    return NO;
}
@end
