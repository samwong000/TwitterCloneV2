//
//  TweetCell.h
//  TwitterCloneV2
//
//  Created by Sam Wong on 17/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UILabel *userName;
@property (nonatomic, weak) IBOutlet UILabel *alias;
@property (nonatomic, weak) IBOutlet UILabel *tweetText;
@property (nonatomic, weak) IBOutlet UILabel *time;
@property (nonatomic, weak) IBOutlet UILabel *favoriteCount;
@property (nonatomic, weak) IBOutlet UILabel *retweet;
@end
