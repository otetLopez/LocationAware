//
//  ViewController.swift
//  LocationAware
//
//  Created by otet_tud on 1/9/20.
//  Copyright © 2020 otet_tud. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var latlbl: UILabel!
    @IBOutlet weak var longlbl: UILabel!
    @IBOutlet weak var speedlbl: UILabel!
    @IBOutlet weak var courselbl: UILabel!
    @IBOutlet weak var altlbl: UILabel!
    @IBOutlet weak var addrlbl: UILabel!
    
    
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        latlbl.text = String(location.coordinate.latitude)
        longlbl.text = String(location.coordinate.longitude)
        speedlbl.text = String(location.speed)
        courselbl.text = String(location.course)
        altlbl.text = String(location.altitude)
        
       
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print(error)
            }  else {
                if let placemark = placemarks?[0] {
                    var address = ""
                    var subThoroufare = ""
                    if placemark.subThoroughfare != nil {
                        subThoroufare = placemark.subThoroughfare!
                    }
                    
                    var thoroufare = ""
                    if placemark.thoroughfare != nil {
                        thoroufare = placemark.thoroughfare!
                    }
                    
                    var subLocality = ""
                    if placemark.subLocality != nil {
                        subLocality = placemark.subLocality!
                    }
                    
                    var subAdministrativeArea = ""
                    if placemark.subAdministrativeArea != nil {
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    
                    var postalCode = ""
                    if placemark.postalCode != nil {
                        postalCode = placemark.postalCode!
                    }
                    
                    var country = ""
                    if placemark.country != nil {
                        country = placemark.country!
                    }
                    
                    address = String("\(subThoroufare)\n\(thoroufare)\n\(subLocality)\n\(subAdministrativeArea)\n\(postalCode)\n\(country)")
                    print("1 This is the address --> \(address)")
                    self.addrlbl.text = address

                }
            }
        }
//        print("2 This is the address --> \(address)")
//        addrlbl.text = address
        
    }


}

