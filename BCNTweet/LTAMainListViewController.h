//
//  LTAMainListViewController.h
//  BCNTweet
//
//  Created by Patryk Filip Peszko on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTAProfileViewController.h"

@interface LTAMainListViewController : UITableViewController <LTAProfileViewControllerDelegate>

- (IBAction)tweet:(id)sender;

@end
