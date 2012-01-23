//
//  MemberAreaViewController.h
//  TechnicalApp
//
//  Created by preet dhillon on 26/11/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalController.h"
#import "MBProgressHUD.h"
#import "Constant.h"
#import "XMLReader.h"
#import "SettingViewController.h"
#import "SubDetailViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface MemberAreaViewController : UIViewController<ModalDelegate>
{
    ModalController *modal;
    IBOutlet UITableView *tableViewMem;
    NSMutableArray *arrayElement;
    NSMutableArray *arrayCount;
    NSMutableArray *subArry;
    NSDictionary *_xmlDictionaryData ;
    NSTimer *timer;
    
}
-(void)fetchData;

-(NSMutableArray *)sortAccordingTo:(NSInteger)index;

-(NSInteger)numberOfUnreadMsg:(NSInteger)index;

@end
