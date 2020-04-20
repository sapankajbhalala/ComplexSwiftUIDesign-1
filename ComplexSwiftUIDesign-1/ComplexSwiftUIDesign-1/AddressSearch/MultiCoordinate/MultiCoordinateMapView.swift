//
//  MultiCoordinateMapView.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 20/04/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI
import MapKit

struct MultiCoordinateMapView: UIViewRepresentable {
  @Binding var checkpointList: [AddressPoint]
  
  func makeUIView(context: Context) -> MKMapView {
    MKMapView()
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    uiView.addAnnotations(checkpointList)
//    // set span (radius of points)
//    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
//
//    // set region
//    let region = MKCoordinateRegion(center: checkpoints[0].coordinate, span: span)
    //    uiView.setRegion(region, animated: true)

    uiView.setVisibleMapRect(getZoomRect(list: checkpointList), edgePadding: mapEdgePadding, animated: true)
  }
}
//===========================
