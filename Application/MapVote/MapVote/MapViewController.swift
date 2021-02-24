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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setMapView()
    }

    //기본 위도, 경도 location으로 mapView 표시
    func setMapView(){
        mainMapView.delegate = self
        mainMapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(Annotation.self))
        
        // Set initial region with initialLocation and span
        let initialLocation = CLLocationCoordinate2D(latitude: 36.505733, longitude: 127.255664)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.04)
        
        region = MKCoordinateRegion(center: initialLocation, span: span)
        
        // setRegion on mapView
        self.mainMapView.setRegion(region!, animated: true)
        
        // Annotation 추가하기. flatMap으로 3개 카테고리 내의 item들을 하나의 array로 만들고,
        // item들을 Annotation으로 변환
        self.mainMapView.addAnnotations(dummyCategories.flatMap{$0.items}.map{$0.makeAnnotation()})
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // 사용자의 현재 위치를 나타내는 이미지는 커스터마이즈 하지 않는다.
            return nil
        }
        
        var annotationView: MKAnnotationView?
        
        if let annotation = annotation as? Annotation {
            annotationView = setupAnnotationView(for: annotation, on: mapView)
        }
        
        return annotationView
    }
    
    private func setupAnnotationView(for annotation: Annotation, on mapView: MKMapView) -> MKAnnotationView {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(Annotation.self), for: annotation)
        annotationView.canShowCallout = true
        annotationView.calloutOffset = CGPoint(x: -5, y: 5)
        
        annotationView.image = UIImage(named: annotation.item.pinImageUrl)

        return annotationView
    }
    
}

