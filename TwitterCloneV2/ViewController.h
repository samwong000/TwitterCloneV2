//
//  ViewController.h
//  TwitterCloneV2
//
//  Created by Sam Wong on 12/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

