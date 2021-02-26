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
    
    var region : MKCoordinateRegion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getJson { (jsonData) in
    
            self.makeRandomData(categories : jsonData)
        }
        
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
        
        updateUI()
    }
    
    func updateUI() {
        // setRegion on mapView
        self.mainMapView.setRegion(region, animated: true)
        
        var annotations = mainMapView.annotations
        self.mainMapView.removeAnnotations(annotations)
        
        // Annotation 추가하기. flatMap으로 3개 카테고리 내의 item들을 하나의 array로 만들고,
        // item들을 Annotation으로 변환
        self.mainMapView.addAnnotations(categoryData.flatMap{$0.items}.map{$0.makeAnnotation()})
    }
    
    func makeRandomData(categories : [Category]){
        categoryData = [Category]()
        for category in categories{
            print("category : \(category)")
            var newCategory = Category(categoryName: category.categoryName, itemTemplates: category.itemTemplates, items: [Item]())
            
            for itemTemplate in category.itemTemplates {
                print("data : \(itemTemplate)")
                let items = makeRandomItems(itemTemplate:itemTemplate)
                newCategory.items.append(contentsOf: items)
            }
            categoryData.append(newCategory)
            
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    func makeRandomItems(itemTemplate : ItemTemplate) -> [Item] {
        
        let pinPerCategory = 50
        let itemPinCount = (pinPerCategory * itemTemplate.weight) / 100
        
        var items:[Item] = []
        for _ in 0...itemPinCount {
            let randomLocation = createRandomLocation(in: region)
            items.append(Item(itemName: itemTemplate.itemName, pinImageUrl: itemTemplate.pinImageUrl, latitude: randomLocation.0, longitude: randomLocation.1))
        }
        return items
    }
    
    func createRandomLocation(in region: MKCoordinateRegion) -> (Double, Double) {
        //region의 최소, 최대값 구함 (최소 : 중앙에서 span의 1/2만큼 마이너스, 최대 : 중앙에서 span의 1/2만큼 플러스)
        let minLat = region.center.latitude - (region.span.latitudeDelta/2)
        let maxLat = region.center.latitude + (region.span.latitudeDelta/2)
        
        let minLon = region.center.longitude - (region.span.longitudeDelta/2)
        let maxLon = region.center.longitude + (region.span.longitudeDelta/2)
        
        //0부터 파라미터(span값) 사이의 난수를 리턴
        let latRand = Double.random(in: minLat...maxLat)
        let lonRand = Double.random(in: minLon...maxLon)
        
        return (latRand, lonRand)
    }
    
    @IBAction func unwindToMap(segue:UIStoryboardSegue){
        print("unwind")
        
    }
    
    @IBAction func refreshSelection(_ sender: Any) {
        region = mainMapView.region
        
        self.makeRandomData(categories: categoryData)
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
