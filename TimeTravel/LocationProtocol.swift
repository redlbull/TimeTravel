//
//  LocationProtocol.swift
//  TimeTravel
//
//  Created by Rafael Reis on 26.03.20.
//  Copyright © 2020 Rafael Reis. All rights reserved.
//

import Foundation

protocol LocationProtocol {
  
    func lat() -> Float
    func long() -> Float
    func addr() -> String
    func isDefined() -> Bool
}
