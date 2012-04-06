//
//  LTAFirstViewController.m
//  BCNTweet
//
//  Created by Patryk Filip Peszko on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LTAMentionsViewController.h"

@interface LTAMentionsViewController () {

}

@property (nonatomic, strong) NSString *twitterURL;

@end

@implementation LTAMentionsViewController

@dynamic twitterURL;

- (void)viewDidLoad
{
    self.twitterURL = @"http://api.twitter.com/1/statuses/mentions.json";
    [super viewDidLoad];
}

@end
