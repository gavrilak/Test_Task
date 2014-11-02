//
//  DSViewController.h
//  TestTAsk
//
//  Created by Dima on 11/2/14.
//  Copyright (c) 2014 Dima Soldatenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSCell.h"

@interface DSViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate, NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;


@end

