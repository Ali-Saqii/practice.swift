//
//  practice_swiftApp.swift
//  practice.swift
//
//  Created by Mac mini on 17/10/2026.
//

import SwiftUI
import SwiftData

@main
struct practice_swiftApp: App {
    var body: some Scene {
        WindowGroup {
            SwiftDataView()
        }
        .modelContainer(for: Destination.self)
        /*
         .modelContainer modifier this tells swift data we want to create the stroage for
         this destination object or load it if it was created seperately and then use that storage for
         all the data inside our whole window group which for us as entire app.
         */
    }
}
