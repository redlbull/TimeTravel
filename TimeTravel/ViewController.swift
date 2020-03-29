//
//  ViewController.swift
//  TimeTravel
//
//  Created by Rafael Reis on 26.03.20.
//  Copyright © 2020 Rafael Reis. All rights reserved.
//

import UIKit
import GooglePlaces
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var searchTxtField: UITextField!
    @IBAction func searchTxtField(_ sender: Any) {
        searchTxtField.resignFirstResponder()
        
        let acController = GMSAutocompleteViewController()
            acController.delegate = self
       
        present(acController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var timeToGoLabel: UILabel!
    
    
    var locationManager = CLLocationManager()
    
    var user: UserProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
            
        let api = GoogleMapAPI()
        let map = MapGoogle(api: api)
        user = IphoneUser(map: map)
        
    }
    
}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        searchTxtField.text = place.name
        
        let latitude = Float(place.coordinate.latitude)
        let longitude = Float(place.coordinate.longitude)
        let add = String(place.name ?? "")
        
        self.user = self.user!.changeDest(location: SimpleLocation(lat: latitude, long: longitude, address: add))
        
        self.user!.travelTime(completion: { seconds in
            
            if(seconds > 0){
                let timeToGo = self.secondsToHoursMinutesSeconds(seconds: seconds)
                DispatchQueue.main.async {
                    self.timeToGoLabel.text = timeToGo
                }
            }else{
                DispatchQueue.main.async {
                    self.timeToGoLabel.text = "No route found"
                }
            }
        })
        
        dismiss(animated: true, completion: nil)
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        let (h, m, s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        var time = ""
        if(h > 0) {
            time = "\(h) Hours, \(m) Minutes"
        }else if(h == 0 && m > 0){
            time = "\(m) Minutes"
        }else{
            time = "\(s) Seconds"
        }
      return time
    }
}

