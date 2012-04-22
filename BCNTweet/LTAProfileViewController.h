//
//  LTAProfileViewController.h
//  BCNTweet
//
//  Created by Patryk Filip Peszko on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTAProfileViewController;

@protocol LTAProfileViewControllerDelegate <NSObject>

- (void)didFinished:(LTAProfileViewController *)controller;

@end

@interface LTAProfileViewController : UIViewController

@property (weak, nonatomic) id <LTAProfileViewControllerDelegate> delegate;

@property (strong, nonatomic) NSString *screenName;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *tweetsCount;
@property (weak, nonatomic) IBOutlet UILabel *favoritesCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;

- (IBAction)close:(id)sender;
@end
