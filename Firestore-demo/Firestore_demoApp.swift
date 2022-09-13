//
//  Firestore_demoApp.swift
//  Firestore-demo
//
//  Created by kittawat phuangsombat on 2022/9/11.
//

import SwiftUI
import FirebaseCore

@main
struct Firestore_demoApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
