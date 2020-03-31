//
//  DetailView.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 31/03/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @State var show = false
    var item = Movie(title: "Toy Story",
                    image: "Toy Story",
                    color: Color("background3"),
                    shadowColor: Color("backgroundShadow3"))
    
    var body: some View {
      return VStack(alignment: .leading) {
         HStack {
            Text(item.title)
               .font(.largeTitle)
               .fontWeight(.heavy)
            Spacer()
         }
        Image(item.image)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 0.0)
            .frame(width: 400.0, height: 300)
            
         Spacer()
      }.padding()
      .animation(.default)
        .background(Color.yellow.opacity(0.2))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
