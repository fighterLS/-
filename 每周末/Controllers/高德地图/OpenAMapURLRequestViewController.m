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
    
    self.destination.coordinate = CLLocationCoordinate2DMake([_location.lat floatValue], [_location.lon floatValue]);
    self.destination.title = _locationName;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *rightBarButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBarButton setTitle:@"导航" forState:UIControlStateNormal];
    [rightBarButton setTitleColor:[UIColor colorWithHexString:@"b39954"] forState:UIControlStateNormal];
    [rightBarButton addTarget:self action:@selector(installMapAppInYourIPhone) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    [self initDestination];
}

-(void)installMapAppInYourIPhone
{
    NSMutableArray *itemsArray=[NSMutableArray arrayWithCapacity:0];
    NSString *appName=@"每周末";
    NSString *urlScheme=@"meizhoumo://";
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]])
    {
       MMPopupItem *item= MMItemMake(@"苹果地图", MMItemTypeNormal, ^(NSInteger index) {
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
           
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_destination.coordinate addressDictionary:nil]];
            
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        });
        
        [itemsArray addObject:item];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
      MMPopupItem *item = MMItemMake(@"百度地图", MMItemTypeNormal, ^(NSInteger index) {
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",_destination.coordinate.latitude, _destination.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
             });
        [itemsArray addObject:item];
 
    }
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
      MMPopupItem *item = MMItemMake(@"高德地图", MMItemTypeNormal, ^(NSInteger index) {
          MARouteConfig *config = [MARouteConfig new];
          config.appName =@"每周末";
          config.appScheme = @"每周末";
          
          config.startCoordinate=self.mapView.userLocation.coordinate;
          config.destinationCoordinate = _destination.coordinate;
          config.routeType = MARouteSearchTypeTransit;
          [MAMapURLSearch openAMapRouteSearch:config];

//          NSString *urlString = [[NSString stringWithFormat:@" iosamap://path?sourceApplication=%@&sid=%@&did=%@&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",appName,urlScheme,@"iosamap",_destination.coordinate.latitude, _destination.coordinate.longitude,_locationName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            
//            NSLog(@"%@",urlString);
//            
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        });
        [itemsArray addObject:item];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
       MMPopupItem *item = MMItemMake(@"谷歌地图", MMItemTypeNormal, ^(NSInteger index) {
            
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,_destination.coordinate.latitude, _destination.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        });
        [itemsArray addObject:item];
    }
    
    MMSheetView *sheetView=[[MMSheetView alloc]initWithTitle:@"" items:itemsArray];
    [sheetView show];
}

-(void)gaoDeRouteSearchAction
{
    MARouteConfig *config = [MARouteConfig new];
    config.appName =@"每周末";
    config.appScheme = @"每周末";
    
    config.startCoordinate=self.mapView.userLocation.coordinate;
    config.destinationCoordinate = _destination.coordinate;
    config.routeType = MARouteSearchTypeTransit;
    [MAMapURLSearch openAMapRouteSearch:config];
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
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
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
