//
//  ViewController.h
//  DeponijaBar
//
//  Created by Kerim Njuhović on 11/6/15.
//  Copyright © 2015 Kerim Njuhovic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATLabel.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *thinkGreenImage;
@property (weak, nonatomic) IBOutlet ATLabel *animatedLabel;
- (IBAction)goAnotherController:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonProperty;


@end

