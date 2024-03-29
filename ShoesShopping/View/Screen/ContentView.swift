//
//  ContentView.swift
//  ShoesShopping
//
//  Created by user on 29.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel : ContentViewModel
    @State var selectedBrandItem: Brand? = nil
    
    @State var initHasRun = false
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            
            //TODO: Remove Google Plist Before Publish
                VStack {
                    
                    // FEATURED TOP VIEW
                    FeaturedView()
                        .frame(maxHeight: 180)
                        .padding()
                        
                    
                    // BRAND HORIZONTAL MENU
                    ZStack {
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach (ShoeData().brandList) { item in
                                  
                                        BrandCell(
                                            displayState:stateForChoice(brand: item),
                                            brand: item,
                                            selectedBrand: self.$selectedBrandItem)
                                }
                               
                            }.padding(.horizontal)
                        }
                        
                    .scrollIndicators(.hidden)
                        
                        HStack {
                            HorizontalTransparentGradient(rotateDegree: 0.0)
                                .frame(width: 20, height: 50)
                            Spacer()
                            HorizontalTransparentGradient(rotateDegree: 180.0)
                                .frame(width: 20, height: 50)
                        }
                    }
                    
                    // POPULAR TEXT & FILTER BUTTON
                    HStack {
    
                        Text(selectedBrandItem?.name.capitalized ?? "Popular")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.blackWhiteText)
                        
                        
                        Spacer()
                        
                        Button {
                            selectedBrandItem = nil
                            Task {
                                try? await viewModel.getShoes()
                            }
                        } label: {
                            Text("show all")
                                .foregroundStyle(.blackWhiteText)
                                .modifier(ShowAllBackground())
                                
                        }
                        .padding(.leading, 4)
                        .opacity(selectedBrandItem==nil ? 0 : 1)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                   
                    // SHOES LIST
                    ZStack(alignment: .center) {
                        ZStack (alignment: .top) {
                            ScrollView {
                               
                                LazyVGrid (columns: [GridItem(.adaptive(minimum: 120))], spacing: 16) {
                                    ForEach(viewModel.shoes, id: \.self){item in
                                           
                                                NavigationLink (destination: DetailView(shoe: item)){
                                                    ShoeVerticalCell(shoe: item)
                                                    
                                                        .foregroundStyle(.black)
                                                }
                                    }
                                       
                                }
                                .padding(16)
                                    
                                    .task {
                                        //Avoid api calls in every time onAppeared triggered by getting back to contentView from detailView
                                        if !initHasRun {
                                            try? await viewModel.getShoes()
                                            initHasRun = true
                                        }
                                    }
                                 
                         
                            }.scrollIndicators(.hidden)
                            
                            VerticalTransparentGradient()
                                .frame(height: 20)
                        }
                        
                        
                        ProgressView {
                                Text("Loading")
                                            .foregroundColor(.black)
                                    }
                        .opacity(viewModel.shoes.count > 0 ? 0 : 1)
                    }
                   
                
            }
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
   
    private func stateForChoice(brand: Brand) -> BrandCell.DisplayState {
        
        if brand.name == selectedBrandItem?.name {
            return .selected
        } else {
            return .notSelected
        }
    }
}

struct ShowAllBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom(FontManager.Mulish.regular, size: 12))
            .fontWeight(.thin)
            .foregroundStyle(.black.opacity(0.8))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(RoundedRectangle(cornerRadius: 6)
                .foregroundStyle(.gray.opacity(0.1)))
    }
}

struct FilterButton: View {
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Image("filter")
                    .resizable()
                    .frame(width: 18, height: 18)
            }
            
        }
    }
}

struct FeaturedView: View {
    var body: some View {
        GeometryReader { geometry in
        
            HStack (spacing: 0){
                VStack (alignment: .leading) {
                    
                    Text("Nike Air Zoom")
                        .font(Font.custom(FontManager.BebasNeue.regular, size: 26))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Man shoes")
                        .foregroundStyle(.white)
                        .font(.footnote)
                        .fontWeight(.regular)
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    
                    
                    Button {
                        
                    } label: {
                        Text("Shop now")
                            .fontWeight(.medium)
                            .font(.footnote)
                            .foregroundStyle(.blackWhiteText)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.whiteBlackBackground)
                            )
                    }.buttonStyle(ButtonScaleStyle())
                    
                }
                .frame(width: geometry.size.width * 0.5)
                .foregroundColor(.white)
                
                VStack {
                    Image("shoe2")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 126)
                }
                .frame(width: geometry.size.width * 0.3)
                
            }.padding()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.featuredBackground)
            )
        }
    }
}

struct BrandCheckmarkModifier: ViewModifier {
    var checked: Bool = false
    
    func body(content: Content) -> some View {
        Group {
            if checked {
                content
                    .background(
                RoundedRectangle(
                    cornerRadius: 8)
                    .strokeBorder(.gray.opacity(0.3), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 8)
                    .fill(.black.opacity(0.10)))
                )
            } else {
                content
                    .background(
                RoundedRectangle(
                    cornerRadius: 8)
                    .strokeBorder(.gray.opacity(0.3), lineWidth: 1)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill(.gray.opacity(0.075)))
                )
            }
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(ContentViewModel())
}
