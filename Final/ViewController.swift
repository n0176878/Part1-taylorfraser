//
//  ViewController.swift
//  Final
//
//  Created by Kimberley Holmes on 2019-04-15.
//  Copyright © 2019 Taylor Fraser. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    

    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    // MARK:- Actions
    @IBAction func getLocation() {
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    // MARK:- Helper Methods
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func updateLabels() {
        if let location = location {
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            
            // setting color variables
          
            let red = abs(location.coordinate.latitude.rounded() / location.coordinate.latitude)
            print(red)
            let green = abs(location.coordinate.longitude.rounded() / location.coordinate.longitude)
            print(green)
            let blue: Double = (176878 / 1000000)
            print(blue)
            let alpha = (1.0)
            print(alpha)
            
            let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))

    
            self.view.backgroundColor = color
            
       
        } else {
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            self.view.backgroundColor = UIColor.white
  
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")
        location = newLocation
        
        
 
        updateLabels()
        }
}

