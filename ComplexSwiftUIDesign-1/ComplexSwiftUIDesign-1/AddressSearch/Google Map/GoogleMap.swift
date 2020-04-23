//
//  GoogleMap.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 21/04/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct GoogleMap: View {
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
                        VStack{
                            HStack {
                                Text("Google Map Coordinate")
                                if checkpoints.count > 0 {
                                    Spacer()
                                    Button(action: {
                                        self.checkpoints = []
                                    }) {
                                        Text("Clear")
                                    }
                                }
                            }.padding(10)
                            GoogleMapView(checkpointList: $checkpoints)
                        }
                        if checkpoints.count > 0 {
                            VStack {
                                HStack {
                                    Text("Address List : ")
                                        .fontWeight(.bold)
                                        .padding(.leading, 20)
                                    Spacer()
                                }
                                List {
                                    ForEach(checkpoints, id: \.self) { (item) in
                                        HStack {
                                            Image(systemName: "pin").foregroundColor(.red)
                                            VStack(alignment: .leading) {
                                                Text("\(item.title ?? "")")
                                                Text("\(item.coordinate.latitude), \(item.coordinate.longitude)")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }.onDelete { (indexSet) in
                                        self.checkpoints.remove(atOffsets: indexSet)
                                    }
                                }.onAppear() {
                                    UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                                }
                            }
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
                print("place:\(place)")
                self.checkpoints.append(AddressPoint(title: place.formattedAddress, coordinate: place.coordinate))
            }
        }
    }

    ///function for autocomplete
    /// get places from input string
    func placeAutocomplete(input: String) {
        let placesClient = GMSPlacesClient()
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
                    let address = Address(placeId: result.placeID, title: result.attributedFullText.string, coordinate: nil)
                    self.addressList.append(address)
                }

            }
        }
    }

}

struct GoogleMap_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMap()
    }
}

struct GoogleMapView: UIViewRepresentable {
    @Binding var checkpointList: [AddressPoint]
    
    func makeUIView(context: Context) -> GMSMapView {
        GMSMapView()
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Creates a marker in the center of the map.
        uiView.clear()
        for position in checkpointList {
            let marker = GMSMarker()
            marker.position = position.coordinate
            marker.title = position.title
            marker.map = uiView
        }
        if checkpointList.count > 0 {
            let firstLocation = (checkpointList.first!).coordinate
            var bounds = GMSCoordinateBounds(coordinate: firstLocation, coordinate: firstLocation)

            for marker in checkpointList {
              bounds = bounds.includingCoordinate(marker.coordinate)
            }

           let update = GMSCameraUpdate.fit(bounds, withPadding: CGFloat(15))
           uiView.animate(with: update)
        }
    }
}
//===========================
