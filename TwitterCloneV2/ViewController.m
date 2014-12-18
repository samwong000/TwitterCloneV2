^{
    i
}//
//  ViewController.m
//  TwitterCloneV2
//
//  Created by Sam Wong on 12/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import "ViewController.h"
#import "Tweet.h"
#import "NetworkController.h"
#import <Social/Social.h>
#import <UIKit/UIKit.h>

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) ACAccount *account;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
//@property (nonatomic, strong)
@end

typedef NS_ENUM(NSInteger, HomeViewControllerMode) {
    HomeViewControllerModeDefault,
    HomeViewControllerModeUser
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up UI
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.estimatedRowHeight = 200;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    // set up Xib
    [_tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TWEET_CELL"];
    [_tableView setRowHeight: UITableViewAutomaticDimension];
    [_tableView setEstimatedRowHeight:68.0];
    
    // scroll up to refresh
    _refreshControl = [UIRefreshControl new];
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Release to refresh"];
    [_refreshControl addTarget:self action: @selector(fetchNewHomeLine:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    
    // add icon to navigation bar
    
    
//    
//    [[NetworkController sharedInstance] fetchHomeTimeLine:nil maxID:nil completionHandler:^(NSError *error, NSMutableArray *tweets) {
//        //
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchNewHomeLine:(id *) sender {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TWEET_CELL" forIndexPath:indexPath];
    Tweet *newTweet = _tweets[indexPath.row];
    
    if (indexPath.row >= _tweets.count) {
        
    }
    
    //cell.textLabel.text = [newTweet.title];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tweets.count;
}


@end
