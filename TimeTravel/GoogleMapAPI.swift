//
//  GoogleMapAPI.swift
//  TimeTravel
//
//  Created by Rafael Reis on 26.03.20.
//  Copyright © 2020 Rafael Reis. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapAPI: RestFulGetAPIProtocol {
    
    let url: String
    
    init() {
        self.url = "https://maps.googleapis.com/maps/api/"
    }
    
    func call(function: String, params: Dictionary<String, String>, completion: @escaping (JSON) -> Void) -> Void {
        
        var googleUrl = buidURL(function: function, params: params)
        googleUrl = googleUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var urlRequest = URLRequest(url: URL(string: googleUrl)!)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest){ (data, resp, err) in
            guard let data = data else { return }
            if err == nil {
                if let json = try? JSON(data: data) {
                    completion(json)
                }
            }else {
                print(err!.localizedDescription)
            }
        }
        task.resume()
    }
    
    private func buidURL(function: String, params: Dictionary<String, String>) -> String {
        var googleUrl = "\(self.url)\(function)?"
        
        for (item) in params.enumerated() {
            if(item.offset > 0){
                googleUrl = "\(googleUrl)&\(item.element.key)=\(item.element.value)"
            }else {
                googleUrl = "\(googleUrl)\(item.element.key)=\(item.element.value)"
            }
        }
        googleUrl = "\(googleUrl)&key=\(apiKey)"
        
        return googleUrl
    }

}
