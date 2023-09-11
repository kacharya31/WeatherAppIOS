//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Krithik Acharya on 9/9/23.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject {
    
    private var coreLocationManager: CLLocationManager
    
    @Published var location: CLLocationCoordinate2D?
    @Published var gettingLocation: Bool = false
    
    override init() {
        self.coreLocationManager = CLLocationManager()
        super.init()
        configureCoreLocationManager()
    }
    
    private func configureCoreLocationManager() {
        coreLocationManager.delegate = self
    }
    
    func requestLocation() {
        gettingLocation = true
        coreLocationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else { return }
        location = mostRecentLocation.coordinate
        updateGettingLocationStatus(to: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occurred: \(error.localizedDescription)")
        updateGettingLocationStatus(to: false)
    }
    
    private func updateGettingLocationStatus(to value: Bool) {
        gettingLocation = value
    }
}


