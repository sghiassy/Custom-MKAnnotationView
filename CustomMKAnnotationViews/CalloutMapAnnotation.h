//
//  CalloutMapAnnotation.h
//  CustomMKAnnotationViews
//
//  Created by Shaheen Ghiassy on 10/11/14.
//  Copyright (c) 2014 Shaheen Calvin Ghiassy. All rights reserved.
//  Forked from Code: http://blog.asynchrony.com/2010/09/building-custom-map-annotation-callouts-part-1/
//

#import <MapKit/MapKit.h>

@interface CalloutMapAnnotation : NSObject <MKAnnotation>

/**
 *  Designated Initializer
 *
 *  @param latitude
 *  @param longitude
 *
 *  @return instancetype
 */
- (instancetype)initWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;

/**
 *  Returns the Annotation's Coordinate
 */
- (CLLocationCoordinate2D)coordinate;

@end
