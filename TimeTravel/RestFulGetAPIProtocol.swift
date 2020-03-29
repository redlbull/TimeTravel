//
//  CallProtocol.swift
//  TimeTravel
//
//  Created by Rafael Reis on 26.03.20.
//  Copyright © 2020 Rafael Reis. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol RestFulGetAPIProtocol {
    func call(function: String, params: Dictionary<String, String>, completion: @escaping (JSON) -> Void) -> Void
}
