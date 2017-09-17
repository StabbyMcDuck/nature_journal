//
//  PinMapViewController.swift
//  nature_journal
//
//  Created by Regina Imhoff on 9/17/17.
//  Copyright © 2017 Regina Imhoff. All rights reserved.
//

import UIKit
import MapKit

class PinMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var centerLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    let regionRadius: CLLocationDistance = 500 // 500 meters
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        
        centerMapOnLocation(location: centerLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
