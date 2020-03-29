//
//  UserProtocol.swift
//  TimeTravel
//
//  Created by Rafael Reis on 26.03.20.
//  Copyright © 2020 Rafael Reis. All rights reserved.
//

import Foundation

protocol UserProtocol {
  
    func position(completion: @escaping (LocationProtocol) -> Void) -> Void
    func destination() -> LocationProtocol
    func changeDest(location: LocationProtocol) -> UserProtocol
    //func changeDest(place: String, completion: @escaping (UserProtocol) -> Void) -> Void
    func travelTime(completion: @escaping (Int) -> Void) -> Void
}
