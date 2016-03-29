//
//  NetworkManager.m
//  GitAnotherExample
//
//  Created by Seryozha Poghosyan on 3/27/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager ()

@property (nonatomic, strong) NSURLSession *session;

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
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (void)loginWithTestUser {
    
}

- (void)loadProjects {
    
}

@end
