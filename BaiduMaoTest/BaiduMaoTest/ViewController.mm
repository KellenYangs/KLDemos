//
//  ViewController.m
//  BaiduMaoTest
//
//  Created by bcmac3 on 16/6/2.
//  Copyright © 2016年 KellenYangs. All rights reserved.
//

#import "ViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface ViewController () <BMKLocationServiceDelegate, BMKMapViewDelegate, BMKGeoCodeSearchDelegate, BMKRouteSearchDelegate>
/** <#注释#> */
@property (nonatomic, strong) BMKMapView *mapView;
/** <#注释#> */
@property (nonatomic, strong) BMKLocationService *locationService;
/** <#注释#> */
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;
/** 声明路线搜索服务对象 */
@property (nonatomic, strong) BMKRouteSearch *routeSearch;

/** 开始的路线检索节点 */
@property (nonatomic, strong) BMKPlanNode *startNode;

/** 结束的路线检索节点 */
@property (nonatomic, strong) BMKPlanNode *endNode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 搭建UI
    [self addSubViews];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-40)];
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 15;
    [self.view addSubview:self.mapView];
    
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    // 设置再次定位的最小距离
    self.locationService.distanceFilter = 10.0;
    
    self.geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
    self.geoCodeSearch.delegate = self;
    
    self.routeSearch = [[BMKRouteSearch alloc] init];
    self.routeSearch.delegate = self;
}



- (void)startLocation {
    // 1.开启定位
    [self.locationService startUserLocationService];
    // 2.显示用户的位置
    self.mapView.showsUserLocation = YES;
}

- (void)stopLocation {
    [self.locationService stopUserLocationService];
    self.mapView.showsUserLocation = NO;
    [self.mapView removeAnnotation:self.mapView.annotations.lastObject];
}

- (void)routeSearchButtonClick {
    // 正向地址编码
    BMKGeoCodeSearchOption *option = [[BMKGeoCodeSearchOption alloc] init];
    option.city = @"上海市";
    option.address = @"吴中路369号";
    
    [self.geoCodeSearch geoCode:option];
}

#pragma mark -- BMKLocationServiceDelegate
/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser {
    NSLog(@"开始定位");
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser {
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"新位置");
    // 编码
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    option.reverseGeoPoint = userLocation.location.coordinate;
    [self.geoCodeSearch reverseGeoCode:option];

}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"定位失败 - %@", error);
}

#pragma mark --  BMKGeoCodeSearchDelegate 
/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if([result.address isEqualToString:@"吴中路369号"]) {
        self.startNode = [[BMKPlanNode alloc] init];
        self.startNode.pt = result.location;
        
        BMKGeoCodeSearchOption *option = [[BMKGeoCodeSearchOption alloc] init];
        option.city = @"上海市";
        option.address = @"桂林路100号";
        
        self.endNode = nil;
        [self.geoCodeSearch geoCode:option];
        
        
    } else {
        self.endNode = [[BMKPlanNode alloc] init];
        self.endNode.pt = result.location;
    }
    
    if (self.startNode != nil && self.endNode != nil) {
        // 开始进行路线检索
        // 1.创建驾车路线规划
        BMKDrivingRoutePlanOption *dOption =  [[BMKDrivingRoutePlanOption alloc] init];
        dOption.from = self.startNode;
        dOption.to = self.endNode;
        [self.routeSearch drivingSearch:dOption];
        
//        // 2.创建公交路线规划
//        BMKTransitRoutePlanOption *tOption =  [[BMKTransitRoutePlanOption alloc] init];
//        
//        // 3.创建步行路线规划
//        BMKWalkingRoutePlanOption *wOption =  [[BMKWalkingRoutePlanOption alloc] init];
//        
//        // 4.创建骑行路线规划
//        BMKRidingRoutePlanOption *rOption =  [[BMKRidingRoutePlanOption alloc] init];
        
        
        
    }
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    // 插入大头针
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = result.location;
    annotation.title = result.address;
    [self.mapView addAnnotation:annotation];
    [self.mapView setCenterCoordinate:result.location animated:YES];
}

#pragma mark -- BMKRouteSearchDelegate
/**
 *返回公交搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKTransitRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    
}
/**
 *返回驾乘搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKDrivingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    // 原来的覆盖物
    NSArray *array = [NSArray arrayWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:array];
    
    // 原来的轨迹
    array = [NSArray arrayWithArray:self.mapView.overlays];
    [self.mapView removeOverlays:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        // 获取一条路线
        BMKDrivingRouteLine *plan = result.routes[0];
        // 计算路线方案中路段的数目
        NSUInteger size = plan.steps.count;
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            // 获取所有路段
            BMKDrivingStep *step = plan.steps[i];
           
            
            if (i == 0) {
                // 地图显示经纬度
                [self.mapView setRegion:BMKCoordinateRegionMake(step.entrace.location, BMKCoordinateSpanMake(0.001, 0.001))];
            }
            // 累计轨迹点
            planPointCounts += step.pointsCount;
        }
        // 申明一个结构体保存所有用来保存的轨迹点
//        NSMutableArray *temppoints = [NSMutableArray arrayWithCapacity:planPointCounts];
        
        BMKMapPoint *temppoints = new BMKMapPoint[planPointCounts];
        
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep *transStep = plan.steps[j];
            int k = 0;
            for (k = 0; k < transStep.pointsCount; k++) {
                // 获取每个轨迹点的x,y
                temppoints[i].x = transStep.points[k].x;
                temppoints[i].y = transStep.points[k].y;
                i++;
            }
        }
        
        
        // 通过轨迹点构造BMKPolyLine折线
        BMKPolyline *polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        // 添加到mapView上
        [self.mapView addOverlay:polyLine];
    }
}

/**
 *返回步行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKWalkingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    
}

/**
 *返回骑行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKRidingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetRidingRouteResult:(BMKRouteSearch*)searcher result:(BMKRidingRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    
}

#pragma mark -- BMKMapViewDelegate
// 绘制轨迹
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        // 创建要显示的折线
        BMKPolylineView *ploylineView = [[BMKPolylineView alloc]initWithOverlay:overlay];
        // 设置该线条的填充颜色
        ploylineView.fillColor = [UIColor redColor];
        ploylineView.strokeColor = [UIColor blueColor];
        ploylineView.lineWidth = 3.0;
        return ploylineView;
    }
    return nil;
}


- (void)dealloc {
    self.mapView.delegate = nil;
    self.locationService.delegate = nil;
    self.geoCodeSearch.delegate = nil;
    self.routeSearch.delegate = nil;
}

- (void)addSubViews {
    // 设置BarButtonItem
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始定位" style:UIBarButtonItemStylePlain target:self action:@selector(startLocation)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"停止定位" style:UIBarButtonItemStylePlain target:self action:@selector(stopLocation)];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setTitle:@"路线规划" forState:UIControlStateNormal];
    b.backgroundColor = [UIColor orangeColor];
    b.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 40, [[UIScreen mainScreen] bounds].size.width, 40);
    [b addTarget:self action:@selector(routeSearchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
    
}

@end
