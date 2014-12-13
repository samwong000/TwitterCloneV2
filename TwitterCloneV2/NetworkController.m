//
//  NetworkController.m
//  TwitterCloneV2
//
//  Created by Sam Wong on 12/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import "NetworkController.h"

@interface NetworkController()
@property(nonatomic, strong) NSURLSession *session;
@property(nonatomic, strong) NSURLSessionConfiguration *configuration;
@end

@implementation NetworkController

+ (instancetype) sharedInstance {
    static NetworkController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype) init {
    _configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:_configuration];
    return self;
}

- (void) dealloc {
    
}

//    func fetchUserTimeLine (userId : String, completionHander: (errorDescription : String?, tweets: [Tweet]?) -> (Void) ) {
- (void) fetchUserTimeLine (NSString *userId, completionHander: (void(^)NSError *error, NSMutableArray *tweets))completionHander {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=", userId];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    SLRequest *twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:nil];
    
    
}


@end
