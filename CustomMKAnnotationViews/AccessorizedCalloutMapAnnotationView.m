//
//  AccessorizedCalloutMapAnnotationView.m
//  CustomMKAnnotationViews
//
//  Created by Shaheen Ghiassy on 10/11/14.
//  Copyright (c) 2014 Shaheen Calvin Ghiassy. All rights reserved.
//  Derived from Code: http://blog.asynchrony.com/2010/09/building-custom-map-annotation-callouts-part-1/
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
        [self.accessory addTarget: self
                           action: @selector(calloutAccessoryTapped)
                 forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchCancel];
        [self addSubview:self.accessory];

        UIImage *car = [UIImage imageNamed:@"Car.png"];
        UIButton *carButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, car.size.width, car.size.height)];
        [carButton setImage:car forState:UIControlStateNormal];
        [self addSubview:carButton];
        carButton.layer.borderColor = [UIColor orangeColor].CGColor;
        carButton.layer.borderWidth = 1.0f;
        [carButton addTarget:self action:@selector(carTapped) forControlEvents:UIControlEventTouchUpInside];

        UIImage *spinner = [UIImage imageNamed:@"spinner2-bluey.gif"];
        UIImageView *spinnerView = [[UIImageView alloc] initWithImage:spinner];
        [self addSubview:spinnerView];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [spinnerView removeFromSuperview];
        });

        // Set up a Touch Gesture
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedAnnotation:)];
        [tap setNumberOfTapsRequired:1];
        [tap setDelegate:self];
        self.exclusiveTouch = YES;
        [self addGestureRecognizer:tap];

    }
    return self;
}

- (void)carTapped {
    NSLog(@"Car Button was tapped");
}


- (void)userTappedAnnotation:(UIGestureRecognizer *)gestureRecognizer {
    [self removeFromSuperview];
    [self.parentAnnotationView removeFromSuperview];
}

- (void)prepareContentFrame {
    CGRect contentFrame = CGRectMake(self.bounds.origin.x + 10,
                                     self.bounds.origin.y + 3,
                                     self.bounds.size.width - 20,
                                     self.contentHeight);

    self.contentView.frame = contentFrame;
}

- (void)prepareAccessoryFrame {
    self.accessory.frame = CGRectMake(self.bounds.size.width - self.accessory.frame.size.width - 15,
                                      (self.contentHeight + 3 - self.accessory.frame.size.height) / 2,
                                      self.accessory.frame.size.width,
                                      self.accessory.frame.size.height);
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self prepareAccessoryFrame];
}

- (void)calloutAccessoryTapped {
    if ([self.mapView.delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)]) {
        [self.mapView.delegate mapView:self.mapView
                        annotationView:self.parentAnnotationView
         calloutAccessoryControlTapped:self.accessory];
    }
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//	UIView *hitView = [super hitTest:point withEvent:event];
//
//	//If the accessory is hit, the map view may want to select an annotation sitting below it, so we must disable the other annotations
//	//But not the parent because that will screw up the selection
//	if (hitView == self.accessory) {
//		[self preventParentSelectionChange];
//		[self performSelector:@selector(allowParentSelectionChange) withObject:nil afterDelay:1.0];
//		for (UIView *sibling in self.superview.subviews) {
//			if ([sibling isKindOfClass:[MKAnnotationView class]] && sibling != self.parentAnnotationView) {
//				((MKAnnotationView *)sibling).enabled = NO;
//				[self performSelector:@selector(enableSibling:) withObject:sibling afterDelay:1.0];
//			}
//		}
//    } else {
////        for (UIView *sibling in self.superview.subviews) {
//            if ([hitView isKindOfClass:[AccessorizedCalloutMapAnnotationView class]]) {
////                ((MKAnnotationView *)sibling).enabled = NO;
////                [self performSelector:@selector(enableSibling:) withObject:sibling afterDelay:1.0];
//                NSLog(@"");
//                hitView.layer.borderColor = [UIColor blueColor].CGColor;
//                hitView.layer.borderWidth = 1.0f;
//            }
////        }
//    }
//
//    hitView.layer.borderColor = [UIColor orangeColor].CGColor;
//    hitView.layer.borderWidth = 1.0f;
//    [hitView removeFromSuperview];
//
//	return hitView;
//}
//
//- (void) enableSibling:(UIView *)sibling {
//	((MKAnnotationView *)sibling).enabled = YES;
//}
//
//- (void) preventParentSelectionChange {
//	BasicMapAnnotationView *parentView = (BasicMapAnnotationView *)self.parentAnnotationView;
//	parentView.preventSelectionChange = YES;
//}
//
//- (void) allowParentSelectionChange {
//	//The MapView may think it has deselected the pin, so we should re-select it
//	[self.mapView selectAnnotation:self.parentAnnotationView.annotation animated:NO];
//	
//	BasicMapAnnotationView *parentView = (BasicMapAnnotationView *)self.parentAnnotationView;
//	parentView.preventSelectionChange = NO;
//}

@end
