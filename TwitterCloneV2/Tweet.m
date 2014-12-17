//
//  Tweet.m
//  TwitterCloneV2
//
//  Created by Sam Wong on 14/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import "Tweet.h"

@interface Tweet()
@property (nonatomic, strong) NSDate *date;
@end

@implementation Tweet

- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary {
    self = [super init];
    
    if (self) {
        NSDictionary *userInfoDictionary = jsonDictionary[@"user"];
        
        _text = (NSString *)jsonDictionary [@"text"];
        _favouriteCount = (NSInteger)jsonDictionary[@"retweet_count"];
        _retweets = (NSInteger)jsonDictionary[@"retweet_count"];
        _tweetId = (NSString *)jsonDictionary[@"id_str"];
        
        _userName = userInfoDictionary[@"name"];
        _profileImageURL = userInfoDictionary[@"profile_image_url_https"];
    }
    
    return self;
};

+ (NSMutableArray *) parseJSONDataIntoTweets:(NSData *)rawJSONData {
    
    NSError *error = nil;
    NSMutableArray *tweets = [NSMutableArray new];
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options: NSJSONReadingAllowFragments error:&error];
    
    for (NSDictionary *tweetItem in jsonDictionary) {
        Tweet *tweetObject = [[Tweet alloc] initWithDictionary: tweetItem];
        [tweets addObject:tweetObject];
    }
    
    return tweets;
};



@end
