//
//  ParkVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit
import MapKit

class RingVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var coordinat: [[Double]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadring()
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: false)
        }

        self.locationManager = locationManager

        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
    }
    
    
    func loadring()
    {
        navigationController?.title = "Ring Noktaları"
        GetRings().get { (result) in
            switch result
            {
                case .succes(let data):
                
                    for park in data.parklar
                    {
                        if let lat = Double(park.lat), let long = Double(park.long)
                        {
                            self.coordinat.append([lat, long])
                        }
                }
                
                    for point in self.coordinat
                {
                    let annotation = MKPointAnnotation()
                    let coordinat = CLLocationCoordinate2D(latitude: point[0], longitude: point[1])
                    annotation.coordinate = coordinat
                    annotation.title = "Ring Noktası"
                    self.mapView.addAnnotation(annotation)
                }
                
            
            case .error(errorType: let type):
                break
                
            }
        }
    }

}
