//
//  CalloutMapAnnotationView.h
//  CustomMKAnnotationViews
//
//  Created by Shaheen Ghiassy on 10/11/14.
//  Copyright (c) 2014 Shaheen Calvin Ghiassy. All rights reserved.
//  Derived from Code: http://blog.asynchrony.com/2010/09/building-custom-map-annotation-callouts-part-1/
//

#import <MapKit/MapKit.h>

@interface CalloutMapAnnotationView : MKAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, readonly, strong) UIView *contentView;
@property (nonatomic, weak) MKAnnotationView *parentAnnotationView;
@property (nonatomic, weak) MKMapView *mapView;

@end
