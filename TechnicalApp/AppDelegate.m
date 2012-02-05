//
//  AppDelegate.m
//  TechnicalApp
//
//  Created by preet dhillon on 17/11/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Constant.h"

@implementation AppDelegate

@synthesize window = window;

- (void)dealloc
{
    [window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /////////For push notification
    
    [[UIApplication sharedApplication] 
	 registerForRemoteNotificationTypes:
	 (UIRemoteNotificationTypeAlert | 
	  UIRemoteNotificationTypeBadge | 
	  UIRemoteNotificationTypeSound)];

    NSDictionary *tmpDic = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    
    //if tmpDic is not nil, then your app is launched due to an APNs push, therefore check this NSDictionary for further information
    if (tmpDic != nil) {
        NSLog(@" - launch options dict has something ");
        NSLog(@" - badge number is %@ ", [[tmpDic objectForKey:@"aps"] objectForKey:@"badge"]);
        NSLog(@" - ");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QuickCheck" message:@"New version of QuickCheck is available. Do you want to upgrade Now?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
        alert.delegate = self;
        alert.tag = 333;
        [alert show];
        [alert release];
        
    } 
    
    
    totalrem = 0;
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    if(![ModalController    getContforKey:USERNAME])
    {
        LoginViewController *login=[[LoginViewController alloc]init];
        navigation=[[UINavigationController alloc]initWithRootViewController:login];
    }
    else
    {
        MemberAreaViewController *MemberAreaController=[[MemberAreaViewController alloc]init];
        navigation=[[UINavigationController alloc]initWithRootViewController:MemberAreaController];
        
    }
    [self.window addSubview:navigation.view];
    
    [self.window makeKeyAndVisible];
    
    NSLog(@"Registering for push notifications...");    
        
    return YES;
}

//- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 
//{ 
//	
//    NSLog(@"devToken=%@",deviceToken);
//	NSString *URLString = [[UIDevice alloc] name];
//	NSString *dt = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"&lt;&gt;"]];
//    dt = [dt stringByReplacingOccurrencesOfString:@" " withString:@""];
//	dt = [dt stringByReplacingOccurrencesOfString:@"<" withString:@""];
//    dt = [dt stringByReplacingOccurrencesOfString:@">" withString:@""];
//	
//    NSString *urlTemp = [NSString stringWithFormat:@"http://www.thetechnicaltraders.com/index.php?easyapns=register&task=register&appname=TechnicalApp&appversion=1.0&deviceuid=%@&devicetoken=%@&devicemodel=%@&devicename=%@&deviceversion=%@&pushbadge=enabled&pushalert=enabled&pushsound=enabled",[[UIDevice currentDevice] uniqueIdentifier],dt,[[UIDevice currentDevice] model],URLString,[[UIDevice currentDevice] systemVersion]];
////	NSLog(@"%@",urlTemp);
//	NSString *urlt = [urlTemp stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//    NSLog(@"StrURL=%@", urlt);
//    NSURL *url = [[NSURL alloc] initWithString:[urlTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//	//NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:URLString];
//    NSLog(@"FullURL=%@", url);
//	
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//	
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//	NSString *webpage = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    //NSLog(@"%@",webpage);
//    
//    [url release];
//    [request release];
//    
//    
//	
//}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	
     
	// Get Bundle Info for Remote Registration (handy if you have more than one app)
	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
	// Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
	
	// Set the defaults to disabled unless we find otherwise...
	NSString *pushBadge = @"disabled";
	NSString *pushAlert = @"disabled";
	NSString *pushSound = @"disabled";
	
	// Check what Registered Types are turned on. This is a bit tricky since if two are enabled, and one is off, it will return a number 2... not telling you which
	// one is actually disabled. So we are literally checking to see if rnTypes matches what is turned on, instead of by number. The "tricky" part is that the 
	// single notification types will only match if they are the ONLY one enabled.  Likewise, when we are checking for a pair of notifications, it will only be 
	// true if those two notifications are on.  This is why the code is written this way ;)
	if(rntypes == UIRemoteNotificationTypeBadge){
		pushBadge = @"enabled";
	}
	else if(rntypes == UIRemoteNotificationTypeAlert){
		pushAlert = @"enabled";
	}
	else if(rntypes == UIRemoteNotificationTypeSound){
		pushSound = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)){
		pushBadge = @"enabled";
		pushAlert = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)){
		pushBadge = @"enabled";
		pushSound = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)){
		pushAlert = @"enabled";
		pushSound = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)){
		pushBadge = @"enabled";
		pushAlert = @"enabled";
		pushSound = @"enabled";
	}
	
	// Get the users Device Model, Display Name, Unique ID, Token & Version Number
	UIDevice *dev = [UIDevice currentDevice];
	NSString *deviceUuid = dev.uniqueIdentifier;
    NSString *deviceName = dev.name;
	NSString *deviceModel = dev.model;
	NSString *deviceSystemVersion = dev.systemVersion;
	
	// Prepare the Device Token for Registration (remove spaces and < >)
	NSString *deviceToken = [[[[devToken description] 
                               stringByReplacingOccurrencesOfString:@"<"withString:@""] 
                              stringByReplacingOccurrencesOfString:@">" withString:@""] 
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
	
	// Build URL String for Registration
	// !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
	// !!! SAMPLE: "secure.awesomeapp.com"
	NSString *host = @"www.thetechnicaltraders.com";
	
	// !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
	// !!! ( MUST START WITH / AND END WITH ? ). 
	// !!! SAMPLE: "/path/to/apns.php?"
	NSString *urlString = [NSString stringWithFormat:@"/index.php?easyapns=register&task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, deviceToken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
	
	// Register the Device Data
	// !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSLog(@"Register URL: %@", url);
	NSLog(@"Return Data: %@", returnData);
	

}

/**
 * Failed to Register for Remote Notifications
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	
 	
	NSLog(@"Error in registration. Error: %@", error);
	
}

/**
 * Remote Notification Received while application was open.
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	     
	NSLog(@"remote notification: %@",[userInfo description]);
	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	
	NSString *alert = [apsInfo objectForKey:@"alert"];
	NSLog(@"Received Push Alert: %@", alert);
	
	NSString *sound = [apsInfo objectForKey:@"sound"];
	NSLog(@"Received Push Sound: %@", sound);
	
	NSString *badge = [apsInfo objectForKey:@"badge"];
	NSLog(@"Received Push Badge: %@", badge);
	application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
	
    
    NSLog(@"%@",userInfo);
    UIAlertView *alertv = [[UIAlertView alloc] initWithTitle:@"QuickCheck" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    
    alertv.tag = 444;
    [alertv show];
    [alertv release];

}
//- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err { 
//	
//    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QuickCheck" message:@"Unable to register for push notification." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
//    alert.tag = 222;
//    [alert show];
//    [alert release];
//}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(alertView.tag == 444 || alertView.tag == 333){
//        if(buttonIndex == 1){
//            NSURL *url = [[NSURL alloc] initWithString:@"http://itunes.apple.com/us/app/quickcheck-fire-code/id449166394?mt=8&uo=4"];
//            [[UIApplication sharedApplication] openURL:url];
//            //[self openReferralURL:url];
//            [url release];
//            
//            
//        }
//    }
    
}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    NSLog(@"%@",userInfo);
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QuickCheck" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
//    alert.delegate = self;
//    
//    alert.tag = 444;
//    [alert show];
//    [alert release];
//    
//}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if([ModalController getContforKey:USERNAME])
        [UIApplication sharedApplication].applicationIconBadgeNumber = totalrem;
    
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
