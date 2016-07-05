//
//  politicianViewController.h
//  DeponijaBar
//
//  Created by Kerim Njuhović on 11/7/15.
//  Copyright © 2015 Kerim Njuhovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface politicianViewController : UIViewController
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backButtonProperty;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;

@property (weak, nonatomic) IBOutlet UILabel *cityMajors;



@end
