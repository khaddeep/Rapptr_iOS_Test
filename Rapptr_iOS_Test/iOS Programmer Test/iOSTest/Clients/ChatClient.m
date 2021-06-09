//
//  ChatClient.m
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import "ChatClient.h"

@interface ChatClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ChatClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 **/

- (void)fetchChatData:(void (^)(NSArray<Message *> *))completion withError:(void (^)(NSString *error))errorBlock
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.rapptrlabs.com/Tests/scripts/chat_log.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            errorBlock(error.localizedDescription);
            dispatch_semaphore_signal(sema);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSError *parseError = nil;
            NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
            NSDictionary *parsedObject = [[NSDictionary alloc] initWithDictionary: responseDictionary];
            NSMutableArray *messages = [[NSMutableArray alloc] init];
            NSArray *results = [parsedObject valueForKey:@"data"];
            for (NSDictionary *aMessage in results) {
                Message *msg    = [[Message alloc] init];
                msg.userID    = aMessage[@"user_id"];
                msg.username     = aMessage[@"name"];
                NSURL *url = [[NSURL alloc] initWithString:aMessage[@"avatar_url"]];
                msg.avatarURL     = url;
                msg.text     = aMessage[@"message"];
                
                //5. Add message to messages
                [messages addObject: msg];
            }
            completion(messages);
            dispatch_semaphore_signal(sema);
        }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

@end

