//
//  MapView.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 20/04/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

///Simple Mapview with current location
///Zoom coordinate with current location


struct MapView: UIViewRepresentable {
  
  var locationManager = CLLocationManager()
  func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
  }
  
  func makeUIView(context: Context) -> MKMapView {
    setupManager()
    let mapView = MKMapView()
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
        // set span (radius of points)
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//
//    if let location = locationManager.location {
//            // set region
//        let region = MKCoordinateRegion(center: location.coordinate, span: span)
//                uiView.setRegion(region, animated: true)
//    }
////    uiView.setVisibleMapRect(getZoomRect(list: uiView.annotations), edgePadding: mapEdgePadding, animated: true)
  }
}
//========================
