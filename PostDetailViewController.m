//
//  PostDetailViewController.m
//  TechnicalApp
//
//  Created by preet dhillon on 10/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "PostDetailViewController.h"

@implementation PostDetailViewController
@synthesize dictPostDetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
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
//    webSub.backgroundColor   = [UIColor clearColor];
//    webSub.opaque   = 0;
    
    lableDate.text = [dictPostDetail objectForKey:POSTDATE];
    lableName.text = [dictPostDetail objectForKey:POSTTITLE];
    
    modal = [[ModalController alloc] init];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Loading...";
    
    webSub.delegate = self;
    
    [webSub loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:URLPOSTS,[dictPostDetail objectForKey:ID],[dictPostDetail  objectForKey:SUBID]]]]];
////    modal.delegate = self;
////    
////    [modal sendTheRequestWithPostString:nil withURLString:[NSString stringWithFormat:URLPOSTS,[dictPostDetail objectForKey:ID],[dictPostDetail  objectForKey:SUBID]]];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest 
//                                    requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:URLPOSTS,[dictPostDetail objectForKey:ID],[dictPostDetail  objectForKey:SUBID]]] 
//                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                    timeoutInterval:100];  
//    
////    NSData *postData = [string dataUsingEncoding:NSUTF8StringEncoding];
////    [request setHTTPBody:postData];
////    
////    [request setHTTPMethod:@"POST"];
//    receivedData = [[NSMutableData alloc] init];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc]
//                                   initWithRequest:request
//                                   delegate:self
//                                   startImmediately:YES];
//    
//    
//    [connection release];
//
//    
//    NSLog(@"---Here is link--%@",[NSString stringWithFormat:URLPOSTS,[dictPostDetail objectForKey:ID],[dictPostDetail  objectForKey:SUBID]]);
//    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
     
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [ModalController showTheAlertWithMsg:@"Error in Network" withTitle:@"Failed" inController:self];
}
     
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//	[receivedData appendData:data];    
//    //////NSLog(@"Received data is now %d bytes", [receivedData length]); 	  
//}
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//    [ModalController showTheAlertWithMsg:@"Error in Network" withTitle:@"Failed" inController:self];
//
////    stringRx = @"error";
////    [self.delegate getError];
//    //[[NSNotificationCenter defaultCenter] postNotificationName:ERROR object:nil];
//}
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//   // NSLog(@"%@",modal.stringRx);
//    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];   
//    [webSub loadHTMLString:[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] baseURL:nil];
//
////    dataXml = [[NSData alloc] initWithData:receivedData];
////    
////    stringRx = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
////    
////    ////NSLog(@"GetString-%@",stringRx);
////    [self.delegate getdata];
//    //[[NSNotificationCenter defaultCenter] postNotificationName:GETXML 
//    //                                                  object:nil];
//}
#define mark -ModalDelegate-

//-(void)getdata
//{
//    NSLog(@"%@",modal.stringRx);
//    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];   
//    [webSub loadHTMLString:modal.stringRx baseURL:nil];
//}
//
//-(void)getError
//{
//    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//    [ModalController showTheAlertWithMsg:@"Error in Network" withTitle:@"Failed" inController:self];
//}


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
