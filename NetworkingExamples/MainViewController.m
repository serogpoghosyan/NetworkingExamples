//
//  MainViewController.m
//  GitAnotherExample
//
//  Created by Seryozha Poghosyan on 3/22/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)downlaodAction {
    dispatch_queue_t downloadQueue = dispatch_queue_create("Image Download Queue", NULL);
    dispatch_async(downloadQueue, ^{
        NSString *str = @"https://static.pexels.com/photos/2324/skyline-buildings-new-york-skyscrapers.jpg";
        NSURL *imageURL = [NSURL URLWithString:str];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            [self.imageView setImage:image];
        });
    });
}

@end
