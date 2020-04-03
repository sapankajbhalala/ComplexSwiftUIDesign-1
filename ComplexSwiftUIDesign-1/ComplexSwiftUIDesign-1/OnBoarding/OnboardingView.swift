//
//  OnboardingView.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 31/03/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    var subviews = [
        UIHostingController(rootView: Subview(imageString: "meditating")),
        UIHostingController(rootView: Subview(imageString: "skydiving")),
        UIHostingController(rootView: Subview(imageString: "sitting"))
    ]
    
    var titles = ["Poster 1", "Poster 2", "Poster 3"]
    
    var captions =  ["Display movie poster 1", "Display movie poster 2", "Display movie poster 3"]
    
    @State var currentPageIndex = 0
    @EnvironmentObject var userOnboard: UserOnboard
    var body: some View {
        VStack(alignment: .leading) {
            PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                .frame(height: 500)
            Group {
                Text(titles[currentPageIndex])
                    .font(.title)
                Text(captions[currentPageIndex])
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: 300, height: 50, alignment: .leading)
                .lineLimit(nil)
            }
                .padding()
            HStack {
                PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
                Spacer()
                ButtonContent().onTapGesture {
                    self.userOnboard.onboardComplete = true
                }
//                Button(action: {
//                    self.showDetails.toggle()
////                    if self.currentPageIndex+1 == self.subviews.count {
////                        self.currentPageIndex = 0
////                    } else {
////                        self.currentPageIndex += 1
////                    }
//                }) {
//                    ButtonContent()
//                }
            }
                .padding()
            }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
struct ButtonContent: View {
    var body: some View {
        Image(systemName: "arrow.right")
        .resizable()
        .foregroundColor(.white)
        .frame(width: 30, height: 30)
        .padding()
        .background(Color.orange)
        .cornerRadius(30)
    }
}
