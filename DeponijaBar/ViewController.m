//
//  ViewController.m
//  DeponijaBar
//
//  Created by Kerim Njuhović on 11/6/15.
//  Copyright © 2015 Kerim Njuhovic. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize thinkGreenImage, animatedLabel, buttonProperty;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // setting garadient effect of color for background and some toher set up
    [self backgroundColorGradientEffect];
    [self circleProgressAnimation];
    thinkGreenImage.alpha = 0;
    [self fadeInImage];
    // animation for label
    [self.animatedLabel animateWithWords:@[@"Think Different",
                                           @"Think Green",
                                           @"Change The World"
                                          ]
                             forDuration:2.0f
                           withAnimation:ATAnimationTypeSlideTopInBottomOut];
    buttonProperty.enabled = NO;
    buttonProperty.alpha = 0;
    // calling function to button alpha after 5 seconds
    [self performSelector:@selector(fadeInButton) withObject:self afterDelay:2.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backgroundColorGradientEffect{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:99.0/255.0f green:186.0/255.0f blue:177/255.0f alpha:1.0] CGColor], (id)[[UIColor colorWithRed:92.0/255.0f green:186/255.0f blue:90/255.0f alpha:1.0] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

// returning white status bar
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)circleProgressAnimation{
    int radius = 140;
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    circle.position = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
                                  CGRectGetMidY(self.view.frame)-radius);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor whiteColor].CGColor;
    circle.lineWidth = 1;
    
    // Add to parent layer
    [self.view.layer addSublayer:circle];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 3.0; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}

- (void)fadeInImage
{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:6.0];
    thinkGreenImage.alpha = 1.0;
    [UIView commitAnimations];
    
}
-(void)fadeInButton{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:3.0];
    buttonProperty.alpha = 1.0;
    [UIView commitAnimations];
    buttonProperty.enabled = YES;
}

- (IBAction)goAnotherController:(id)sender {
}
@end
