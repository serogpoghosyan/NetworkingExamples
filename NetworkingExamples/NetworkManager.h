//
//  NetworkManager.h
//  GitAnotherExample
//
//  Created by Seryozha Poghosyan on 3/27/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)loginWithTestUser:(void (^)(NSDictionary *info))completionHandler;
- (void)loadProjects;
- (void)loadUserList:(void (^)(NSArray *users, NSError *error))completionHandler;

@end
