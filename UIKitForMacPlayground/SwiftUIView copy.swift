//
//  SwiftUIView.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/17/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text("This view is defined in SwiftUI.")
            .frame(width: 300, height: 300)
            .background(Color.pink)
    }
}

#if DEBUG
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
#endif
