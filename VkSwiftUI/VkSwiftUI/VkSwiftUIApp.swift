//
//  VkSwiftUIApp.swift
//  VkSwiftUI
//
//  Created by Sokolov on 21.02.2023.
//

import SwiftUI

enum Screen {
    case veb
    case log
    case bosses
}

final class TabRouter: ObservableObject {
    
    @Published var screen: Screen = .log
    
    func change(to screen: Screen) {
        self.screen = screen
    }
}

@main
struct VkSwiftUIApp: App {
    
    @StateObject var router = TabRouter()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $router.screen) {
                Vebinar()
                    .tag(Screen.veb)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                LoginView()
                    .tag(Screen.log)
                    .environmentObject(router)
                    .tabItem {
                        Label("Login View", systemImage: "person.badge.key")
                    }
                BossesOfEldenRing()
                    .tag(Screen.bosses)
                    .environmentObject(router)
                    .tabItem {
                        Label("Elden Ring bosses", systemImage: "shield.lefthalf.filled")
                    }
            }
        }
    }
}
