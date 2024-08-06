//
//  DevPrepApp.swift
//  DevPrep
//
//  Created by Naveen Keerthy on 7/15/24.
//

import SwiftUI
import SwiftData

@main
struct DevPrepApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            CategoriesListView()
        }
        .modelContainer(for: Category.self)
    }
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex: "#313e53")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Set the color of the back button and other bar button items
//        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        debugPrint(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
