//
//  ParroTalkAppApp.swift
//  ParroTalk
//
//  Created by apple on 2023/05/20.
//

import SwiftUI

@main
struct ParroTalkAppApp: App {
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
