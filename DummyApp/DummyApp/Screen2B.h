//
//  Screen2B.h
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-07.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>


@interface Screen2B : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>

//@property (strong, nonatomic) CLLocationManager *locationManager;
@property(nonatomic,retain) CLLocationManager *locationManager;


@property (strong, nonatomic) CLLocation *startLocation;


@end
