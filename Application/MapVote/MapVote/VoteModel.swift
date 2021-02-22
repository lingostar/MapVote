//
//  VoteModel.swift
//  MapVote
//
//  Created by LingoStar on 2021/02/22.
//

import Foundation
import MapKit

let dummyAnnotations = createDummyAnnotations()

func createDummyAnnotations() -> [MKPointAnnotation] {
    let annotation1 = MKPointAnnotation()
    annotation1.coordinate = CLLocationCoordinate2D(latitude: 36.5085153116395, longitude: 127.25339880040323)
    let annotation2 = MKPointAnnotation()
    annotation2.coordinate = CLLocationCoordinate2D(latitude: 36.51154098158622, longitude: 127.24874279646995)
    let annotation3 = MKPointAnnotation()
    annotation3.coordinate = CLLocationCoordinate2D(latitude: 36.507612895951, longitude: 127.2421385355717)
    let annotation4 = MKPointAnnotation()
    annotation4.coordinate = CLLocationCoordinate2D(latitude: 36.51509731960058, longitude: 127.2649232356707)
    let annotation5 = MKPointAnnotation()
    annotation5.coordinate = CLLocationCoordinate2D(latitude: 36.50182656892, longitude: 127.26165412652605)
    let annotation6 = MKPointAnnotation()
    annotation6.coordinate = CLLocationCoordinate2D(latitude: 36.514221520182, longitude: 127.24649734776456)
    let annotation7 = MKPointAnnotation()
    annotation7.coordinate = CLLocationCoordinate2D(latitude: 36.5006320897654, longitude: 127.25184679909215)
    let annotation8 = MKPointAnnotation()
    annotation8.coordinate = CLLocationCoordinate2D(latitude: 36.51315993184142, longitude: 127.2365249138082)
    let annotation9 = MKPointAnnotation()
    annotation9.coordinate = CLLocationCoordinate2D(latitude: 36.509736210237556, longitude: 127.22866584333926)
    let annotation10 = MKPointAnnotation()
    annotation10.coordinate = CLLocationCoordinate2D(latitude: 36.50859493604809, longitude: 127.26730076959407)
    
    return [annotation1, annotation2, annotation3, annotation4, annotation5, annotation6, annotation7, annotation8, annotation9, annotation10]
}
