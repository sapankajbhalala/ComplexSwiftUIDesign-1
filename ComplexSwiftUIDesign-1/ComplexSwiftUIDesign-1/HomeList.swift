//
//  HomeList.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 27/03/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI

struct HomeList: View {

   var courses = coursesData
   @State var showDetail = false

   var body: some View {
      ScrollView {
         VStack {
            HStack {
               VStack(alignment: .leading) {
                  Text("Movies")
                     .font(.largeTitle)
                     .fontWeight(.heavy)

                  Text("All Movies")
                     .foregroundColor(.gray)
               }
               Spacer()
            }
            .padding(.leading, 60.0)

            ScrollView(.horizontal, showsIndicators: false) {
               HStack(spacing: 30.0) {
                  ForEach(courses) { item in
                     Button(action: { self.showDetail.toggle() }) {
                        GeometryReader { geometry in
                           MovieView(title: item.title,
                                      image: item.image,
                                      color: item.color,
                                      shadowColor: item.shadowColor)
                              .rotation3DEffect(Angle(degrees:
                                 Double(geometry.frame(in: .global).minX - 20) / -40), axis: (x: 0, y: 20.0, z: 0))
                        }
                        .frame(width: 246, height: 360)
                     }
                  }
               }
               .padding(.leading, 30)
               .padding(.top, 30)
               .padding(.bottom, 70)
               Spacer()
            }
         }
         .padding(.top, 78)
      }
   }
}

#if DEBUG
struct HomeList_Previews: PreviewProvider {
   static var previews: some View {
      HomeList()
   }
}
#endif

struct MovieView: View {

   var title = "Toy Story"
   var image = "Toy Story"
   var color = Color("background3")
   var shadowColor = Color("backgroundShadow3")

   var body: some View {
      return VStack(alignment: .leading) {
        ZStack {
            
                     Image(image)
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 246, height: 360)
            Text(title)
               .font(.title)
               .fontWeight(.bold)
               .foregroundColor(.white)
                .lineLimit(4)
            .shadow(color: color, radius: 4, x: 1, y: 1)

        }
         
      }
      .background(color)
      .cornerRadius(30)
      .frame(width: 246, height: 360)
      .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
   }
}

struct Movie: Identifiable {
   var id = UUID()
   var title: String
   var image: String
   var color: Color
   var shadowColor: Color
}

let coursesData = [
   Movie(title: "Toy Story",
          image: "Toy Story",
          color: Color("background3"),
          shadowColor: Color("backgroundShadow3")),
   Movie(title: "Grumpy Old Men",
          image: "Grumpy Old Men",
          color: Color("background4"),
          shadowColor: Color("backgroundShadow4")),
   Movie(title: "Father of the Bride",
          image: "Father of the Bride",
          color: Color("background7"),
          shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
   Movie(title: "GoldenEye",
          image: "GoldenEye",
          color: Color("background8"),
          shadowColor: Color("backgroundShadow4")),
   Movie(title: "The American President",
          image: "The American President",
          color: Color("background9"),
          shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
]
