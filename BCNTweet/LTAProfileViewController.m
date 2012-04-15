//
//  LTAProfileViewController.m
//  BCNTweet
//
//  Created by Patryk Filip Peszko on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LTAProfileViewController.h"
#import "LTAAppDelegate.h"
#import <Twitter/Twitter.h>

@interface LTAProfileViewController ()

- (void)updateUserData:(NSDictionary *)userData;

@end

@implementation LTAProfileViewController

@synthesize screenName = _screenName;
@synthesize profileName = _profileName;
@synthesize description = _description;
@synthesize tweetsCount = _tweetsCount;
@synthesize favoritesCount = _favoritesCount;
@synthesize followersCount = _followersCount;
@synthesize followingCount = _followingCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadUser];
}

- (void)viewDidUnload
{
    [self setProfileName:nil];
    [self setDescription:nil];
    [self setTweetsCount:nil];
    [self setFavoritesCount:nil];
    [self setFollowersCount:nil];
    [self setFollowingCount:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)loadUser
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        NSMutableString *url = [NSString stringWithFormat:@"http://api.twitter.com/1/users/show.json?include_entities=true&screen_name=%@", self.screenName];
        NSURL *userURL = [NSURL URLWithString:url];
        NSDictionary *parameters = [NSDictionary dictionary];
        LTAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        TWRequest *userRequest = [[TWRequest alloc] initWithURL:userURL parameters:parameters requestMethod:TWRequestMethodGET];
        userRequest.account = appDelegate.userAccount;

        [userRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            NSError *jsonError;
            if (!error) {
                id feedData = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                if (!jsonError) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self updateUserData:feedData];
                    });
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
                                                                    message:[error localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
        }];
    });
}

- (void)updateUserData:(NSDictionary *)userData
{
    NSLog(@"user data %@", userData);
    self.profileName.text = [userData objectForKey:@"name"];
    self.description.text = [userData objectForKey:@"description"];
    self.tweetsCount.text = [[userData objectForKey:@"statuses_count"] stringValue];
    self.favoritesCount.text = [[userData objectForKey:@"favourites_count"] stringValue];
    self.followersCount.text = [[userData objectForKey:@"followers_count"] stringValue];
    self.followingCount.text = [[userData objectForKey:@"friends_count"] stringValue];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)close:(id)sender {
}
@end
