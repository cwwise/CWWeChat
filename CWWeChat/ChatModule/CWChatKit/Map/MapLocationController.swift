//
//  MapLocationController.swift
//  CWWeChat
//
//  Created by chenwei on 2017/9/20.
//  Copyright © 2017年 cwwise. All rights reserved.
//

import UIKit

class MapLocationController: UIViewController {

    var mapView: MAMapView!
    var search: AMapSearchAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        mapView = MAMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = .follow
        self.view.addSubview(mapView)

        let location = MAUserLocationRepresentation()
        location.showsAccuracyRing = true
        self.mapView.update(location)
        
    }

    func buttonItemAction(_ sender: UIBarButtonItem) {
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400)
        self.mapView.takeSnapshot(in: mapView.bounds) { (image, rect) in
            UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
