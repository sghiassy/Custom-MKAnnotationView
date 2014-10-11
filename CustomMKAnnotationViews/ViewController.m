//
//  ViewController.m
//  CustomMKAnnotationViews
//
//  Created by Shaheen Ghiassy on 10/10/14.
//  Copyright (c) 2014 Shaheen Calvin Ghiassy. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ViewController.h"


@interface ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) MKMapView *map;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    [self setupGestureRecognizer];
}

- (void)setupMapView {
    self.map = [[MKMapView alloc] init];
    [self.view addSubview:self.map];

    // Setup Autolayout
    self.map.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[map]|"
                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                      metrics:nil
                                                                        views:@{@"map":self.map}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[map]|"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:nil
                                                                        views:@{@"map":self.map}]];

    CLLocationCoordinate2D coordinate = {45.52, -122.681944}; // Portland, OR
    [self.map setRegion:MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(1.5, 1.5))]; // Set Map's Center Location and Zoom Level
}

- (void)setupGestureRecognizer {
    // Set up a Touch Gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedMap:)];
    [tap setDelegate:self];
    [self.map addGestureRecognizer:tap];
}

#pragma mark - Actions

- (void)userTappedMap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"User Tapped Map");
//    NSArray *annotations = self.map.annotations;
//    NSUInteger count = [annotations count];
//
//    if (count > 1) {
//        //        [self.calloutAnnotation release];
//        [self.mapView removeAnnotations:self.mapView.annotations]; // Remove all existing annotations
//    }
//
//
//    CGPoint screenPoint = [gestureRecognizer locationInView:self.mapView];
//    CLLocationCoordinate2D geoPoint = [self.mapView convertPoint:screenPoint toCoordinateFromView:self.view];
//    //    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
//    BasicMapAnnotation *annotation = [[[BasicMapAnnotation alloc] initWithLatitude:geoPoint.latitude andLongitude:geoPoint.longitude] autorelease];
//    //    point1.coordinate = geoPoint;
//    [self.mapView addAnnotation:annotation];
//
//    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    [self.mapView selectAnnotation:annotation animated:NO];
//    //    });

}

@end
