//
//  NetworkController.h
//  TwitterCloneV2
//
//  Created by Sam Wong on 12/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "Tweet.h"

@interface NetworkController : NSObject
+ (instancetype) sharedInstance;
- (void) setup: (void(^) (NSString *errorString))completionHandler;
- (void) fetchUserTimeLine:(NSString *)userId completionHander: (void(^) (NSError *error, NSMutableArray *tweets))completionHander;
- (void) fetchHomeTimeLine: (NSString *)sinceID maxID:(NSString *)maxID completionHandler: (void(^)(NSError *error, NSMutableArray *tweets))completionHandler;
- (void) downloadImage: (Tweet *) tweet completionHandler: (void(^)(UIImage *image)) completionHandler;

@end
