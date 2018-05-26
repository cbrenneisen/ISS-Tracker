//
//  LocationManager.swift
//  Coding Challenge
//
//  Created by Carlos Brenneisen on 3/16/18.
//  Copyright © 2018 Carl Brenneisen. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    
    func updated(location: CLLocation?)
    func updatedAuthorization(status: CLAuthorizationStatus)
}

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var currentLocation: CLLocation? {
        didSet {
            delegate?.updated(location: currentLocation)
        }
    }
    var status: CLAuthorizationStatus = .notDetermined {
        didSet {
            delegate?.updatedAuthorization(status: status)
        }
    }

    weak var delegate: LocationManagerDelegate?
    let locationManger = CLLocationManager()
    
    override init(){
        super.init()
        locationManger.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManger.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            //currentLocation = manager.location
            locationManger.startUpdatingLocation()
        default:
            locationManger.stopUpdatingLocation()
            //currentLocation = nil
        }
    }
}
