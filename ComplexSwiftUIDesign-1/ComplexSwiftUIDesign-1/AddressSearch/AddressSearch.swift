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
import GooglePlaces
import GoogleMapsBase

struct AddressSearch: View {
    @State var checkpoints: [Checkpoint] = [
       Checkpoint(title: "Da Nang", coordinate: .init(latitude: 16.047079, longitude: 108.206230)),
       Checkpoint(title: "Ha Noi", coordinate: .init(latitude: 21.027763, longitude: 105.834160))
     ]
    @State var address: String = ""
    @State var typing = false
    @State var addressList: [Address] = []
    @State var selPlace: GMSPlace?
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            VStack{
                VStack {
                    HStack {
                        Image(systemName: "location").foregroundColor(.gray)
                        TextField("Search Address", text: Binding<String>(
                        get: { self.address },
                        set: {
                            self.address = $0
                            self.placeAutocomplete(text_input: $0)
                        }))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                      }
                    .padding(10)
                }
                ZStack {
                    VStack {
                        VStack{
                            Text("Current Location")
                            MapView()
                        }
                        VStack{
                            Text("Multiple Coordinate")
                            MapViewAdvance(checkpoints: $checkpoints)
                        }
                    }
                    if addressList.count > 0 {
                        List(addressList) { address in
                            HStack {
                                Button(action: {
                                    self.getLocationFromplaceId(placeId: address.placeId)
                                }) {
                                    Text("\(address.title)")
                                }.alert(isPresented: self.$showingAlert) {
                                    Alert(title: Text(""), message: Text(self.alertMessage), dismissButton: .default(Text("Ok")))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //function for autocomplete
    func placeAutocomplete(text_input: String) {
        let filter = GMSAutocompleteFilter()
        let placesClient = GMSPlacesClient()
        filter.type = .establishment
        //geo bounds set for bengaluru region
        let bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: 13.001356, longitude: 75.174399), coordinate: CLLocationCoordinate2D(latitude: 13.343668, longitude: 80.272055))
        
        placesClient.autocompleteQuery(text_input, bounds: nil, filter: nil) { (results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
                return
            }
            self.addressList = []
            if let results = results {
                print("Result: \(results)")
                for result in results {
                    let address = Address(placeId: result.placeID, title: result.attributedPrimaryText.string, coordinate: nil)
                    self.addressList.append(address)
                }

            }
        }
    }

    func getLocationFromplaceId(placeId: String)  {
        let placesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(placeId) { (place, error) in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
                return
            }
            if let place = place {
    //                    self.lblName?.text = place.name
                print("Place: \(place)")
                print("The selected place is: \(place.name)")
                self.addressList = []
                self.selPlace = place
                self.checkpoints.append(Checkpoint(title: place.name, coordinate: place.coordinate))
                self.address = ""
                resignKeyboard()
            }
        }
    }
}

struct AddressSearch_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearch(address: "")
    }
}

struct Address: Identifiable {
    var id = UUID()
    var placeId: String
    var title: String
    var coordinate: CLLocationCoordinate2D? = nil
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
    
    if let location = locationManager.location {
            // set region
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
                uiView.setRegion(region, animated: true)
    }
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

//==================
