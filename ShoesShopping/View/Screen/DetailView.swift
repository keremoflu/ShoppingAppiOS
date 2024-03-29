//
//  DetailView.swift
//  ShoesShopping
//
//  Created by user on 31.03.2024.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    
    var shoe: Shoe
    @State var selectedSize: Int? = nil
    
    
    @State var isFavorited = false
    @EnvironmentObject var viewModel: ContentViewModel
    
    @State var isShowingCart = false
    
    //Swift Data
    @StateObject var cartViewModel = CartViewModel()
    @Environment(\.modelContext) var context
    @Query(sort: \CartShoe.id) var cartProducts: [CartShoe]
    
    @State var showSizeAlert = false
    @State var isAlertExit = false
    
    var body: some View {
        
        ScrollView {
            VStack (spacing: 0) {
                
                // IMAGE
                ImageView(imageUrl: shoe.image)
                    .padding(.top)
               
                
                VStack (spacing: 16) {
                    
                    Text(shoe.brand.capitalized)
                        .font(Font.custom(FontManager.Mulish.regular, size: 16))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                    
                    // NAME & PRICE
                    GeometryReader { geometry in
                        HStack {
                            Text(shoe.name)
                                .font(Font.custom(FontManager.BebasNeue.regular, size: 30))
                                .foregroundStyle(.blackWhiteText)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: geometry.size.width * 0.7, alignment: .leading)
                            Spacer()
                            
                            Text("$\(shoe.price)")
                                .font(Font.custom(FontManager.BebasNeue.regular, size: 30))
                                .foregroundStyle(.blackWhiteText)
                                .frame(maxWidth: geometry.size.width * 0.2, alignment: .trailing)
                        }
                    }
                    .padding(.bottom,24)
                        
                    
                    // SIZE HORIZONTAL LIST
                    VStack {
                        
                        ScrollView (.horizontal){
                            HStack (spacing: 4) {
                                ForEach(shoe.stock.sorted(by: <),
                                    //.filter({ $0.value > 0}), // If shoe in stock
                                        id: \.key){ key, value in
                                    SizeCell(
                                        size: Int(key)!,
                                        stock: value,
                                        selectedSize: self.$selectedSize)
                                        .foregroundStyle(.black)
                                }
                            }.padding(.vertical, 8)
                        }.scrollIndicators(.hidden)
                    }
                    
                    
                    // DESCRIPTION
                    VStack {
                        Text("Description")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 8)
                            .font(Font.custom(FontManager.Mulish.bold, size: 16))
                            .foregroundStyle(.blackWhiteText)
                        
                        Text(shoe.description)
                            .font(Font.custom(FontManager.Mulish.regular, size: 15))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.blackGrayText)
                            .lineSpacing(6.0)
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
               
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(.all, edges: .bottom)
        .safeAreaInset(edge: .bottom) {
            Button {
                addToCart()
            } label: {
               CartButtonBackground()
            }.buttonStyle(ButtonScaleStyle())
                .modifier(AlertModifier(isExit: $isAlertExit, isAlert: $showSizeAlert))
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
               ToolbarBackButton()
            }
            
            ToolbarItem(placement: .topBarTrailing) {
               CartButton()
                    .onTapGesture {
                        isShowingCart.toggle()
                    }
                    .sheet(isPresented: $isShowingCart, content: {
                        CartView()
                            .presentationDragIndicator(.visible)
                            .ignoresSafeArea()
                    })
                    
            }
        }
        
    }
    
    func addToCart(){
        
        if(selectedSize != nil){
            let cartShoe = CartShoe(shoeId: shoe.id, name: shoe.name, image: shoe.image, size:selectedSize ?? 30, price: shoe.price, count: 1)
            
            if(cartViewModel.isAlreadyOnCart(cartShoe: cartShoe, cartProducts: cartProducts)){
                cartViewModel.increaseAmount(productId: shoe.id, productSize: selectedSize ?? 40, cartProducts: cartProducts)
            } else {
                context.insert(cartShoe)
            }
        } else {
            showSizeAlert.toggle()
        }
       
    }
}

struct ToolbarBackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Image(systemName: "arrow.left")
            .padding(8)
            .foregroundStyle(.blackWhiteBackground)
            .onTapGesture {
                dismiss()
            }
    }
}

struct CartButtonBackground: View {
    var body: some View {
        HStack (spacing: 0) {
            
            
            Image(systemName: "cart.fill")
                .resizable()
                .frame(width: 20, height: 16)
                .foregroundStyle(.whiteBlackBackground)
            
            Text("Add To Cart")
                .font(Font.custom(FontManager.NotoSans.medium, size: 14))
                .buttonStyle(ButtonScaleStyle())
                .foregroundStyle(.whiteBlackText)
                .padding()
                
           
        }.frame(maxWidth: .infinity, maxHeight: 60)
            .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.blackWhiteButton)
            )
            .padding(32)
    }
}

struct ImageView : View {
    
    var imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)){ img in
                img
                .resizable()
                .scaledToFit()
                .padding(32)
                .frame(maxWidth: .infinity, maxHeight: 230)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.contentItem)
                ).padding(.horizontal)
            
                
        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.contentItem)
                    .frame(maxWidth: .infinity, minHeight: 230)
                    .padding(.horizontal)
                
                ProgressView()
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    // Enables back swipe gesture (Using custom back button disables)
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

#Preview {
    DetailView(shoe: Shoe(id: "xxx", name: "Palermo Green Suede", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", image: "https://firebasestorage.googleapis.com/v0/b/shoesapp-d836c.appspot.com/o/nike1.png?alt=media&token=76322e9c-068d-4d7d-bb10-e03f75160147", brand: "nike", price: 85, gender: "man", stock: ["42":0, "43": 1]))
}
