//
//  SimpleLocation.swift
//  TimeTravel
//
//  Created by Rafael Reis on 26.03.20.
//  Copyright © 2020 Rafael Reis. All rights reserved.
//

import UIKit

class SimpleLocation: LocationProtocol {
    private var latitude,longitude : Float
    private var address: String
    
    public static let NULL = SimpleLocation()
    
    init(lat: Float, long: Float, address: String) {
        self.latitude = lat
        self.longitude = long
        self.address = address
    }
    
    private init() {
        self.latitude = 0
        self.longitude = 0
        self.address = ""
    }
    
    func lat() -> Float {
        
        return self.latitude
    }
    
    func long() -> Float {
        return self.longitude
    }
    
    func addr() -> String {
        return self.address
    }
    
    func isDefined() -> Bool {
        return true
    }
    

}
