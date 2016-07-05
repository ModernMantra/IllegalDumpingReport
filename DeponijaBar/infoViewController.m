//
//  infoViewController.m
//  DeponijaBar
//
//  Created by Kerim Njuhović on 11/7/15.
//  Copyright © 2015 Kerim Njuhovic. All rights reserved.
//

#import "infoViewController.h"

@interface infoViewController ()

@end

@implementation infoViewController
@synthesize infoLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *labelText = @"This application covers environmental issues and engagement for society in order to improve the condition  of community and environment. Illegal dumps make big problems, so there is our app to help you.\n\nSimply take photo and automatically mail will be gnerated with taken photo and current coordinates of your location. Just send the mail to responsible persons and make your environment cleaner. Also there is list of all city majors responsible for our cleaner environemnt.";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    infoLabel.attributedText = attributedString ;
    infoLabel.textAlignment = NSTextAlignmentCenter;

    infoLabel.alpha = 0;
    [self performSelector:@selector(fadeInImage)
               withObject:self
               afterDelay:0.5];
    [self performSelector:@selector(makeX)
               withObject:self
               afterDelay:1.0];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)fadeInImage
{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:1.9];
    infoLabel.alpha = 1.0;
    [UIView commitAnimations];
}
-(void)fadeOutLabel{
    [UIView beginAnimations:@"fade out" context:nil];
    [UIView setAnimationDuration:1.0];
    infoLabel.alpha = 0;
    [UIView commitAnimations];
}

- (IBAction)back:(id)sender {
    [self fadeOutLabel];
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [[self.view.layer.sublayers objectAtIndex:0] removeFromSuperlayer];
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

-(void) makeX:(CGFloat)xCoordinate and:(CGFloat)yCoordinate{
    
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(xCoordinate + 7,yCoordinate + 6)];
    [linePath addLineToPoint:CGPointMake(xCoordinate + 40 , yCoordinate + 40)];
    [linePath moveToPoint:CGPointMake(xCoordinate + 40 , yCoordinate + 6)];
    [linePath addLineToPoint:CGPointMake(xCoordinate + 7, yCoordinate + 40)];
    line.path = linePath.CGPath;
    line.fillColor = nil;
    line.opacity = 1.0;
    line.lineWidth = 2;
    line.strokeColor = [UIColor whiteColor].CGColor;
    [self.view.layer insertSublayer:line atIndex:0];
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    drawAnimation.duration            = 0.5; // 0.5
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    [line addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}
-(void)makeX{
    CGPoint coordinates = self.backButton.frame.origin;
    CGFloat x = coordinates.x;
    CGFloat y = coordinates.y;
    [self makeX:x and:y];

}
@end
