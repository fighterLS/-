//
//  OpenAMapURLRequestViewController.m
//  officialDemo2D
//
//  Created by xiaoming han on 15/6/12.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#import "OpenAMapURLRequestViewController.h"
#import "MANaviAnnotationView.h"

@interface OpenAMapURLRequestViewController ()

@end

@implementation OpenAMapURLRequestViewController

#pragma mark - Initialization

- (void)initDestination
{
    self.destination = [[MAPointAnnotation alloc] init];
    
    self.destination.coordinate = CLLocationCoordinate2DMake(39.923034, 116.388988);
    self.destination.title = @"谁说这个应用打不开";
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDestination];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mapView.showsUserLocation = YES;
    
    [self.mapView addAnnotation:self.destination];
    [self.mapView selectAnnotation:self.destination animated:YES];
}
#pragma mark - mapView delegate

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=39.92848272&slon=116.39560823&sname=我的位置&did=BGVIS2&dlat=39.98848272&dlon=116.47560823&dname=B&dev=0&m=0&t=0"]]];
        MARouteConfig *config = [MARouteConfig new];
        config.appName =@"兴趣周末";
        config.appScheme = @"兴趣周末";
    
       config.startCoordinate=self.mapView.userLocation.coordinate;
        config.destinationCoordinate = _destination.coordinate;
        config.routeType = MARouteSearchTypeTransit;
        [MAMapURLSearch openAMapRouteSearch:config];
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MANaviAnnotationView *annotationView = (MANaviAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MANaviAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        
        return annotationView;
    }
    
    return nil;
}



@end
