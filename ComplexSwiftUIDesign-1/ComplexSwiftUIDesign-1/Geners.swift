//
//  Geners.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 30/03/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI

struct GenersView: View {

   var certificates = genersData
    var courses = generData

   var body: some View {
      VStack(alignment: .leading) {
         Text("Geners")
            .font(.system(size: 20))
            .fontWeight(.heavy)
            .padding(.leading, 30)
         ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
               ForEach(courses) { item in
                Button(action: {  }) {
                   GeometryReader { geometry in
                      SingleGenerView(title: item.title,
//                                 image: item.title,
                                 color: item.color,
                                 shadowColor: item.shadowColor)
//                         .rotation3DEffect(Angle(degrees:
//                            Double(geometry.frame(in: .global).minX - 20) / -40), axis: (x: 0, y: 20.0, z: 0))
                   }
                   .frame(width: 100, height: 100)
                }
//                  CertificateView(item: item)
               }
            }
//            .padding(10)
            .padding(.leading, 20)
         }
      }
   }
}

//#if DEBUG
struct GenersView_Previews: PreviewProvider {
   static var previews: some View {
      GenersView()
   }
}
//#endif

struct Geners: Identifiable {
   var id = UUID()
   var title: String
   var image: String
   var width: Int
   var height: Int
}

let genersData = [
   Geners(title: "UI Design", image: "Certificate1", width: 230, height: 150),
   Geners(title: "SwiftUI", image: "Certificate2", width: 230, height: 150),
   Geners(title: "Sketch", image: "Certificate3", width: 230, height: 150),
   Geners(title: "Framer", image: "Certificate4", width: 230, height: 150)
]
