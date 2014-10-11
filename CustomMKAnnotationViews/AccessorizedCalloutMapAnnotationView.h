//
//  AccessorizedCalloutMapAnnotationView.h
//  CustomMKAnnotationViews
//
//  Created by Shaheen Ghiassy on 10/11/14.
//  Copyright (c) 2014 Shaheen Calvin Ghiassy. All rights reserved.
//  Derived from Code: http://blog.asynchrony.com/2010/09/building-custom-map-annotation-callouts-part-1/
//

#import "CalloutMapAnnotationView.h"

@interface AccessorizedCalloutMapAnnotationView : CalloutMapAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;


@end
