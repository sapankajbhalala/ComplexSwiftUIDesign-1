//
//  AddressSearch.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 17/04/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

struct AddressSearch: View {
    @State var checkpoints: [Checkpoint] = [
       Checkpoint(title: "Da Nang", coordinate: .init(latitude: 16.047079, longitude: 108.206230)),
       Checkpoint(title: "Ha Noi", coordinate: .init(latitude: 21.027763, longitude: 105.834160))
     ]

    var body: some View {
        VStack{
            VStack{
                Text("Current Location")
                MapView()
            }
            VStack{
                Text("Multiple Coordinate")
                MapViewAdvance(checkpoints: $checkpoints)
            }
            
        }
    }
}

struct AddressSearch_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearch()
    }
}


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
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
        // set region
    let region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: span)
            uiView.setRegion(region, animated: true)
//    uiView.setVisibleMapRect(getZoomRect(list: uiView.annotations), edgePadding: mapEdgePadding, animated: true)
  }
}
//========================


//=================
///MapView with multiple Coordinates
final class Checkpoint: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
  
  init(title: String?, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.coordinate = coordinate
  }
}

struct MapViewAdvance: UIViewRepresentable {
  @Binding var checkpoints: [Checkpoint]
  
  func makeUIView(context: Context) -> MKMapView {
    MKMapView()
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    uiView.addAnnotations(checkpoints)
//    // set span (radius of points)
//    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
//
//    // set region
//    let region = MKCoordinateRegion(center: checkpoints[0].coordinate, span: span)
    //    uiView.setRegion(region, animated: true)

    uiView.setVisibleMapRect(getZoomRect(list: checkpoints), edgePadding: mapEdgePadding, animated: true)
  }
}
//===========================


//===========================
///Bound zoom map with multiple coordinates
let mapEdgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

func getZoomRect(list: [MKAnnotation]) -> MKMapRect {
    var zoomRect:MKMapRect = MKMapRect.null
    for index in 0..<list.count {
        let annotation = list[index]
        let aPoint:MKMapPoint = MKMapPoint(annotation.coordinate)
        let rect:MKMapRect = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)

        if zoomRect.isNull {
            zoomRect = rect
        } else {
            zoomRect = zoomRect.union(rect)
        }
    }
    return zoomRect
}
