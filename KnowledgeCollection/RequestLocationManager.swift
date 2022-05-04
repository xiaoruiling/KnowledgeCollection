//
//  RequestLocationManager.swift
//  MapCallouts
//
//  Created by liruiling on 2022/5/4.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

@objc protocol RequestLocationManagerDelegate {
    @objc optional func didUpdateLocations(locations: [CLLocation]) -> Void
    
}

class RequestLocationManager: NSObject {
    
    static let shared = RequestLocationManager()
    var delegate: RequestLocationManagerDelegate?
    
    let locationManager = CLLocationManager()
    
    func startLocation() {
        if locationServiceIsValid() == false {
            debugPrint("用户拒绝该app使用定位服务")
            return
        }
        
        //该场景下是否需要精确定位
        
        let isNeedFullAccuracy: Bool = true
        
        //该场景下如果需要精确定位，则对应的plist中配置的key
        
        let purposeKey: String = "ExampleUsageDescription"
        
        checkLocationAuthorizationStatus(locationManager,
                                         isNeedFullAccuracy: isNeedFullAccuracy,
                                         purposeKey: purposeKey)
        
        // 开始连续定位
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
    }
    
    
    // 当前应用是否可以使用/申请定位服务
    private func locationServiceIsValid() -> Bool {
        if authorizationStatus() == .denied ||
            authorizationStatus() == .restricted {
            return false
        }
        return true
    }
    
    // 获取当前定位的权限
    private func authorizationStatus() -> CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }
    
    // 检查定位状态
    private func checkLocationAuthorizationStatus(_ manager: CLLocationManager,
                                                  isNeedFullAccuracy: Bool,
                                                  purposeKey: String) {
        if authorizationStatus() == .notDetermined {
            // 如果没有定位权限，则需要先申请定位权限
            //如果是iOS14申请权限弹窗时可以选择精度开关，所以不用在单独处理精度权限
            requestLocationAuthorizationIfNeed(manager)
        } else if isNeedFullAccuracy {
            //如果已经有定位权限且需要精确定位
            requestTemporaryFullAccuracyAuthorizationIfNeed(manager: manager, purposeKey: purposeKey)
        }
    }
    
    //请求定位权限，
    private func requestLocationAuthorizationIfNeed(_ manager: CLLocationManager) {
        // 获取系统版本号
        guard let systemVersion = Float(UIDevice.current.systemVersion) else { return }
        // 系统版本8+ && 没有选择过定位权限
        if (systemVersion > 7.99 && CLLocationManager.authorizationStatus() == .notDetermined) {
            //获取info.plist中配置字段信息
            guard let hasAlwaysKey = Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") as? String else {
                debugPrint("需要在Info.plist中添加 NSLocationAlwaysUsageDescription 字段")
                return }
            
            guard let hasWhenInUseKey = Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") as? String else {
                debugPrint("需要在Info.plist中添加 NSLocationWhenInUseUsageDescription 字段")
                return }
            
            guard let hasAlwaysAndWhenInUseKey =  Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysAndWhenInUseUsageDescription") as? String else {
                debugPrint("需要在Info.plist中添加 NSLocationAlwaysAndWhenInUseUsageDescription 字段")
                return }
            
            if #available(iOS 11.0, *) {
                if (!hasAlwaysAndWhenInUseKey.isEmpty && !hasWhenInUseKey.isEmpty) {
                    manager.requestAlwaysAuthorization()
                } else if (!hasWhenInUseKey.isEmpty) {
                    manager.requestWhenInUseAuthorization()
                } else {
                    debugPrint("要在iOS11及以上版本使用定位服务, 需要在Info.plist中添加 \\NSLocationAlwaysAndWhenInUseUsageDescription和NSLocationWhenInUseUsageDescription字段。")
                }
            } else {
                if (!hasAlwaysKey.isEmpty) {
                    manager .requestAlwaysAuthorization()
                } else if (!hasWhenInUseKey.isEmpty) {
                    manager.requestWhenInUseAuthorization()
                } else {
                    debugPrint("要在iOS8到iOS10版本使用定位服务, 需要在Info.plist中添加 \\NSLocationAlwaysUsageDescription或者NSLocationWhenInUseUsageDescription字段。")
                }
            }
        }
        
    }
    
    //如果当前场景需要精确定位，则可以申请一次临时精确定位
    private func requestTemporaryFullAccuracyAuthorizationIfNeed(manager: CLLocationManager, purposeKey: String) {
        if #available(iOS 14.0, *) {
            //如果已经获得定位权限，但精度权限只是模糊定位
            if manager.accuracyAuthorization == .reducedAccuracy {
                guard let locationTemporaryDictionary = Bundle.main.object(forInfoDictionaryKey: "NSLocationTemporaryUsageDescriptionDictionary") as? String else {
                    debugPrint("如果需要使用临时精确定位，需要在Info.plist中添加 \\ NSLocationTemporaryUsageDescriptionDictionary字段。")
                    return }
                
                let hasLocationTemporaryKey = !locationTemporaryDictionary.isEmpty
                
                if (hasLocationTemporaryKey) {
                    //此API不能用于申请定位权限，只能用于从模糊定位升级为精确定位；申请定位权限只能调用
                    //requestWhen或requestAlways，如果没有获得定位权限，直接调用此API无效。
                    manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: purposeKey, completion: nil)
                } else {
                    debugPrint("如果需要使用临时精确定位，需要在Info.plist中添加 \\ NSLocationTemporaryUsageDescriptionDictionary字段。");
                }
            }
        }
    }
}

extension RequestLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let delegate = delegate {
            delegate.didUpdateLocations?(locations: locations)
        }
        manager.stopUpdatingLocation()
    }
}
