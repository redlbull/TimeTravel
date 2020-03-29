//
//  IphoneUser.swift
//  TimeTravel
//
//  Created by Rafael Reis on 26.03.20.
//  Copyright © 2020 Rafael Reis. All rights reserved.
//

import UIKit
import GooglePlaces
import SwiftyJSON

class IphoneUser: NSObject, UserProtocol {
        
    var dest: LocationProtocol
    var map: MapProtocol
    
    var placesClient: GMSPlacesClient!
    
    init(map: MapProtocol, destination: LocationProtocol = SimpleLocation.NULL){
        self.map = map
        self.dest = destination
    }
    
    func position(completion: @escaping (LocationProtocol) -> Void) -> Void {
        placesClient = GMSPlacesClient.shared()
        
        self.placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    let loc = SimpleLocation(lat: Float(place.coordinate.latitude), long: Float(place.coordinate.longitude), address: place.name ?? "")
                    completion(loc)
                }
            }
        })
    }
    
    func destination() -> LocationProtocol {
        //return user destination
        let location = self.dest
        return location
    }
    
    func changeDest(location: LocationProtocol) -> UserProtocol {
        return IphoneUser(map: self.map, destination: location)
    }
    
    /*
    func changeDest(place: String, completion: @escaping (UserProtocol) -> Void) {
        self.map.findPlace(place: place) { loc in
            completion(IphoneUser(map: self.map, destination: loc))
        }
    }
    */
    
    func travelTime(completion: @escaping (Int) -> Void) -> Void {
        position { pos in
            self.map.timeA2B(origin: pos, dest: self.dest) { seconds in
                completion(seconds)
            }
        }
    }
}
