//
//  SecondViewController.m
//  DeponijaBar
//
//  Created by Kerim Njuhović on 11/7/15.
//  Copyright © 2015 Kerim Njuhovic. All rights reserved.
//
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#import "SecondViewController.h"
#import <MessageUI/MFMailComposeViewController.h> 
UIImage *image;
NSString *postalCode, *administrativeAre, *locality, *longitude, *lattitude, *responsibleMajor;
NSDictionary *cityMajors;
NSAttributedString *boldedCityMajor;
@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize textLabel1;

- (void)viewDidLoad {
    [super viewDidLoad];
    cityMajors = [[NSDictionary alloc] initWithObjectsAndKeys: @"Sarajevo",@"Denis Muhić",@"Bihac",@"Zlatko Zlatkic",@"Tuzla",@"Mirza Šabić", @"Mostar",@"Senad Senić", nil];
    // Do any additional setup after loading the view.
    textLabel1.alpha = 0;
    [self performSelector:@selector(animateLabel) withObject:self afterDelay:0.5];
    self.takePhotoButton.alpha = 0;
    self.politiciansButton.alpha = 0;
    self.infoButton.alpha = 0;
    [self appearButtons];
#pragma mark Location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void) animateLabel
{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:3.0];
    textLabel1.alpha = 1.0;
    [UIView commitAnimations];

}

-(void) appearButtons {
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self fadeInPhotoButton];[self playSound];});
    
    delayInSeconds += 0.4;
    popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self fadeInPoliticianButton];[self playSound];});
    
    delayInSeconds += 0.4;
    popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self fadeInInfoButton];[self playSound];});
}

-(void) playSound {
    SystemSoundID soundId;
    NSString *file = [[NSBundle mainBundle] pathForResource:@"blob" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:file]), &soundId);
    AudioServicesPlaySystemSound(soundId);
}
-(void)fadeInPhotoButton{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.3];
    self.takePhotoButton.alpha = 1.0;
    [UIView commitAnimations];
}
-(void)fadeInPoliticianButton{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.3];
    self.politiciansButton.alpha = 1.0;
    [UIView commitAnimations];
}
-(void)fadeInInfoButton{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:0.3];
    self.infoButton.alpha = 1.0;
    [UIView commitAnimations];
}

- (IBAction)takePhoto:(id)sender {
    [self playSound];
    // take photo
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)showPolitician:(id)sender {
    [self playSound];
}

- (IBAction)info:(id)sender {
    [self playSound];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
     UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:^(void){[self composeMail];}];

}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
-(void)composeMail{
    MFMailComposeViewController *pick = [[MFMailComposeViewController alloc] init];
    pick.mailComposeDelegate = self;
    [pick setSubject:@"Notification for Illegal Dump"];
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"DEPONIJABA@hotmail.com"];
    // NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    [pick setToRecipients:toRecipients];
    
    NSData *myData = UIImagePNGRepresentation(image);
    [pick addAttachmentData:myData mimeType:@"image/png" fileName:@"coolImage.png"];
    
    // Fill out the email body text
    NSString *emailBody = [NSString stringWithFormat:@"Dear fellow President, Hope this email finds you well. I would like to inform that there is illegal dump. In attachment you can find photo and other important information.\n Warmest greetings \n\n %@\n%@\n%@\n Latitude:%@\nLongitude:%@\n Major of the city responsible for dump: %@", administrativeAre,locality, postalCode, lattitude, longitude, responsibleMajor];
    [pick setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController:pick animated:YES];

}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        lattitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(@"Location -> %@, %@", longitude, lattitude);
        CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
        [geocoder reverseGeocodeLocation:locationManager.location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                           
                           if (error){
                               NSLog(@"Geocode failed with error: %@", error);
                               return;
                           }
                           CLPlacemark *placemark = [placemarks objectAtIndex:0];
                           postalCode = placemark.postalCode;
                           administrativeAre = placemark.administrativeArea;
                           locality = placemark.locality;
                           NSLog(@"Postal code - > %@", postalCode);
                           NSLog(@"Adminstrative area - > %@", administrativeAre);
                           NSLog(@"Locality - > %@", locality);
                           
                           for (id key in cityMajors) {
                                if ([[cityMajors objectForKey:key] isEqualToString:locality]) {
                                    responsibleMajor = key;
                                    NSLog(@"Responsible major is ->>>>> %@", responsibleMajor);
                                }
                           }
                           }];
        [manager stopUpdatingLocation];
    }
}
@end
