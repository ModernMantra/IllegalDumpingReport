//
//  politicianViewController.m
//  DeponijaBar
//
//  Created by Kerim Njuhović on 11/7/15.
//  Copyright © 2015 Kerim Njuhovic. All rights reserved.
//

#import "politicianViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define iPad_DEVICE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
UILabel *dynamicLabelOne, *dynamicLabelTwo, *dynamicLabelThree, *dynamicLabelFour;
static float width = 240, height = 80;
@interface politicianViewController ()

@end

@implementation politicianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image1.alpha = 0;
    self.image2.alpha = 0;
    self.image3.alpha = 0;
    self.image4.alpha = 0;
    self.cityMajors.alpha = 0;
    [self fadeInImages];
    double delayInSeconds = 1.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self makeX];
    });
    
    
    popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self drawLines];
    });
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:1.3 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
    }];
    [self changePostionOfLabels];
    [self fadeInMajors];
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
    line.strokeColor = [UIColor colorWithRed:39/255.0f green:44/255.0f blue:50/255.0f alpha:1.0].CGColor;
    [self.view.layer insertSublayer:line atIndex:0];
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    drawAnimation.duration            = 0.5; // 0.5
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    [line addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}


- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)makeX{
    CGPoint coordinates = self.backButtonProperty.frame.origin;
    CGFloat x = coordinates.x;
    CGFloat y = coordinates.y;
    [self makeX:x and:y];
}
#pragma mark Hard Coded Things
-(void)drawLines{
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(10,230)];
    [linePath addLineToPoint:CGPointMake(365, 230)];
    
    [linePath moveToPoint:CGPointMake(365,380)];
    [linePath addLineToPoint:CGPointMake(10, 380)];
    
    [linePath moveToPoint:CGPointMake(10,530)];
    [linePath addLineToPoint:CGPointMake(365, 530)];

    line.path = linePath.CGPath;
    line.fillColor = nil;
    line.opacity = 1.0;
    line.lineWidth = 1.0;
    line.strokeColor = [UIColor blackColor].CGColor;
    [self.view.layer insertSublayer:line atIndex:0];
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    drawAnimation.duration            = 1.2; // 0.5
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    [line addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}
-(void)fadeInImages{
    double delayInSeconds = 1.23;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.image1.alpha = 1;
    });
    delayInSeconds += 0.4;
    popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.image2.alpha = 1;
    });
    delayInSeconds += 0.4;
    popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.image3.alpha = 1;
    });
    delayInSeconds += 0.4;
    popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.image4.alpha = 1;
    });
}
-(void)changePostionOfLabels{
    /*
     main offset from top of screen used for all positioning of labels and elements,
     it is different depending on device
     */
    int offset = (iPad_DEVICE)?(180):(90);
    int fontSize = 16;
    
    dynamicLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(-200, SCREEN_HEIGHT/6 + 10, width, height)];
    dynamicLabelOne.text=@"Lorem ipsum dolor sit amet, cum omittam appetere at, cu has agam eius persequeris. At duo salutatus aliquando, eam assum neglegentur.";
    dynamicLabelOne.textAlignment = NSTextAlignmentRight;
    dynamicLabelOne.textColor = [UIColor colorWithRed:112/255.0f green:171/255.0f blue:185/255.0f alpha:1.0f];
    dynamicLabelOne.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:fontSize];
    dynamicLabelOne.alpha = 0;
    dynamicLabelOne.numberOfLines = 0;
    [self.view addSubview:dynamicLabelOne];
    
    dynamicLabelTwo =[[UILabel alloc]initWithFrame:CGRectMake(-200, SCREEN_HEIGHT/6 + 150, width, height)];
    dynamicLabelTwo.text=@"Pri deleniti suscipit repudiandae ut, at graece deserunt nominati nam, cum veritus appetere at. Pri at scripta vituperata. Doming invenire.";
    dynamicLabelTwo.textAlignment = NSTextAlignmentRight;
    dynamicLabelTwo.textColor = [UIColor colorWithRed:112/255.0f green:171/255.0f blue:185/255.0f alpha:1.0f];
    dynamicLabelTwo.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:fontSize];
    dynamicLabelTwo.alpha = 0;
    dynamicLabelTwo.numberOfLines = 0;
    [self.view addSubview:dynamicLabelTwo];
    
    dynamicLabelThree =[[UILabel alloc]initWithFrame:CGRectMake(-200, SCREEN_HEIGHT/6 + 290, width, height)];
    dynamicLabelThree.text=@"Quis concludaturque ad vim, ea solet libris usu. Liber tacimates intellegat mei ea, dictas instructior ex nec. Delicata consequat eos te.";
    dynamicLabelThree.textAlignment = NSTextAlignmentRight;
    dynamicLabelThree.textColor = [UIColor colorWithRed:112/255.0f green:171/255.0f blue:185/255.0f alpha:1.0f];
    dynamicLabelThree.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:fontSize];
    dynamicLabelThree.alpha = 0;
    dynamicLabelThree.numberOfLines = 0;
    [self.view addSubview:dynamicLabelThree];
    
    dynamicLabelFour =[[UILabel alloc]initWithFrame:CGRectMake(-200, SCREEN_HEIGHT/6 + 430, width, height)];
    dynamicLabelFour.text=@"Mea eu sonet mucius pericula. An legimus omittantur eos, in modo timeam diceret usu. Quaeque quaestio adolescens per id, in part.";
    dynamicLabelFour.textAlignment = NSTextAlignmentRight;
    dynamicLabelFour.textColor = [UIColor colorWithRed:112/255.0f green:171/255.0f blue:185/255.0f alpha:1.0f];
    dynamicLabelFour.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:fontSize];
    dynamicLabelFour.alpha = 0;
    dynamicLabelFour.numberOfLines = 0;
    [self.view addSubview:dynamicLabelFour];

    // animate appearance of label one by one (connect headphones)
    [UIView animateWithDuration:0.9
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // x, y, width, height
                         dynamicLabelOne.frame = CGRectMake((SCREEN_WIDTH/2)-(width/2) + 30,SCREEN_HEIGHT/6 + 10, width, height);
                         dynamicLabelOne.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         // do something after animation finishes
                     }];
    // animation of label 'select desired mode'
    [UIView animateWithDuration:0.9
                          delay:0.7
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // x, y, width, height
                         dynamicLabelTwo.frame = CGRectMake((SCREEN_WIDTH/2)-(width/2)+30,SCREEN_HEIGHT/6 + 150, width, height);
                         dynamicLabelTwo.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         // do something after animation finishes
                     }];
    // animation of 'listen to chnages'
    [UIView animateWithDuration:0.9
                          delay:0.9
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // x, y, width, height
                         dynamicLabelThree.frame = CGRectMake((SCREEN_WIDTH/2)-(width/2)+30,SCREEN_HEIGHT/6 + 290, width, height);
                         dynamicLabelThree.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         //[UIView animateWithDuration:1.0 animations:^{button_property.alpha = 1.0f;}];
                         //[self animateLabelsOneByOne];
                     }];
    [UIView animateWithDuration:0.9
                          delay:1.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // x, y, width, height
                         dynamicLabelFour.frame = CGRectMake((SCREEN_WIDTH/2)-(width/2)+ 30,SCREEN_HEIGHT/6 + 430, width, height);
                         dynamicLabelFour.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         //[UIView animateWithDuration:1.0 animations:^{button_property.alpha = 1.0f;}];
                         //[self animateLabelsOneByOne];
                     }];

    
}
- (void)fadeInMajors
{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:1.0];
    self.cityMajors.alpha = 1.0;
    [UIView commitAnimations];
}



@end
