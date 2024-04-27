//
//  SmartF_DMTApp.swift
//  SmartF-DMT
//
//  Created by Wei Zhang on 4/10/24.
//

import SwiftUI

@main
struct SmartF_DMTApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(userStore: UserStore())
        }
    }
}
