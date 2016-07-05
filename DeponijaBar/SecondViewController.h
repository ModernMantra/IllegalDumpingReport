//
//  SecondViewController.h
//  DeponijaBar
//
//  Created by Kerim Njuhović on 11/7/15.
//  Copyright © 2015 Kerim Njuhovic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface SecondViewController : UIViewController <UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate>

{
    UIImagePickerController *imagePicker;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

@property (weak, nonatomic) IBOutlet UILabel *textLabel1;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *politiciansButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;


- (IBAction)takePhoto:(id)sender;
- (IBAction)showPolitician:(id)sender;
- (IBAction)info:(id)sender;


@end
