//
//  LTAAppDelegate.h
//  BCNTweet
//
//  Created by Patryk Filip Peszko on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>

@interface LTAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableDictionary *profileImages;
@property (strong, nonatomic) ACAccount *userAccount;
@property (strong, nonatomic) ACAccountStore *accountStore;

@end
