//
//  LoginClient.m
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import "LoginClient.h"

@interface LoginClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation LoginClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 **/

- (void)loginWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(NSDictionary *))completion
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.rapptrlabs.com/Tests/scripts/login.php"]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:10.0];
    NSDictionary *headers = @{
      @"Accept": @"application/json"
    };
    [request setAllHTTPHeaderFields:headers];
    NSArray *parameters = @[
      @{ @"name": @"email", @"value": email },
      @{ @"name": @"password", @"value": password },
    ];
    NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
    NSError *error;
    NSMutableString *body = [NSMutableString string];
    for (NSDictionary *param in parameters) {
      [body appendFormat:@"--%@\r\n", boundary];
      [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", param[@"name"]];
      [body appendFormat:@"%@", param[@"value"]];
    }
    [body appendFormat:@"\r\n--%@--\r\n", boundary];
    NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"%@", error);
          completion(error);
        dispatch_semaphore_signal(sema);
      } else {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"%@",responseDictionary);
          completion(responseDictionary);
        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

@end
