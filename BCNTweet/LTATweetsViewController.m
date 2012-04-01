//
//  LTAFirstViewController.m
//  BCNTweet
//
//  Created by Patryk Filip Peszko on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LTATweetsViewController.h"
#import "LTATweetCell.h"
#import "LTAAppDelegate.h"
#import <Twitter/Twitter.h>

@interface LTATweetsViewController () {
    NSArray *tweets;
}

- (void)getFeed;
- (void)updateFeed:(id)feedData;

@end

@implementation LTATweetsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    LTAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (appDelegate.userAccount) {
        [self getFeed];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getFeed)
                                                 name:@"TwitterAccountAcquiredNotification"
                                               object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    LTATweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.userNameLabel.text = @"Here";

    return cell;
}

- (void)getFeed
{
    NSURL *feedURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"30", @"count", nil];
    UIApplication *application = [UIApplication sharedApplication];
    TWRequest *twitterFeed = [[TWRequest alloc] initWithURL:feedURL
                                                 parameters:parameters
                                              requestMethod:TWRequestMethodGET];
    LTAAppDelegate *appDelegate = [application delegate];
    twitterFeed.account = appDelegate.userAccount;
    application.networkActivityIndicatorVisible = YES;

    [twitterFeed performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSError *jsonError = nil;
        if (!error) {
            id feedData = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];

            if (!jsonError) {
                [self updateFeed:feedData];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:[jsonError localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:[jsonError localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
     application.networkActivityIndicatorVisible = NO;
     }];
}

- (void)updateFeed:(id)feedData
{
    tweets = feedData;
    [self.tableView reloadData];
    NSLog(@"feed data %@", feedData);
}

@end
