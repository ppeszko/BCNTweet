//
//  LTAFirstViewController.m
//  BCNTweet
//
//  Created by Patryk Filip Peszko on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LTATweetsViewController.h"

@interface LTATweetsViewController () {

}

@property (nonatomic, strong) NSString *twitterURL;

@end

@implementation LTATweetsViewController

@dynamic twitterURL;

- (void)viewDidLoad
{
    self.twitterURL = @"http://api.twitter.com/1/statuses/home_timeline.json";
    [super viewDidLoad];
}

@end
