//
//  Subview.swift
//  ComplexSwiftUIDesign-1
//
//  Created by Pankaj Bhalala on 31/03/20.
//  Copyright © 2020 Solution Analysts. All rights reserved.
//

import SwiftUI

struct Subview: View {
    
    var imageString: String
    
    var body: some View {
        Image(imageString)
        .resizable()
        .aspectRatio(contentMode: .fill)
            .frame(width: CScreenSizeBounds.width, height: 600)
        .clipped()
    }
}

#if DEBUG
struct Subview_Previews: PreviewProvider {
    static var previews: some View {
        Subview(imageString: "meditating")
    }
}
#endif
