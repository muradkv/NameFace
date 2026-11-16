//
//  LocationFetcher.swift
//  NameFace
//
//  Created by murad on 13.11.2026.
//

import CoreLocation
import Observation

@Observable
final class LocationFetcher: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func stop() {
        manager.stopUpdatingLocation()
        lastKnownLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
