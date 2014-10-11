//
//  ViewController.m
//  CustomMKAnnotationViews
//
//  Created by Shaheen Ghiassy on 10/10/14.
//  Copyright (c) 2014 Shaheen Calvin Ghiassy. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ViewController.h"
#import "CalloutMapAnnotation.h"
#import "CalloutMapAnnotationView.h"
#import "AccessorizedCalloutMapAnnotationView.h"


@interface ViewController () <UIGestureRecognizerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *map;
@property (nonatomic, strong) MKAnnotationView *selectedAnnotationView; // Can I get rid of this?

@end


@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    [self setupGestureRecognizer];
}

#pragma mark - Setup Methods

- (void)setupMapView {
    self.map = [[MKMapView alloc] init];
    self.map.delegate = self;
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
    [self removeAllPreviousAnnotations]; // Comment this line out if you want to keep all previous annotations

    CGPoint screenPoint = [gestureRecognizer locationInView:self.map]; // Grab the screen point from the gesture event
    CLLocationCoordinate2D geoPoint = [self.map convertPoint:screenPoint toCoordinateFromView:self.view];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = geoPoint;
    [self.map addAnnotation:annotation];
    [self.map selectAnnotation:annotation animated:NO];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Asynchrony Solutions"
                                                    message:@"Callout Accessory Tapped"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - MKMapViewDelegate Methods

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // When the first annotation is added automatically by the system, we then add our second, custom, annotation
    CalloutMapAnnotation *customAnnotation = [[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
    [self.map addAnnotation:customAnnotation];
    self.selectedAnnotationView = view;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    CalloutMapAnnotationView *calloutMapAnnotationView = nil;
    BOOL annotationIsOurCustomClass = [annotation isKindOfClass:[CalloutMapAnnotation class]];

    if (annotationIsOurCustomClass) {
        // If so, then create our custom annotation view
        calloutMapAnnotationView = [[AccessorizedCalloutMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutAnnotation"];
        calloutMapAnnotationView.contentHeight = 78.0f;
        UIImage *asynchronyLogo = [UIImage imageNamed:@"asynchrony-logo-small.png"];
        UIImageView *asynchronyLogoView = [[UIImageView alloc] initWithImage:asynchronyLogo];
        asynchronyLogoView.frame = CGRectMake(5, 2, asynchronyLogoView.frame.size.width, asynchronyLogoView.frame.size.height);
        [calloutMapAnnotationView.contentView addSubview:asynchronyLogoView];
        calloutMapAnnotationView.parentAnnotationView = self.selectedAnnotationView;
        calloutMapAnnotationView.mapView = self.map;
    }

    return calloutMapAnnotationView;
}

#pragma mark - Utility / Convience Methods

- (void)removeAllPreviousAnnotations {
    [self.map removeAnnotations:self.map.annotations]; // Remove all existing annotations
}

@end
