//
//  MapProtocol.swift
//  TimeTravel
//
//  Created by Rafael Reis on 26.03.20.
//  Copyright © 2020 Rafael Reis. All rights reserved.
//

import Foundation

protocol MapProtocol {
    func findPlace(place: String, completion: @escaping (LocationProtocol) -> Void) -> Void
    func timeA2B(origin: LocationProtocol, dest: LocationProtocol, completion: @escaping (Int) -> Void) -> Void
}
