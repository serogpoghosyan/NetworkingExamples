//
//  ViewController.m
//  NetworkingExamples
//
//  Created by Seryozha Poghosyan on 3/29/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    [[NetworkManager sharedManager] loginWithTestUser:^(NSDictionary *info) {
        // refresh UI
        // do something with data
    }];
     */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedProjects:) name:@"NetworkManagerProjectsNotification" object:nil];
    [[NetworkManager sharedManager] loadProjects];
    
    [self updateData];
}

- (void)updateData {
    [[NetworkManager sharedManager] loadUserList:^(NSArray *users, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", users);
            // self.users = users;
            // [self.tableView reloadData];
        }
    }];
}

- (void)receivedProjects:(NSNotification *)notification {
    NSDictionary *data = notification.object;
    NSLog(@"data - %@", data);
    // refresh UI
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
