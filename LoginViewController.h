//
//  LoginViewController.h
//  TechnicalApp
//
//  Created by preet dhillon on 17/11/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalController.h"
#import "MBProgressHUD.h"
#import "Constant.h"
#import "XMLReader.h"
#import "MemberAreaViewController.h"


@interface LoginViewController : UIViewController<UITextFieldDelegate,ModalDelegate>
{
    UILabel *label1;
    UITextField *txtfld;
    UITextField *fieldUser;
    UITextField *fieldPass;
    
    ModalController *modal;
    
    IBOutlet UITableView *loginTableView;
    IBOutlet UIScrollView *loginScalView;
}
-(IBAction)clickToEnter:(id)sender;
@end
