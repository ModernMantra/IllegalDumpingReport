//
//  infoViewController.h
//  DeponijaBar
//
//  Created by Kerim Njuhović on 11/7/15.
//  Copyright © 2015 Kerim Njuhovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface infoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
- (IBAction)back:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@end
