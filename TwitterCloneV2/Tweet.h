//
//  Tweet.h
//  TwitterCloneV2
//
//  Created by Sam Wong on 14/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tweet : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic) NSInteger favouriteCount;
@property (nonatomic) NSInteger retweets;
@property (nonatomic, strong) NSString *tweetId;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *profileImageURL;
@property (nonatomic, strong) UIImage *profileImage;

- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary;
+ (NSMutableArray *) parseJSONDataIntoTweets:(NSData *) rawJSONData;

@end
