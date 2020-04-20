//
//  Address.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 20/04/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

struct Address: Identifiable {
    var id = UUID()
    var placeId: String
    var title: String
    var coordinate: CLLocationCoordinate2D? = nil
}

//=================
///MapView with multiple Coordinates
final class AddressPoint: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
  
  init(title: String?, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.coordinate = coordinate
  }
}
