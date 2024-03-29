//
//  ContentViewModel.swift
//  ShoesShopping
//
//  Created by user on 30.03.2024.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var shoes = [Shoe]()
    
    func getShoes() async throws {
        // Descending Order (Last Added on Top)
        let snapshot = try await Firestore.firestore().collection("shoes").getDocuments()
        
        shoes = snapshot.documents.compactMap({
            // Decoding Firebase Data to Our Model
            try? $0.data(as: Shoe.self)
        })
    }
    

    @MainActor
    func getShoesByBrand(brandName: String) async throws {
            let snapshot = try await Firestore.firestore().collection("shoes")
                .whereField("brand", isEqualTo: brandName)
                .getDocuments()
            
            shoes = snapshot.documents.compactMap({
                // Decoding Firebase Data to Our Model
                try? $0.data(as: Shoe.self)
            })
        
    }
    
   
}
