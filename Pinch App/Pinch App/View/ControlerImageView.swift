//
//  ControlerImageView.swift
//  Pinch App
//
//  Created by Admin on 20/12/22.
//

import SwiftUI

struct ControlerImageView: View {
    var icon : String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 24))
    }
}

struct ControlerImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlerImageView(icon : "plus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
