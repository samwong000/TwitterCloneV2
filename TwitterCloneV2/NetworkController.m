//
//  NetworkController.m
//  TwitterCloneV2
//
//  Created by Sam Wong on 12/12/2014.
//  Copyright (c) 2014 sam wong. All rights reserved.
//

#import "NetworkController.h"
#import "Tweet.h"

@interface NetworkController()
//@property(nonatomic, strong) NSURLSession *session;
//@property(nonatomic, strong) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) ACAccountType *accountType;
@property (nonatomic, strong) ACAccount *twitterAccount;
@property (nonatomic, strong) ACAccountStore *accountStore;
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
    _accountStore = [[ACAccountStore alloc] init];
    _accountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
//    _configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
//    _session = [NSURLSession sessionWithConfiguration:_configuration];
    return self;
}

- (void) dealloc {
}

- (void) setup: (void(^) (NSString *errorString)) completionHandler {
    [_accountStore requestAccessToAccountsWithType:_accountType options:nil completion:^(BOOL granted, NSError *error) {
        
        NSString *errorString;
        
        if (!granted) {
            errorString = @"Access to account not granted";
        } else {
            if (error != nil) {
                errorString = error.localizedDescription;
            }
        }
        NSLog(@"%@", errorString);

        if (errorString == nil) {
            ACAccountStore *accountStore = [ACAccountStore new];
            NSArray *accountArray = [accountStore accountsWithAccountType:_accountType];
            
            if (accountArray.count == 0) {
                errorString = @"No Twitter account configured";
            } else {
                _twitterAccount = (ACAccount *)accountArray.firstObject;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(errorString);
            });
        }
    }];
}

- (void) downloadImage: (Tweet *) tweet completionHandler: (void(^)(UIImage *image)) completionHandler {
    [_queue addOperationWithBlock:^{
        UIImage *profileImage;
        NSData *data = [_cache objectForKey:(tweet.profileImageURL)];
        
        // if image url in cache
        if (data != nil) {
            profileImage = [[UIImage alloc] initWithData:data];
        } else {
            NSURL *url = [[NSURL alloc] initWithString:tweet.profileImageURL];
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
            profileImage = [[UIImage alloc] initWithData:imageData];
            [_cache setObject:imageData forKey:tweet.profileImageURL];
        }
        
        tweet.profileImage = profileImage;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(profileImage);
        }];
    }];
    
//    Concurrently run two threads
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
//        //Background Thread
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            //Run UI Updates
//        });
//    });
    
}

//    func fetchUserTimeLine (userId : String, completionHander: (errorDescription : String?, tweets: [Tweet]?) -> (Void) ) {
- (void) fetchUserTimeLine:(NSString *)userId completionHander: (void(^)(NSError *error, NSMutableArray *tweets))completionHander {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=%@", userId];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:nil];
    
    request.account = self.twitterAccount;
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
     {
         if (error != nil) {
             NSLog(@"Error : %@", [error localizedDescription]);
             
         } else {
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
             NSInteger statusCode = [httpResponse statusCode];
             
             if (statusCode >= 200 && statusCode <=299) {
                 NSMutableArray *tweetArray = [Tweet parseJSONDataIntoTweets:responseData];
                 
                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                     completionHander(nil, tweetArray);
                 }];
//                 dispatch_async(dispatch_get_main_queue(), ^{
//                     completionHander(nil, nil);
//                 });
                 
             } else {
                 NSLog(@"%@", httpResponse);
             }

         }
     }];
    
}


- (void) fetchHomeTimeLine: (NSString *)sinceID maxID:(NSString *)maxID completionHandler: (void(^)(NSError *error, NSMutableArray *tweets))completionHandler {
//    NSString *parameter;
//    SLRequest *request;
    
    if (_twitterAccount == nil) {
        NSError *errorObj = [NSError errorWithDomain:@"No twitter account" code:100 userInfo:nil];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(errorObj, nil);
        }];
        
        
//        dispatch_async(dispatch_get_main_queue)
    } else {
        
        NSString *urlString;
        
        if (sinceID != nil) {
            urlString = [NSString stringWithFormat: @"https://api.twitter.com/1.1/statuses/home_timeline.json?since_id=%@", sinceID];
        } else if (maxID != nil) {
            urlString = [NSString stringWithFormat: @"https://api.twitter.com/1.1/statuses/home_timeline.json?max_id=%@", maxID];
        } else {
            urlString = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
        }
        
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:nil];
        request.account = _twitterAccount;
        
        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            if (error != nil) {
                NSLog(@"Error : %@", [error localizedDescription]);
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler(error, nil);
                }];
                
            } else {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
                NSInteger statusCode = [httpResponse statusCode];
                
                if (statusCode >= 200 && statusCode <=299) {
                    NSMutableArray *tweetArray = [Tweet parseJSONDataIntoTweets:responseData];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completionHandler(nil, tweetArray);
                    }];
                }
                
            }
        }];
        
    }
    
}


@end
