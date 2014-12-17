//
//  ViewController.m
//  TwitterCloneV2
//
//  Created by Sam Wong on 12/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import "ViewController.h"
#import "Tweet.h"
#import <Social/Social.h>
#import "NetworkController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) ACAccount *account;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TWEET_CELL"];
    [_tableView setRowHeight: UITableViewAutomaticDimension];
    [_tableView setEstimatedRowHeight:68.0];
    
    [[NetworkController sharedInstance] fetchHomeTimeLine:nil maxID:nil completionHandler:^(NSError *error, NSMutableArray *tweets) {
        //
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
