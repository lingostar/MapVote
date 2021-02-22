//
//  ViewController.swift
//  MapVote
//
//  Created by LingoStar on 2021/02/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mainMapView: MKMapView!
    
    var region : MKCoordinateRegion?
    private var allAnnotations: [MKAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setMapView()
    }

    //기본 위도, 경도 location으로 mapView 표시
    func setMapView(){
        // Set initial region with initialLocation and span
        let initialLocation = CLLocationCoordinate2D(latitude: 36.505733, longitude: 127.255664)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.04)
        
        region = MKCoordinateRegion(center: initialLocation, span: span)
        
        // setRegion on mapView
        self.mainMapView.setRegion(region!, animated: true)
        
        // Set Annotation on initialLocation
        self.mainMapView.addAnnotations(dummyAnnotations)
    }

    // MARK: - Annotation
    
    private func registerMapAnnotationViews() {
        mainMapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(Annotation.self))
    }
    
}

