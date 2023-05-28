//
//  rememberEnglishApp.swift
//  rememberEnglish
//
//  Created by apple on 2023/05/20.
//

import SwiftUI

@main
struct rememberEnglishApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
}
