//
//  ContentView.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 27/03/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var showProfile = false

    var body: some View {
       ZStack(alignment: .top) {
          HomeList()
             .blur(radius: show ? 20 : 0)
             .scaleEffect(showProfile ? 0.95 : 1)
             .animation(.default)
       }
       .background(Color("background"))
       .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
