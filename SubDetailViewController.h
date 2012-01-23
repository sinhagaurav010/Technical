//
//  SubDetailViewController.h
//  TechnicalApp
//
//  Created by preet dhillon on 10/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "PostDetailViewController.h"

@interface SubDetailViewController : UIViewController
{
    IBOutlet UITableView *tableSub;
    NSString *stringSubID;
    NSMutableArray *arraySub;
}
-(void)saveTheUsedPostID:(NSInteger)index;

-(BOOL)isAlreadyRead:(NSInteger)index;
@property(retain)NSMutableDictionary *dictDetail;
@property(retain)NSString *stringTitle;
@end
