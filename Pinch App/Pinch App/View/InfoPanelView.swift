//
//  InfoPanelView.swift
//  Pinch App
//
//  Created by Admin on 20/12/22.
//

import SwiftUI

struct InfoPanelView: View {
    
    // MARK: Propertys
    
    var offset : CGSize
    var scale : CGFloat
    @State var isInfoPanelVisible : Bool = false
    
    // MARK: Views
    var body: some View {
        HStack{
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30 , height: 30)
                .onLongPressGesture(minimumDuration: 1){
                    withAnimation(.easeOut){
                        isInfoPanelVisible.toggle()
                    }
                }
            Spacer()
            
            HStack(spacing: 2){
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offset.height)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            
            Spacer()
            
        }//
    }
}


//  MARK: Previews
struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(offset: .zero, scale: 1)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
