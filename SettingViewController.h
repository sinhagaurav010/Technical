//
//  SettingViewController.h
//  TechnicalApp
//
//  Created by preet dhillon on 01/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalController.h"
#import "Constant.h"
#import "LoginViewController.h"
@interface SettingViewController : UIViewController
{
    NSMutableArray *arrayElment;
    NSInteger checkedItem;
    IBOutlet UITableView *tableSetting;
}
-(IBAction)logOut:(id)sender;

@end
