//
//  MapDetails.swift
//  RunningAppMap
//
//  Created by Julian Sandoval on 4/11/23.
//

import MapKit

enum MapDetails {
    static let location = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
    static let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class MapViewDetails: NSObject, ObservableObject,
                            CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.location, span: MapDetails.span)
    var locationManager: CLLocationManager?
    
    func checkIfLocationIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Location Else Statement")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Restricted Location")
        case .denied:
            print("Denied Location")
        //User has location on -> center map on them
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.span)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
