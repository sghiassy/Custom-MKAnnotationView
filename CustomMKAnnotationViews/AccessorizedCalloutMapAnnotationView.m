//
//  AccessorizedCalloutMapAnnotationView.m
//  CustomMKAnnotationViews
//
//  Created by Shaheen Ghiassy on 10/11/14.
//  Copyright (c) 2014 Shaheen Calvin Ghiassy. All rights reserved.
//  Forked from Code: http://blog.asynchrony.com/2010/09/building-custom-map-annotation-callouts-part-1/
//

#import "AccessorizedCalloutMapAnnotationView.h"


@interface AccessorizedCalloutMapAnnotationView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *accessory;

@end


@implementation AccessorizedCalloutMapAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];

    if (self) {
        self.accessory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        self.accessory.exclusiveTouch = YES;
        self.accessory.enabled = YES;
        [self.accessory addTarget: self action: @selector(calloutAccessoryTapped) forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchCancel];
        [self addSubview:self.accessory];

        // Set up a Touch Gesture
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedAnnotation:)];
        [tap setNumberOfTapsRequired:1];
        [tap setDelegate:self];
        self.exclusiveTouch = YES;
        [self addGestureRecognizer:tap];

    }
    return self;
}


- (void)userTappedAnnotation:(UIGestureRecognizer *)gestureRecognizer {
    [self removeFromSuperview];
    [self.parentAnnotationView removeFromSuperview];
}

- (void)prepareContentFrame {
    CGRect contentFrame = CGRectMake(self.bounds.origin.x + 10, self.bounds.origin.y + 3, self.bounds.size.width - 20, self.contentHeight);

    self.contentView.frame = contentFrame;
}

- (void)prepareAccessoryFrame {
    self.accessory.frame = CGRectMake(self.bounds.size.width - self.accessory.frame.size.width - 15, (self.contentHeight + 3 - self.accessory.frame.size.height) / 2, self.accessory.frame.size.width, self.accessory.frame.size.height);
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self prepareAccessoryFrame];
}

- (void)calloutAccessoryTapped {
    if ([self.mapView.delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)]) {
        [self.mapView.delegate mapView:self.mapView annotationView:self.parentAnnotationView calloutAccessoryControlTapped:self.accessory];
    }
}

@end
