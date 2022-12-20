//
//  ContentView.swift
//  Pinch App
//
//  Created by Admin on 20/12/22.
//

import SwiftUI

struct ContentView: View {
    
//    MARK: - Propertys
    
    @State private var isAnimating : Bool = false
    @State private var imageScale : CGFloat = 1
    @State private var imageOffset : CGSize = .zero
    @State private var isDrawerOpen : Bool = false
    
    let pages : [page] = pageData
    @State private var pageIndex : Int = 1
    
//    MARK: - Functios
    
    func resetImageState(){
        withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
//    MARK: - Content
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.clear
//                MARK: - Coatiner image
                Image(pages[pageIndex - 1].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 10 , y: 2 )
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                
//                MARK: Double tap Gesture
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1{
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }else{
                            resetImageState()
                        }
                    })
                
//                MARK: Drag Guesture
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                withAnimation(.linear(duration: 1)){
                                    imageOffset = value.translation
                                }
                                
                            }
                            .onEnded{ _ in
                                if imageScale <= 1{
                                    resetImageState()
                                }
                            })
//                MARK: Magiification gesture
                    .gesture(
                        MagnificationGesture()
                            .onChanged{ value in
                                withAnimation(.linear(duration: 1)){
                                    if imageScale <= 5 && imageScale >= 1{
                                        imageScale = value
                                    }else if imageScale > 5{
                                        imageScale = 5
                                    }
                                }
                                    
                            }
                            .onEnded{ _ in
                                if imageScale > 5{
                                    imageScale = 5
                                }else if imageScale <= 1{
                                    resetImageState()
                                }
                            }
                    )
                
            }// Zstack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            })
            .overlay(
                InfoPanelView(offset: imageOffset, scale: imageScale)
                    .padding(.horizontal)
                    .padding(.top, 30)
                ,alignment: .top
            )
            
//            MARK: Cotroles Panal
            .overlay(
                Group{
                    HStack(spacing : 4){
                        Button{
                            withAnimation(.spring()){
                                if imageScale > 1{
                                    imageScale -= 1
                                    if imageScale <= 1{
                                        resetImageState()
                                    }
                                }
                            }
                          
                        } label: {
                            ControlerImageView(icon: "minus.magnifyingglass")
                        }
                        
                        Button{
                            resetImageState()
                        } label: {
                           ControlerImageView(icon: "dot.arrowtriangles.up.right.down.left.circle")
                        }
                        
                        Button(action: {
                            withAnimation(.spring()){
                                imageScale = imageScale + 1
                            }
                           
                        }, label: {
                            ControlerImageView(icon: "plus.magnifyingglass")
                        })
                        
                        
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                ,alignment: .bottom
            )
            
//            MARK: Drower
            .overlay(
                HStack{
                    // Drower hadle
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture(perform: {
                            withAnimation(.easeOut){
                                isDrawerOpen.toggle()
                            }
                        })
                    
                    //Drower tumbails
                    
                    ForEach(pages) { page in
                        Image(page.thumbnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5) , value : isDrawerOpen)
                            .onTapGesture(perform: {
                                isAnimating = true
                                pageIndex = page.id
                            })
                    }
                    Spacer()

                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .padding(.top , UIScreen.main.bounds.height / 12)
                    .offset(x : isDrawerOpen ? 40 : 220)
                    .frame(width: 260)
                ,alignment : .topTrailing
            )
        }// NaviigationView
        .navigationViewStyle(.stack)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
