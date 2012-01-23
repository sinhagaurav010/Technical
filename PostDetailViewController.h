//
//  PostDetailViewController.h
//  TechnicalApp
//
//  Created by s dhillon on 10/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "ModalController.h"
#import "XMLReader.h"
#import "MBProgressHUD.h"

@interface PostDetailViewController : UIViewController<ModalDelegate,UIWebViewDelegate>
{
    NSMutableData *receivedData;
    IBOutlet UILabel *lableDate;
    IBOutlet UILabel *lableName;
    IBOutlet UIWebView *webSub;
    ModalController *modal;
}
@property(retain)NSMutableDictionary *dictPostDetail;
@end
