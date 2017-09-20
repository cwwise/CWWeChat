//
//  MapShowController.swift
//  CWWeChat
//
//  Created by wei chen on 2017/9/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CWActionSheet

class MapShowController: UIViewController {

    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    var address: String = ""
    var detail: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()

        mapView = MKMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0))
        }
        
        if CLLocationManager.locationServicesEnabled() == false {
            print("定位服务未开启")
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        
        let locationButton = UIButton(type: .custom)
        locationButton.setImage(#imageLiteral(resourceName: "location_my_current"), for: .normal)
        locationButton.setImage(#imageLiteral(resourceName: "location_my_HL"), for: .highlighted)
        locationButton.addTarget(self, action: #selector(locationAction), for: .touchUpInside)
        self.view.addSubview(locationButton)
        
        locationButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.bottom.equalTo(-90-15)
        }
        
        setupNavigationItem()
        setupLocationInfo()
    }
    
    func setupNavigationItem() {
        
        
    }
    
    func setupLocationInfo() {
        let bottomView = UIView()
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(90)
        }
        
        let addressLabel = UILabel()
        addressLabel.font = UIFont.systemFont(ofSize: 18)
        addressLabel.numberOfLines = 1
        addressLabel.textColor = UIColor.black
        bottomView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(20)
        }
        
        let detailLabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        detailLabel.numberOfLines = 0
        detailLabel.textColor = UIColor.gray
        bottomView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(addressLabel.snp.bottom).offset(6)
        }

        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "locationSharing_navigate_icon"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "locationSharing_navigate_icon_HL"), for: .highlighted)
        button.addTarget(self, action: #selector(navigationLocation), for: .touchUpInside)
        bottomView.addSubview(button)

        button.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func locationAction() {
        
        let location = mapView.userLocation.coordinate
        mapView.setCenter(location, animated: true)
    }
    
    @objc func navigationLocation() {
        
        let otherButtonTitle = ["腾讯地图","Apple地图"]
        let clickedHandler = { (actionSheet: ActionSheetView, index: Int) in
            
            if index == 0 {
             
            } else if index == 1 {

            }
            
        }
        
        let actionSheet = ActionSheetView(title: "显示路线",
                                          cancelButtonTitle: "取消",
                                          otherButtonTitles: otherButtonTitle,
                                          clickedHandler: clickedHandler)
        
        actionSheet.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MapShowController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
}

extension MapShowController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("点击。。。")
    }
    
}
