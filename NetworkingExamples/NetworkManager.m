//
//  NetworkManager.m
//  GitAnotherExample
//
//  Created by Seryozha Poghosyan on 3/27/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager () <NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableData *data;

@end

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[NetworkManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        self.data = [NSMutableData data];
    }
    return self;
}

- (void)loginWithTestUser:(void (^)(NSDictionary *info))completionHandler {
    NSURL *url = [NSURL URLWithString:@"http://hub.attask.com/attask/api/v5.0/Project/metadata"];
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            switch ([(NSHTTPURLResponse *)response statusCode]) {
                case 200:
                {
                    NSError *jsonError;
                    NSDictionary *dictionaryData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                    if (!jsonError) {
                        NSLog(@"keys - %@", dictionaryData.allKeys);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completionHandler(dictionaryData);
                        });
                    } else {
                        NSLog(@"Parsing failed with error - %@", jsonError.description);
                    }
                }
                    break;
                    
                default:
                    break;
            }
        } else {
            NSLog(@"Connection error");
        }
    }];
    [task resume];
}

- (void)loadProjects {
    NSURL *url = [NSURL URLWithString:@"http://hub.attask.com/attask/api/v5.0/Project/metadata"];
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url];
    [task resume];
}

#pragma mark - NSURLSessionDelegate methods

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    if ([(NSHTTPURLResponse *)response statusCode] == 200) {
        //
    }
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    [self.data appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if (error) {
        NSLog(@"Connection error - %@", error);
    } else {
        NSError *jsonError;
        NSDictionary *dictionaryData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
        NSLog(@"JSON error - %@", jsonError);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NetworkManagerProjectsNotification" object:dictionaryData];
        });
    }
}

@end
