//
//  ViewController.swift
//  DemoBeacon
//
//  Created by TuanLA on 10/9/19.
//  Copyright © 2019 TuanLA. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    let distanceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lbl.text = "Out Of Range"
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(distanceLabel)
        distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        distanceLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = iBeaconConfiguration.uuid
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons.count)
        if beacons.count > 0 {
            updateDistance(beacons[0].proximity)
        } else {
            updateDistance(.unknown)
        }
    }
    
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.5) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                self.distanceLabel.text = "Out Of Range!"
                
            case .far:
                self.view.backgroundColor = UIColor.blue
                self.distanceLabel.text = "Far"
                
            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceLabel.text = "Near"
                
            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceLabel.text = "Immediate"
                
            @unknown default:
                self.view.backgroundColor = UIColor.white
                self.distanceLabel.text = "Error!"
            }
        }
    }
    
}

