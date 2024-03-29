//
//  ShoesShoppingApp.swift
//  ShoesShopping
//
//  Created by user on 29.03.2024.
//

import SwiftUI
import Firebase
import FirebaseCore
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
    
@main
struct ShoesShoppingApp: App {
    
    @StateObject var contentVM : ContentViewModel = ContentViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: CartShoe.self)
        .environmentObject(contentVM)
        
    }
}
