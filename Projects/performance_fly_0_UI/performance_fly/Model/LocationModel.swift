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
        } else {
            placeMarkCallback = completion
            if !placeMarkFetchInProgress {
                
            }
        }
    }
    
    private func beginReverseGeocodingLocationFromCoordinates() {
        if placeMarkFetchInProgress {
            return
        }
    }
    
    static func ==(lhs: LocationModel, rhs: LocationModel) -> Bool {
        return (lhs.coordinates.latitude == rhs.coordinates.latitude && lhs.coordinates.longitude == rhs.coordinates.longitude)
    }

}
