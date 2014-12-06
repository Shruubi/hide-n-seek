#import <EstimoteSDK/ESTBeaconManager.h>

#import "ViewController.h"

#define GREEN_MSG @"Keep looking! You'll find me eventually!"
#define YELLOW_MSG @"I think I can hear the pitter-patter of you getting closer now"
#define ORANGE_MSG @"Was that you I spy out of the corner of my eye?"
#define RED_MSG @"Here I am!"

@interface ViewController () <ESTBeaconManagerDelegate>

@property(weak, nonatomic) IBOutlet UILabel *txtLbl;

@property(nonatomic, strong) ESTBeaconManager *beaconManager;

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated {
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconManager.returnAllRangedBeaconsAtOnce = YES;
    
    ESTBeaconRegion *region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"SomeID" secured:YES];
    
    [self startRangingBeacons:region];
}

- (void)setMasterViewBackgroundColor:(UIColor *)color {
    [self.view setBackgroundColor:color];
}

- (void)setBackgroundRed {
    [self.txtLbl setText:RED_MSG];
    [self setMasterViewBackgroundColor:[UIColor redColor]];
}

- (void)setBackgroundOrange {
    [self.txtLbl setText:ORANGE_MSG];
    [self setMasterViewBackgroundColor:[UIColor orangeColor]];
}

- (void)setBackgroundYellow {
    [self.txtLbl setText:YELLOW_MSG];
    [self setMasterViewBackgroundColor:[UIColor yellowColor]];
}

- (void)setBackgroundGreen {
    [self.txtLbl setText:GREEN_MSG];
    [self setMasterViewBackgroundColor:[UIColor greenColor]];
}

#pragma mark STUPID_IOS8_PERMISSIONS_FUCKING_FUCK_FUCK_SHIT

-(void)startRangingBeacons:(ESTBeaconRegion*)region {
    if ([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
            NSLog(@"IOS version is 7.1 or less");
            [self.beaconManager startRangingBeaconsInRegion:region];
        } else {
            NSLog(@"IOS version is 8.0 or greater");
            [self.beaconManager requestAlwaysAuthorization];
            [self.beaconManager startRangingBeaconsInRegion:region];
        }
    } else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"already authorized");
        [self.beaconManager startRangingBeaconsInRegion:region];
    } else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Access Denied"
                                                        message:@"You have denied access to location services. Change this in app settings."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
    } else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Available"
                                                        message:@"You have no access to location services."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
    }
}

#pragma mark ESTIMOTE_DELEGATE_METHODS

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    if (beacons.count > 0) {
        ESTBeacon *closestBeacon = beacons[0];

        switch (closestBeacon.proximity) {
            case CLProximityUnknown:
                [self setBackgroundGreen];
                break;
            case CLProximityImmediate:
                [self setBackgroundRed];
                break;
            case CLProximityNear:
                [self setBackgroundOrange];
                break;
            case CLProximityFar:
                [self setBackgroundYellow];
                break;
            default:
                [self setBackgroundGreen];
                break;
        }
    } else {
        [self setBackgroundGreen];
    }
}

-(void)beaconManager:(ESTBeaconManager *)manager rangingBeaconsDidFailForRegion:(ESTBeaconRegion *)region withError:(NSError *)error {
    if(error) {
        NSLog(@"There was an error in ranging");
    }
    
    NSLog(@"%@", error.description);
}

-(void)beaconManager:(ESTBeaconManager *)manager didFailDiscoveryInRegion:(ESTBeaconRegion *)region {
    NSLog(@"failed discovery in region");
}

@end
