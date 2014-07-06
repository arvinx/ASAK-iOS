//
//  Screen2B.m
//  DummyApp
//
//  Created by Arvin Rezvanpour on 2014-06-07.
//  Copyright (c) 2014 Arvin Rezvanpour. All rights reserved.
//

#import "Screen2B.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Event.h"
#import "MapBottomBar.h"


@interface Screen2B ()

@end

@implementation Screen2B {
    GMSMapView *mapView_;
    GMSMarker *_apin;
    NSMutableArray *_events;
    NSMutableArray *_eventPins;
    BOOL firstLocationUpdate_;
}

MapBottomBar *bottomBar;
@synthesize locationManager;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self makeEvents];
        self.navigationController.navigationBar.alpha = 0.1;
        self.navigationController.view.alpha = 0.1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Screen2B"];

    [self allocGMaps];
//    
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
//    
//    
//    [locationManager startUpdatingLocation];
    
    bottomBar = [[[NSBundle mainBundle] loadNibNamed:@"MapInfoView" owner:self options:nil] lastObject];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [bottomBar setFrame:CGRectMake(0, screenRect.size.height, screenRect.size.width, 100)];
    
    [self.view addSubview:bottomBar];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self dropPins];
}

- (void) allocGMaps
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:47.6150001
                                                            longitude:-122.3331688
                                                                 zoom:15];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    mapView_.myLocationEnabled = YES;
    mapView_.settings.compassButton = YES;
    
    [mapView_ addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    self.view = mapView_;
    
    mapView_.delegate = self;

    // Creates a marker in the center of the map.
    dispatch_async(dispatch_get_main_queue(), ^{
        mapView_.myLocationEnabled = YES;
    });
}
//
//- (NSString *)deviceLocation {
//    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
//    return theLocation;
//}


- (void) dropPins
{
    _eventPins = [[NSMutableArray alloc] init];
    
    for (Event *event in _events) {
        _apin = [[GMSMarker alloc] init];
        _apin.title = event.name;
        _apin.snippet = event.snippit;
        _apin.position = CLLocationCoordinate2DMake(event.latitude.doubleValue, event.longitude.doubleValue);
        _apin.flat = YES;
        _apin.userData = event;
        [_eventPins addObject:_apin];
    }
    
    for (GMSMarker *pin in _eventPins) {
        pin.map = (GMSMapView *)self.view;
    }
    
    
}

- (void) makeEvents
{
    _events = [[NSMutableArray alloc] init];
    Event *event = [[Event alloc] init];
    event.name = @"Rooftop party";
    event.snippit = @"free booze";
    event.latitude = [[NSNumber alloc] initWithDouble:47.619];
    event.longitude = [[NSNumber alloc] initWithDouble:-122.33316];
    event.date = @"Mon @ 5:30PM";
    event.imageHost = [UIImage imageNamed:@"host1.jpg"];
    [_events addObject:event];
    
    event = [[Event alloc] init];
    event.name = @"Basketball";
    event.snippit = @"court 2v2";
    event.date = @"Tomorrow @ 2:00PM";
    event.latitude = [[NSNumber alloc] initWithDouble:47.6150001];
    event.longitude = [[NSNumber alloc] initWithDouble:-122.3331688];
    event.imageHost = [UIImage imageNamed:@"host2.jpg"];
    [_events addObject:event];
    
    event = [[Event alloc] init];
    event.name = @"G3T Drunk!";
    event.snippit = @"house party";
    event.date = @"Tonight @ 11:00PM";
    event.latitude = [[NSNumber alloc] initWithDouble:47.617];
    event.longitude = [[NSNumber alloc] initWithDouble:-122.33315];
    event.imageHost = [UIImage imageNamed:@"host3.jpg"];
    [_events addObject:event];
    
    event = [[Event alloc] init];
    event.name = @"Karaoke ;)";
    event.snippit = @"Pub with few of my buds";
    event.date = @"Friday June 27 @ 10:00PM";
    event.latitude = [[NSNumber alloc] initWithDouble:47.618];
    event.longitude = [[NSNumber alloc] initWithDouble:-122.334];
    event.imageHost = [UIImage imageNamed:@"host2.jpg"];
    [_events addObject:event];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [mapView_ removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }
    
    if ([keyPath isEqualToString:@"myLocation"]) {
        NSLog(@"LOCATION UPDATED");
    }
}


#pragma mark - GMSMapViewDelegate
- (BOOL) mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
//    [bottomBar setBackgroundColor:[UIColor grayColor]];
//    bottomBar.labelTitle.text = marker.title;
    Event *event = (Event*)marker.userData;
    bottomBar.labelTime.text = event.date;
    bottomBar.labelTitle.text = event.name;
    
    bottomBar.imageUser.contentMode = UIViewContentModeScaleAspectFit;
    bottomBar.imageUser.clipsToBounds = YES;
    bottomBar.imageUser.image = event.imageHost;
    
    if (bottomBar.tag == 0) {
        bottomBar.tag = 1;
        [UIView animateWithDuration:0.3
                         animations:^{
                             bottomBar.frame = CGRectMake(0, bottomBar.frame.origin.y - 100, bottomBar.frame.size.width, bottomBar.frame.size.height);
                         }];
        NSLog(@"Opened map event %@", marker.title);
    }
    return NO;
}


- (void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (bottomBar.tag == 1) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             bottomBar.frame = CGRectMake(0, bottomBar.frame.origin.y + 100, bottomBar.frame.size.width, bottomBar.frame.size.height);
                         }];
    }
    //    bottomBar.hidden = YES;
    bottomBar.tag = 0;
    NSLog(@"Closed map event");
}


@end



//#pragma mark -
//#pragma mark CLLocationManagerDelegate
//
//-(void)locationManager:(CLLocationManager *)manager
//   didUpdateToLocation:(CLLocation *)newLocation
//          fromLocation:(CLLocation *)oldLocation
//{
//    NSString *currentLatitude = [[NSString alloc]
//                                 initWithFormat:@"%+.6f",
//                                 newLocation.coordinate.latitude];
//
//    NSString *currentLongitude = [[NSString alloc]
//                                  initWithFormat:@"%+.6f",
//                                  newLocation.coordinate.longitude];
//    NSString *currentHorizontalAccuracy =
//    [[NSString alloc]
//     initWithFormat:@"%+.6f",
//     newLocation.horizontalAccuracy];
//
//    NSString *currentAltitude = [[NSString alloc]
//                                 initWithFormat:@"%+.6f",
//                                 newLocation.altitude];
//    NSString *currentVerticalAccuracy =
//    [[NSString alloc]
//     initWithFormat:@"%+.6f",
//     newLocation.verticalAccuracy];
//
//    if (_startLocation == nil)
//        _startLocation = newLocation;
//
//    CLLocationDistance distanceBetween = [newLocation
//                                          distanceFromLocation:_startLocation];
//
//    NSString *tripString = [[NSString alloc]
//                            initWithFormat:@"%f",
//                            distanceBetween];
//
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude
//                                                            longitude:newLocation.coordinate.longitude
//                                                                 zoom:6];
//}

