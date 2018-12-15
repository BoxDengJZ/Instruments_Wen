//
//  LocationModel.swift
//  Catstagram-Starter
//
//  Created by Luke Parham on 2/12/17.
//  Copyright © 2017 Luke Parham. All rights reserved.
//

import Foundation
import CoreLocation

class LocationModel {
    var locationString = ""
    var coordinates: CLLocationCoordinate2D
    var placemark: CLPlacemark?
    
    var placeMarkCallback: ((LocationModel) -> Void)?
    var placeMarkFetchInProgress = false
    
    init?(photoDictionary: [String: Any]) {
        guard let latitude = photoDictionary["latitude"] as? Double,
            let longitude = photoDictionary["longitude"] as? Double else {
            return nil
        }
        
        coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    
    
    
    
    
    
    func reverseGeocodedLocation(completion: @escaping ((LocationModel) -> Void)) {
        if placemark != nil {
            completion(self)
        }
        else {
            placeMarkCallback = completion
            if !placeMarkFetchInProgress {
                beginReverseGeocodingLocationFromCoordinates()
            }
        }
    }
    
    
    
    
    
    
    
    

    private func beginReverseGeocodingLocationFromCoordinates() {
        if placeMarkFetchInProgress {
            return
        }
        placeMarkFetchInProgress = true
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [unowned self] (placemarks, error) in
            if let lastPlacemark = placemarks?.last {
                self.placemark = lastPlacemark
            }
            self.locationString = self.locationStringFromPlacemark()
            
            if self.placeMarkCallback != nil {
                self.placeMarkCallback!(self)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    private func locationStringFromPlacemark() -> String {
        guard let placemark = placemark else {
            return ""
        }
        
        var locationString = ""
        
        if (placemark.inlandWater != nil) {
            locationString = placemark.inlandWater!
        } else if (placemark.subLocality != nil) && (placemark.locality != nil) {
            locationString = "\(String(describing: placemark.subLocality!)), \(String(describing: placemark.locality!))"
        } else if ((placemark.administrativeArea != nil) && (placemark.subAdministrativeArea != nil)) {
            locationString = "\(String(describing: placemark.subAdministrativeArea!)) \(String(describing: placemark.administrativeArea!))"
        } else if ((placemark.country) != nil) {
            locationString = placemark.country!
        }
        
        return locationString
    }
    

    
    static func ==(lhs: LocationModel, rhs: LocationModel) -> Bool {
        return (lhs.coordinates.latitude == rhs.coordinates.latitude && lhs.coordinates.longitude == rhs.coordinates.longitude)
    }

}
