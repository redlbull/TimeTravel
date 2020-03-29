//
//  MapAPI.swift
//  TimeTravel
//
//  Created by Rafael Reis on 26.03.20.
//  Copyright © 2020 Rafael Reis. All rights reserved.
//

import UIKit
import SwiftyJSON

class MapGoogle: MapProtocol {
    
    
    let api: GoogleMapAPI
    
    init(api: GoogleMapAPI){
        self.api = api
    }
    
    func findPlace(place: String, completion: @escaping (LocationProtocol)-> Void) -> Void {
        api.call(function: "place/textsearch/json", params: ["query":place]) { json in
            print(json["results"]["formatted_address"].stringValue)
            
            let loc = SimpleLocation(lat: json["results"]["geometry"]["location"]["lat"].floatValue, long: json["results"]["geometry"]["location"]["lng"].floatValue, address: json["results"]["formatted_address"].stringValue)
            
            completion(loc)
        }
        
    }
    
    func timeA2B(origin: LocationProtocol, dest: LocationProtocol, completion: @escaping (Int) -> Void) {
        api.call(function: "directions/json", params: ["origin":"\(origin.lat()),\(origin.long())", "destination":"\(dest.lat()),\(dest.long())"]) { json in
            let seconds = json["routes"][0]["legs"][0]["duration"]["value"].intValue
            completion(seconds)
        }
    }
    
}
