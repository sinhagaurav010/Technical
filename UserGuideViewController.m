//
//  UserGuideViewController.m
//  TechnicalApp
//
//  Created by Rohit Dhawan on 19/01/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "UserGuideViewController.h"

@implementation UserGuideViewController

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
    [self.navigationItem setTitle:@"User Guide"];
    
    NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"htm"];
    NSString *fileContents =[NSString stringWithContentsOfFile:urlAddress encoding:NSASCIIStringEncoding error:nil];
    
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [webViewWell loadHTMLString:fileContents baseURL:baseURL];
    [self.view addSubview:webViewWell];

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
