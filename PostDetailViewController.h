//
//  PostDetailViewController.h
//  TechnicalApp
//
//  Created by preet dhillon on 10/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface PostDetailViewController : UIViewController
{
    IBOutlet UILabel *lableDate;
    IBOutlet UILabel *lableName;
    IBOutlet UIWebView *webSub;
}
@property(retain)NSMutableDictionary *dictPostDetail;
@end
