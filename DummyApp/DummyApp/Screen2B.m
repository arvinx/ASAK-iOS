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
#import "DummyNetworking.h"
#import "JSONObjectify.h"
#import "UserSessionManager.h"
#import "Reachability.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"



@interface Screen2B ()

@end

@implementation Screen2B {
    GMSMapView *mapView_;
    GMSMarker *_apin;
    NSMutableArray *_events;
    NSMutableArray *_eventPins;
    BOOL firstLocationUpdate_;
    UIImageView *_avatorImageView;
}

MapBottomBar *bottomBar;
@synthesize locationManager;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        [self makeEvents];
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
    
    DummyNetworking *dummyNetwork = [[DummyNetworking alloc] init];

    void (^successBlock)(id) = ^(id responseObject) {
        NSLog([responseObject description]);
        NSArray *events = [JSONObjectify makeObject:responseObject forRequestType:kRequestTypeEvent];
        _events = [NSMutableArray arrayWithArray:events];
        [self dropPins];
    };
    
    void (^requestBlock)(void) = ^{
        [dummyNetwork getRequest:kRequestTypeEvent withParams:nil withFailureBlock:nil withSuccesBlock:successBlock];
    };
    
    NetworkStatus status = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (status != NotReachable) {
        [UserSessionManager checkShouldRefreshAndRefreshSession:requestBlock];
    } else {
        [dummyNetwork getRequest:kRequestTypeEvent withParams:nil withFailureBlock:nil withSuccesBlock:successBlock];
    }

    bottomBar = [[[NSBundle mainBundle] loadNibNamed:@"MapInfoView" owner:self options:nil] lastObject];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [bottomBar setFrame:CGRectMake(0, screenRect.size.height, screenRect.size.width, 100)];
    
    [self.view addSubview:bottomBar];
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void) allocGMaps
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:47.6150001
                                                            longitude:-122.3331688
                                                                 zoom:2];
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

- (void) dropPins
{
    _eventPins = [[NSMutableArray alloc] init];
    
    for (Event *event in _events) {
        _apin = [[GMSMarker alloc] init];
        _apin.title = event.name;
//        _apin.snippet = event.snippit;
        _apin.position = CLLocationCoordinate2DMake(event.location_lat, event.location_long);
        _apin.icon = event.host.avatar;
        _apin.flat = YES;
        _apin.userData = event;
        [_eventPins addObject:_apin];
    }
    
    for (GMSMarker *pin in _eventPins) {
        pin.map = (GMSMapView *)self.view;
    }
    
    
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

    firstLocationUpdate_ = YES;
    CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
    mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                     zoom:2];
    
    if ([keyPath isEqualToString:@"myLocation"]) {
        NSLog(@"LOCATION UPDATED");
    }
}


#pragma mark - GMSMapViewDelegate
- (BOOL) mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    Event *event = (Event*)marker.userData;
    bottomBar.labelTitle.text = event.name;

    // formatting the date
    
    bottomBar.labelTime.text = [self getFormattedDate:event.start_time];
    
    //calculate distance in km
    CLLocationCoordinate2D eventLocation;
    eventLocation.latitude = event.location_lat;
    eventLocation.longitude = event.location_long;
    
    double distanceInKm = getDistanceMetresBetweenLocationCoordinates(eventLocation, mapView_.myLocation.coordinate)/1000;
    bottomBar.labelDistance.text = [NSString stringWithFormat:@"%.01f km away", distanceInKm];
    
    bottomBar.imageUser.contentMode = UIViewContentModeScaleAspectFill;
    bottomBar.imageUser.clipsToBounds = YES;
    [bottomBar.imageUser setImageWithURL:[NSURL URLWithString:event.host.avatarUrl]];
    
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

#pragma mark - helpers

double getDistanceMetresBetweenLocationCoordinates(CLLocationCoordinate2D coord1, CLLocationCoordinate2D coord2)
{
    CLLocation* location1 = [[CLLocation alloc] initWithLatitude: coord1.latitude longitude: coord1.longitude];
    CLLocation* location2 = [[CLLocation alloc] initWithLatitude: coord2.latitude longitude: coord2.longitude];
    return [location1 distanceFromLocation: location2];
}

- (NSString *) getFormattedDate:(NSString *) rawEventDate
{
    NSDateFormatter *dateFormatterReader = [[NSDateFormatter alloc] init];
    [dateFormatterReader setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssz"];
    NSDate *date = [dateFormatterReader dateFromString:rawEventDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDoesRelativeDateFormatting:YES];
    
    return [dateFormatter stringFromDate:date];
}


@end


//- (void) makeEvents
//{
//    _events = [[NSMutableArray alloc] init];
//    Event *event = [[Event alloc] init];
//    event.name = @"Rooftop party";
//    event.snippit = @"free booze";
//    event.latitude = [[NSNumber alloc] initWithDouble:47.619];
//    event.longitude = [[NSNumber alloc] initWithDouble:-122.33316];
//    event.date = @"Mon @ 5:30PM";
//    event.imageHost = [UIImage imageNamed:@"host1.jpg"];
//    [_events addObject:event];
//
//    event = [[Event alloc] init];
//    event.name = @"Basketball";
//    event.snippit = @"court 2v2";
//    event.date = @"Tomorrow @ 2:00PM";
//    event.latitude = [[NSNumber alloc] initWithDouble:47.6150001];
//    event.longitude = [[NSNumber alloc] initWithDouble:-122.3331688];
//    event.imageHost = [UIImage imageNamed:@"host2.jpg"];
//    [_events addObject:event];
//
//    event = [[Event alloc] init];
//    event.name = @"G3T Drunk!";
//    event.snippit = @"house party";
//    event.date = @"Tonight @ 11:00PM";
//    event.latitude = [[NSNumber alloc] initWithDouble:47.617];
//    event.longitude = [[NSNumber alloc] initWithDouble:-122.33315];
//    event.imageHost = [UIImage imageNamed:@"host3.jpg"];
//    [_events addObject:event];
//
//    event = [[Event alloc] init];
//    event.name = @"Karaoke ;)";
//    event.snippit = @"Pub with few of my buds";
//    event.date = @"Friday June 27 @ 10:00PM";
//    event.latitude = [[NSNumber alloc] initWithDouble:47.618];
//    event.longitude = [[NSNumber alloc] initWithDouble:-122.334];
//    event.imageHost = [UIImage imageNamed:@"host2.jpg"];
//    [_events addObject:event];
//}

