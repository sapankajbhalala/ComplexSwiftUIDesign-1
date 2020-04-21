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


let mapEdgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

struct AddressSearch: View {
    @State private var checkpoints: [AddressPoint] = []
    @State private var address: String = ""
    @State private var typing = false
    @State private var addressList: [Address] = []
    @State private var showingAlert = false
    @State private var alertMessage = ""
    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMessage), dismissButton: .default(Text("OK")))
    }
    
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
                            self.placeAutocomplete(input: $0)
                        }))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        if !self.address.isEmpty {
                            Button(action: {
                                self.address = ""
                                resignKeyboard()
                                self.addressList = []
                            }) {
                                Image(systemName: "multiply.circle")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 30, weight: Font.Weight.light, design: Font.Design.default))
                                    .frame(width: 40, height: 40, alignment: .center)
                            }
                        }
                      }
                    .padding(10)
                }
                ZStack {
                    VStack {
//                        VStack{
//                            Text("Current Location")
//                            MapView()
//                        }
                        VStack{
                            HStack {
                                Text("Multiple Coordinate")
                                if checkpoints.count > 0 {
                                    Spacer()
                                    Button(action: {
                                        self.checkpoints = []
                                    }) {
                                        Text("Clear")
                                    }
                                }
                            }.padding(10)
                            MultiCoordinateMapView(checkpointList: $checkpoints)
                        }
                    }
                    if addressList.count > 0 {
                        List(addressList) { address in
                            HStack {
                                Button(action: {
                                    self.getLocationFromplaceId(placeId: address.placeId)
                                }) {
                                    Text("\(address.title)")
                                }
                            }
                        }
                    }
                }
            }.alert(isPresented: self.$showingAlert, content: { self.alert })
        }
    }
    
    ///function for autocomplete
    /// get places from input string
    func placeAutocomplete(input: String) {
        let filter = GMSAutocompleteFilter()
        let placesClient = GMSPlacesClient()
        filter.type = .establishment
        //geo bounds set for bengaluru region
        let bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: 13.001356, longitude: 75.174399), coordinate: CLLocationCoordinate2D(latitude: 13.343668, longitude: 80.272055))
        
        placesClient.autocompleteQuery(input, bounds: nil, filter: nil) { (results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                self.alertMessage = error.localizedDescription
                self.showingAlert.toggle()
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

    ///function for autocomplete
    /// get place information from place id
    func getLocationFromplaceId(placeId: String)  {
        let placesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(placeId) { (place, error) in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                self.alertMessage = error.localizedDescription
                self.showingAlert.toggle()
                return
            }
            if let place = place {
                self.addressList = []
                self.address = ""
                resignKeyboard()
                self.checkpoints.append(AddressPoint(title: place.formattedAddress, coordinate: place.coordinate))
            }
        }
    }
}

struct AddressSearch_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearch()
    }
}


